Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA2BC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2ED20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbfFLF7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 01:59:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:48986 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfFLF7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 01:59:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 22:59:16 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jun 2019 22:59:15 -0700
Subject: Re: [PATCH 01/11] perf intel-pt: Add new packets for PEBS via PT
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20190610072803.10456-1-adrian.hunter@intel.com>
 <20190610072803.10456-2-adrian.hunter@intel.com>
 <20190612000945.GE28689@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e0a9a4e9-6c49-ecd1-4729-79002c66fafe@intel.com>
Date:   Wed, 12 Jun 2019 08:58:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612000945.GE28689@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/19 3:09 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jun 10, 2019 at 10:27:53AM +0300, Adrian Hunter escreveu:
>> Add 3 new packets to supports PEBS via PT, namely Block Begin Packet (BBP),
>> Block Item Packet (BIP) and Block End Packet (BEP). PEBS data is encoded
>> into multiple BIP packets that come between BBP and BEP. The BEP packet
>> might be associated with a FUP packet. That is indicated by using a
>> separate packet type (INTEL_PT_BEP_IP) similar to other packets types with
>> the _IP suffix.
>>
>> Refer to the Intel SDM for more information about PEBS via PT.
> 
> In these cases would be nice to provide an URL and page number, for
> convenience.

Intel SDM:

	https://software.intel.com/en-us/articles/intel-sdm

May 2019 version: Vol. 3B 18.5.5.2 PEBS output to Intel® Processor Trace

> 
> - Arnaldo
>  
>> Decoding of BIP packets conflicts with single-byte TNT packets. Since BIP
>> packets only occur in the context of a block (i.e. between BBP and BEP),
>> that context must be recorded and passed to the packet decoder.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  .../util/intel-pt-decoder/intel-pt-decoder.c  |  38 ++++-
>>  .../intel-pt-decoder/intel-pt-pkt-decoder.c   | 140 +++++++++++++++++-
>>  .../intel-pt-decoder/intel-pt-pkt-decoder.h   |  21 ++-
>>  tools/perf/util/intel-pt.c                    |   3 +-
>>  4 files changed, 193 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
>> index 9eb778f9c911..44218f9cf16a 100644
>> --- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
>> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
>> @@ -140,6 +140,7 @@ struct intel_pt_decoder {
>>  	int mtc_shift;
>>  	struct intel_pt_stack stack;
>>  	enum intel_pt_pkt_state pkt_state;
>> +	enum intel_pt_pkt_ctx pkt_ctx;
>>  	struct intel_pt_pkt packet;
>>  	struct intel_pt_pkt tnt;
>>  	int pkt_step;
>> @@ -558,7 +559,7 @@ static int intel_pt_get_split_packet(struct intel_pt_decoder *decoder)
>>  	memcpy(buf + len, decoder->buf, n);
>>  	len += n;
>>  
>> -	ret = intel_pt_get_packet(buf, len, &decoder->packet);
>> +	ret = intel_pt_get_packet(buf, len, &decoder->packet, &decoder->pkt_ctx);
>>  	if (ret < (int)old_len) {
>>  		decoder->next_buf = decoder->buf;
>>  		decoder->next_len = decoder->len;
>> @@ -593,6 +594,7 @@ static int intel_pt_pkt_lookahead(struct intel_pt_decoder *decoder,
>>  {
>>  	struct intel_pt_pkt_info pkt_info;
>>  	const unsigned char *buf = decoder->buf;
>> +	enum intel_pt_pkt_ctx pkt_ctx = decoder->pkt_ctx;
>>  	size_t len = decoder->len;
>>  	int ret;
>>  
>> @@ -611,7 +613,8 @@ static int intel_pt_pkt_lookahead(struct intel_pt_decoder *decoder,
>>  			if (!len)
>>  				return INTEL_PT_NEED_MORE_BYTES;
>>  
>> -			ret = intel_pt_get_packet(buf, len, &pkt_info.packet);
>> +			ret = intel_pt_get_packet(buf, len, &pkt_info.packet,
>> +						  &pkt_ctx);
>>  			if (!ret)
>>  				return INTEL_PT_NEED_MORE_BYTES;
>>  			if (ret < 0)
>> @@ -686,6 +689,10 @@ static int intel_pt_calc_cyc_cb(struct intel_pt_pkt_info *pkt_info)
>>  	case INTEL_PT_MNT:
>>  	case INTEL_PT_PTWRITE:
>>  	case INTEL_PT_PTWRITE_IP:
>> +	case INTEL_PT_BBP:
>> +	case INTEL_PT_BIP:
>> +	case INTEL_PT_BEP:
>> +	case INTEL_PT_BEP_IP:
>>  		return 0;
>>  
>>  	case INTEL_PT_MTC:
>> @@ -878,7 +885,7 @@ static int intel_pt_get_next_packet(struct intel_pt_decoder *decoder)
>>  		}
>>  
>>  		ret = intel_pt_get_packet(decoder->buf, decoder->len,
>> -					  &decoder->packet);
>> +					  &decoder->packet, &decoder->pkt_ctx);
>>  		if (ret == INTEL_PT_NEED_MORE_BYTES && BITS_PER_LONG == 32 &&
>>  		    decoder->len < INTEL_PT_PKT_MAX_SZ && !decoder->next_buf) {
>>  			ret = intel_pt_get_split_packet(decoder);
>> @@ -1624,6 +1631,10 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
>>  		case INTEL_PT_MWAIT:
>>  		case INTEL_PT_PWRE:
>>  		case INTEL_PT_PWRX:
>> +		case INTEL_PT_BBP:
>> +		case INTEL_PT_BIP:
>> +		case INTEL_PT_BEP:
>> +		case INTEL_PT_BEP_IP:
>>  			decoder->have_tma = false;
>>  			intel_pt_log("ERROR: Unexpected packet\n");
>>  			err = -EAGAIN;
>> @@ -1717,6 +1728,10 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
>>  		case INTEL_PT_MWAIT:
>>  		case INTEL_PT_PWRE:
>>  		case INTEL_PT_PWRX:
>> +		case INTEL_PT_BBP:
>> +		case INTEL_PT_BIP:
>> +		case INTEL_PT_BEP:
>> +		case INTEL_PT_BEP_IP:
>>  			intel_pt_log("ERROR: Missing TIP after FUP\n");
>>  			decoder->pkt_state = INTEL_PT_STATE_ERR3;
>>  			decoder->pkt_step = 0;
>> @@ -2038,6 +2053,12 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
>>  			decoder->state.pwrx_payload = decoder->packet.payload;
>>  			return 0;
>>  
>> +		case INTEL_PT_BBP:
>> +		case INTEL_PT_BIP:
>> +		case INTEL_PT_BEP:
>> +		case INTEL_PT_BEP_IP:
>> +			break;
>> +
>>  		default:
>>  			return intel_pt_bug(decoder);
>>  		}
>> @@ -2076,6 +2097,10 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
>>  		case INTEL_PT_MWAIT:
>>  		case INTEL_PT_PWRE:
>>  		case INTEL_PT_PWRX:
>> +		case INTEL_PT_BBP:
>> +		case INTEL_PT_BIP:
>> +		case INTEL_PT_BEP:
>> +		case INTEL_PT_BEP_IP:
>>  			intel_pt_log("ERROR: Unexpected packet\n");
>>  			err = -ENOENT;
>>  			goto out;
>> @@ -2282,6 +2307,10 @@ static int intel_pt_walk_to_ip(struct intel_pt_decoder *decoder)
>>  		case INTEL_PT_MWAIT:
>>  		case INTEL_PT_PWRE:
>>  		case INTEL_PT_PWRX:
>> +		case INTEL_PT_BBP:
>> +		case INTEL_PT_BIP:
>> +		case INTEL_PT_BEP:
>> +		case INTEL_PT_BEP_IP:
>>  		default:
>>  			break;
>>  		}
>> @@ -2632,11 +2661,12 @@ static unsigned char *intel_pt_last_psb(unsigned char *buf, size_t len)
>>  static bool intel_pt_next_tsc(unsigned char *buf, size_t len, uint64_t *tsc,
>>  			      size_t *rem)
>>  {
>> +	enum intel_pt_pkt_ctx ctx = INTEL_PT_NO_CTX;
>>  	struct intel_pt_pkt packet;
>>  	int ret;
>>  
>>  	while (len) {
>> -		ret = intel_pt_get_packet(buf, len, &packet);
>> +		ret = intel_pt_get_packet(buf, len, &packet, &ctx);
>>  		if (ret <= 0)
>>  			return false;
>>  		if (packet.type == INTEL_PT_TSC) {
>> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
>> index d426761a549d..2b2793b339c0 100644
>> --- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
>> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
>> @@ -71,6 +71,10 @@ static const char * const packet_name[] = {
>>  	[INTEL_PT_MWAIT]	= "MWAIT",
>>  	[INTEL_PT_PWRE]		= "PWRE",
>>  	[INTEL_PT_PWRX]		= "PWRX",
>> +	[INTEL_PT_BBP]		= "BBP",
>> +	[INTEL_PT_BIP]		= "BIP",
>> +	[INTEL_PT_BEP]		= "BEP",
>> +	[INTEL_PT_BEP_IP]	= "BEP",
>>  };
>>  
>>  const char *intel_pt_pkt_name(enum intel_pt_pkt_type type)
>> @@ -289,6 +293,55 @@ static int intel_pt_get_pwrx(const unsigned char *buf, size_t len,
>>  	return 7;
>>  }
>>  
>> +static int intel_pt_get_bbp(const unsigned char *buf, size_t len,
>> +			    struct intel_pt_pkt *packet)
>> +{
>> +	if (len < 3)
>> +		return INTEL_PT_NEED_MORE_BYTES;
>> +	packet->type = INTEL_PT_BBP;
>> +	packet->count = buf[2] >> 7;
>> +	packet->payload = buf[2] & 0x1f;
>> +	return 3;
>> +}
>> +
>> +static int intel_pt_get_bip_4(const unsigned char *buf, size_t len,
>> +			      struct intel_pt_pkt *packet)
>> +{
>> +	if (len < 5)
>> +		return INTEL_PT_NEED_MORE_BYTES;
>> +	packet->type = INTEL_PT_BIP;
>> +	packet->count = buf[0] >> 3;
>> +	memcpy_le64(&packet->payload, buf + 1, 4);
>> +	return 5;
>> +}
>> +
>> +static int intel_pt_get_bip_8(const unsigned char *buf, size_t len,
>> +			      struct intel_pt_pkt *packet)
>> +{
>> +	if (len < 9)
>> +		return INTEL_PT_NEED_MORE_BYTES;
>> +	packet->type = INTEL_PT_BIP;
>> +	packet->count = buf[0] >> 3;
>> +	memcpy_le64(&packet->payload, buf + 1, 8);
>> +	return 9;
>> +}
>> +
>> +static int intel_pt_get_bep(size_t len, struct intel_pt_pkt *packet)
>> +{
>> +	if (len < 2)
>> +		return INTEL_PT_NEED_MORE_BYTES;
>> +	packet->type = INTEL_PT_BEP;
>> +	return 2;
>> +}
>> +
>> +static int intel_pt_get_bep_ip(size_t len, struct intel_pt_pkt *packet)
>> +{
>> +	if (len < 2)
>> +		return INTEL_PT_NEED_MORE_BYTES;
>> +	packet->type = INTEL_PT_BEP_IP;
>> +	return 2;
>> +}
>> +
>>  static int intel_pt_get_ext(const unsigned char *buf, size_t len,
>>  			    struct intel_pt_pkt *packet)
>>  {
>> @@ -329,6 +382,12 @@ static int intel_pt_get_ext(const unsigned char *buf, size_t len,
>>  		return intel_pt_get_pwre(buf, len, packet);
>>  	case 0xA2: /* PWRX */
>>  		return intel_pt_get_pwrx(buf, len, packet);
>> +	case 0x63: /* BBP */
>> +		return intel_pt_get_bbp(buf, len, packet);
>> +	case 0x33: /* BEP no IP */
>> +		return intel_pt_get_bep(len, packet);
>> +	case 0xb3: /* BEP with IP */
>> +		return intel_pt_get_bep_ip(len, packet);
>>  	default:
>>  		return INTEL_PT_BAD_PACKET;
>>  	}
>> @@ -477,7 +536,8 @@ static int intel_pt_get_mtc(const unsigned char *buf, size_t len,
>>  }
>>  
>>  static int intel_pt_do_get_packet(const unsigned char *buf, size_t len,
>> -				  struct intel_pt_pkt *packet)
>> +				  struct intel_pt_pkt *packet,
>> +				  enum intel_pt_pkt_ctx ctx)
>>  {
>>  	unsigned int byte;
>>  
>> @@ -487,6 +547,22 @@ static int intel_pt_do_get_packet(const unsigned char *buf, size_t len,
>>  		return INTEL_PT_NEED_MORE_BYTES;
>>  
>>  	byte = buf[0];
>> +
>> +	switch (ctx) {
>> +	case INTEL_PT_NO_CTX:
>> +		break;
>> +	case INTEL_PT_BLK_4_CTX:
>> +		if ((byte & 0x7) == 4)
>> +			return intel_pt_get_bip_4(buf, len, packet);
>> +		break;
>> +	case INTEL_PT_BLK_8_CTX:
>> +		if ((byte & 0x7) == 4)
>> +			return intel_pt_get_bip_8(buf, len, packet);
>> +		break;
>> +	default:
>> +		break;
>> +	};
>> +
>>  	if (!(byte & BIT(0))) {
>>  		if (byte == 0)
>>  			return intel_pt_get_pad(packet);
>> @@ -525,15 +601,65 @@ static int intel_pt_do_get_packet(const unsigned char *buf, size_t len,
>>  	}
>>  }
>>  
>> +void intel_pt_upd_pkt_ctx(const struct intel_pt_pkt *packet,
>> +			  enum intel_pt_pkt_ctx *ctx)
>> +{
>> +	switch (packet->type) {
>> +	case INTEL_PT_BAD:
>> +	case INTEL_PT_PAD:
>> +	case INTEL_PT_TSC:
>> +	case INTEL_PT_TMA:
>> +	case INTEL_PT_MTC:
>> +	case INTEL_PT_FUP:
>> +	case INTEL_PT_CYC:
>> +	case INTEL_PT_CBR:
>> +	case INTEL_PT_MNT:
>> +	case INTEL_PT_EXSTOP:
>> +	case INTEL_PT_EXSTOP_IP:
>> +	case INTEL_PT_PWRE:
>> +	case INTEL_PT_PWRX:
>> +	case INTEL_PT_BIP:
>> +		break;
>> +	case INTEL_PT_TNT:
>> +	case INTEL_PT_TIP:
>> +	case INTEL_PT_TIP_PGD:
>> +	case INTEL_PT_TIP_PGE:
>> +	case INTEL_PT_MODE_EXEC:
>> +	case INTEL_PT_MODE_TSX:
>> +	case INTEL_PT_PIP:
>> +	case INTEL_PT_OVF:
>> +	case INTEL_PT_VMCS:
>> +	case INTEL_PT_TRACESTOP:
>> +	case INTEL_PT_PSB:
>> +	case INTEL_PT_PSBEND:
>> +	case INTEL_PT_PTWRITE:
>> +	case INTEL_PT_PTWRITE_IP:
>> +	case INTEL_PT_MWAIT:
>> +	case INTEL_PT_BEP:
>> +	case INTEL_PT_BEP_IP:
>> +		*ctx = INTEL_PT_NO_CTX;
>> +		break;
>> +	case INTEL_PT_BBP:
>> +		if (packet->count)
>> +			*ctx = INTEL_PT_BLK_4_CTX;
>> +		else
>> +			*ctx = INTEL_PT_BLK_8_CTX;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +}
>> +
>>  int intel_pt_get_packet(const unsigned char *buf, size_t len,
>> -			struct intel_pt_pkt *packet)
>> +			struct intel_pt_pkt *packet, enum intel_pt_pkt_ctx *ctx)
>>  {
>>  	int ret;
>>  
>> -	ret = intel_pt_do_get_packet(buf, len, packet);
>> +	ret = intel_pt_do_get_packet(buf, len, packet, *ctx);
>>  	if (ret > 0) {
>>  		while (ret < 8 && len > (size_t)ret && !buf[ret])
>>  			ret += 1;
>> +		intel_pt_upd_pkt_ctx(packet, ctx);
>>  	}
>>  	return ret;
>>  }
>> @@ -611,8 +737,10 @@ int intel_pt_pkt_desc(const struct intel_pt_pkt *packet, char *buf,
>>  		return snprintf(buf, buf_len, "%s 0x%llx IP:0", name, payload);
>>  	case INTEL_PT_PTWRITE_IP:
>>  		return snprintf(buf, buf_len, "%s 0x%llx IP:1", name, payload);
>> +	case INTEL_PT_BEP:
>>  	case INTEL_PT_EXSTOP:
>>  		return snprintf(buf, buf_len, "%s IP:0", name);
>> +	case INTEL_PT_BEP_IP:
>>  	case INTEL_PT_EXSTOP_IP:
>>  		return snprintf(buf, buf_len, "%s IP:1", name);
>>  	case INTEL_PT_MWAIT:
>> @@ -630,6 +758,12 @@ int intel_pt_pkt_desc(const struct intel_pt_pkt *packet, char *buf,
>>  				(unsigned int)((payload >> 4) & 0xf),
>>  				(unsigned int)(payload & 0xf),
>>  				(unsigned int)((payload >> 8) & 0xf));
>> +	case INTEL_PT_BBP:
>> +		return snprintf(buf, buf_len, "%s SZ %s-byte Type 0x%llx",
>> +				name, packet->count ? "4" : "8", payload);
>> +	case INTEL_PT_BIP:
>> +		return snprintf(buf, buf_len, "%s ID 0x%02x Value 0x%llx",
>> +				name, packet->count, payload);
>>  	default:
>>  		break;
>>  	}
>> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h
>> index 73ddc3a88d07..682b35282abc 100644
>> --- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h
>> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h
>> @@ -59,6 +59,10 @@ enum intel_pt_pkt_type {
>>  	INTEL_PT_MWAIT,
>>  	INTEL_PT_PWRE,
>>  	INTEL_PT_PWRX,
>> +	INTEL_PT_BBP,
>> +	INTEL_PT_BIP,
>> +	INTEL_PT_BEP,
>> +	INTEL_PT_BEP_IP,
>>  };
>>  
>>  struct intel_pt_pkt {
>> @@ -67,10 +71,25 @@ struct intel_pt_pkt {
>>  	uint64_t		payload;
>>  };
>>  
>> +/*
>> + * Decoding of BIP packets conflicts with single-byte TNT packets. Since BIP
>> + * packets only occur in the context of a block (i.e. between BBP and BEP), that
>> + * context must be recorded and passed to the packet decoder.
>> + */
>> +enum intel_pt_pkt_ctx {
>> +	INTEL_PT_NO_CTX,	/* BIP packets are invalid */
>> +	INTEL_PT_BLK_4_CTX,	/* 4-byte BIP packets */
>> +	INTEL_PT_BLK_8_CTX,	/* 8-byte BIP packets */
>> +};
>> +
>>  const char *intel_pt_pkt_name(enum intel_pt_pkt_type);
>>  
>>  int intel_pt_get_packet(const unsigned char *buf, size_t len,
>> -			struct intel_pt_pkt *packet);
>> +			struct intel_pt_pkt *packet,
>> +			enum intel_pt_pkt_ctx *ctx);
>> +
>> +void intel_pt_upd_pkt_ctx(const struct intel_pt_pkt *packet,
>> +			  enum intel_pt_pkt_ctx *ctx);
>>  
>>  int intel_pt_pkt_desc(const struct intel_pt_pkt *packet, char *buf, size_t len);
>>  
>> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
>> index 3cff8fe2eaa0..f43d3ac2db8b 100644
>> --- a/tools/perf/util/intel-pt.c
>> +++ b/tools/perf/util/intel-pt.c
>> @@ -174,13 +174,14 @@ static void intel_pt_dump(struct intel_pt *pt __maybe_unused,
>>  	int ret, pkt_len, i;
>>  	char desc[INTEL_PT_PKT_DESC_MAX];
>>  	const char *color = PERF_COLOR_BLUE;
>> +	enum intel_pt_pkt_ctx ctx = INTEL_PT_NO_CTX;
>>  
>>  	color_fprintf(stdout, color,
>>  		      ". ... Intel Processor Trace data: size %zu bytes\n",
>>  		      len);
>>  
>>  	while (len) {
>> -		ret = intel_pt_get_packet(buf, len, &packet);
>> +		ret = intel_pt_get_packet(buf, len, &packet, &ctx);
>>  		if (ret > 0)
>>  			pkt_len = ret;
>>  		else
>> -- 
>> 2.17.1
> 


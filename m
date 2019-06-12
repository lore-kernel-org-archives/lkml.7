Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC59C31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 00:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD7C21721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 00:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EySNu/Tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407389AbfFLAJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 20:09:52 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41550 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405287AbfFLAJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 20:09:52 -0400
Received: by mail-qk1-f193.google.com with SMTP id c11so8860908qkk.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 17:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B6SsaZB5uGhCAsxc9F8lMD7sBJKJaGRB5YjOmHQoDfM=;
        b=EySNu/TzNrLS0idUX3tqqeATfzyoSyJhcWI/j1RqvAhZcfb5KaldB4ryyCzrqcGkYL
         hr+zET8ce5pbL2EwOpfTf52cq882++8ReccrCYRmC7Ft3OIUSrmNpUau47kTAT4m1L3A
         u4JjGlY2RJ4XVtnM0zqFq75ZHQjUCVLtEjhN64ftMMy8F6rhHh+1RIvn6/s4SxfNKbwd
         anT5dHnarvcbD3pLMWJHkb+JXPbt2m4Wmf6VBT9kZOM1ieJ4MpQFWYzjLavV5PylKfqM
         Ja0h/I9xqJQptmafkV/rQKYKQuZ8bkdOkwE49OMbG132Vb47CUWEG5fxr8/RDizI6w5S
         3vXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B6SsaZB5uGhCAsxc9F8lMD7sBJKJaGRB5YjOmHQoDfM=;
        b=FqcnjrHYwtpNgS491RnaKRE4o6lY2jffQ5A74bO4BdRlwNzpZBUdLzlyUXK7AsABiK
         7Y2M9QKXvupHrTYfTJJUh84g1VgHZOFzHHoVrsKUk8WV3hE9I1DklrQn49Afw1Z4337Q
         ZXGeamRzTZgRH6+OBTVyCA5ekbW2wcpP7pM801XGiFeMuAc+09NkTvBi70clqxqcm/gP
         MIxF0nkvNVLyowBPFtjY8MXjjw9QlU8rQv5HgHqB/gguXIOt1t/btOcwNwgwjuDpTeEe
         TMBiRHfOLQ16h5DNPSY6LoR8Rc10rdIJdbJRZ3zCv2f82YhiZkHT0jxL/D00o8opHaFR
         1vMg==
X-Gm-Message-State: APjAAAUCUqi1j2NvC2C6OJqipECJ0K/1uVuPD6/vAq8ezOQ1urBMV8MJ
        vr5cggsxxF/9WKZnbb75mDU=
X-Google-Smtp-Source: APXvYqwku3fR69s3otXeuDy4zhMTUZFfd94zBcQloKGuGmQRLCSq/RtxwuvqqpszIlE0jusI9FEFbA==
X-Received: by 2002:a05:620a:35e:: with SMTP id t30mr62986376qkm.14.1560298190734;
        Tue, 11 Jun 2019 17:09:50 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id w9sm5473808qki.81.2019.06.11.17.09.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 17:09:49 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 652C541149; Tue, 11 Jun 2019 21:09:45 -0300 (-03)
Date:   Tue, 11 Jun 2019 21:09:45 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] perf intel-pt: Add new packets for PEBS via PT
Message-ID: <20190612000945.GE28689@kernel.org>
References: <20190610072803.10456-1-adrian.hunter@intel.com>
 <20190610072803.10456-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610072803.10456-2-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 10, 2019 at 10:27:53AM +0300, Adrian Hunter escreveu:
> Add 3 new packets to supports PEBS via PT, namely Block Begin Packet (BBP),
> Block Item Packet (BIP) and Block End Packet (BEP). PEBS data is encoded
> into multiple BIP packets that come between BBP and BEP. The BEP packet
> might be associated with a FUP packet. That is indicated by using a
> separate packet type (INTEL_PT_BEP_IP) similar to other packets types with
> the _IP suffix.
> 
> Refer to the Intel SDM for more information about PEBS via PT.

In these cases would be nice to provide an URL and page number, for
convenience.

- Arnaldo
 
> Decoding of BIP packets conflicts with single-byte TNT packets. Since BIP
> packets only occur in the context of a block (i.e. between BBP and BEP),
> that context must be recorded and passed to the packet decoder.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  .../util/intel-pt-decoder/intel-pt-decoder.c  |  38 ++++-
>  .../intel-pt-decoder/intel-pt-pkt-decoder.c   | 140 +++++++++++++++++-
>  .../intel-pt-decoder/intel-pt-pkt-decoder.h   |  21 ++-
>  tools/perf/util/intel-pt.c                    |   3 +-
>  4 files changed, 193 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> index 9eb778f9c911..44218f9cf16a 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> @@ -140,6 +140,7 @@ struct intel_pt_decoder {
>  	int mtc_shift;
>  	struct intel_pt_stack stack;
>  	enum intel_pt_pkt_state pkt_state;
> +	enum intel_pt_pkt_ctx pkt_ctx;
>  	struct intel_pt_pkt packet;
>  	struct intel_pt_pkt tnt;
>  	int pkt_step;
> @@ -558,7 +559,7 @@ static int intel_pt_get_split_packet(struct intel_pt_decoder *decoder)
>  	memcpy(buf + len, decoder->buf, n);
>  	len += n;
>  
> -	ret = intel_pt_get_packet(buf, len, &decoder->packet);
> +	ret = intel_pt_get_packet(buf, len, &decoder->packet, &decoder->pkt_ctx);
>  	if (ret < (int)old_len) {
>  		decoder->next_buf = decoder->buf;
>  		decoder->next_len = decoder->len;
> @@ -593,6 +594,7 @@ static int intel_pt_pkt_lookahead(struct intel_pt_decoder *decoder,
>  {
>  	struct intel_pt_pkt_info pkt_info;
>  	const unsigned char *buf = decoder->buf;
> +	enum intel_pt_pkt_ctx pkt_ctx = decoder->pkt_ctx;
>  	size_t len = decoder->len;
>  	int ret;
>  
> @@ -611,7 +613,8 @@ static int intel_pt_pkt_lookahead(struct intel_pt_decoder *decoder,
>  			if (!len)
>  				return INTEL_PT_NEED_MORE_BYTES;
>  
> -			ret = intel_pt_get_packet(buf, len, &pkt_info.packet);
> +			ret = intel_pt_get_packet(buf, len, &pkt_info.packet,
> +						  &pkt_ctx);
>  			if (!ret)
>  				return INTEL_PT_NEED_MORE_BYTES;
>  			if (ret < 0)
> @@ -686,6 +689,10 @@ static int intel_pt_calc_cyc_cb(struct intel_pt_pkt_info *pkt_info)
>  	case INTEL_PT_MNT:
>  	case INTEL_PT_PTWRITE:
>  	case INTEL_PT_PTWRITE_IP:
> +	case INTEL_PT_BBP:
> +	case INTEL_PT_BIP:
> +	case INTEL_PT_BEP:
> +	case INTEL_PT_BEP_IP:
>  		return 0;
>  
>  	case INTEL_PT_MTC:
> @@ -878,7 +885,7 @@ static int intel_pt_get_next_packet(struct intel_pt_decoder *decoder)
>  		}
>  
>  		ret = intel_pt_get_packet(decoder->buf, decoder->len,
> -					  &decoder->packet);
> +					  &decoder->packet, &decoder->pkt_ctx);
>  		if (ret == INTEL_PT_NEED_MORE_BYTES && BITS_PER_LONG == 32 &&
>  		    decoder->len < INTEL_PT_PKT_MAX_SZ && !decoder->next_buf) {
>  			ret = intel_pt_get_split_packet(decoder);
> @@ -1624,6 +1631,10 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
>  		case INTEL_PT_MWAIT:
>  		case INTEL_PT_PWRE:
>  		case INTEL_PT_PWRX:
> +		case INTEL_PT_BBP:
> +		case INTEL_PT_BIP:
> +		case INTEL_PT_BEP:
> +		case INTEL_PT_BEP_IP:
>  			decoder->have_tma = false;
>  			intel_pt_log("ERROR: Unexpected packet\n");
>  			err = -EAGAIN;
> @@ -1717,6 +1728,10 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
>  		case INTEL_PT_MWAIT:
>  		case INTEL_PT_PWRE:
>  		case INTEL_PT_PWRX:
> +		case INTEL_PT_BBP:
> +		case INTEL_PT_BIP:
> +		case INTEL_PT_BEP:
> +		case INTEL_PT_BEP_IP:
>  			intel_pt_log("ERROR: Missing TIP after FUP\n");
>  			decoder->pkt_state = INTEL_PT_STATE_ERR3;
>  			decoder->pkt_step = 0;
> @@ -2038,6 +2053,12 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
>  			decoder->state.pwrx_payload = decoder->packet.payload;
>  			return 0;
>  
> +		case INTEL_PT_BBP:
> +		case INTEL_PT_BIP:
> +		case INTEL_PT_BEP:
> +		case INTEL_PT_BEP_IP:
> +			break;
> +
>  		default:
>  			return intel_pt_bug(decoder);
>  		}
> @@ -2076,6 +2097,10 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
>  		case INTEL_PT_MWAIT:
>  		case INTEL_PT_PWRE:
>  		case INTEL_PT_PWRX:
> +		case INTEL_PT_BBP:
> +		case INTEL_PT_BIP:
> +		case INTEL_PT_BEP:
> +		case INTEL_PT_BEP_IP:
>  			intel_pt_log("ERROR: Unexpected packet\n");
>  			err = -ENOENT;
>  			goto out;
> @@ -2282,6 +2307,10 @@ static int intel_pt_walk_to_ip(struct intel_pt_decoder *decoder)
>  		case INTEL_PT_MWAIT:
>  		case INTEL_PT_PWRE:
>  		case INTEL_PT_PWRX:
> +		case INTEL_PT_BBP:
> +		case INTEL_PT_BIP:
> +		case INTEL_PT_BEP:
> +		case INTEL_PT_BEP_IP:
>  		default:
>  			break;
>  		}
> @@ -2632,11 +2661,12 @@ static unsigned char *intel_pt_last_psb(unsigned char *buf, size_t len)
>  static bool intel_pt_next_tsc(unsigned char *buf, size_t len, uint64_t *tsc,
>  			      size_t *rem)
>  {
> +	enum intel_pt_pkt_ctx ctx = INTEL_PT_NO_CTX;
>  	struct intel_pt_pkt packet;
>  	int ret;
>  
>  	while (len) {
> -		ret = intel_pt_get_packet(buf, len, &packet);
> +		ret = intel_pt_get_packet(buf, len, &packet, &ctx);
>  		if (ret <= 0)
>  			return false;
>  		if (packet.type == INTEL_PT_TSC) {
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
> index d426761a549d..2b2793b339c0 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
> @@ -71,6 +71,10 @@ static const char * const packet_name[] = {
>  	[INTEL_PT_MWAIT]	= "MWAIT",
>  	[INTEL_PT_PWRE]		= "PWRE",
>  	[INTEL_PT_PWRX]		= "PWRX",
> +	[INTEL_PT_BBP]		= "BBP",
> +	[INTEL_PT_BIP]		= "BIP",
> +	[INTEL_PT_BEP]		= "BEP",
> +	[INTEL_PT_BEP_IP]	= "BEP",
>  };
>  
>  const char *intel_pt_pkt_name(enum intel_pt_pkt_type type)
> @@ -289,6 +293,55 @@ static int intel_pt_get_pwrx(const unsigned char *buf, size_t len,
>  	return 7;
>  }
>  
> +static int intel_pt_get_bbp(const unsigned char *buf, size_t len,
> +			    struct intel_pt_pkt *packet)
> +{
> +	if (len < 3)
> +		return INTEL_PT_NEED_MORE_BYTES;
> +	packet->type = INTEL_PT_BBP;
> +	packet->count = buf[2] >> 7;
> +	packet->payload = buf[2] & 0x1f;
> +	return 3;
> +}
> +
> +static int intel_pt_get_bip_4(const unsigned char *buf, size_t len,
> +			      struct intel_pt_pkt *packet)
> +{
> +	if (len < 5)
> +		return INTEL_PT_NEED_MORE_BYTES;
> +	packet->type = INTEL_PT_BIP;
> +	packet->count = buf[0] >> 3;
> +	memcpy_le64(&packet->payload, buf + 1, 4);
> +	return 5;
> +}
> +
> +static int intel_pt_get_bip_8(const unsigned char *buf, size_t len,
> +			      struct intel_pt_pkt *packet)
> +{
> +	if (len < 9)
> +		return INTEL_PT_NEED_MORE_BYTES;
> +	packet->type = INTEL_PT_BIP;
> +	packet->count = buf[0] >> 3;
> +	memcpy_le64(&packet->payload, buf + 1, 8);
> +	return 9;
> +}
> +
> +static int intel_pt_get_bep(size_t len, struct intel_pt_pkt *packet)
> +{
> +	if (len < 2)
> +		return INTEL_PT_NEED_MORE_BYTES;
> +	packet->type = INTEL_PT_BEP;
> +	return 2;
> +}
> +
> +static int intel_pt_get_bep_ip(size_t len, struct intel_pt_pkt *packet)
> +{
> +	if (len < 2)
> +		return INTEL_PT_NEED_MORE_BYTES;
> +	packet->type = INTEL_PT_BEP_IP;
> +	return 2;
> +}
> +
>  static int intel_pt_get_ext(const unsigned char *buf, size_t len,
>  			    struct intel_pt_pkt *packet)
>  {
> @@ -329,6 +382,12 @@ static int intel_pt_get_ext(const unsigned char *buf, size_t len,
>  		return intel_pt_get_pwre(buf, len, packet);
>  	case 0xA2: /* PWRX */
>  		return intel_pt_get_pwrx(buf, len, packet);
> +	case 0x63: /* BBP */
> +		return intel_pt_get_bbp(buf, len, packet);
> +	case 0x33: /* BEP no IP */
> +		return intel_pt_get_bep(len, packet);
> +	case 0xb3: /* BEP with IP */
> +		return intel_pt_get_bep_ip(len, packet);
>  	default:
>  		return INTEL_PT_BAD_PACKET;
>  	}
> @@ -477,7 +536,8 @@ static int intel_pt_get_mtc(const unsigned char *buf, size_t len,
>  }
>  
>  static int intel_pt_do_get_packet(const unsigned char *buf, size_t len,
> -				  struct intel_pt_pkt *packet)
> +				  struct intel_pt_pkt *packet,
> +				  enum intel_pt_pkt_ctx ctx)
>  {
>  	unsigned int byte;
>  
> @@ -487,6 +547,22 @@ static int intel_pt_do_get_packet(const unsigned char *buf, size_t len,
>  		return INTEL_PT_NEED_MORE_BYTES;
>  
>  	byte = buf[0];
> +
> +	switch (ctx) {
> +	case INTEL_PT_NO_CTX:
> +		break;
> +	case INTEL_PT_BLK_4_CTX:
> +		if ((byte & 0x7) == 4)
> +			return intel_pt_get_bip_4(buf, len, packet);
> +		break;
> +	case INTEL_PT_BLK_8_CTX:
> +		if ((byte & 0x7) == 4)
> +			return intel_pt_get_bip_8(buf, len, packet);
> +		break;
> +	default:
> +		break;
> +	};
> +
>  	if (!(byte & BIT(0))) {
>  		if (byte == 0)
>  			return intel_pt_get_pad(packet);
> @@ -525,15 +601,65 @@ static int intel_pt_do_get_packet(const unsigned char *buf, size_t len,
>  	}
>  }
>  
> +void intel_pt_upd_pkt_ctx(const struct intel_pt_pkt *packet,
> +			  enum intel_pt_pkt_ctx *ctx)
> +{
> +	switch (packet->type) {
> +	case INTEL_PT_BAD:
> +	case INTEL_PT_PAD:
> +	case INTEL_PT_TSC:
> +	case INTEL_PT_TMA:
> +	case INTEL_PT_MTC:
> +	case INTEL_PT_FUP:
> +	case INTEL_PT_CYC:
> +	case INTEL_PT_CBR:
> +	case INTEL_PT_MNT:
> +	case INTEL_PT_EXSTOP:
> +	case INTEL_PT_EXSTOP_IP:
> +	case INTEL_PT_PWRE:
> +	case INTEL_PT_PWRX:
> +	case INTEL_PT_BIP:
> +		break;
> +	case INTEL_PT_TNT:
> +	case INTEL_PT_TIP:
> +	case INTEL_PT_TIP_PGD:
> +	case INTEL_PT_TIP_PGE:
> +	case INTEL_PT_MODE_EXEC:
> +	case INTEL_PT_MODE_TSX:
> +	case INTEL_PT_PIP:
> +	case INTEL_PT_OVF:
> +	case INTEL_PT_VMCS:
> +	case INTEL_PT_TRACESTOP:
> +	case INTEL_PT_PSB:
> +	case INTEL_PT_PSBEND:
> +	case INTEL_PT_PTWRITE:
> +	case INTEL_PT_PTWRITE_IP:
> +	case INTEL_PT_MWAIT:
> +	case INTEL_PT_BEP:
> +	case INTEL_PT_BEP_IP:
> +		*ctx = INTEL_PT_NO_CTX;
> +		break;
> +	case INTEL_PT_BBP:
> +		if (packet->count)
> +			*ctx = INTEL_PT_BLK_4_CTX;
> +		else
> +			*ctx = INTEL_PT_BLK_8_CTX;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  int intel_pt_get_packet(const unsigned char *buf, size_t len,
> -			struct intel_pt_pkt *packet)
> +			struct intel_pt_pkt *packet, enum intel_pt_pkt_ctx *ctx)
>  {
>  	int ret;
>  
> -	ret = intel_pt_do_get_packet(buf, len, packet);
> +	ret = intel_pt_do_get_packet(buf, len, packet, *ctx);
>  	if (ret > 0) {
>  		while (ret < 8 && len > (size_t)ret && !buf[ret])
>  			ret += 1;
> +		intel_pt_upd_pkt_ctx(packet, ctx);
>  	}
>  	return ret;
>  }
> @@ -611,8 +737,10 @@ int intel_pt_pkt_desc(const struct intel_pt_pkt *packet, char *buf,
>  		return snprintf(buf, buf_len, "%s 0x%llx IP:0", name, payload);
>  	case INTEL_PT_PTWRITE_IP:
>  		return snprintf(buf, buf_len, "%s 0x%llx IP:1", name, payload);
> +	case INTEL_PT_BEP:
>  	case INTEL_PT_EXSTOP:
>  		return snprintf(buf, buf_len, "%s IP:0", name);
> +	case INTEL_PT_BEP_IP:
>  	case INTEL_PT_EXSTOP_IP:
>  		return snprintf(buf, buf_len, "%s IP:1", name);
>  	case INTEL_PT_MWAIT:
> @@ -630,6 +758,12 @@ int intel_pt_pkt_desc(const struct intel_pt_pkt *packet, char *buf,
>  				(unsigned int)((payload >> 4) & 0xf),
>  				(unsigned int)(payload & 0xf),
>  				(unsigned int)((payload >> 8) & 0xf));
> +	case INTEL_PT_BBP:
> +		return snprintf(buf, buf_len, "%s SZ %s-byte Type 0x%llx",
> +				name, packet->count ? "4" : "8", payload);
> +	case INTEL_PT_BIP:
> +		return snprintf(buf, buf_len, "%s ID 0x%02x Value 0x%llx",
> +				name, packet->count, payload);
>  	default:
>  		break;
>  	}
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h
> index 73ddc3a88d07..682b35282abc 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h
> @@ -59,6 +59,10 @@ enum intel_pt_pkt_type {
>  	INTEL_PT_MWAIT,
>  	INTEL_PT_PWRE,
>  	INTEL_PT_PWRX,
> +	INTEL_PT_BBP,
> +	INTEL_PT_BIP,
> +	INTEL_PT_BEP,
> +	INTEL_PT_BEP_IP,
>  };
>  
>  struct intel_pt_pkt {
> @@ -67,10 +71,25 @@ struct intel_pt_pkt {
>  	uint64_t		payload;
>  };
>  
> +/*
> + * Decoding of BIP packets conflicts with single-byte TNT packets. Since BIP
> + * packets only occur in the context of a block (i.e. between BBP and BEP), that
> + * context must be recorded and passed to the packet decoder.
> + */
> +enum intel_pt_pkt_ctx {
> +	INTEL_PT_NO_CTX,	/* BIP packets are invalid */
> +	INTEL_PT_BLK_4_CTX,	/* 4-byte BIP packets */
> +	INTEL_PT_BLK_8_CTX,	/* 8-byte BIP packets */
> +};
> +
>  const char *intel_pt_pkt_name(enum intel_pt_pkt_type);
>  
>  int intel_pt_get_packet(const unsigned char *buf, size_t len,
> -			struct intel_pt_pkt *packet);
> +			struct intel_pt_pkt *packet,
> +			enum intel_pt_pkt_ctx *ctx);
> +
> +void intel_pt_upd_pkt_ctx(const struct intel_pt_pkt *packet,
> +			  enum intel_pt_pkt_ctx *ctx);
>  
>  int intel_pt_pkt_desc(const struct intel_pt_pkt *packet, char *buf, size_t len);
>  
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 3cff8fe2eaa0..f43d3ac2db8b 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -174,13 +174,14 @@ static void intel_pt_dump(struct intel_pt *pt __maybe_unused,
>  	int ret, pkt_len, i;
>  	char desc[INTEL_PT_PKT_DESC_MAX];
>  	const char *color = PERF_COLOR_BLUE;
> +	enum intel_pt_pkt_ctx ctx = INTEL_PT_NO_CTX;
>  
>  	color_fprintf(stdout, color,
>  		      ". ... Intel Processor Trace data: size %zu bytes\n",
>  		      len);
>  
>  	while (len) {
> -		ret = intel_pt_get_packet(buf, len, &packet);
> +		ret = intel_pt_get_packet(buf, len, &packet, &ctx);
>  		if (ret > 0)
>  			pkt_len = ret;
>  		else
> -- 
> 2.17.1

-- 

- Arnaldo

Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B14EC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEA82080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="DqlDD0SI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgAGKeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:34:00 -0500
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:43420 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgAGKeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1578393240;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=z/fsjt78pJMz4B+wjlDWepOeio604O0lnHJYzh166TA=;
  b=DqlDD0SIKXsWANxx/9JzRy2eDavzueQ3lL0f6m4XUDTH9GbuTHlHYlra
   NByICCyYwVnDy9f1wYINw9PjM+QCxbRSdgck7IRPRqm9V0IpZBMN+N/mt
   i0Qsnrnxp9h8EdhlZYNxhwvguTpKZL3479WarHdP+bchYJ5XixmNnNJvs
   E=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=sergey.dyasli@citrix.com; spf=Pass smtp.mailfrom=sergey.dyasli@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  sergey.dyasli@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
  sergey.dyasli@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: iyYQjhefkR0muYjKwTb36+XIOUJ+gc2PhRc9NrwemCf1i3BaA6RVntv+r1OugCWlK/hHj6yLuV
 CrU/7HZxnvEA1YcHBcEVjGfU4/F4fqnpfsSfPdOja8du+46VPz75T7BP1Dfl5T/YruKMhjhDEt
 F9JUnNW+WNKl3fWs9j3JP1vW/VcPbjdISoUEiINvCEQp/ZTmr7VXejs4Q+dKu2yZljChXrvbZb
 mzoWIgppp57ADJAebm9DAx+vtNNecL3jVskp22W6WSUEwxd86iyY3A+c2jRgu3Ex8S98+2pKqQ
 Gmc=
X-SBRS: 2.7
X-MesageID: 10556611
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,405,1571716800"; 
   d="scan'208";a="10556611"
Subject: Re: [Xen-devel] [RFC PATCH 3/3] xen/netback: Fix grant copy across
 page boundary with KASAN
To:     "Durrant, Paul" <pdurrant@amazon.com>,
        "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        "Ross Lagerwall" <ross.lagerwall@citrix.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "sergey.dyasli@citrix.com >> Sergey Dyasli" 
        <sergey.dyasli@citrix.com>
References: <20191217140804.27364-1-sergey.dyasli@citrix.com>
 <20191217140804.27364-4-sergey.dyasli@citrix.com>
 <8e2d5fca57a74d31be8d5daf399454c0@EX13D32EUC003.ant.amazon.com>
From:   Sergey Dyasli <sergey.dyasli@citrix.com>
Autocrypt: addr=sergey.dyasli@citrix.com; keydata=
 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
Message-ID: <1e9c5008-d263-5a90-b1ba-c304861f7ad2@citrix.com>
Date:   Tue, 7 Jan 2020 10:33:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8e2d5fca57a74d31be8d5daf399454c0@EX13D32EUC003.ant.amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/2019 15:14, Durrant, Paul wrote:
>> -----Original Message-----
>> From: Xen-devel <xen-devel-bounces@lists.xenproject.org> On Behalf Of
>> Sergey Dyasli
>> Sent: 17 December 2019 14:08
>> To: xen-devel@lists.xen.org; kasan-dev@googlegroups.com; linux-
>> kernel@vger.kernel.org
>> Cc: Juergen Gross <jgross@suse.com>; Sergey Dyasli
>> <sergey.dyasli@citrix.com>; Stefano Stabellini <sstabellini@kernel.org>;
>> George Dunlap <george.dunlap@citrix.com>; Ross Lagerwall
>> <ross.lagerwall@citrix.com>; Alexander Potapenko <glider@google.com>;
>> Andrey Ryabinin <aryabinin@virtuozzo.com>; Boris Ostrovsky
>> <boris.ostrovsky@oracle.com>; Dmitry Vyukov <dvyukov@google.com>
>> Subject: [Xen-devel] [RFC PATCH 3/3] xen/netback: Fix grant copy across
>> page boundary with KASAN
>>
>> From: Ross Lagerwall <ross.lagerwall@citrix.com>
>>
>> When KASAN (or SLUB_DEBUG) is turned on, the normal expectation that
>> allocations are aligned to the next power of 2 of the size does not
>> hold. Therefore, handle grant copies that cross page boundaries.
>>
>> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
>> Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>
>
> Would have been nice to cc netback maintainers...

Sorry, I'll try to be more careful next time.

>
>> ---
>>  drivers/net/xen-netback/common.h  |  2 +-
>>  drivers/net/xen-netback/netback.c | 55 ++++++++++++++++++++++++-------
>>  2 files changed, 45 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/xen-netback/common.h b/drivers/net/xen-
>> netback/common.h
>> index 05847eb91a1b..e57684415edd 100644
>> --- a/drivers/net/xen-netback/common.h
>> +++ b/drivers/net/xen-netback/common.h
>> @@ -155,7 +155,7 @@ struct xenvif_queue { /* Per-queue data for xenvif */
>>  	struct pending_tx_info pending_tx_info[MAX_PENDING_REQS];
>>  	grant_handle_t grant_tx_handle[MAX_PENDING_REQS];
>>
>> -	struct gnttab_copy tx_copy_ops[MAX_PENDING_REQS];
>> +	struct gnttab_copy tx_copy_ops[MAX_PENDING_REQS * 2];
>>  	struct gnttab_map_grant_ref tx_map_ops[MAX_PENDING_REQS];
>>  	struct gnttab_unmap_grant_ref tx_unmap_ops[MAX_PENDING_REQS];
>>  	/* passed to gnttab_[un]map_refs with pages under (un)mapping */
>> diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-
>> netback/netback.c
>> index 0020b2e8c279..1541b6e0cc62 100644
>> --- a/drivers/net/xen-netback/netback.c
>> +++ b/drivers/net/xen-netback/netback.c
>> @@ -320,6 +320,7 @@ static int xenvif_count_requests(struct xenvif_queue
>> *queue,
>>
>>  struct xenvif_tx_cb {
>>  	u16 pending_idx;
>> +	u8 copies;
>>  };
>
> I know we're a way off the limit (48 bytes) but I wonder if we ought to have a compile time check here that we're not overflowing skb->cb.

I will add a BUILD_BUG_ON()

>
>>
>>  #define XENVIF_TX_CB(skb) ((struct xenvif_tx_cb *)(skb)->cb)
>> @@ -439,6 +440,7 @@ static int xenvif_tx_check_gop(struct xenvif_queue
>> *queue,
>>  {
>>  	struct gnttab_map_grant_ref *gop_map = *gopp_map;
>>  	u16 pending_idx = XENVIF_TX_CB(skb)->pending_idx;
>> +	u8 copies = XENVIF_TX_CB(skb)->copies;
>>  	/* This always points to the shinfo of the skb being checked, which
>>  	 * could be either the first or the one on the frag_list
>>  	 */
>> @@ -450,23 +452,27 @@ static int xenvif_tx_check_gop(struct xenvif_queue
>> *queue,
>>  	int nr_frags = shinfo->nr_frags;
>>  	const bool sharedslot = nr_frags &&
>>  				frag_get_pending_idx(&shinfo->frags[0]) ==
>> pending_idx;
>> -	int i, err;
>> +	int i, err = 0;
>>
>> -	/* Check status of header. */
>> -	err = (*gopp_copy)->status;
>> -	if (unlikely(err)) {
>> -		if (net_ratelimit())
>> -			netdev_dbg(queue->vif->dev,
>> +	while (copies) {
>> +		/* Check status of header. */
>> +		int newerr = (*gopp_copy)->status;
>> +		if (unlikely(newerr)) {
>> +			if (net_ratelimit())
>> +				netdev_dbg(queue->vif->dev,
>>  				   "Grant copy of header failed! status: %d
>> pending_idx: %u ref: %u\n",
>>  				   (*gopp_copy)->status,
>>  				   pending_idx,
>>  				   (*gopp_copy)->source.u.ref);
>> -		/* The first frag might still have this slot mapped */
>> -		if (!sharedslot)
>> -			xenvif_idx_release(queue, pending_idx,
>> -					   XEN_NETIF_RSP_ERROR);
>> +			/* The first frag might still have this slot mapped */
>> +			if (!sharedslot && !err)
>> +				xenvif_idx_release(queue, pending_idx,
>> +						   XEN_NETIF_RSP_ERROR);
>
> Can't this be done after the loop, if there is an accumulated err? I think it would make the code slightly neater.

Looks like xenvif_idx_release() indeed wants to be just after the loop.

>
>> +			err = newerr;
>> +		}
>> +		(*gopp_copy)++;
>> +		copies--;
>>  	}
>> -	(*gopp_copy)++;
>>
>>  check_frags:
>>  	for (i = 0; i < nr_frags; i++, gop_map++) {
>> @@ -910,6 +916,7 @@ static void xenvif_tx_build_gops(struct xenvif_queue
>> *queue,
>>  			xenvif_tx_err(queue, &txreq, extra_count, idx);
>>  			break;
>>  		}
>> +		XENVIF_TX_CB(skb)->copies = 0;
>>
>>  		skb_shinfo(skb)->nr_frags = ret;
>>  		if (data_len < txreq.size)
>> @@ -933,6 +940,7 @@ static void xenvif_tx_build_gops(struct xenvif_queue
>> *queue,
>>  						   "Can't allocate the frag_list
>> skb.\n");
>>  				break;
>>  			}
>> +			XENVIF_TX_CB(nskb)->copies = 0;
>>  		}
>>
>>  		if (extras[XEN_NETIF_EXTRA_TYPE_GSO - 1].type) {
>> @@ -990,6 +998,31 @@ static void xenvif_tx_build_gops(struct xenvif_queue
>> *queue,
>>
>>  		queue->tx_copy_ops[*copy_ops].len = data_len;
>
> If offset_in_page(skb->data)+ data_len can exceed XEN_PAGE_SIZE, does this not need to be truncated?

It is performed as the first thing inside the if condition below.

>>  		queue->tx_copy_ops[*copy_ops].flags = GNTCOPY_source_gref;
>> +		XENVIF_TX_CB(skb)->copies++;
>> +
>> +		if (offset_in_page(skb->data) + data_len > XEN_PAGE_SIZE) {
>> +			unsigned int extra_len = offset_in_page(skb->data) +
>> +					     data_len - XEN_PAGE_SIZE;
>> +
>> +			queue->tx_copy_ops[*copy_ops].len -= extra_len;
>> +			(*copy_ops)++;
>> +
>> +			queue->tx_copy_ops[*copy_ops].source.u.ref = txreq.gref;
>> +			queue->tx_copy_ops[*copy_ops].source.domid =
>> +				queue->vif->domid;
>> +			queue->tx_copy_ops[*copy_ops].source.offset =
>> +				txreq.offset + data_len - extra_len;
>> +
>> +			queue->tx_copy_ops[*copy_ops].dest.u.gmfn =
>> +				virt_to_gfn(skb->data + data_len - extra_len);
>> +			queue->tx_copy_ops[*copy_ops].dest.domid = DOMID_SELF;
>> +			queue->tx_copy_ops[*copy_ops].dest.offset = 0;
>> +
>> +			queue->tx_copy_ops[*copy_ops].len = extra_len;
>> +			queue->tx_copy_ops[*copy_ops].flags =
>> GNTCOPY_source_gref;
>> +
>> +			XENVIF_TX_CB(skb)->copies++;
>> +		}
>>
>>  		(*copy_ops)++;
>>
>> --
>> 2.17.1
>>
>>
>> _______________________________________________
>> Xen-devel mailing list
>> Xen-devel@lists.xenproject.org
>> https://lists.xenproject.org/mailman/listinfo/xen-devel

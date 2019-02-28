Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9487BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7AB2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbfB1MxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:53:02 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:26006 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730792AbfB1MxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:53:02 -0500
X-IronPort-AV: E=Sophos;i="5.58,423,1544486400"; 
   d="scan'208";a="79320580"
Date:   Thu, 28 Feb 2019 12:52:59 +0000
From:   Wei Liu <wei.liu2@citrix.com>
To:     Igor Druzhinin <igor.druzhinin@citrix.com>
CC:     <xen-devel@lists.xenproject.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wei.liu2@citrix.com>,
        <paul.durrant@citrix.com>, <davem@davemloft.net>
Subject: Re: [PATCH v2] xen-netback: fix occasional leak of grant ref
 mappings under memory pressure
Message-ID: <20190228125259.xhih5osz6obtbwzn@zion.uk.xensource.com>
References: <1551358083-14227-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1551358083-14227-1-git-send-email-igor.druzhinin@citrix.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 12:48:03PM +0000, Igor Druzhinin wrote:
> Zero-copy callback flag is not yet set on frag list skb at the moment
> xenvif_handle_frag_list() returns -ENOMEM. This eventually results in
> leaking grant ref mappings since xenvif_zerocopy_callback() is never
> called for these fragments. Those eventually build up and cause Xen
> to kill Dom0 as the slots get reused for new mappings:
> 
> "d0v0 Attempt to implicitly unmap a granted PTE c010000329fce005"
> 
> That behavior is observed under certain workloads where sudden spikes
> of page cache writes coexist with active atomic skb allocations from
> network traffic. Additionally, rework the logic to deal with frag_list
> deallocation in a single place.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>

Acked-by: Wei Liu <wei.liu2@citrix.com>

> ---
>  drivers/net/xen-netback/netback.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
> index 80aae3a..f09948b 100644
> --- a/drivers/net/xen-netback/netback.c
> +++ b/drivers/net/xen-netback/netback.c
> @@ -1072,11 +1072,6 @@ static int xenvif_handle_frag_list(struct xenvif_queue *queue, struct sk_buff *s
>  		skb_frag_size_set(&frags[i], len);
>  	}
>  
> -	/* Copied all the bits from the frag list -- free it. */
> -	skb_frag_list_init(skb);
> -	xenvif_skb_zerocopy_prepare(queue, nskb);
> -	kfree_skb(nskb);
> -
>  	/* Release all the original (foreign) frags. */
>  	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++)
>  		skb_frag_unref(skb, f);
> @@ -1145,6 +1140,8 @@ static int xenvif_tx_submit(struct xenvif_queue *queue)
>  		xenvif_fill_frags(queue, skb);
>  
>  		if (unlikely(skb_has_frag_list(skb))) {
> +			struct sk_buff *nskb = skb_shinfo(skb)->frag_list;
> +			xenvif_skb_zerocopy_prepare(queue, nskb);
>  			if (xenvif_handle_frag_list(queue, skb)) {
>  				if (net_ratelimit())
>  					netdev_err(queue->vif->dev,
> @@ -1153,6 +1150,9 @@ static int xenvif_tx_submit(struct xenvif_queue *queue)
>  				kfree_skb(skb);
>  				continue;
>  			}
> +			/* Copied all the bits from the frag list -- free it. */
> +			skb_frag_list_init(skb);
> +			kfree_skb(nskb);
>  		}
>  
>  		skb->dev      = queue->vif->dev;
> -- 
> 2.7.4
> 

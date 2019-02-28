Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EAFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA84E21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbfB1JrH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:47:07 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:51518 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfB1JrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:47:06 -0500
X-IronPort-AV: E=Sophos;i="5.58,423,1544486400"; 
   d="scan'208";a="86578168"
From:   Paul Durrant <Paul.Durrant@citrix.com>
To:     Igor Druzhinin <igor.druzhinin@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wei Liu <wei.liu2@citrix.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Igor Druzhinin <igor.druzhinin@citrix.com>
Subject: RE: [PATCH] xen-netback: fix occasional leak of grant ref mappings
 under memory pressure
Thread-Topic: [PATCH] xen-netback: fix occasional leak of grant ref mappings
 under memory pressure
Thread-Index: AQHUzwnalyGnLUhGt0OYo7x3WDkwmKX09AIQ
Date:   Thu, 28 Feb 2019 09:46:57 +0000
Message-ID: <8424fba34a1f43908a6dae3a9308863b@AMSPEX02CL02.citrite.net>
References: <1551319382-32595-1-git-send-email-igor.druzhinin@citrix.com>
In-Reply-To: <1551319382-32595-1-git-send-email-igor.druzhinin@citrix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Igor Druzhinin [mailto:igor.druzhinin@citrix.com]
> Sent: 28 February 2019 02:03
> To: xen-devel@lists.xenproject.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Wei Liu <wei.liu2@citrix.com>; Paul Durrant <Paul.Durrant@citrix.com>; davem@davemloft.net; Igor
> Druzhinin <igor.druzhinin@citrix.com>
> Subject: [PATCH] xen-netback: fix occasional leak of grant ref mappings under memory pressure
> 
> Zero-copy callback flag is not yet set on frag list skb at the moment
> xenvif_handle_frag_list() returns -ENOMEM. This eventually results in
> leaking grant ref mappings since xenvif_zerocopy_callback() is never
> called for these fragments. Those eventually build up and cause Xen
> to kill Dom0 as the slots get reused for new mappings.
> 
> That behavior is observed under certain workloads where sudden spikes
> of page cache usage for writes coexist with active atomic skb allocations.
> 
> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
> ---
>  drivers/net/xen-netback/netback.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
> index 80aae3a..2023317 100644
> --- a/drivers/net/xen-netback/netback.c
> +++ b/drivers/net/xen-netback/netback.c
> @@ -1146,9 +1146,12 @@ static int xenvif_tx_submit(struct xenvif_queue *queue)
> 
>  		if (unlikely(skb_has_frag_list(skb))) {
>  			if (xenvif_handle_frag_list(queue, skb)) {
> +				struct sk_buff *nskb =
> +						skb_shinfo(skb)->frag_list;
>  				if (net_ratelimit())
>  					netdev_err(queue->vif->dev,
>  						   "Not enough memory to consolidate frag_list!\n");
> +				xenvif_skb_zerocopy_prepare(queue, nskb);
>  				xenvif_skb_zerocopy_prepare(queue, skb);
>  				kfree_skb(skb);
>  				continue;

Whilst this fix will do the job, I think it would be better to get rid of the kfree_skb() from inside xenvif_handle_frag_list() and always deal with it here rather than having it happen in two different places. Something like the following...

---8<---
diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index 80aae3a32c2a..093c7b860772 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -1027,13 +1027,13 @@ static void xenvif_tx_build_gops(struct xenvif_queue *queue,
 /* Consolidate skb with a frag_list into a brand new one with local pages on
  * frags. Returns 0 or -ENOMEM if can't allocate new pages.
  */
-static int xenvif_handle_frag_list(struct xenvif_queue *queue, struct sk_buff *skb)
+static int xenvif_handle_frag_list(struct xenvif_queue *queue, struct sk_buff *diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index 80aae3a32c2a..093c7b860772 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -1027,13 +1027,13 @@ static void xenvif_tx_build_gops(struct xenvif_queue *qu
eue,
 /* Consolidate skb with a frag_list into a brand new one with local pages on
  * frags. Returns 0 or -ENOMEM if can't allocate new pages.
  */
-static int xenvif_handle_frag_list(struct xenvif_queue *queue, struct sk_buff *
skb)
+static int xenvif_handle_frag_list(struct xenvif_queue *queue, struct sk_buff *
skb,
+                                  struct sk_buff *nskb)
 {
        unsigned int offset = skb_headlen(skb);
        skb_frag_t frags[MAX_SKB_FRAGS];
        int i, f;
        struct ubuf_info *uarg;
-       struct sk_buff *nskb = skb_shinfo(skb)->frag_list;

        queue->stats.tx_zerocopy_sent += 2;
        queue->stats.tx_frag_overflow++;
@@ -1072,11 +1072,6 @@ static int xenvif_handle_frag_list(struct xenvif_queue *q
ueue, struct sk_buff *s
                skb_frag_size_set(&frags[i], len);
        }

-       /* Copied all the bits from the frag list -- free it. */
-       skb_frag_list_init(skb);
-       xenvif_skb_zerocopy_prepare(queue, nskb);
-       kfree_skb(nskb);
-
        /* Release all the original (foreign) frags. */
        for (f = 0; f < skb_shinfo(skb)->nr_frags; f++)
                skb_frag_unref(skb, f);
@@ -1145,7 +1140,11 @@ static int xenvif_tx_submit(struct xenvif_queue *queue)
                xenvif_fill_frags(queue, skb);

                if (unlikely(skb_has_frag_list(skb))) {
-                       if (xenvif_handle_frag_list(queue, skb)) {
+                       struct sk_buff *nskb = skb_shinfo(skb)->frag_list;
+
+                       xenvif_skb_zerocopy_prepare(queue, nskb);
+
+                       if (xenvif_handle_frag_list(queue, skb, nskb)) {
                                if (net_ratelimit())
                                        netdev_err(queue->vif->dev,
                                                   "Not enough memory to consolidate frag_list!\n");
@@ -1153,6 +1152,10 @@ static int xenvif_tx_submit(struct xenvif_queue *queue)
                                kfree_skb(skb);
                                continue;
                        }
+
+                       /* Copied all the bits from the frag list. */
+                       skb_frag_list_init(skb);
+                       kfree(nskb);
                }

                skb->dev      = queue->vif->dev;
---8<---

What do you think?

  Paul

> --
> 2.7.4


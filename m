Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1485EC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D724C20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355003;
	bh=9kB2UqVNkZ1GL3DOYo+QbBILVKKZvFBQybL6Dsc+gPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UYU1xU6bSDIebI0s+1/DT4261XnoDXUBqCTY7vA0PF1sPz223ah2nqXflZQEVQdiV
	 nwapqWE7nuV61YxJhW92IzmgIL7ChT9Anblt+y50HUveFL3vdisKVFsJlMQ/knhyOB
	 egOjztqY7QSTCOkldtfFqd8EpVaQweqhTCSjPyzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfDOTDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:03:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbfDOTDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:03:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 761AF20880;
        Mon, 15 Apr 2019 19:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355000;
        bh=9kB2UqVNkZ1GL3DOYo+QbBILVKKZvFBQybL6Dsc+gPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aekCGlGFGS+z6NT161g8QcqnMZfOuwIKYOiVNrwJQpXGWrO3squbfhrPTwMHgjnfz
         ER7OwEP5vYhij3Sq7Pfof4l/xjG5gvfXaijt2t1wxxMr0Hxzov4T4FbWmIc/t+Ovqg
         JqjectZ892/42wR23lVL1UzEyVz/JLrWcwpa3BgU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Hurley <john.hurley@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 30/69] nfp: validate the return code from dev_queue_xmit()
Date:   Mon, 15 Apr 2019 20:58:48 +0200
Message-Id: <20190415183731.498737115@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit c8ba5b91a04e3e2643e48501c114108802f21cda ]

dev_queue_xmit() may return error codes as well as netdev_tx_t,
and it always consumes the skb.  Make sure we always return a
correct netdev_tx_t value.

Fixes: eadfa4c3be99 ("nfp: add stats and xmit helpers for representors")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: John Hurley <john.hurley@netronome.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
@@ -200,7 +200,7 @@ static netdev_tx_t nfp_repr_xmit(struct
 	ret = dev_queue_xmit(skb);
 	nfp_repr_inc_tx_stats(netdev, len, ret);
 
-	return ret;
+	return NETDEV_TX_OK;
 }
 
 static int nfp_repr_stop(struct net_device *netdev)



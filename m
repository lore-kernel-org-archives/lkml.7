Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3F8FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5974721925
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263345;
	bh=LWgLsoX1gvGw1i0WlasUv7H00ezR1kmu8IDt3Rw9Tqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V92ZoFNrPAuoVxlZmPFTZPSL3jeXUzqkTcy2P6D/ESuL/25Z/WUijmhpXH4BMqvhM
	 wJXIvbKfHrLSJhNYY5dmQWeKBRCg76KGhoakN9LmrHJFmB4Wdyn278w0lVmYAYDDvy
	 VvDYnccZEcT6/rGYSA2Jq0DYo0q1+zlCgKeMbWsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438618AbfJPV7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438255AbfJPV6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:58:46 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D12921925;
        Wed, 16 Oct 2019 21:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263125;
        bh=LWgLsoX1gvGw1i0WlasUv7H00ezR1kmu8IDt3Rw9Tqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MMO22C3vrL2NCjHF4a1PDkzz1MWUCBFY+u+7hgu4WbAOsE1jBAnkIEURyHMDW8+IZ
         9htgkeUgwWg9nhn4i02qI8bD/+PrXYXOTShQwhHm4Zpf5Wqook0iQY8EaJTl0+4wcA
         O42kXFWTMFtLGTEMHG+dLDcm2z1DuudSGVos0YKo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Dan Carpenter <dan.carpenter@gmail.com>
Subject: [PATCH 5.3 049/112] Staging: fbtft: fix memory leak in fbtft_framebuffer_alloc
Date:   Wed, 16 Oct 2019 14:50:41 -0700
Message-Id: <20191016214855.334419989@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit 5bdea6060618cfcf1459dca137e89aee038ac8b9 upstream.

In fbtft_framebuffer_alloc the error handling path should take care of
releasing frame buffer after it is allocated via framebuffer_alloc, too.
Therefore, in two failure cases the goto destination is changed to
address this issue.

Fixes: c296d5f9957c ("staging: fbtft: core support")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20190930030949.28615-1-navid.emamdoost@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/fbtft/fbtft-core.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -714,7 +714,7 @@ struct fb_info *fbtft_framebuffer_alloc(
 	if (par->gamma.curves && gamma) {
 		if (fbtft_gamma_parse_str(par, par->gamma.curves, gamma,
 					  strlen(gamma)))
-			goto alloc_fail;
+			goto release_framebuf;
 	}
 
 	/* Transmit buffer */
@@ -731,7 +731,7 @@ struct fb_info *fbtft_framebuffer_alloc(
 	if (txbuflen > 0) {
 		txbuf = devm_kzalloc(par->info->device, txbuflen, GFP_KERNEL);
 		if (!txbuf)
-			goto alloc_fail;
+			goto release_framebuf;
 		par->txbuf.buf = txbuf;
 		par->txbuf.len = txbuflen;
 	}
@@ -753,6 +753,9 @@ struct fb_info *fbtft_framebuffer_alloc(
 
 	return info;
 
+release_framebuf:
+	framebuffer_release(info);
+
 alloc_fail:
 	vfree(vmem);
 



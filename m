Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CB6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7628920672
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141644;
	bh=hVTmL0FORV+KWz1VpzuweX8Ats/8839pboW72CRooBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UU60Xb9KIOVuucIRB77+Ysd6qNma2JBNnuqSS4Eyu4venzR55D/F1SXgj2IJJ58vU
	 AbYXIzDHwm8XQr4Q08OqKzDlTuT8WqDgc5qHtv1aOSl5g8UVigQWdcD+z4l+YOEwth
	 2bWLCNT8gF2UFzU7oCHw9/aRCzqVEipJt7ofBnk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfKSFeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:34:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729597AbfKSFeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:34:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5D8220672;
        Tue, 19 Nov 2019 05:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141639;
        bh=hVTmL0FORV+KWz1VpzuweX8Ats/8839pboW72CRooBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gbs8l+9UKhqqWMjcKUSfc1YeCZConPMldrWybIVVFDFvrmVnVS+Z7OGT5g0mzJMUO
         mZUKAqObaVmLydLFstp+3Cz7x2HlRAaGAwnlCdCGX/F6VjbbwIsri0Ry75H4mn8qxC
         OBNsRvhjsckieA+GJfV1MwXo41IXC1ldF/yx7J5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 189/422] media: dt-bindings: adv748x: Fix decimal unit addresses
Date:   Tue, 19 Nov 2019 06:16:26 +0100
Message-Id: <20191119051410.759767849@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 27582f0ea97fe3e4a38beb98ab36cce4b6f029d5 ]

With recent dtc and W=1:

    Warning (graph_port): video-receiver@70/port@10: graph node unit address error, expected "a"
    Warning (graph_port): video-receiver@70/port@11: graph node unit address error, expected "b"

Unit addresses are always hexadecimal (without prefix), while the bases
of reg property values depend on their prefixes.

Fixes: e69595170b1cad85 ("media: adv748x: Add adv7481, adv7482 bindings")

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/media/i2c/adv748x.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/adv748x.txt b/Documentation/devicetree/bindings/media/i2c/adv748x.txt
index 21ffb5ed81830..54d1d3bc18694 100644
--- a/Documentation/devicetree/bindings/media/i2c/adv748x.txt
+++ b/Documentation/devicetree/bindings/media/i2c/adv748x.txt
@@ -73,7 +73,7 @@ Example:
 			};
 		};
 
-		port@10 {
+		port@a {
 			reg = <10>;
 
 			adv7482_txa: endpoint {
@@ -83,7 +83,7 @@ Example:
 			};
 		};
 
-		port@11 {
+		port@b {
 			reg = <11>;
 
 			adv7482_txb: endpoint {
-- 
2.20.1




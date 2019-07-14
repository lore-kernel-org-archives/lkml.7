Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214B7C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79692063F
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563117028;
	bh=M8nkO3xj/tK7Ft6Aqn/qbtZ/dPN3Wb9pvD6da1DPTiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oFDOV84xmIHhNKdfem4MOwIbaqYsPcMBB/FKtD1v+DQusEEDVio2YO9W1T2r3aL86
	 N2ljuCOcYhVrqN7to3jhg1jlUDMkValXPahiZLL6Hp1XsUsOxBmEhhkjxXY6i97OGy
	 iHg3p5pUQwEHGpuJaR9OPoSY38B720+jzt7xwY7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfGNPK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 11:10:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfGNPKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 11:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jFyzo3As5CrICxDhs7tl/BXq0/acefqHr/iuBUuENY8=; b=gMO/ftlGwyFgSdBRkJINYx7xxv
        GDpoWZQUSpNsCJRlVo1WL4IvlNkUn13Twk3FwFjCx0yl3d+bx4ARpk9Nfuxp8PFKS7Hi2Ag+V2vWX
        v5VV2d9JzhfOJEP1uGtwe+4XHGwjBMmtsdF3H+LIVNvLyITuSDBPpui3u+2TcxYShIMmHfICQZ9QI
        dUawkU/p1DiuoEZYP0QNiUYxCFa8BzxtXx6T1aCLF/L9PvBUKodNwzQvECrngZPVqq/McXtc5+K1g
        zZk7iRsP27ioB6lj0LOCAJZaPU34dwglPkHWEGR777LgyzkbSSPfU1X5KeqQjDhZQM5K8S+5kA/ML
        EmkyDbjA==;
Received: from 201.86.163.160.dynamic.adsl.gvt.net.br ([201.86.163.160] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmg8o-0004f5-EI; Sun, 14 Jul 2019 15:10:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hmg8l-0007TG-26; Sun, 14 Jul 2019 12:10:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 5/8] scripts/sphinx-pre-install: cleanup Gentoo checks
Date:   Sun, 14 Jul 2019 12:10:10 -0300
Message-Id: <853ba32a59561b1ec11bd12c9607d7fe4bf84922.1563115732.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563115732.git.mchehab+samsung@kernel.org>
References: <cover.1563115732.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Gentoo, the portage changes for ImageMagick to work are
always suggested, even if already applied. While the two
extra commands should be harmless, add a check to avoid
reporting it without need.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/sphinx-pre-install | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 8dc13fe95ffe..0a5c83aa5f44 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -533,8 +533,19 @@ sub give_gentoo_hints()
 	return if (!$need && !$optional);
 
 	printf("You should run:\n\n");
-	printf("\tsudo su -c 'echo \"media-gfx/imagemagick svg png\" > /etc/portage/package.use/imagemagick'\n");
-	printf("\tsudo su -c 'echo \"media-gfx/graphviz cairo pdf\" > /etc/portage/package.use/graphviz'\n");
+
+	my $imagemagick = "media-gfx/imagemagick svg png";
+	my $cairo = "media-gfx/graphviz cairo pdf";
+	my $portage_imagemagick = "/etc/portage/package.use/imagemagick";
+	my $portage_cairo = "/etc/portage/package.use/graphviz";
+
+	if (qx(cat $portage_imagemagick) ne "$imagemagick\n") {
+		printf("\tsudo su -c 'echo \"$imagemagick\" > $portage_imagemagick'\n")
+	}
+	if (qx(cat $portage_cairo) ne  "$cairo\n") {
+		printf("\tsudo su -c 'echo \"$cairo\" > $portage_cairo'\n");
+	}
+
 	printf("\tsudo emerge --ask $install\n");
 
 }
-- 
2.21.0


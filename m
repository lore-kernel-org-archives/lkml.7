Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C84C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906DC206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560440116;
	bh=yQDo3aG80+76CZc8vNJaHa1q0KrK4cCRgQLyIDojr5M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jojPigTHKJllljuGtEZxGCaTEBBBp1snfDPeUIcrUjbbIhnCPM7zvdO/haeDr9kUD
	 a06Xu5DEddJPIJbYfLYW3w4hRvqCD1VFepXAjPfjVElVVnjtiyTGC5rfh8OncPHVuz
	 uIosRORIPTa56ynTcHg8vSinuxYEPd140ezzCkNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbfFMPfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:35:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbfFMK3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l6eX/LOpY2lKbloYe4ibvvvCroTQzEKMG7QHU9kz2r0=; b=Knqjy4+Nqo87caXZLzc3vAHdL
        t3AV50Ce06k9sbtYT+1Hy7lHc7R9B8WlT71KU0CrbbPEdmAhPvyvNfgRpCVNgmXC1dWh63eaRWeuW
        nz5MVAowbfTtwkqOvyq2Z+0QV0IWMmpChU/Pb+hlT1xLZ8BHVurZu/OZD2kw4dbDm8oM68SkQ29Om
        yfrdbQwmM1c1Ll6e5X/J2rj3xkSe3GGRW86oqoZV6fbXUPtyOoKAgo8V+qIyJHP3714JHNRjsKgHS
        jpFjLQz2iLy2j75wlPMKiYtWwz8HFklYqMk2lb8ytcTjqVhTgtbMw2N1pJ1Db/TZdoQ23N8JXre3q
        1REHKG7mw==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbMyx-0007Z4-Hz; Thu, 13 Jun 2019 10:29:23 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbMyv-0005vt-KN; Thu, 13 Jun 2019 07:29:21 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] scripts/documentation-file-ref-check: ignore output dir
Date:   Thu, 13 Jun 2019 07:29:17 -0300
Message-Id: <093d01459be472a20894c5be6f9b937ff7fd7d47.1560421751.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there's no Documentation/output directory, the script will
complain about those missing references:

	Documentation/doc-guide/sphinx.rst: Documentation/output
	Documentation/doc-guide/sphinx.rst: Documentation/output
	Documentation/process/howto.rst: Documentation/output
	Documentation/translations/it_IT/doc-guide/sphinx.rst: Documentation/output
	Documentation/translations/it_IT/doc-guide/sphinx.rst: Documentation/output
	Documentation/translations/it_IT/process/howto.rst: Documentation/output
	Documentation/translations/ja_JP/howto.rst: Documentation/output
	Documentation/translations/ko_KR/howto.rst: Documentation/output

Those are false positives, so add an ignore rule for them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/documentation-file-ref-check | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/documentation-file-ref-check b/scripts/documentation-file-ref-check
index a4139a576726..7784c54aa38b 100755
--- a/scripts/documentation-file-ref-check
+++ b/scripts/documentation-file-ref-check
@@ -90,6 +90,9 @@ while (<IN>) {
 	# Skip this script
 	next if ($f eq $scriptname);
 
+	# Ignore the dir where documentation will be built
+	next if ($ln =~ m,\b(\S*)Documentation/output,);
+
 	if ($ln =~ m,\b(\S*)(Documentation/[A-Za-z0-9\_\.\,\~/\*\[\]\?+-]*)(.*),) {
 		my $prefix = $1;
 		my $ref = $2;
-- 
2.21.0


Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,WEIRD_PORT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9E7C31E60
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A722084A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560892052;
	bh=r8VnT3QNR87iGr8C8ynzjeSytX/wiQGiOpdeAaMK8qY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X/hzkP5+yx6ReZJV90LVYslU8T/MvdV0HfJOB77bpdEA9xpBSlVC2iIvg5fuRn/aC
	 g8Z6AY9kEDIimVbxNTiVHbDm5W1mgMyQpY5hHEgoe+hbuH9ivduZOHgM7sZrpg/4eI
	 k44fIMFTZOgXKUzR/WUcya7moWnZzOTBUPBTHs70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbfFRVHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 17:07:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34516 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730791AbfFRVFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 17:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fDp1vmYN70Ky7jAA9wBp1x588BaRAa6H0+xb29YYzd0=; b=ihWgwoLA1rEkPJ7pJkXH9pTfe6
        Ym4Du3265C3P6voKHYz6wDpiElgEtojtfsLLiH7b2O70e8N0xD7HRUlsCLQvzNYEcvlu4wGSR5dho
        GnnWZ8ugZBA2yg6feTnazRbf2QJ2OtuzFmwdpRxNTtBf/00EsliXhv/FZRnoak9sBYPPdkxCPHKqI
        AZuhhdpUvQFa++mzdIW5sNQdeXowjd1oJnulVzhgesjYush9sUBujlS9TpxP6i++NHTG+fE9/dFO3
        zP2Vl1YVR1TR/zKdFshphzhBm2hKNGffewW/B8a/n0UZoLxR+7r5fbiquy2hHEXzuJahEUkISYtI9
        8RfKd/3Q==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdLIc-0006yp-4A; Tue, 18 Jun 2019 21:05:50 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdLIZ-0002Cc-W8; Tue, 18 Jun 2019 18:05:48 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ning Sun <ning.sun@intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        tboot-devel@lists.sourceforge.net,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 13/22] docs: x86: move two x86-specific files to x86 arch dir
Date:   Tue, 18 Jun 2019 18:05:37 -0300
Message-Id: <a6edb615e3a280a2702c02fc395913e4be6b869e.1560891322.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560891322.git.mchehab+samsung@kernel.org>
References: <cover.1560891322.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those two docs belong to the x86 architecture.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/x86/index.rst                            | 2 ++
 Documentation/{Intel-IOMMU.rst => x86/intel-iommu.rst} | 1 -
 Documentation/{ => x86}/intel_txt.rst                  | 1 -
 MAINTAINERS                                            | 2 +-
 security/Kconfig                                       | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename Documentation/{Intel-IOMMU.rst => x86/intel-iommu.rst} (99%)
 rename Documentation/{ => x86}/intel_txt.rst (99%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index f2de1b2d3ac7..af64c4bb4447 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -20,6 +20,8 @@ x86-specific Documentation
    mtrr
    pat
    intel_mpx
+   intel-iommu
+   intel_txt
    amd-memory-encryption
    pti
    mds
diff --git a/Documentation/Intel-IOMMU.rst b/Documentation/x86/intel-iommu.rst
similarity index 99%
rename from Documentation/Intel-IOMMU.rst
rename to Documentation/x86/intel-iommu.rst
index b001104c25c8..c7cf568c0ce7 100644
--- a/Documentation/Intel-IOMMU.rst
+++ b/Documentation/x86/intel-iommu.rst
@@ -1,4 +1,3 @@
-:orphan:
 
 ===================
 Linux IOMMU Support
diff --git a/Documentation/intel_txt.rst b/Documentation/x86/intel_txt.rst
similarity index 99%
rename from Documentation/intel_txt.rst
rename to Documentation/x86/intel_txt.rst
index 5a55007ecf08..d6af4c7d7625 100644
--- a/Documentation/intel_txt.rst
+++ b/Documentation/x86/intel_txt.rst
@@ -1,4 +1,3 @@
-:orphan:
 
 =====================
 Intel(R) TXT Overview
diff --git a/MAINTAINERS b/MAINTAINERS
index 85a6f090ccc0..b7364119ce83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8208,7 +8208,7 @@ L:	tboot-devel@lists.sourceforge.net
 W:	http://tboot.sourceforge.net
 T:	hg http://tboot.hg.sourceforge.net:8000/hgroot/tboot/tboot
 S:	Supported
-F:	Documentation/intel_txt.rst
+F:	Documentation/x86/intel_txt.rst
 F:	include/linux/tboot.h
 F:	arch/x86/kernel/tboot.c
 
diff --git a/security/Kconfig b/security/Kconfig
index 4da0d09c3e49..0d65594b5196 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -121,7 +121,7 @@ config INTEL_TXT
 	  See <http://www.intel.com/technology/security/> for more information
 	  about Intel(R) TXT.
 	  See <http://tboot.sourceforge.net> for more information about tboot.
-	  See Documentation/intel_txt.rst for a description of how to enable
+	  See Documentation/x86/intel_txt.rst for a description of how to enable
 	  Intel TXT support in a kernel boot.
 
 	  If you are unsure as to whether this is required, answer N.
-- 
2.21.0


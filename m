Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7974FC072B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B3020883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558955289;
	bh=FcIEge0zk+jjeAe3jF8drHA93MwW2ubxP9ptYQVAVIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uD+yIHD5FwEcABUQ2yB2i5NxH6YuWajoaiqkNlK6yz3inWhl0jPNhdYk1ceIWkaF0
	 /ozoROCmMEUS71qyKqUA2upw364SDfJ4Ui2BGAkkKwj4pWlDWY4ik3IcHiVRzUmtXs
	 wjSCd4/LNoJd0E6XJDpkgA2oLc678WlAGpkd69bA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfE0LHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 07:07:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57836 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfE0LHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uQCGkdMpLup5seR2eOGZrEj83EK7R6BAf5CrYNPT128=; b=kkDbAtbig016mmWPk8Q0ECOcNj
        6i2x6TRRxm4pHg7q3zywdNvrVs9WWeNsxq3w9Gd7v2tarbn1H3xpSsDlPWX4gLPezG0bpho94/h+v
        62+mv5ya/1QC+iZREHYViN0Dlla+oOJoWs5/EbGNRiG+nBYqEKi8yHgq3TSh9VFXiOuJM5qzE2Ngx
        mTu3xOeYoV8vPuLOibnNBdUf52Og/A36QXmcSz4gTKNEr/una58qXtqftt7QUkCtXXyVvKBnsAB59
        rJMf9IlCyYwUrmOv9mqhkbESd+Pr/FAL+pRLbR62WC5iOd/HXgjQqJdz+ysoCimzGWsxfZPSvD9XZ
        3W7lZGWw==;
Received: from [177.159.249.4] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVDTn-00061v-O8; Mon, 27 May 2019 11:07:47 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hVDTi-0002cq-Qa; Mon, 27 May 2019 08:07:42 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 4/5] docs: by default, build docs a lot faster with Sphinx >= 1.7
Date:   Mon, 27 May 2019 08:07:40 -0300
Message-Id: <baf19095789f2b2ed0c7a940703037a00cd77850.1558955082.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558955082.git.mchehab+samsung@kernel.org>
References: <cover.1558955082.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Sphinx version 1.7, it is possible to use "-jauto" in
order to speedup documentation builds. On older versions,
while -j was already supported, one would need to set the
number of threads manually.

So, if SPHINXOPTS is not provided, add -jauto, in order to
speed up the build. That makes it *a lot* times faster than
without -j.

If one really wants to slow things down, it can just use:

	make SPHINXOPTS=-j1 htmldocs

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 380e24053d6f..794233d05789 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -28,6 +28,8 @@ ifeq ($(HAVE_SPHINX),0)
 
 else # HAVE_SPHINX
 
+SPHINXOPTS = $(shell perl -e 'open IN,"sphinx-build --version |"; while (<IN>) { if (m/([\d\.]+)/) { print "-jauto" if ($$1 >= "1.7") } ;} close IN')
+
 # User-friendly check for pdflatex and latexmk
 HAVE_PDFLATEX := $(shell if which $(PDFLATEX) >/dev/null 2>&1; then echo 1; else echo 0; fi)
 HAVE_LATEXMK := $(shell if which latexmk >/dev/null 2>&1; then echo 1; else echo 0; fi)
-- 
2.21.0


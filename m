Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78B9C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 13:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9519E2173C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 13:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553953570;
	bh=0QilTRzxNO5xB15mBruAGJAMibWGxas3okOvzDSSd8U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=N81SseAmJ52Hj106zlPboRmhv5TwzaKhC9ADAyeDgyo3Qk48fsp71JaVwTlwJ11bq
	 X7V1PxbbfZfnyHE5pyZsbVdlbvPQn7Rl3Y21OmnaRLyHzyuvE6h4CmxeCQX70AlWoX
	 4+HrP7yJguuvJrixnpRE6a+gZJhv8N/s6iyGkrmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbfC3NqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 09:46:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730839AbfC3NqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 09:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ymGHAe8Xb+yjWOhZHRIj9ejbnXMe6pMmo0/tWfE5DPI=; b=foMBxMvVYX7b90DNeiET/+RuP
        xeBp1yySYd8YL6X5c8IGeqx7oA8qbxaAWLc6StnwE9meiu/WZG2+ixj2hoRDGolVeu+CqGQhFTxLB
        b+5GAdQ7WYanWJgtkDyN9AD2NhnQ+bvBW4EL6cVUorZz5KVAR+4m3exF0XqITTYr7TRdlmMoE2yhH
        yMHwcKvT1gC2f5LvX2OZ6NnsZPIV/MZCJC28DurOnoEBinBOsaoSWBBkwCBx3aHdnM4nucVlpu4Us
        0ua5akGXBQ53g3+euT0IBe7/5KeUNowZCeDnam20PeJNo9G/4Ap319TiMM2kFRonf6W1pOfUOokZT
        oLoRLo89g==;
Received: from [179.95.36.211] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hAEJ9-0003vS-OT; Sat, 30 Mar 2019 13:46:03 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hAEJ6-0007P6-QP; Sat, 30 Mar 2019 10:46:00 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/2] docs: Makefile: use latexmk if available
Date:   Sat, 30 Mar 2019 10:45:58 -0300
Message-Id: <bfcc25db0c687797697d4ad71703ff8449072fad.1553953553.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the past, Sphinx was generating a LaTex Makefile that would
run xelatex 3 times. Running it multiple times is needed in order
to make the indexes right.

However, newer versions of it runs it just once, as it expects
the machine to use the "latexmk" build, with automatically
detects the need for rebuilds.

So, add a logic at the Makefile in order to detect if latexmk
is installed. If so, it will call it.

As an additional bonus, the output of latexmk is a little bit
better, making easier to identify build problems.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/Makefile | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 9786957c6a35..e889e7cb8511 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -28,8 +28,13 @@ ifeq ($(HAVE_SPHINX),0)
 
 else # HAVE_SPHINX
 
-# User-friendly check for pdflatex
+# User-friendly check for pdflatex and latexmk
 HAVE_PDFLATEX := $(shell if which $(PDFLATEX) >/dev/null 2>&1; then echo 1; else echo 0; fi)
+HAVE_LATEXMK := $(shell if which latexmk >/dev/null 2>&1; then echo 1; else echo 0; fi)
+
+ifeq ($(HAVE_LATEXMK),1)
+	PDFLATEX := latexmk -$(PDFLATEX)
+endif #HAVE_LATEXMK
 
 # Internal variables.
 PAPEROPT_a4     = -D latex_paper_size=a4
@@ -82,7 +87,7 @@ pdfdocs:
 else # HAVE_PDFLATEX
 
 pdfdocs: latexdocs
-	$(foreach var,$(SPHINXDIRS), $(MAKE) PDFLATEX=$(PDFLATEX) LATEXOPTS="$(LATEXOPTS)" -C $(BUILDDIR)/$(var)/latex || exit;)
+	$(foreach var,$(SPHINXDIRS), $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" -C $(BUILDDIR)/$(var)/latex || exit;)
 
 endif # HAVE_PDFLATEX
 
-- 
2.20.1


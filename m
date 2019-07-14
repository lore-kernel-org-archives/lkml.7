Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53A1C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E362063F
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563117041;
	bh=/hZDxUz8AnLnzXUu8/Bpf1rqpk9kLL0hYmaAbLzV3Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HWXXEJ4Yk9SuCp8sHScCBIVyVrUR0F0VVC+StwgUkwf/DGe1xMdESFNXnNa6GbpS1
	 M4IcyX2j9kFJriTuwFCbGLnwjPDSfeBgpWXqsvbgZP1dG8kuJVrHY3RN05Q3MMD+Uf
	 91RChe/yd5tx9OBLPsO5Nu6W8yu0+eyPioMg3enQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfGNPKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 11:10:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45536 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbfGNPKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 11:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BHbEVXmpRXCdh5Jrvlt6ed3il/gE3QsZ5hyzVd7gNN0=; b=V5dTy3ecDVyVve2LdA9CapeQBX
        Qtg8igUfrNsWqh8fqMte//tGz12fkhLz3mflQziMLaOvt0hJSggUATibBzfBvcvBJOL99l35TG43C
        Rr8XsZ/5fUJnLw8rz01SnkU8uTFU+IH9eO/abqrwirasMX1HTyF81vMJTxow4h1e/StlKtkQKwwGt
        AGTCnbE5QxruJAVSz7VMiwSNfmK/6/u+OXzuwcSFWwbql5QQ1cejmltJXN+gHRV0SMTROq1Jc2S+B
        bk6VlqsLct6eXw++bVkzAJCQyKv5CZKSu4tFdKj6npxVdM2tOCj5LaBQ6HwIEqiIuVita+OHbTq1n
        6H8NtBqA==;
Received: from 201.86.163.160.dynamic.adsl.gvt.net.br ([201.86.163.160] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmg8o-0004fA-EX; Sun, 14 Jul 2019 15:10:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hmg8k-0007T4-Vu; Sun, 14 Jul 2019 12:10:14 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/8] scripts/sphinx-pre-install: fix script for RHEL/CentOS
Date:   Sun, 14 Jul 2019 12:10:07 -0300
Message-Id: <947eaf63519e19c98dbafc43cf4176d07f56ba6d.1563115732.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563115732.git.mchehab+samsung@kernel.org>
References: <cover.1563115732.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a missing parenthesis at the script, with causes it to
fail to detect non-Fedora releases (e. g. RHEL/CentOS).

Tested with Centos 7.6.1810.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/sphinx-pre-install | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index f230e65329a2..101ddd00bf02 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -371,7 +371,7 @@ sub give_redhat_hints()
 	#
 	# Checks valid for RHEL/CentOS version 7.x.
 	#
-	if (! $system_release =~ /Fedora/) {
+	if (!($system_release =~ /Fedora/)) {
 		$map{"virtualenv"} = "python-virtualenv";
 	}
 
-- 
2.21.0


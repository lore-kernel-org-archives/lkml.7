Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6DEC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C8820883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558955285;
	bh=zIVSxzLcFYCEKabhSfmjGO4t+Y92qDrk87H7DC7vaVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=et+CCv18C+578CIYDDfRUOTGHr3smNo46R7egkKPW5Z9N4oPs3B4IconV5KN46CgB
	 4HxUjjqHqoL+aVPOUkunl2rFvh6vqT7wMVfwSPDTqeXskk4m7FbPkShGuEVRQsdSNa
	 fiYV+XGYxvTF06MLLfEI7be1smz5asPM47s4CWRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfE0LHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 07:07:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfE0LHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8g48329FQhEsiuSKYHuqBZrE6fufei6sAnLid9P5pyM=; b=acc1/u1a6AefoquRE3b/srYkDW
        XFNwIsPb2hVl+wyGlUv0yE8gtd+3c5dY3pYC48jKQLZlg696R5KeUbkVK7N1BCwPktTpph73Qda7M
        gebfcPXNW8NRZ1MkJDVzzvYiqaqHXeoGwy18OVVPwE4C6lP3Zx3BROsaSOYIBEDacbg0Xizp0x34n
        +Mmt89ZcuII1EDTTdI71QmqRWgGawoZlxnLP5GXZ0LEIRZa3+lkBNhD5yaGqXO3pMLce7yDuZLYD1
        fdEpw4fNOAPSlf1QjSGsrFWbH9Ob5Pjr8Tm+d/fUryoDiLwU1SfJ1Ls7AptEb24qdh82HUOi7udMY
        WfwjDecw==;
Received: from [177.159.249.4] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVDTn-00061s-Ma; Mon, 27 May 2019 11:07:47 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hVDTi-0002ci-P4; Mon, 27 May 2019 08:07:42 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/5] scripts/sphinx-pre-install: get rid of RHEL7 explicity check
Date:   Mon, 27 May 2019 08:07:38 -0300
Message-Id: <d01851ff7721606d2033fef2d6a09321f8e9702d.1558955082.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558955082.git.mchehab+samsung@kernel.org>
References: <cover.1558955082.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RHEL8 was already launched. This test won't get it, and will
do the wrong thing. Ok, we could fix it, but now we check
Sphinx version to ensure that it matches the minimal (1.3),
so there's no need for an explicit check there.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/sphinx-pre-install | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 11239eb29695..ded3e2ef3f8d 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -581,19 +581,6 @@ sub check_needs()
 		print "Unknown OS\n";
 	}
 
-	# RHEL 7.x and clones have Sphinx version 1.1.x and incomplete texlive
-	if (($system_release =~ /Red Hat Enterprise Linux/) ||
-	    ($system_release =~ /CentOS/) ||
-	    ($system_release =~ /Scientific Linux/) ||
-	    ($system_release =~ /Oracle Linux Server/)) {
-		$virtualenv = 1;
-		$pdf = 0;
-
-		printf("NOTE: On this distro, Sphinx and TexLive shipped versions are incompatible\n");
-		printf("with doc build. So, use Sphinx via a Python virtual environment.\n\n");
-		printf("This script can't install a TexLive version that would provide PDF.\n");
-	}
-
 	# Check for needed programs/tools
 	check_sphinx();
 	check_perl_module("Pod::Usage", 0);
-- 
2.21.0


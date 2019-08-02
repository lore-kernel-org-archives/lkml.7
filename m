Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD09C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2E821871
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752014;
	bh=dHperu63nYS8UK5KTdZoHxwDBf0maf/PLEgDFchR0oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xIZD4tuElfXjrPhO7pcb5kNaCNxFtvd8V409Dvbi/buC907VtUpMEx+C8v8ksZlfu
	 oFX4VCttm9sBMy+KGS3eU8/45FEeha1YGBS5x1N404qqcdem7xP7xnbPdiboJs9QHn
	 jQ1jlercR+D1oCm9AV7pRDnQlGW1yXyz7u7Muvlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393304AbfHBNUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:20:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393219AbfHBNUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:20:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A7C121850;
        Fri,  2 Aug 2019 13:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752005;
        bh=dHperu63nYS8UK5KTdZoHxwDBf0maf/PLEgDFchR0oU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KIXk3N11YxW/5OorTHk/yAqZQTLnSFptneabjynS/Z/uUTxBr0TSGQdfgzcWaxUbD
         zCa4QPDtx3Hk0r5RrWFVqOWwaIj6yZRP6vFItaR/y2YF4BvmDoxDcgZD0yIRUc5UgN
         wMY22/rXNakv/5Ym5xl3iMUorn6IlHn8BNgAHk74=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 11/76] scripts/sphinx-pre-install: fix latexmk dependencies
Date:   Fri,  2 Aug 2019 09:18:45 -0400
Message-Id: <20190802131951.11600-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802131951.11600-1-sashal@kernel.org>
References: <20190802131951.11600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

[ Upstream commit 353290a9eb5362a80bc8e52fcd7eb77a30f48afc ]

The name of the package with carries latexmk is different
on two distros:

- On OpenSUSE, latexmk is packaged as "texlive-latexmk-bin"
- On Mageia, latexmk is packaged at "texlive-collection-basic"

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/sphinx-pre-install | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 4cc2b3ee5209f..1f9f0a334c24f 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -447,6 +447,8 @@ sub give_opensuse_hints()
 		"texlive-zapfding",
 	);
 
+	$map{"latexmk"} = "texlive-latexmk-bin";
+
 	check_rpm_missing(\@suse_tex_pkgs, 2) if ($pdf);
 	check_missing_tex(2) if ($pdf);
 	check_missing(\%map);
@@ -472,6 +474,8 @@ sub give_mageia_hints()
 		"texlive-fontsextra",
 	);
 
+	$map{"latexmk"} = "texlive-collection-basic";
+
 	check_rpm_missing(\@tex_pkgs, 2) if ($pdf);
 	check_missing(\%map);
 
-- 
2.20.1


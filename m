Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC182C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE002205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561223844;
	bh=MKRc9+RDngvnVz52hlGDYY+KaYMWxlc05G9WTy6Zzlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QloGs9AM6aV7QjqTHiQ5PEkqZwKolbhq+8DYMEiVS1a1T5VxJF5h2jXtlixN6sRsu
	 49wsWqc/Ac+mcT6pDGtRpv4sISC73yffo45iGTUcdfLPN1TNRkOetTpqzgENICwWSe
	 LlVBNKjzcwBIlBq4zKhQUvyPjJwkgCsiMXQjW3Sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfFVRRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 13:17:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfFVRRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 13:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=86TkPPpFJuPy6eZbgDCbTxzixd78qAKph70hSGg4B2A=; b=D1UE/6GFymDFXFzmUPRfnlSSmB
        hR+V8aLMWXklf9fF0Q91UL0ysQzjEdbMk3iYhZBFcbcITrvC0U7rBnX2Nns9UaoGQWxp4SALAfLtB
        /H7SWfIjjNUpzphr5xTWbMFLOUMlI6J74Q43WlVaj8WMNIFKFriEgaOHtYKavMAcvByjVZRs9va+1
        wNeeCjc/DuW8E+uoEBqcdcBu4UdTsUgx0OAyPZqooE12zgDOxDrkv+gplTbdue5iGLrr+OjlfY5nJ
        EYfRs1zZbSGt0ojnFnHb591f+ABht7T2wXs00WawlPUfw89XFTwwbxCqks+hO6mi4c0SMo3+8YsXY
        VgXtsF9A==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejdX-0002tg-Qv; Sat, 22 Jun 2019 17:17:11 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejdV-00014P-5x; Sat, 22 Jun 2019 14:17:09 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] scripts/get_feat.pl: handle ".." special case
Date:   Sat, 22 Jun 2019 14:17:05 -0300
Message-Id: <9c8964caa4140206efcc455f0068d6ad46a76e7b.1561222784.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561222784.git.mchehab+samsung@kernel.org>
References: <cover.1561222784.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The status ".." Means that the feature can't be implemented
on a given architecture.

The problem is that this doesn't show anything at the
output, so replace it by "---", with is a markup for a long
hyphen.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_feat.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/get_feat.pl b/scripts/get_feat.pl
index 401cbc820caa..79d83595addd 100755
--- a/scripts/get_feat.pl
+++ b/scripts/get_feat.pl
@@ -141,6 +141,8 @@ sub parse_feat {
 				$max_size_arch = length($a);
 			}
 
+			$status = "---" if ($status =~ m/^\.\.$/);
+
 			$archs{$a} = 1;
 			$arch_table{$a} = $status;
 			next;
-- 
2.21.0


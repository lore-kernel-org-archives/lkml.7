Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4433C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85ACB2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555940214;
	bh=MDrdlBzQBgz4CJ3SpzJUm96lnJcESY0wNkuvJKmWMFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IhRn+aCBPSQyM1dxdX4y2fuEHibXFjm2Fa462+2zov1Lmjb4jMTgYj7kz3eh8HNQP
	 UIQGyRuyYcvH9RXp8uF2oEqYEWDSDJH0IcYVx4//EmsGidfTAi8CexET0Dy6qeyCnD
	 +5TYYfv/lviWQNrWZXGuh69CrcPaxDzZrAoc7Zi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfDVNgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:36:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfDVN2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LknHlP8O80qHE1WCh8WxWrtnHyrgma3TZ5Je3ultqgs=; b=S/sucOVHPYUdGATx3TbiajJgkN
        oxeB7igzj3QwP6vUEA6GcI1uKwZYJsIukbOxvflCPRBh8W7qpY7yspXZZBBFb8UuoWfitWN9znld5
        YyhSRuA7gTQwbFkl0CkBK80IL2lzWSgbm6NwvtWlpoymdMbyzawSmON4R34i+pqwK/bfXo7rXTJL9
        XRLyBUVf6+vb1HHhK97eo8rLvvjYH7WCSU66mDOD1oFck3Qyu4/0n1GM7YdWEuKJQq8hta/BC5gqR
        ZVQy1NmKuTNwZqgWk3wzkjJYOGqCrAxwQ+vH7KzpQu54aCmvtt0nJY4W59q4TkCldJzcOM7cL0tA2
        V4QuSBKQ==;
Received: from 179.176.125.229.dynamic.adsl.gvt.net.br ([179.176.125.229] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIYzU-0005HT-Il; Mon, 22 Apr 2019 13:28:12 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hIYzS-0005jd-AJ; Mon, 22 Apr 2019 10:28:10 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 03/79] scripts/documentation-file-ref-check: don't parse Next/ dir
Date:   Mon, 22 Apr 2019 10:26:52 -0300
Message-Id: <64012d057b5cf2b75192fb75ef5d2547254ccf06.1555938375.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555938375.git.mchehab+samsung@kernel.org>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If one tries to run this script under linux-next, it would
hit lots of false-positives, due to the tree merges that
are stored under the Next/ directory.

So, add a logic to ignore it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/documentation-file-ref-check | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/documentation-file-ref-check b/scripts/documentation-file-ref-check
index ad9db6821824..bd7d9ab63941 100755
--- a/scripts/documentation-file-ref-check
+++ b/scripts/documentation-file-ref-check
@@ -38,6 +38,9 @@ while (<IN>) {
 	my $f = $1;
 	my $ln = $2;
 
+	# On linux-next, discard the Next/ directory
+	next if ($f =~ m,^Next/,);
+
 	# Makefiles and scripts contain nasty expressions to parse docs
 	next if ($f =~ m/Makefile/ || $f =~ m/\.sh$/);
 
-- 
2.20.1


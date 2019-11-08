Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B90C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FA32087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239828;
	bh=qHrXqXTGoipl8/RNConQPJh/ZF8X6C0g1hIwEtiH0vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vBgoUmwf9KT+I3gzQdjMF0xANPt1RCZL1BoAX9BUkPFJ5uKesGxzRavF0v0NZOdbn
	 4p3+5HD6M38qogC10Tug4bejMFcl++4O64L7ESx77ZiNpI+X2hdER818SXNc/Q6txD
	 g/67HgZL2o/8HXJjscm9hulbjCNX9jige3H8ruoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390856AbfKHTDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:03:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732439AbfKHTDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:03:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAE9F2087E;
        Fri,  8 Nov 2019 19:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239825;
        bh=qHrXqXTGoipl8/RNConQPJh/ZF8X6C0g1hIwEtiH0vM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mvipFJvwnEL/+soM8x1t7HSRQSPmU0Op0eLbNAA3vQLJIrSokJ2HKpjg7REM1XMR6
         Lo7/r2J56BwdkxEA5JLCsu1052/B8plkhKWPKzCMZt0V0a3PmRik3tfH7kuAVgbV2G
         XASRWPd5RmdpW3ngO4psfnHlpgvqoT9XZBjnV2+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxim Mikityanskiy <maxtram95@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 72/79] wireless: Skip directory when generating certificates
Date:   Fri,  8 Nov 2019 19:50:52 +0100
Message-Id: <20191108174824.968628501@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174745.495640141@linuxfoundation.org>
References: <20191108174745.495640141@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Mikityanskiy <maxtram95@gmail.com>

[ Upstream commit 32b5a2c9950b9284000059d752f7afa164deb15e ]

Commit 715a12334764 ("wireless: don't write C files on failures") drops
the `test -f $$f` check. The list of targets contains the
CONFIG_CFG80211_EXTRA_REGDB_KEYDIR directory itself, and this check used
to filter it out. After the check was removed, the extra keydir option
no longer works, failing with the following message:

od: 'standard input': read error: Is a directory

This commit restores the check to make extra keydir work again.

Fixes: 715a12334764 ("wireless: don't write C files on failures")
Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/net/wireless/Makefile
+++ b/net/wireless/Makefile
@@ -38,6 +38,7 @@ $(obj)/extra-certs.c: $(CONFIG_CFG80211_
 	@(set -e; \
 	  allf=""; \
 	  for f in $^ ; do \
+	      test -f $$f || continue;\
 	      # similar to hexdump -v -e '1/1 "0x%.2x," "\n"' \
 	      thisf=$$(od -An -v -tx1 < $$f | \
 	                   sed -e 's/ /\n/g' | \



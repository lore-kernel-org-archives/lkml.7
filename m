Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FA7C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB96A2229A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fQbivGvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfGVIfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:35:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37915 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfGVIfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:35:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M8ZcsN3743120
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 01:35:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M8ZcsN3743120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563784539;
        bh=4CybGVFZOuraeB7f6IPi1aspO9I93kO0/sBWCAwxFPk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=fQbivGvtlGHH90/CWs6fvehkLhH6ZBTJ35KVTXiuoIHC8Tr/TlvfkeutfD/HEQRbP
         gb8T4rwyWtwfw4BQaLW4yW4QtHRHysYDExt77UjlSjqmMMU9J2WZjFl1xLjFoWpr7L
         ChydTiDlfwJr7DGF+I5n5ouyf8qDgIwJFjPANJMND/HypSRTo9JOZ47zEO3OAoKCX/
         q5lfUOg+JP8m1uHXFkFr4hB9eoGm7zZZDbP5qDN904bWDNiyCa2Hv402Ztw2EOrAKE
         lug8soJ0n1YSHh7Nr2pXTOiUq7b/6Tt4SlMjGCV/gDGfamNM4Y3lNHXsCSSkVD67Wp
         SvPjwyM7dY4nw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M8Zcl93743117;
        Mon, 22 Jul 2019 01:35:38 -0700
Date:   Mon, 22 Jul 2019 01:35:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-f85a8573ceb225e606fcf38a9320782316f47c71@git.kernel.org>
Cc:     tglx@linutronix.de, luto@kernel.org, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, luto@kernel.org, hpa@zytor.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <4b7565954c5a06530ac01d98cb1592538fd8ae51.1562185330.git.luto@kernel.org>
References: <4b7565954c5a06530ac01d98cb1592538fd8ae51.1562185330.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/entry] x86/syscalls: Disallow compat entries for all types
 of 64-bit syscalls
Git-Commit-ID: f85a8573ceb225e606fcf38a9320782316f47c71
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f85a8573ceb225e606fcf38a9320782316f47c71
Gitweb:     https://git.kernel.org/tip/f85a8573ceb225e606fcf38a9320782316f47c71
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 3 Jul 2019 13:34:03 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 10:31:22 +0200

x86/syscalls: Disallow compat entries for all types of 64-bit syscalls

A "compat" entry in the syscall tables means to use a different entry on
32-bit and 64-bit builds.

This only makes sense for syscalls that exist in the first place in 32-bit
builds, so disallow it for anything other than i386.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/4b7565954c5a06530ac01d98cb1592538fd8ae51.1562185330.git.luto@kernel.org

---
 arch/x86/entry/syscalls/syscalltbl.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscalltbl.sh b/arch/x86/entry/syscalls/syscalltbl.sh
index 94fcd1951aca..53c8c1a9adf9 100644
--- a/arch/x86/entry/syscalls/syscalltbl.sh
+++ b/arch/x86/entry/syscalls/syscalltbl.sh
@@ -27,8 +27,8 @@ emit() {
     compat="$4"
     umlentry=""
 
-    if [ "$abi" = "64" -a -n "$compat" ]; then
-	echo "a compat entry for a 64-bit syscall makes no sense" >&2
+    if [ "$abi" != "I386" -a -n "$compat" ]; then
+	echo "a compat entry ($abi: $compat) for a 64-bit syscall makes no sense" >&2
 	exit 1
     fi
 

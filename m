Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A39FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F9120811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QtwSLJx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfCHJ5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:57:04 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:58442 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfCHJ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:57:04 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x289uSqa003883;
        Fri, 8 Mar 2019 18:56:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x289uSqa003883
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552038988;
        bh=5cYoMwhwP7MQYAIXIKGJrDLwUHl9mhxyYhEh0rTq03E=;
        h=From:To:Cc:Subject:Date:From;
        b=QtwSLJx4pij8cDr3SpU0PP5Go2irqNyGZnV4pc+AVkvWfXfBkqx8JuUZgH4hJBnra
         ilSYT9pXLo39QIEPV85b8ozgvl79zk8ifYpPxAVJ5QBE+6YgCxa2Lc1dh5COrqCyKp
         pbinu8xM4lxPjGctdz1K/EmWK0mmjLtTdRC1P5q+RMLdaw6A1i3EaUHgL70De5RSJ1
         USOF4qzt8BxQVJZczbd8CKXkcOTAW1muRSZngZEuyYKPkX3MBjhwaeZJ6jS9l3e9UT
         yBeIynAO+gZDawfJ78TaYsbQ5vNA5jyeQnjmwaFv3o06HucGuzQ2Vf53LGE0oWcneI
         GwJ0TojfST8Fw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kbuild: deb-pkg: add CONFIG_ prefix to kernel config options
Date:   Fri,  8 Mar 2019 18:56:23 +0900
Message-Id: <1552038985-10473-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This might be a kind of bike-shed, but I personally prefer grep'able
code.

I often do 'git grep CONFIG_FOO' instead of 'git grep FOO' when I
want to know where that CONFIG option is used.

This makes code longer, but I hope this is acceptable level.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/package/mkdebian | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index f030961..e3726e8 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -7,7 +7,7 @@
 set -e
 
 is_enabled() {
-	grep -q "^CONFIG_$1=y" $KCONFIG_CONFIG
+	grep -q "^$1=y" $KCONFIG_CONFIG
 }
 
 if_enabled_echo() {
@@ -31,23 +31,23 @@ set_debarch() {
 	x86_64)
 		debarch=amd64 ;;
 	sparc*)
-		debarch=sparc$(if_enabled_echo 64BIT 64) ;;
+		debarch=sparc$(if_enabled_echo CONFIG_64BIT 64) ;;
 	s390*)
 		debarch=s390x ;;
 	ppc*)
-		if is_enabled 64BIT; then
-			debarch=ppc64$(if_enabled_echo CPU_LITTLE_ENDIAN el)
+		if is_enabled CONFIG_64BIT; then
+			debarch=ppc64$(if_enabled_echo CONFIG_CPU_LITTLE_ENDIAN el)
 		else
-			debarch=powerpc$(if_enabled_echo SPE spe)
+			debarch=powerpc$(if_enabled_echo CONFIG_SPE spe)
 		fi
 		;;
 	parisc*)
 		debarch=hppa ;;
 	mips*)
-		if is_enabled CPU_LITTLE_ENDIAN; then
-			debarch=mips$(if_enabled_echo 64BIT 64)$(if_enabled_echo CPU_MIPSR6 r6)el
-		elif is_enabled CPU_MIPSR6; then
-			debarch=mips$(if_enabled_echo 64BIT 64)r6
+		if is_enabled CONFIG_CPU_LITTLE_ENDIAN; then
+			debarch=mips$(if_enabled_echo CONFIG_64BIT 64)$(if_enabled_echo CONFIG_CPU_MIPSR6 r6)el
+		elif is_enabled CONFIG_CPU_MIPSR6; then
+			debarch=mips$(if_enabled_echo CONFIG_64BIT 64)r6
 		else
 			debarch=mips
 		fi
@@ -55,8 +55,8 @@ set_debarch() {
 	aarch64|arm64)
 		debarch=arm64 ;;
 	arm*)
-		if is_enabled AEABI; then
-			debarch=arm$(if_enabled_echo VFP hf el)
+		if is_enabled CONFIG_AEABI; then
+			debarch=arm$(if_enabled_echo CONFIG_VFP hf el)
 		else
 			debarch=arm
 		fi
@@ -64,10 +64,10 @@ set_debarch() {
 	openrisc)
 		debarch=or1k ;;
 	sh)
-		if is_enabled CPU_SH3; then
-			debarch=sh3$(if_enabled_echo CPU_BIG_ENDIAN eb)
-		elif is_enabled CPU_SH4; then
-			debarch=sh4$(if_enabled_echo CPU_BIG_ENDIAN eb)
+		if is_enabled CONFIG_CPU_SH3; then
+			debarch=sh3$(if_enabled_echo CONFIG_CPU_BIG_ENDIAN eb)
+		elif is_enabled CONFIG_CPU_SH4; then
+			debarch=sh4$(if_enabled_echo CONFIG_CPU_BIG_ENDIAN eb)
 		fi
 		;;
 	esac
-- 
2.7.4


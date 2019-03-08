Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1B7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA63B20854
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TSqeBJUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfCHJ5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:57:08 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:58452 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHJ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:57:04 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x289uSqc003883;
        Fri, 8 Mar 2019 18:56:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x289uSqc003883
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552038989;
        bh=aGnH/xy3lfI4P4Pf0gopqcxOtRSY0Xj6FuRqiw7m0Ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSqeBJUJvdm2Zj9GsK0vq15nu3owCIP1fsZo02DdyjXc3Ae0UHrcQmUQyrpTn5EE4
         36/SjarjrJARMCHxC3mgpdinSPqLCa5LOlrLShKQV8n9ba6rmCO1lGMrVPWtghfGBf
         +zQg3IgTkRjCusyfJZnsEp369ij+P9tb0Ofy4ZMWEwG9O7Et5dMbMErgFPD+yt/XXX
         olJVZnXWtUTCoP3pyvm2X/wngjkxh/cwKEMk08AG2FiwWYsHoA1eN+eNJVRS91h0X5
         HfQaaSXD0SX9HGNMufxMROH4BB1d5Za0PBjhVPxlWN/dUSNvkpmjNJNgynWez2p2Uw
         0mFqFESxSbwmQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kbuild: pkg: grep include/config/auto.conf instead of $KCONFIG_CONFIG
Date:   Fri,  8 Mar 2019 18:56:25 +0900
Message-Id: <1552038985-10473-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552038985-10473-1-git-send-email-yamada.masahiro@socionext.com>
References: <1552038985-10473-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be a little more efficient since unset CONFIG options are
stripped away from auto.conf, and we can hard-code the path to auto.conf
since it is never overridden.

include/config/kernel.release is generated before %pkg is run.
So, it is guaranteed auto.conf is up-to-date.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/package/builddeb | 2 +-
 scripts/package/buildtar | 2 +-
 scripts/package/mkdebian | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index e2cb438..b03dd56 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -13,7 +13,7 @@
 set -e
 
 is_enabled() {
-	grep -q "^$1=y" $KCONFIG_CONFIG
+	grep -q "^$1=y" include/config/auto.conf
 }
 
 if_enabled_echo() {
diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index cfd2a4a..2f66c81 100755
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -56,7 +56,7 @@ dirs=boot
 #
 # Try to install modules
 #
-if grep -q '^CONFIG_MODULES=y' "${KCONFIG_CONFIG}"; then
+if grep -q '^CONFIG_MODULES=y' include/config/auto.conf; then
 	make ARCH="${ARCH}" -f ${srctree}/Makefile INSTALL_MOD_PATH="${tmpdir}" modules_install
 	dirs="$dirs lib"
 fi
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index e3726e8..dd7202f 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -7,7 +7,7 @@
 set -e
 
 is_enabled() {
-	grep -q "^$1=y" $KCONFIG_CONFIG
+	grep -q "^$1=y" include/config/auto.conf
 }
 
 if_enabled_echo() {
-- 
2.7.4


Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE5EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1409B2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PDh+kHdD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbfCLRYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:24:14 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:26883 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbfCLRYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:24:11 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x2CHNW1f000384;
        Wed, 13 Mar 2019 02:23:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x2CHNW1f000384
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552411413;
        bh=wZ4a4Qo8H4S3PsjxHsSKvEoDuqCYVYPAktZ4OUtsjkI=;
        h=From:To:Cc:Subject:Date:From;
        b=PDh+kHdDJ0TaSEFS6UOLmrWZtE4GgoxcZ9ZY/C/7aL3Axiuv+qf4D7G7sFa+qu3OL
         6aV5c+ePX2l6mGVV2183rqQZ9yD1HkGWPAncoBn2gea9sR+5rmihOHWxUTsP9yquFJ
         c/DzIgCkePPBEO2UzuUZZgZBZ0Vp/LeH62crzyg4RgU/QrIC3JnFuOGR9WpoKGaCV6
         6j+5EJNRxsD7/WKr3+OFYBnGZ6QMM5M6HNZkVfTgg7LUq6joNpg3x8UWgjF/fh0s6/
         45u7qLZQWAGklgiXj1UReYehvN/udJpjtRwn6ZyZIb2fQh36pekWBVjoTVS6Y6C392
         JuPScL04KxbHA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] deb-pkg: generate correct build dependencies
Date:   Wed, 13 Mar 2019 02:23:24 +0900
Message-Id: <1552411404-32271-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Riku Voipio <riku.voipio@linaro.org>

bison/flex is now needed always for building for kconfig. Some build
dependencies depend on kernel configuration, enable them as needed:

- libelf-dev when UNWINDER_ORC is set
- libssl-dev for SYSTEM_TRUSTED_KEYRING

Since the libssl-dev is needed for extract_cert binary, denote with
:native to install the libssl-dev for the build machines architecture,
rather than for the architecture of the kernel being built.

Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
Reviewed-by: Ben Hutchings <ben@decadent.org.uk>
Acked-by: maximilian attems <maks@stro.at>
[masahiro.yamada: add change 'flex' to 'flex | flex:native' ]
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Hi Riku,

I did not get your update, but anyway I changed
'flex' to 'flex | flex:native'.

With this change, now I am able to cross-compile deb-pkg.


 scripts/package/mkdebian | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index f030961..110cd8d 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -134,6 +134,8 @@ fi
 
 mkdir -p debian/
 echo $debarch > debian/arch
+extra_build_depends=", $(if_enabled_echo UNWINDER_ORC libelf-dev)"
+extra_build_depends="$extra_build_depends, $(if_enabled_echo SYSTEM_TRUSTED_KEYRING libssl-dev:native)"
 
 # Generate a simple changelog template
 cat <<EOF > debian/changelog
@@ -170,7 +172,7 @@ Source: $sourcename
 Section: kernel
 Priority: optional
 Maintainer: $maintainer
-Build-Depends: bc, kmod, cpio
+Build-Depends: bc, kmod, cpio, bison, flex | flex:native $extra_build_depends
 Homepage: http://www.kernel.org/
 
 Package: $packagename
-- 
2.7.4


Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FAFC2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 09:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32117217F4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 09:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="JQ+0PkPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgADJz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 04:55:59 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:52047 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgADJz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 04:55:58 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47qcbb5t3czGW;
        Sat,  4 Jan 2020 10:55:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578131756; bh=oM/ciusTy/ZEkF90jacNzOpT3U2e3nEZociObnH9O7g=;
        h=Date:From:Subject:To:Cc:From;
        b=JQ+0PkPraFXwd1ql9TG9LVsHIHcRyz7/sDGUPYSjVJMafroM7YrHtc+ArI+ohBdye
         Umv6dgsZ+6MIVUOBBgCdocxQBbrCxMVmqJBoBykJrFjVHwo06x36NG1haLHIvL/B7v
         0SUOLU0W0GGe4JIhPQvXm6wzFa8BKh9rIzVYoscBqefEObQjiIsd7SJYxeOoI7+4xD
         7ieb2Q/4FLpwdrVscB7iXtCsv+uMhdNEd/NtDxedIKD+7l++xHaGzJO+UgovSbh/Rr
         OaqZSmD5y1NEp+Jn4ew0b2KmvmncTvGLAFqBO8i3CYxASdZfgrkl5yMIkx1MEMJjo2
         DM9079Gn95IrQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Sat, 04 Jan 2020 10:55:52 +0100
Message-Id: <09f5b36d9c64b4e6d1d235f84a7333b7802b2866.1578131485.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/2] builddeb: allow selection of .deb compressor
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select deb compression using KPKG_COMPRESS make variable. This allows to
use gzip compression for local or test builds, and that's way faster
than now-default xz compression.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 scripts/package/builddeb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index c4c580f547ef..d289c4ebc891 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -43,7 +43,7 @@ create_package() {
 
 	# Create the package
 	dpkg-gencontrol -p$pname -P"$pdir"
-	dpkg --build "$pdir" ..
+	dpkg-deb ${KPKG_COMPRESS:+-Z$KPKG_COMPRESS} --build "$pdir" ..
 }
 
 version=$KERNELRELEASE
-- 
2.20.1


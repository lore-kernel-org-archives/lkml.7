Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC294C32770
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 09:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CFE217F4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 09:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="HaIJ1Jwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgADJz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 04:55:59 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:17501 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgADJz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 04:55:59 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47qcbc3c0QzqH;
        Sat,  4 Jan 2020 10:55:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578131756; bh=rkH40E0INVXlvDKfacAUiba88ww3D5Wjqs50yFTBFh0=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=HaIJ1JwyGdZCD+RpHddHeEQww41T9ImFOWZfFLDjVohqGTderBEs/96v1Lq0sWbQo
         icblhN1uTGppxrFfhULFauUpCCOo7+dze2uhRLHUKivfKxBKqht5ywyTatfAOvSXJ3
         haaL5xMhyDVljiQTEgCjGmfRFurJIUoW7TNEJye1Rp8Xld07hjt2GAn5f1SY9xg3AW
         Q07OMUPwVBqvm7bk65MQTANyTjP+pYsuEG23XZ4ddqqNIdp4muDuwbNN0mm7sTHFPt
         Ruz7sWz8Or4qWP4RCcqzvgwZgOizMi4jaaDqlOGY5T/bAvr44ual83eLeV5xspn0pW
         eCEPfYkguR5fg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Sat, 04 Jan 2020 10:55:56 +0100
Message-Id: <081640c81d3c89707fdbb8869ae5f54aaea5064e.1578131485.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <09f5b36d9c64b4e6d1d235f84a7333b7802b2866.1578131485.git.mirq-linux@rere.qmqm.pl>
References: <09f5b36d9c64b4e6d1d235f84a7333b7802b2866.1578131485.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/2] builddeb: make headers package thinner
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

Remove a bunch of files not used during external module builds:
 - foreign architecture headers
 - subtree Makefiles
 - Kconfig files
 - perl scripts

On amd64 system this looses a third of the resulting .deb size.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 scripts/package/builddeb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index d289c4ebc891..fb68916d5898 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -165,8 +165,8 @@ EOF
 done
 
 # Build kernel header package
-(cd $srctree; find . -name Makefile\* -o -name Kconfig\* -o -name \*.pl) > "$objtree/debian/hdrsrcfiles"
-(cd $srctree; find arch/*/include include scripts -type f -o -type l) >> "$objtree/debian/hdrsrcfiles"
+(cd $srctree; find . arch/$SRCARCH -maxdepth 1 -name Makefile\*) > "$objtree/debian/hdrsrcfiles"
+(cd $srctree; find include scripts -type f -o -type l) >> "$objtree/debian/hdrsrcfiles"
 (cd $srctree; find arch/$SRCARCH -name module.lds -o -name Kbuild.platforms -o -name Platform) >> "$objtree/debian/hdrsrcfiles"
 (cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f) >> "$objtree/debian/hdrsrcfiles"
 if is_enabled CONFIG_STACK_VALIDATION; then
-- 
2.20.1


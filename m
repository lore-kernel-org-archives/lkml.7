Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25162C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEED21848
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="frbgdxeG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfI0JhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 05:37:02 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:33054 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfI0JhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 05:37:01 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x8R9a5ug001372;
        Fri, 27 Sep 2019 18:36:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x8R9a5ug001372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569576972;
        bh=UQ6bH4/qZBZ6u3bYLv57zfd3f4RxEgvS4K1+jdI01bE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=frbgdxeGGQj1AAOjEhqLFlCDcjeLt7cStOzPH2l82NztyjA71sxo14Zi/bXCzvh4P
         9kwGdlzThgqbZ5CzsQdWDHGtrdB9yVtVpy5U1E7UswRYGVcjPc0tI+RKVhIb6drVlP
         ytCFvoZbIb64pCdDTruU+ag/LDUV+50pjhDetlTWyp8DFje/JNuoquAbcFNwlWw2GC
         wiGq7O8KYRo0/d/OJBomxqPpMxuswzr450Tbaau6QB7nrV6HzL4rkxGg0xrB/NddBz
         +gXUFIRw3MPzkk2lypyO98bt6neq0ofHuGCZqKUpFvH9K9bOSqQF+kDIgy6RdYXUfy
         ELHedr+p7EVNQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Will Deacon <will.deacon@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] nsdeps: fix hashbang of scripts/nsdeps
Date:   Fri, 27 Sep 2019 18:36:02 +0900
Message-Id: <20190927093603.9140-7-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927093603.9140-1-yamada.masahiro@socionext.com>
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This script does not use bash-extension. I am guessing this hashbang
was copied from scripts/coccicheck, which really uses bash-extension.

/bin/sh is enough for this script.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/nsdeps | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/nsdeps b/scripts/nsdeps
index ac2b6031dd13..964b7fb8c546 100644
--- a/scripts/nsdeps
+++ b/scripts/nsdeps
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # Linux kernel symbol namespace import generator
 #
-- 
2.17.1


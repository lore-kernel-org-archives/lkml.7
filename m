Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC3DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3AE0222C1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498157;
	bh=6VIKjkADuQVWzy7sSUCb36dA36xQEKAE3RYlBg5BnCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qhHY1TEZhO16wmbVafyu2mLHk5aqp7uNhsc7U+sXMB/JyJjaDRlNMr5xvpiWrGoWd
	 q0RKVDpA8n7dHqRQw5OVWDxwWXxlL8RyHJuCSAMKAXw+XtPKswChCCunWMAqdJ07Si
	 v1mYQLgCeRUsA9DWvOdHtA/kkAlfGN5lar64jcA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfKKStQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:49:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbfKKStL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:49:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F9E0222C1;
        Mon, 11 Nov 2019 18:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498151;
        bh=6VIKjkADuQVWzy7sSUCb36dA36xQEKAE3RYlBg5BnCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0KL8r5QstwOmjzV8M/F91hwREk/ysXE6vChr4jaPhOZNW0SnwrL4ZvysqOe0+noL8
         2Chm1uNY6f4H1MAGwt+iTaFvcP6AII/Vb/KuSfyOpx1lUFHDEw5o2WfVVnfXBlAAMG
         9Zkt8EbMz6GvuSs0AOhGE9EZTzDwJ0g9UEvZEFoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 5.3 038/193] tools: gpio: Use !building_out_of_srctree to determine srctree
Date:   Mon, 11 Nov 2019 19:27:00 +0100
Message-Id: <20191111181503.802726119@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <skhan@linuxfoundation.org>

commit 4a6a6f5c4aeedb72db871d60bfcca89835f317aa upstream.

make TARGETS=gpio kselftest fails with:

Makefile:23: tools/build/Makefile.include: No such file or directory

When the gpio tool make is invoked from tools Makefile, srctree is
cleared and the current logic check for srctree equals to empty
string to determine srctree location from CURDIR.

When the build in invoked from selftests/gpio Makefile, the srctree
is set to "." and the same logic used for srctree equals to empty is
needed to determine srctree.

Check building_out_of_srctree undefined as the condition for both
cases to fix "make TARGETS=gpio kselftest" build failure.

Cc: stable@vger.kernel.org
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/gpio/Makefile |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/tools/gpio/Makefile
+++ b/tools/gpio/Makefile
@@ -3,7 +3,11 @@ include ../scripts/Makefile.include
 
 bindir ?= /usr/bin
 
-ifeq ($(srctree),)
+# This will work when gpio is built in tools env. where srctree
+# isn't set and when invoked from selftests build, where srctree
+# is set to ".". building_out_of_srctree is undefined for in srctree
+# builds
+ifndef building_out_of_srctree
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif



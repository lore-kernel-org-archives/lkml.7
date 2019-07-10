Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0960DC73C6D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE6F20693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="swqomuh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfGJHQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:16:14 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:46601 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfGJHQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:16:13 -0400
Received: by mail-pg1-f201.google.com with SMTP id u1so913170pgr.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 00:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iuxOaaMz6/nuHb4KDKomfiTWkThnS6wenM774buKrcs=;
        b=swqomuh58V+Sg//U5cqY4Rh1tAi5bpvhwwunna8PvZbQacehjqw+jiBLjywU0PbaV9
         EpODX3G17IiD5mmqty6Ua7/wUUbyRya6LeMviTjJAwbg/+76UIMSyvVrzPVSUJ2WEY6n
         7lKwDj5zpEYSoIULXjTR+oBBCZfl1dvR7J33Y2miUOUDO2Sy18EJCy+VItMzFFxQAIdY
         /T4mQvRlNaRhUjVLmQuSsEc2qgj1X526Ie3m5Fj/WHcsnej2NpsOOSsTm8U1rai+iQqu
         RmvsSm+44+WEG138VYE5wa2mwKza4bSKWLX0erx0LKL6ndVzLZQYCX9qJk+XOClYHS4x
         pMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iuxOaaMz6/nuHb4KDKomfiTWkThnS6wenM774buKrcs=;
        b=nB+sViiEoqjrIrkvB67y9PMgyluFjrCb/0Z7XVsm3zRP4+sXKjaFPVdlBcDuk/XwHE
         TPnsgHSsWuiCAvJepdLhww2ZXm6g49VMtxds5YMDkJRsavK2bHJidYQXNC9r59lWtXqq
         ExknzBrhTqd2OE8mBtx2v2tLRIfioGvMvgYR6mOd8IpnYXbc2ADG+VsXO6VW/sZ4VrNf
         ttOjovF1GLiQbnoKpna9OnGkmsL11hIehaVLJIyc7qFJ2xhlxLUlMkKmkrdsskSVVaPc
         0mHUMAamYPfCdFopC4emuoTnAq50xuF56qFs8XzqQr5F1dqNRychRSsDTMqREEJRosSv
         AFkg==
X-Gm-Message-State: APjAAAWT0yiGbFtNuBqKorfrXJyVJNIdDj6/ZXY3oXCBadjfCBd7Gwi4
        3OoF08gZKnMCWTtLY88jAI0eWoDyrNb4US3Wf8Wq8A==
X-Google-Smtp-Source: APXvYqwvKVOfsz0NTC0mYXChGLM55lyRHym2AQRa0cKt8qzoul87EQvweiisK/9Kb7Yw/xDtn57GMjoaeQBD5oomo5boFg==
X-Received: by 2002:a63:c442:: with SMTP id m2mr22869503pgg.286.1562742972197;
 Wed, 10 Jul 2019 00:16:12 -0700 (PDT)
Date:   Wed, 10 Jul 2019 00:14:56 -0700
In-Reply-To: <20190710071508.173491-1-brendanhiggins@google.com>
Message-Id: <20190710071508.173491-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190710071508.173491-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v8 06/18] kbuild: enable building KUnit
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KUnit is a new unit testing framework for the kernel and when used is
built into the kernel as a part of it. Add KUnit to the root Kconfig and
Makefile to allow it to be actually built.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 Kconfig  | 2 ++
 Makefile | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Kconfig b/Kconfig
index 48a80beab6853..10428501edb78 100644
--- a/Kconfig
+++ b/Kconfig
@@ -30,3 +30,5 @@ source "crypto/Kconfig"
 source "lib/Kconfig"
 
 source "lib/Kconfig.debug"
+
+source "kunit/Kconfig"
diff --git a/Makefile b/Makefile
index 3e4868a6498b2..0ce1a8a2b6fec 100644
--- a/Makefile
+++ b/Makefile
@@ -993,6 +993,8 @@ PHONY += prepare0
 ifeq ($(KBUILD_EXTMOD),)
 core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
 
+core-$(CONFIG_KUNIT) += kunit/
+
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
 		     $(net-y) $(net-m) $(libs-y) $(libs-m) $(virt-y)))
-- 
2.22.0.410.gd8fdbe21b5-goog


Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47F1C41514
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 01:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A53233A0
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 01:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEHLmeCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfHXBe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 21:34:57 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:33909 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfHXBey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 21:34:54 -0400
Received: by mail-ua1-f74.google.com with SMTP id j26so838943uak.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 18:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oSIzNOWvDyzzTQYSf3JN3pjXcKbBe8KEci8pOjVJ0rM=;
        b=nEHLmeCRlNn0vOScVKEBkHT9QuVr1Oityp0ad1fJrBgKxBJq59NmT/ZxcqBl0ysYGY
         yBt6jDjJXfbChkboOUvoU1g4lMi5JhoLzLoPtSz0B7Gl3KjaQndZoMGWZM1pwP5FqO2L
         ClAyL8t2tO6QQLf/Rdl73Zm9P1Bxdp0ClvJv9LduvM5M9mb/TnDoBVSclkO9Oi3eEhfY
         8NnIwRm6UnqLKN4t1Om7vxtkwx92uAnNdr+iweCdUyRT1FCa7j7mICsbGiVBKfN2mKGc
         xbxZey/OA2ersCb91kmL3JKIZJS7NkWS14E+JHvZ4oQi8xyQ+btxx8VHVRXqILcsnZkg
         eYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oSIzNOWvDyzzTQYSf3JN3pjXcKbBe8KEci8pOjVJ0rM=;
        b=s8hN4zqRw+SnUjVYZ0zSjnN03ZJJqo5bQ+/TvwwPCmDcpNREgp1zYSrapm5SvR3k5w
         Ac115uDVhssgSqm6qqD5in0CqaBYchZNN0zMKuTXmVKy3VwIy+zXgKQnxTjCgyrP2XF0
         p9692Q4n0BsalesTjJWwhRiwnZjHFxtrVJPTx7VB18JZ3K+f6WTf1z6y6Cew3qpTfiCd
         f8NyIHXGMBAaro7y7DyimL9C3dMmHlYcEFW4ezr5QxwT5kxozCuU31NMc5zZZTyit4G/
         n4OcVd1Vt1+MmxMPvVlRHenLGWpw8q/R1IEyO+phTFtDGVFX4t/ok/hm2rgxOove0hlB
         +XJA==
X-Gm-Message-State: APjAAAVRDiHZKswjvHXhgC0/L9w2CyKz0bPJZvGhLvMseGOyUW7fYsFX
        oXF+omE8dhsfbLnDxrkhLhfFugb5DuNZ/mL8uwM+Dw==
X-Google-Smtp-Source: APXvYqxmiJDAEh/zAWwF62TCvIYIDIZRIkbCAatUA+zDm/ooJsxNG6fj5NyV/30vHftZKCTGXzwU0uEqfd5BNafZzZSuxw==
X-Received: by 2002:ac5:c4cc:: with SMTP id a12mr3950071vkl.28.1566610492442;
 Fri, 23 Aug 2019 18:34:52 -0700 (PDT)
Date:   Fri, 23 Aug 2019 18:34:13 -0700
In-Reply-To: <20190824013425.175645-1-brendanhiggins@google.com>
Message-Id: <20190824013425.175645-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190824013425.175645-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v15 06/18] kbuild: enable building KUnit
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
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 Kconfig  | 2 ++
 Makefile | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Kconfig b/Kconfig
index e10b3ee084d4..47886dbd6c2a 100644
--- a/Kconfig
+++ b/Kconfig
@@ -32,3 +32,5 @@ source "lib/Kconfig"
 source "lib/Kconfig.debug"
 
 source "Documentation/Kconfig"
+
+source "kunit/Kconfig"
diff --git a/Makefile b/Makefile
index 23cdf1f41364..3795d0a5d037 100644
--- a/Makefile
+++ b/Makefile
@@ -1005,6 +1005,8 @@ PHONY += prepare0
 ifeq ($(KBUILD_EXTMOD),)
 core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
 
+core-$(CONFIG_KUNIT) += kunit/
+
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
 		     $(net-y) $(net-m) $(libs-y) $(libs-m) $(virt-y)))
-- 
2.23.0.187.g17f5b7556c-goog


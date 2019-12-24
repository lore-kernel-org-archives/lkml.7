Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2647C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5A62063A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20150623.gappssmtp.com header.i=@hev-cc.20150623.gappssmtp.com header.b="OK11mFGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfLXRAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:00:30 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40962 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfLXRAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:00:30 -0500
Received: by mail-lf1-f67.google.com with SMTP id m30so15475619lfp.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 09:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fMlqiUykmo16Z9pg3WBxmVvNi2niQ348Njp7IT+vbho=;
        b=OK11mFGHAvMV+VshqPr29zmkfLsHdHcrFCWRTqi8KliQvT/irVVhbSPhfQXMou+Wyh
         JYTobjcq4YuqpvJkBSoQA29mR00WKRc2Q3+HgKREx8lvjsnuTaBxXrWWPyamrlCrnRVr
         HqRbg7r2EMdOdj69RILBR51XF0es+V2Mtd2yrWVG1NeYhsPtkVMWuv6+NIwfFQJMI0ys
         Sk9EQyw0XyN5UEnot7DTrbXD2x+cBI35KMJZlDGSx1cMKg3HieCFK7ucTDETOwyLS37m
         UV+UjwBQMB20AxwH5TXyZCuiGqZh/Nl5etVXIjKrKd+8Nj54A+CFXy2WO/ZijcGG1Aak
         fCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fMlqiUykmo16Z9pg3WBxmVvNi2niQ348Njp7IT+vbho=;
        b=fW4y/dG3vVMFesqjgbsf+F9FnJ/zXu/B+W3oUCTE+3JJeM8e+enQ8Id2Ddtkn4qTmt
         ciAskLKOvhAIpAmaFJO+K11av8xpm7sFBXMh4NaiqW9HtZxF9wdDyNJcBQFju7IwfZpB
         j8zUlgEtrso9mIEv/hD/msSRSf1qs+FeQrcYlddAUaxu0zxji9TcU1XT3fQpt+XWD3KV
         IDaqLYrX8wDV/+qcnND1eNy3VgmeQObgtIYKXu3Ko0mYPISMyBbygOjqZM4X7s0OVz1a
         oq0TMk/orn3+/39+lL1iVUxLgJGJMRZlZI2rPft0CnOXUN8qr9wbAvyT4IIdWjZ4llPc
         mq5g==
X-Gm-Message-State: APjAAAUTyED1GW7Ad4fPMFj0+BH1PcdLGRH+jOPpqOLGf/6hIbQMMnHP
        qtmlKZ56nB6qGBb82O9QesdAckbb2Bef+8qXYLHXJ+o7KcU=
X-Google-Smtp-Source: APXvYqzSCX5pL66KeljfjKBh7VCYL0DVwOnzKSyy3ogGnsARfuOIZt4O5eeNolR5mZQ960hRu4vXQskzGLTVnkazEbc=
X-Received: by 2002:a19:84d:: with SMTP id 74mr20107748lfi.122.1577206826723;
 Tue, 24 Dec 2019 09:00:26 -0800 (PST)
MIME-Version: 1.0
References: <20191224121210.29713-1-r@hev.cc>
In-Reply-To: <20191224121210.29713-1-r@hev.cc>
From:   Hev <r@hev.cc>
Date:   Wed, 25 Dec 2019 01:00:15 +0800
Message-ID: <CAHirt9hnKdyCnJhdVaw1vt40tZm_3F7LTCw4Ng4Svi_=LVecCg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] selftests: add rbtree selftests
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 24, 2019 at 8:12 PM Heiher <r@hev.cc> wrote:
>
> This adds the selftest for rbtree. It will reproduce the crash at earsing.
>
> Signed-off-by: hev <r@hev.cc>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michel Lespinasse <walken@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  tools/testing/selftests/Makefile              |  1 +
>  tools/testing/selftests/lib/rbtree/.gitignore |  1 +
>  tools/testing/selftests/lib/rbtree/Makefile   | 29 ++++++++
>  .../selftests/lib/rbtree/rbtree_test.c        | 70 +++++++++++++++++++
>  4 files changed, 101 insertions(+)
>  create mode 100644 tools/testing/selftests/lib/rbtree/.gitignore
>  create mode 100644 tools/testing/selftests/lib/rbtree/Makefile
>  create mode 100644 tools/testing/selftests/lib/rbtree/rbtree_test.c
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index b001c602414b..0e84ca3f207f 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -25,6 +25,7 @@ TARGETS += kcmp
>  TARGETS += kexec
>  TARGETS += kvm
>  TARGETS += lib
> +TARGETS += lib/rbtree
>  TARGETS += livepatch
>  TARGETS += membarrier
>  TARGETS += memfd
> diff --git a/tools/testing/selftests/lib/rbtree/.gitignore b/tools/testing/selftests/lib/rbtree/.gitignore
> new file mode 100644
> index 000000000000..4c9f82761fad
> --- /dev/null
> +++ b/tools/testing/selftests/lib/rbtree/.gitignore
> @@ -0,0 +1 @@
> +rbtree_test
> diff --git a/tools/testing/selftests/lib/rbtree/Makefile b/tools/testing/selftests/lib/rbtree/Makefile
> new file mode 100644
> index 000000000000..68fa9dad24a1
> --- /dev/null
> +++ b/tools/testing/selftests/lib/rbtree/Makefile
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +CFLAGS += -I../../../../include/
> +
> +include ../../lib.mk
> +
> +# lib.mk TEST_CUSTOM_PROGS var is for custom tests that need special
> +# build rules. lib.mk will run and install them.
> +
> +TEST_CUSTOM_PROGS := $(OUTPUT)/rbtree_test
> +all: $(TEST_CUSTOM_PROGS)
> +
> +OBJS = rbtree_test.o
> +
> +LIBS = ../../../../lib/rbtree.o
> +
> +OBJS := $(patsubst %,$(OUTPUT)/%,$(OBJS))
> +LIBS := $(patsubst %,$(OUTPUT)/%,$(LIBS))
> +
> +$(TEST_CUSTOM_PROGS): $(LIBS) $(OBJS)
> +       $(CC) -o $(TEST_CUSTOM_PROGS) $(OBJS) $(LIBS) $(CFLAGS) $(LDFLAGS)
> +
> +$(OBJS): $(OUTPUT)/%.o: %.c
> +       $(CC) -c $^ -o $@ $(CFLAGS)
> +
> +$(LIBS): $(OUTPUT)/%.o: %.c
> +       $(CC) -c $^ -o $@ $(CFLAGS)
> +
> +EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(OBJS) $(LIBS)
> diff --git a/tools/testing/selftests/lib/rbtree/rbtree_test.c b/tools/testing/selftests/lib/rbtree/rbtree_test.c
> new file mode 100644
> index 000000000000..11420541071a
> --- /dev/null
> +++ b/tools/testing/selftests/lib/rbtree/rbtree_test.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <stdlib.h>
> +#include <linux/rbtree.h>
> +#include "../../kselftest_harness.h"
> +
> +struct node {
> +       struct rb_node node;
> +       int key;
> +};
> +
> +static int _insert(struct rb_root *tree, int key)
> +{
> +       struct rb_node **new = &tree->rb_node, *parent = NULL;
> +       struct node *node;
> +
> +       while (*new) {
> +               struct node *this = container_of(*new, struct node, node);
> +
> +               if (key < this->key)
> +                       new = &((*new)->rb_left);
> +               else if (key > this->key)
> +                       new = &((*new)->rb_right);
> +               else
> +                       return 0;
> +       }
> +
> +       node = malloc(sizeof(struct node));
> +       if (!node)
> +               return 0;
> +
> +       node->key = key;
> +       rb_link_node(&node->node, parent, new);
> +       rb_insert_color(&node->node, tree);
> +
> +       return 1;
> +}
> +
> +static void _remove(struct rb_root *tree, int key)
> +{
> +       struct rb_node **node = &tree->rb_node;
> +
> +       while (*node) {
> +               struct node *this = container_of(*node, struct node, node);
> +
> +               if (key < this->key) {
> +                       node = &((*node)->rb_left);
> +               } else if (key > this->key) {
> +                       node = &((*node)->rb_right);
> +               } else {
> +                       rb_erase(&this->node, tree);
> +                       free(this);
> +                       return;
> +               }
> +       }
> +}
> +
> +TEST(rbtree)
> +{
> +       struct rb_root tree = { 0 };
> +
> +       _insert(&tree, 2);
> +       _insert(&tree, 1);
> +       _insert(&tree, 4);
> +       _insert(&tree, 3);
> +
> +       _remove(&tree, 2);
> +}
> +
> +TEST_HARNESS_MAIN
> --
> 2.24.1
>

Sorry, recall these patches.
It was my mistake. I forget to update the parent pointer at inserting. :(

-- 
Best regards!
Hev
https://hev.cc

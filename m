Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B10C04AAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 00:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA14E20848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 00:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558053324;
	bh=7TW9YRtA+zrn9bZVhm3pRMCNMOGMBXRGC3+aYbhED+Q=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=XgYsJmHEJwO8Tl/CIL4mNmfeCVga3qzv7vNDoRlliXm2YLwqq/Uyg+7vCVxTeZkg5
	 wJ83yRlysx3rDO9DjZS1HbdRNcE8PSKgHAaNSttj5yxnz8Jgn9m3/+vF3Kx0bCoKyx
	 VIo20AE4AL48clSpiucv2U/Rz8nrcWVH4MAn51wo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfEQAfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 20:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfEQAfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 20:35:23 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A48A7206BF;
        Fri, 17 May 2019 00:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558053322;
        bh=7TW9YRtA+zrn9bZVhm3pRMCNMOGMBXRGC3+aYbhED+Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=2IVzgl9AIPO++Ch2lD+HPwvhsbPyCjqMp1srxLDmXKAwP6rd65u7Wus1PDx6ERIac
         JgIJlEX6orOSTCbWhyMS/r6KVO9ATGZRYWIsOwLBH7NuKkS7fRkhmj+govo4YPjBBW
         njgrIlohapBLa9e+A8WE0GpgY53wrangCoB5QG44=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190514221711.248228-2-brendanhiggins@google.com>
References: <20190514221711.248228-1-brendanhiggins@google.com> <20190514221711.248228-2-brendanhiggins@google.com>
Subject: Re: [PATCH v4 01/18] kunit: test: add KUnit test runner core
From:   Stephen Boyd <sboyd@kernel.org>
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
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com
User-Agent: alot/0.8.1
Date:   Thu, 16 May 2019 17:35:21 -0700
Message-Id: <20190517003522.A48A7206BF@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brendan Higgins (2019-05-14 15:16:54)
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> new file mode 100644
> index 0000000000000..e682ea0e1f9a5
> --- /dev/null
> +++ b/include/kunit/test.h
> @@ -0,0 +1,162 @@
[..]
> +/**
> + * struct kunit - represents a running instance of a test.
> + * @priv: for user to store arbitrary data. Commonly used to pass data c=
reated
> + * in the init function (see &struct kunit_module).
> + *
> + * Used to store information about the current context under which the t=
est is
> + * running. Most of this data is private and should only be accessed ind=
irectly
> + * via public functions; the one exception is @priv which can be used by=
 the
> + * test writer to store arbitrary data.
> + */
> +struct kunit {
> +       void *priv;
> +
> +       /* private: internal use only. */
> +       const char *name; /* Read only after initialization! */
> +       spinlock_t lock; /* Gaurds all mutable test state. */
> +       bool success; /* Protected by lock. */

Is this all the spinlock protects? Doesn't seem useful if it's just
protecting access to the variable being set or not because code that
reads it will have a stale view of the value.

> diff --git a/kunit/test.c b/kunit/test.c
> new file mode 100644
> index 0000000000000..86f65ba2bcf92
> --- /dev/null
> +++ b/kunit/test.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Base unit test (KUnit) API.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#include <linux/sched.h>
> +#include <linux/sched/debug.h>
> +#include <kunit/test.h>
> +
[...]
> +
> +size_t kunit_module_counter =3D 1;

static?


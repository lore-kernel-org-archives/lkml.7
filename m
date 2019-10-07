Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083B8C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D339D206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fi8DtEjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfJGV6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:58:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40328 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbfJGV6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:58:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so9499228pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d9R2DytZLVyk2fwJJFRzpjruYoBx/tgy0WautWlgOD8=;
        b=Fi8DtEjIQeSKrxEK0+d42P779M0GrBfYYm+MgPk1Xj1ol6nl48uSmWyivr1wC7aQZ3
         SBRmwey+QVdnbcBzrHYjark4SV/68MO04hHYrjLg3R2duGdAIJ5D/Pw347dnBXlwVVH9
         cW0799mRq1crPTl6lQ1S5motdn4zbfG51kqiYkqh4QLUaAwbqSgYjyrsMXFrj9clkPza
         rC2EoEsxcUDjOSrQKRUHgLnxjiw5GdhHX3W7HR3KjuBbfx3Ua9JPhKkdjJ3Fq0E2j3MH
         MXkaPHBzET+2hjqUAQfDu+is4YsBX9qz8Hluoezq/wI+rMOd4b3VwQIAQ2jMKJsHOqwH
         Hejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d9R2DytZLVyk2fwJJFRzpjruYoBx/tgy0WautWlgOD8=;
        b=G3IWgKFNBY9FlpcYGYVOrcpUoZyD7eMg/Z5AiEQPoVuHLvjl18cclZbNuUb8/4Ybjr
         LAQzLaBQRITAR+aPArQh+jRcvvOZ2MZXrAdboP/FX7IPeKo4XlS4qYm5bMkWQpDpxsA+
         ol4jqksQzXroqQTsDm88U6t1aHB0p4Y2fB8epeE13K6mUlGsnmmGfjs9xWXNKhvLQZ7U
         fYGZC/YowkzmuYSEWbya75GP256o2b9RPbcrowGMJ4xuWUfjW9nhAIjPlg3u2a173U1E
         0k4EZeoNAI6WLN6BwDvDLv2xrFstUnskl9h6Dho7VyeaXKrboSAhndVTF7tFu7peJa1y
         AmEw==
X-Gm-Message-State: APjAAAUk2lf3pDNAuxkZmx0YF7KOE+yXjc9bKllOxMla6lxRCFz5Attm
        zRAGHyjIY19E/2WmVOQdsAscPg==
X-Google-Smtp-Source: APXvYqwL205rHfAPFri+fkXARng7t7g7JOTuAdW9fVsDitixtXyp2m0tM+RHh6xfTDgdgPcNZjw6lw==
X-Received: by 2002:a62:75d2:: with SMTP id q201mr34993831pfc.43.1570485489852;
        Mon, 07 Oct 2019 14:58:09 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id 26sm13262381pgz.70.2019.10.07.14.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 14:58:08 -0700 (PDT)
Date:   Mon, 7 Oct 2019 14:58:04 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/list-test: add a test for the 'list' doubly linked
 list
Message-ID: <20191007215804.GA119460@google.com>
References: <20191007213633.92565-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007213633.92565-1-davidgow@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 02:36:33PM -0700, David Gow wrote:
> This change adds a KUnit test for the kernel doubly linked list
> implementation in include/linux/list.h
> 
> Note that, at present, it only tests the list_ types (not the
> singly-linked hlist_), and does not yet test all of the
> list_for_each_entry* macros (and some related things like
> list_prepare_entry).
> 
> This change depends on KUnit, so should be merged via the 'test' branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=test

Others might feel differently than me, but I think this should go in the
comment section (below the "---").

> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  lib/Kconfig.debug |  12 +
>  lib/Makefile      |   3 +
>  lib/list-test.c   | 711 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 726 insertions(+)
>  create mode 100644 lib/list-test.c
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index a3017a5dadcd..60691c0aac3e 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1961,6 +1961,18 @@ config SYSCTL_KUNIT_TEST
>  
>  	  If unsure, say N.
>  
> +config LIST_TEST
> +	bool "KUnit Test for Kernel Linked-list stuctures"
> +	depends on KUNIT
> +	help
> +	  This builds the linked list unit test, which runs on boot.
> +	  It tests that the API and basic functionality of the list_head type
> +	  and associated macros.
> +	  For more information on KUnit and unit tests in general please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +
>  config TEST_UDELAY
>  	tristate "udelay test driver"
>  	help
> diff --git a/lib/Makefile b/lib/Makefile
> index bba1fd5485f7..309e174ee35d 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -292,3 +292,6 @@ obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
>  obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
>  obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
>  obj-$(CONFIG_OBJAGG) += objagg.o
> +
> +# KUnit tests
> +obj-$(CONFIG_LIST_TEST) += list-test.o
> diff --git a/lib/list-test.c b/lib/list-test.c
> new file mode 100644
> index 000000000000..f333e8b0d9fe
> --- /dev/null
> +++ b/lib/list-test.c
> @@ -0,0 +1,711 @@
> +// SPDX-License-Identifier: GPL-2.0

Might also want to add a bit more of a description here. Even if it is
just something like "KUnit test for the doubly linked list data
structure."

Also:

/*
 * <Insert description here.>
 *
 * Copyright (C) 2019, Google LLC.
 * Author: David Gow <davidgow@google.com>
 */

> +#include <kunit/test.h>
> +
> +#include <linux/list.h>
> +
> +struct list_test_struct {
> +	int data;
> +	struct list_head list;
> +};

<snip>

Thanks!

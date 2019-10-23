Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75471CA9EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4007C2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBIXqB0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407835AbfJWWC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 18:02:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38126 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405661AbfJWWCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 18:02:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id w8so10768174plq.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 15:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1thfPODjnoKymh0RHqmcX+0PR8e0dlYfkmxouB7h5+4=;
        b=EBIXqB0eDakGs+f2oqaOdh0DVPTJntdeDdTuy7Qyze61blnzpx/S0EuI6IQg9zNqU/
         mo5XmnPuP2T/I+ytUYgMpYp9tv+5PKWWZC+KUAV//Fi19hVvaK/rWwS58ctEEkf1hD3y
         TWhvnCWq/AzuaYt9bN/Rmgr9kxJo0kSOMt3mIPa9F57dcNFaiVDvPWDpwRttQwEvDUsZ
         1sq04F7uOPn7s1UvC2/wtb4aPUuHnE1b3iMetMbm5GeekeCt0IOLqTwftPD03AkmbxE2
         BM8fH0g5Yb3A3AGNn8ZtXaLORy6sf3e9yReq4EuyMu8P+SVhIdph7pr4nJZ/34FnFmB7
         t1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1thfPODjnoKymh0RHqmcX+0PR8e0dlYfkmxouB7h5+4=;
        b=YRABqFW8xqeJQxWH3JYphpnSC36DP7kGqg/cVtrx88f7IYuYlhryKCZP9ilBa26qYW
         WkweVjj5M1IVMdGQXrhZbT8Yn5fqFuxekG5giXOwNMae9cabDL2zs7iVmrRjkgI2wYUm
         S1eizwIbSxaIB7+YfwJmnWyBrMt2encr6oN9Rq0zu4Q1y42CAThD/sPTfIt1/cnLywD3
         N7KAmayLR6El5kntF9ngGLMQQw+1Os6XiKrZ4Tiu5YbUQ4ExNv84p2yf1bPi1Dl/21Of
         yL+HMQ3n84UACDcqE+xRzGQSUeIhd/JKdaNAuASRlN7NAnF7FeL4do7HPz1yPgTpIRsi
         d6Vg==
X-Gm-Message-State: APjAAAX3usZkmuZDSYP9/kSsGN7vMVGAm+oSifb9wX1Al8YseVcDVCii
        WbBWpNaYVZj2YDNhuB7o7AZDww==
X-Google-Smtp-Source: APXvYqyy14/T26jgC0nr0nn9U8HgSJ/w8mZFfiA4lnyO9LtHupuU21wg9L7JhPjg5S3O/lZEIQ/wCA==
X-Received: by 2002:a17:902:8b81:: with SMTP id ay1mr868026plb.79.1571868174092;
        Wed, 23 Oct 2019 15:02:54 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id a6sm5789436pfn.99.2019.10.23.15.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 15:02:53 -0700 (PDT)
Date:   Wed, 23 Oct 2019 15:02:48 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Subject: Re: [PATCH linux-kselftest/test v5] lib/list-test: add a test for
 the 'list' doubly linked list
Message-ID: <20191023220248.GA55483@google.com>
References: <20191022221322.122788-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022221322.122788-1-davidgow@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 03:13:22PM -0700, 'David Gow' via KUnit Development wrote:
> Add a KUnit test for the kernel doubly linked list implementation in
> include/linux/list.h
> 
> Each test case (list_test_x) is focused on testing the behaviour of the
> list function/macro 'x'. None of the tests pass invalid lists to these
> macros, and so should behave identically with DEBUG_LIST enabled and
> disabled.
> 
> Note that, at present, it only tests the list_ types (not the
> singly-linked hlist_), and does not yet test all of the
> list_for_each_entry* macros (and some related things like
> list_prepare_entry).
> 
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

I think I already had a "Reviewed-by and a Tested-by" on this patch.
Please make sure to apply the footers to subsequent versions of a patch
in the future.

> ---
> v5 replaces the use of KUNIT_ASSERT_NOT_ERR_OR_NULL() -- to check the
> return value from kzalloc() and kmalloc() -- with the __GFP_NOFAIL
> arugment. (Both in the list_test_list_init test.)
> 
> Earlier versions of the test can be found:
> v4: https://lore.kernel.org/linux-kselftest/20191018215549.65000-1-davidgow@google.com/
> v3: https://lore.kernel.org/linux-kselftest/20191016215707.95317-1-davidgow@google.com/
> v2: https://lore.kernel.org/linux-kselftest/20191010185631.26541-1-davidgow@google.com/
> v1: https://lore.kernel.org/linux-kselftest/20191007213633.92565-1-davidgow@google.com/
> 
> 
>  MAINTAINERS       |   5 +
>  lib/Kconfig.debug |  18 ++
>  lib/Makefile      |   3 +
>  lib/list-test.c   | 738 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 764 insertions(+)
>  create mode 100644 lib/list-test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ef985e01457..7ced1b69a3d3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9504,6 +9504,11 @@ F:	Documentation/misc-devices/lis3lv02d.rst
>  F:	drivers/misc/lis3lv02d/
>  F:	drivers/platform/x86/hp_accel.c
>  
> +LIST KUNIT TEST
> +M:	David Gow <davidgow@google.com>
> +S:	Maintained
> +F:	lib/list-test.c

Probably want to have a "mailing list" line. Something like:
"""
L:	linux-kselftest@vger.kernel.org
L:	kunit-dev@googlegroups.com
"""

> +
>  LIVE PATCHING
>  M:	Josh Poimboeuf <jpoimboe@redhat.com>
>  M:	Jiri Kosina <jikos@kernel.org>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index a3017a5dadcd..7991b78eb1f3 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1961,6 +1961,24 @@ config SYSCTL_KUNIT_TEST
>  
>  	  If unsure, say N.
>  
> +config LIST_KUNIT_TEST
> +	bool "KUnit Test for Kernel Linked-list structures"
> +	depends on KUNIT
> +	help
> +	  This builds the linked list KUnit test suite.
> +	  It tests that the API and basic functionality of the list_head type
> +	  and associated macros.
> +	

nit: unnecessary tab.

> +	  KUnit tests run during boot and output the results to the debug log
> +	  in TAP format (http://testanything.org/). Only useful for kernel devs
> +	  running the KUnit test harness, and not intended for inclusion into a
> +	  production build.
> +
> +	  For more information on KUnit and unit tests in general please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +
>  config TEST_UDELAY
>  	tristate "udelay test driver"
>  	help
[...]
> diff --git a/lib/list-test.c b/lib/list-test.c
> new file mode 100644
> index 000000000000..a6d17647e309
> --- /dev/null
> +++ b/lib/list-test.c
[...]
> +static void list_test_list_entry(struct kunit *test)
> +{
> +	struct list_test_struct test_struct;
> +
> +	KUNIT_EXPECT_PTR_EQ(test, &test_struct, list_entry(&(test_struct.list), struct list_test_struct, list));

nit: here and elsewhere: over 80 chars.

> +}
> +
> +static void list_test_list_first_entry(struct kunit *test)
> +{
> +	struct list_test_struct test_struct1, test_struct2;
> +	LIST_HEAD(list);
> +
> +	list_add_tail(&test_struct1.list, &list);
> +	list_add_tail(&test_struct2.list, &list);
> +
> +
> +	KUNIT_EXPECT_PTR_EQ(test, &test_struct1, list_first_entry(&list, struct list_test_struct, list));
> +}
[...]
> +static void list_test_list_for_each_entry(struct kunit *test)
> +{
> +	struct list_test_struct entries[5], *cur;
> +	static LIST_HEAD(list);
> +	int i = 0;
> +
> +	for (i = 0; i < 5; ++i) {
> +		entries[i].data = i;
> +		list_add_tail(&entries[i].list, &list);
> +	}
> +
> +	i = 0;
> +
> +	list_for_each_entry(cur, &list, list) {
> +		KUNIT_EXPECT_EQ(test, cur->data, i);
> +		i++;
> +	}
> +	

nit: another unnecessary tab. Looks like you should probably run checkpatch.

> +	KUNIT_EXPECT_EQ(test, i, 5);
> +}
> +
> +static void list_test_list_for_each_entry_reverse(struct kunit *test)
> +{
> +	struct list_test_struct entries[5], *cur;
> +	static LIST_HEAD(list);
> +	int i = 0;
> +
> +	for (i = 0; i < 5; ++i) {
> +		entries[i].data = i;
> +		list_add_tail(&entries[i].list, &list);
> +	}
> +
> +	i = 4;
> +
> +	list_for_each_entry_reverse(cur, &list, list) {
> +		KUNIT_EXPECT_EQ(test, cur->data, i);
> +		i--;
> +	}
> +	
> +	KUNIT_EXPECT_EQ(test, i, -1);
> +}
[...]

Cheers

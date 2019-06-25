Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547ACC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2766520657
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561504975;
	bh=WOthfbC+TT6Y+b05KtOa4YSBhuL37QFplDzj+2ubixc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nzWjemEb0g4zCoJKc2MNkCc3YpJ/yyM3gLuKRZGGkZDKGX3Oa58apj23AA28jFuFN
	 u4f/IQV5bVULSnWwJ0uzdkGNA3lFzAQhmnZXoCEq5dHzWGL2kOilkbqwHCbH4UKhsT
	 n4wtJxu7URj8RCj5T0pU+7I3S+q7uuWJ3eRxtPuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfFYXWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 19:22:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36523 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFYXWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 19:22:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so216699pfl.3;
        Tue, 25 Jun 2019 16:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fn8uhj8tc3U3pScoaEkKu7HBQ+Qs1BqmjB6lHJFC6hE=;
        b=m21X8L4JfBVK3LOmkUWD8c1wzYFdY22z0TGAnQm0WEj1YIm9AjsQWzFiVB77mdEcDm
         x2TfoPYwJBs2jmqjd23rOOPzWiaa8MVb81eEfZ8nYYp+mez9jTOYq6pwyzZuT07MWqyt
         XPZi4ClBC9BwsCKDX08p9vb9VJur4ns8sflUNixn0BT1ETSMDL8oumXOqEtIw0K25cjM
         EGNQbkttpPr/qJilrP5+QQM3xeVNAsfM9x4S1WkmSQUhYtxEs3/3IaNNX8lR5m8LmrQr
         eAQ4LF32+vlkWqIT7vmQKeeCAnfkYcjSLyI+lf39+LcVAr9xHimmV3S91DwqWPp9gExe
         930g==
X-Gm-Message-State: APjAAAVkiHkTqMJPXpPtjYhrY5FI85VRjpNWiNkgbGKERD7cuGKkjRIp
        CnHEFuEYfhkI8HCrHfddt40=
X-Google-Smtp-Source: APXvYqw6Otr6YJTjtY/OOBjSfZ7I1hNT7sLUZRcJRcDWNwR1ZNzZuSus00kEpYiN835NFFYZuHxFdA==
X-Received: by 2002:a63:8f09:: with SMTP id n9mr40832306pgd.249.1561504971968;
        Tue, 25 Jun 2019 16:22:51 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 5sm15215827pfh.109.2019.06.25.16.22.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 16:22:50 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D058A401EB; Tue, 25 Jun 2019 23:22:49 +0000 (UTC)
Date:   Tue, 25 Jun 2019 23:22:49 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, peterz@infradead.org,
        robh@kernel.org, sboyd@kernel.org, shuah@kernel.org, tytso@mit.edu,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        Tim.Bird@sony.com, amir73il@gmail.com, dan.carpenter@oracle.com,
        daniel@ffwll.ch, jdike@addtoit.com, joel@jms.id.au,
        julia.lawall@lip6.fr, khilman@baylibre.com, knut.omang@oracle.com,
        logang@deltatee.com, mpe@ellerman.id.au, pmladek@suse.com,
        rdunlap@infradead.org, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com
Subject: Re: [PATCH v5 07/18] kunit: test: add initial tests
Message-ID: <20190625232249.GS19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-8-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617082613.109131-8-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 01:26:02AM -0700, Brendan Higgins wrote:
> diff --git a/kunit/example-test.c b/kunit/example-test.c
> new file mode 100644
> index 0000000000000..f44b8ece488bb
> --- /dev/null
> +++ b/kunit/example-test.c

<-- snip -->

> +/*
> + * This defines a suite or grouping of tests.
> + *
> + * Test cases are defined as belonging to the suite by adding them to
> + * `kunit_cases`.
> + *
> + * Often it is desirable to run some function which will set up things which
> + * will be used by every test; this is accomplished with an `init` function
> + * which runs before each test case is invoked. Similarly, an `exit` function
> + * may be specified which runs after every test case and can be used to for
> + * cleanup. For clarity, running tests in a test module would behave as follows:
> + *

To be clear this is not the kernel module init, but rather the kunit
module init. I think using kmodule would make this clearer to a reader.

> + * module.init(test);
> + * module.test_case[0](test);
> + * module.exit(test);
> + * module.init(test);
> + * module.test_case[1](test);
> + * module.exit(test);
> + * ...;
> + */

  Luis

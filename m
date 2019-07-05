Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF16C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FA72133F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562358055;
	bh=MFYUFHxCNCNAmDOQhw8XPpluM4Sf6bPUEsgZBMV00bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r4DTtXezAa37vRq5wX9cwQYhDhWNRTGEtAg+u8WFn8ybOLc1kTqiu7cSilPqTP9c3
	 KPN/npkzmQxELeC/CjORZ/m3a0nNDrk1FKYPzh1EZ5Bi7HZ6dUEJVICsUsyjZ1C5xx
	 ieM7W5e8aWtNJdErP9jF6f0eYob/+XgsSCIm/GWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfGEUUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 16:20:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37090 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfGEUUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:20:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so4749447pfa.4;
        Fri, 05 Jul 2019 13:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=25Gxg4cOnHkRGBzoLvP39q6ZGr7xTfO8zZqC3Dmp4ao=;
        b=RyziFGzHWyWzlikAwjp9TuEqufKplQPckAT9Ps87VZr4SMqKSJ/UQS4CSZI6Z21S93
         w2laJ6Ts4yyGPTXs9IGqz337Cjn0f/2fvkfpMuo9/Zk/op4ADRld25AqmX4gbpn/b439
         oFc6WzpyxqwuQa392FOjGrkGT0JHeEZjnXelRFeYhWjNfTAD4niMxk4GNky7HJ0vRDYm
         pH5QcSnU6gRfzU8XW6AdB4rl53KysAKal9zHEHX32AEqOm29zoQDnrq/WSA3AWqJs4+3
         9FE/BEjWVyGpweAZdaQwAVKfw9tE0zrR5ZHvJ5ezUMssVHy6x0LJzWHIZUZRFlHqKWrW
         KQQQ==
X-Gm-Message-State: APjAAAVwvZDbOEmdQXmo3iHAUqKLmwgr4iSaIH+53hQCnWo9ShlHpEJK
        crI2JupPweDGKXAd/Ja4XQc=
X-Google-Smtp-Source: APXvYqzDgP2UvvEnLjwLbSAV5+PRQhqdSDKK5VAZmMuJMa1jdDqx9hxhnLoRC5+cLLJisPXah8LMOQ==
X-Received: by 2002:a63:e506:: with SMTP id r6mr7427654pgh.324.1562358053447;
        Fri, 05 Jul 2019 13:20:53 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r188sm18308824pfr.16.2019.07.05.13.20.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 13:20:52 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A47FE40190; Fri,  5 Jul 2019 20:20:51 +0000 (UTC)
Date:   Fri, 5 Jul 2019 20:20:51 +0000
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
Subject: Re: [PATCH v6 01/18] kunit: test: add KUnit test runner core
Message-ID: <20190705202051.GB19023@42.do-not-panic.com>
References: <20190704003615.204860-1-brendanhiggins@google.com>
 <20190704003615.204860-2-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704003615.204860-2-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 05:35:58PM -0700, Brendan Higgins wrote:
> +struct kunit {
> +	void *priv;
> +
> +	/* private: internal use only. */
> +	const char *name; /* Read only after initialization! */
> +	bool success; /* Read only after test_case finishes! */
> +};

No lock attribute above.

> +void kunit_init_test(struct kunit *test, const char *name)
> +{
> +	spin_lock_init(&test->lock);
> +	test->name = name;
> +	test->success = true;
> +}

And yet here you initialize a spin lock... This won't compile. Seems
you forgot to remove this line. So I guess a re-spin is better.

  Luis

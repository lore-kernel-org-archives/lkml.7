Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67496C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF1C21773
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552341378;
	bh=RCf2ZNGaFSK3RwEizH+Y2yc7+GST12TS4zevIesAL5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UTgZKeB1eY6zDtHppgzofJ2E/B9bIE0s9L69ZQMVD1UnGw0wvfyfNbYpPDpDieaPS
	 XFbXpokC19ZU1VvmZiasWbdLnKr+XN4b5ITM1UUvjDQIGAt05jTcFnbV5DPhETVpJM
	 hd/ThaINtI4aosF8heazEscRYxz3z56x0smiaJ4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfCKV4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:56:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56420 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfCKV4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:56:16 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E2FFEC00;
        Mon, 11 Mar 2019 21:56:14 +0000 (UTC)
Date:   Mon, 11 Mar 2019 14:56:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [LKP] [selftests/vm] a05ef00c97:
 kernel_selftests.vm.vmalloc_stability_smoke_test.fail
Message-Id: <20190311145613.af4e4ed3adf0718a0a7f3b71@linux-foundation.org>
In-Reply-To: <CAHk-=wj2TzOJqCr0-J5H6w=d5DgAtVQBQNrYHzaTMkEwkZrwnA@mail.gmail.com>
References: <20190311074315.GD10839@shao2-debian>
        <CAHk-=wj2TzOJqCr0-J5H6w=d5DgAtVQBQNrYHzaTMkEwkZrwnA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019 10:20:06 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Mar 11, 2019 at 12:43 AM kernel test robot
> <rong.a.chen@intel.com> wrote:
> >
> > ./run_vmtests: line 217: ./test_vmalloc.sh: Permission denied
> 
> I marked that script executable:
> 
>   6bc3fe8e7e17 ("tools: mark 'test_vmalloc.sh' executable")
> 
> although perhaps the better fix would have been to explicitly use the
> shell to start it in the 'run_vmtests' script instead?
> 
> We have a lot of files that aren't marked executable, probably because
> they came in as (or were generated as) non-git patches. Often through
> Andrew's workflow.

Not only that.  patch(1) doesn't set the x bit.  So if someone
downloads and applies patch-5.0-rc1.xz (as we say to do in the
documentation), their kernel won't work correctly.

This happens fairly regularly and the fix is to replace

	test_vmalloc.sh ...

with

	/bin/sh test_vmalloc.sh ...



Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709B2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446F0206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575360585;
	bh=aFg9Veo796TteFVQHjjernjk6fU7EC2u23Cdf1+3pFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fq9i4VA7dbXxe6zhBgzlnQeg0t5d+VuzGx8+DmGo0CweJ75vIP6tpIyNdoiWatlVl
	 u7fh7GUKu0huWuMtHeRdEjqOjTfoev18iIJP3PcwbHehophV1UW9873P3VUqCmq6a/
	 67DW+nY/r/ZkYlrXtVpzEGhUdV7I7FueAgQX4gPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfLCIJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:09:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:51152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbfLCIJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:09:44 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3B3B20675;
        Tue,  3 Dec 2019 08:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575360583;
        bh=aFg9Veo796TteFVQHjjernjk6fU7EC2u23Cdf1+3pFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sIuY74utBClz+BedqnpDyan2E2lvp8+7jDlKap364WLMq4s/fD4kbxrVO08/dmcf6
         AKq5dRqifCI/e8kcSS6MSR22EyLPxez53ZosL4/6/dgEk+/a88GjlQCgt9h0eAliv6
         ZllQbTnJGnvhV5+Cugb1jF4pFkHuZTcdM0kuQqJE=
Date:   Tue, 3 Dec 2019 08:09:33 +0000
From:   Will Deacon <will@kernel.org>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Hanjun Guo <guohanjun@huawei.com>, lkp@lists.01.org
Subject: Re: [LKP] Re: [refcount] d2d337b185:
 WARNING:at_lib/refcount.c:#refcount_warn_saturate
Message-ID: <20191203080932.GA6481@willie-the-truck>
References: <20191121115902.2551-9-will@kernel.org>
 <20191201154913.GQ18573@shao2-debian>
 <CAKv+Gu8VinMc8nv=W2-8c-HP7d6i_TV2weOZu9R8PiiHDtHRFA@mail.gmail.com>
 <92d23f27-5ed0-5765-a9e3-9bc9fbd3768d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92d23f27-5ed0-5765-a9e3-9bc9fbd3768d@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 04:01:46PM +0800, Rong Chen wrote:
> On 12/2/19 5:43 PM, Ard Biesheuvel wrote:
> > On Sun, 1 Dec 2019 at 16:49, kernel test robot <rong.a.chen@intel.com> wrote:
> > > FYI, we noticed the following commit (built with gcc-7):
> > > 
> > > commit: d2d337b185bd2abff262f3cf7de0080b3888e41c ("[RESEND PATCH v4
> > > 08/10] refcount: Consolidate implementations of refcount_t")
> > > url:
> > > https://github.com/0day-ci/linux/commits/Will-Deacon/Rework-REFCOUNT_FULL-using-atomic_fetch_-operations/20191124-052413
> > > 
> > > 
> > > in testcase: ocfs2test
> > > with following parameters:
> > > 
> > >          disk: 1SSD
> > >          test: test-mkfs
> > > 
> > So we went from a success rate of 0 out of 24 to 0 out of 24 by
> > applying that patch. How on earth is that a result that justifies
> > spamming everybody?
> 
> These failures were triggered by ocfs2test test, and all tests were failed
> include parent commit "2ab80bd4ae".

https://lore.kernel.org/lkml/20191119182745.GA11397@willie-the-truck
https://lore.kernel.org/lkml/20190912105640.2l6mtdjmcyyhmyun@willie-the-truck/

The refcount code is doing its job afaict and its the ocfs2 code at fault.

Will

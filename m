Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2DBC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738882133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551395685;
	bh=pjWaxZNql3F0/t5xjbzqBvJc099CWofLnPE0Wc+1U6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gbD2CDdfANU9MhMnLTYAEwfVxVNQsh0MNF0lwUnEOPiEu8HSPmh8lIJWRDcnUcwG2
	 tlNnBTuWPc3zEbDV5026osapP/CFIIao/GomEKL3m2nQ3D95U4nyObi40hHZQiHNAu
	 ezIn3EKQt8SbIG8TWFMRAluQmQO9Ux6hCU95jR+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732709AbfB1XOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:14:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39246 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfB1XOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:14:41 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CFEA0A94E;
        Thu, 28 Feb 2019 23:14:39 +0000 (UTC)
Date:   Thu, 28 Feb 2019 15:14:38 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        guillaume.tucker@collabora.com, matthew.hart@linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>, khilman@baylibre.com,
        enric.balletbo@collabora.com, Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Hocko <mhocko@suse.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, info@kernelci.org
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
Message-Id: <20190228151438.fc44921e66f2f5d393c8d7b4@linux-foundation.org>
In-Reply-To: <CAPcyv4ivjC8fNkfjdFyaYCAjGh7wtvFQnoPpOcR=VNZ=c6d6Rg@mail.gmail.com>
References: <5c6702da.1c69fb81.12a14.4ece@mx.google.com>
        <20190215104325.039dbbd9c3bfb35b95f9247b@linux-foundation.org>
        <20190215185151.GG7897@sirena.org.uk>
        <20190226155948.299aa894a5576e61dda3e5aa@linux-foundation.org>
        <CAPcyv4ivjC8fNkfjdFyaYCAjGh7wtvFQnoPpOcR=VNZ=c6d6Rg@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 16:04:04 -0800 Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Feb 26, 2019 at 4:00 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 15 Feb 2019 18:51:51 +0000 Mark Brown <broonie@kernel.org> wrote:
> >
> > > On Fri, Feb 15, 2019 at 10:43:25AM -0800, Andrew Morton wrote:
> > > > On Fri, 15 Feb 2019 10:20:10 -0800 (PST) "kernelci.org bot" <bot@kernelci.org> wrote:
> > >
> > > > >   Details:    https://kernelci.org/boot/id/5c666ea959b514b017fe6017
> > > > >   Plain log:  https://storage.kernelci.org//next/master/next-20190215/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-collabora/boot-am335x-boneblack.txt
> > > > >   HTML log:   https://storage.kernelci.org//next/master/next-20190215/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-collabora/boot-am335x-boneblack.html
> > >
> > > > Thanks.
> > >
> > > > But what actually went wrong?  Kernel doesn't boot?
> > >
> > > The linked logs show the kernel dying early in boot before the console
> > > comes up so yeah.  There should be kernel output at the bottom of the
> > > logs.
> >
> > I assume Dan is distracted - I'll keep this patchset on hold until we
> > can get to the bottom of this.
> 
> Michal had asked if the free space accounting fix up addressed this
> boot regression? I was awaiting word on that.

hm, does bot@kernelci.org actually read emails?  Let's try info@ as well..

Is it possible to determine whether this regression is still present in
current linux-next?

> I assume you're not willing to entertain a "depends
> NOT_THIS_ARM_BOARD" hack in the meantime?

We'd probably never be able to remove it.  And we don't know whether
other systems might be affected.

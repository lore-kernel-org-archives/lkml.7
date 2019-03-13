Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384F7C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02CD213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552490072;
	bh=mq5yHaM5gk91vQ0+RdufZavu5CdBnNUsqvdzbNZWP+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XvMRrxmEN3P68/O2f8NxfZWBmQrfyE5Wm+UFsoYjrG7xms3QMvRRwOK5QTKLzEhbI
	 hll+3ZBC/ArM0V3f79DTHTrUf1QL4D2e8bCFixcmoST4s9XlKQlqpgbRmPT5yNCF/r
	 9/wa+O5gxrGAD7tsFxtkiLeqZVM3PrMCfZc3inIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfCMPOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:14:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfCMPOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:14:30 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E7732087C;
        Wed, 13 Mar 2019 15:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552490069;
        bh=mq5yHaM5gk91vQ0+RdufZavu5CdBnNUsqvdzbNZWP+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tUX8Z+bC9aP/Rg9nwAq01RErNhmWDIQtrtIwFhSEYGiz7YNwJA1dwWPchlxCZb8bF
         4+gfPAnitXwwHZAsPTmvhFDQrZk6deSwdL4r11e9XxMnXB7OQLdj8x+Q4MkIOLWFJK
         ch8vDjqn9DS+tbHLkWRNvENCJoxcfWk7FkH0CC3k=
Date:   Wed, 13 Mar 2019 08:14:29 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/96] 4.9.163-stable review
Message-ID: <20190313151429.GB9719@kroah.com>
References: <20190312171034.530434962@linuxfoundation.org>
 <20190313144434.GA11117@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190313144434.GA11117@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 07:44:34AM -0700, Guenter Roeck wrote:
> On Tue, Mar 12, 2019 at 10:09:18AM -0700, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.163 release.
> > There are 96 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Mar 14 17:10:06 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> Early results:
> 
> Building x86_64:tools/perf ... failed
> --------------
> Error log:
> Warning: arch/x86/include/asm/cpufeatures.h differs from kernel
> Warning: arch/x86/include/uapi/asm/kvm.h differs from kernel
>   PERF_VERSION = 4.9.162.g605129
> builtin-trace.c: In function ‘perf_evlist__add_vfs_getname’:
> builtin-trace.c:2071:8: error: implicit declaration of function ‘strstarts’ [-Werror=implicit-function-declaration]
> builtin-trace.c:2071:3: error: nested extern declaration of ‘strstarts’ [-Werror=nested-externs]
> 
> Also affects v4.4.y-queue.

Hm, at first I was worried about my backport, but if it hit 4.4 as well,
that's not my fault :)

I'll look at this after breakfast, thanks!

greg k-h

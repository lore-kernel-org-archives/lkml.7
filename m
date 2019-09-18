Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA3AC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577F921897
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568814007;
	bh=VUbgU96p6YOxCBcakCbA6vuheORHf8dhsNuDrHXX1ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vCQtxIySWdLqiTMLqpLq9gkf1Xok/Fp3RFbt8CO+7n46esRExfvCF1JkVG+oz5DTy
	 idPCv21SQZr9nAimubl4zNUxsEM5z6DmRu8Lup5JNLTMiuWN6Ms8OdCA+wPtsLrU5A
	 bcb+vspg7MHUXgBeoFiMG6ugl0YG+YPSI9+b4o5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbfIRNkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731269AbfIRNkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:40:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20FEA20856;
        Wed, 18 Sep 2019 13:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568814005;
        bh=VUbgU96p6YOxCBcakCbA6vuheORHf8dhsNuDrHXX1ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N32GE0THub6Wx+JkM5CHcDzLlQERdcCi449awXv7MfmnV3ejszQls9tTBWiOOvJV2
         Jx5uPeAp+qablf5qbqQUi3EreAvwbpP/eCv0yV4utEBJ9VKZuLbnzucYm1O7DfIIjJ
         KC0R6PwnL/xQK+mKHXHgozyUn5tahQGui8dEgqHw=
Date:   Wed, 18 Sep 2019 15:40:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/50] 4.19.74-stable review
Message-ID: <20190918134003.GF1908968@kroah.com>
References: <20190918061223.116178343@linuxfoundation.org>
 <b1cff98a-d08f-d6cc-393f-9ca80c9229fe@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1cff98a-d08f-d6cc-393f-9ca80c9229fe@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 05:59:09AM -0700, Guenter Roeck wrote:
> On 9/17/19 11:18 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.74 release.
> > There are 50 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri 20 Sep 2019 06:09:47 AM UTC.
> > Anything received after that time might be too late.
> > 
> 
> I see lots of build failures.
> 
> kernel/module.c: In function 'free_module':
> kernel/module.c:2187:2: error: implicit declaration of function 'disable_ro_nx'; did you mean 'disable_irq'?
> 
> kernel/module.c: In function 'load_module':
> kernel/module.c:3828:2: error: implicit declaration of function 'module_disable_nx'; did you mean 'module_disable_ro'?
> 
> Reverting
> 
> ed510bd0bce3 modules: fix compile error if don't have strict module rwx
> 22afe9550160 modules: fix BUG when load module with rodata=n
> 
> fixes the problem.

Ugh, I thought I got these right.  Let me see what I got wrong in the
backport...

Any hint as to what the .config is here that is causing the problems?

greg k-h

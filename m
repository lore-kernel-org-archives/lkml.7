Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D51BC282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643A52186A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555743920;
	bh=ucJ3j2cNu/pagjT6Aw1QsX0v13wfJ6U7VdQydyPsCyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q8YHSKweKqxfgzJcHXk4UUYJBePb5DCx/pkbjgu7JvG0A0An1BNxo1MYryQs7dJsV
	 UyW0HYVgN3KKzC2/Eksk+Gm5f95mkeMfTPj6yichoQlKpusfchx/GGjzrSf0L6TmYA
	 H3BWpaJsbBn/YKoNPJGkfZeIbxqOlm5X+VM66ng4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfDTHFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 03:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDTHFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 03:05:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BA6221479;
        Sat, 20 Apr 2019 07:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555743918;
        bh=ucJ3j2cNu/pagjT6Aw1QsX0v13wfJ6U7VdQydyPsCyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oE5nqo9XuWd84EumiShMb6whnyxbX3MWh+tJ8eqPF1P5B12eJjsU3S5q7bv+iHxv4
         mmNVLsQZUTgqhKhLkoPR/5SlIpy+Ia51DzKUYGo4f87GfWpOechtSJsvNkdsyDJLHS
         l++t381tTdum78PU37gNr2q2WNqvL5I40HvWVkOU=
Date:   Sat, 20 Apr 2019 09:05:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 00/93] 5.0.9-stable review
Message-ID: <20190420070516.GB24855@kroah.com>
References: <20190418160436.781762249@linuxfoundation.org>
 <20190419194102.GD10320@roeck-us.net>
 <20190419210023.GB24525@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419210023.GB24525@roeck-us.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 02:00:23PM -0700, Guenter Roeck wrote:
> On Fri, Apr 19, 2019 at 12:41:02PM -0700, Guenter Roeck wrote:
> > On Thu, Apr 18, 2019 at 07:56:38PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.0.9 release.
> > > There are 93 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sat Apr 20 16:03:33 UTC 2019.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Build results:
> > 	total: 159 pass: 157 fail: 2
> > Failed builds: 
> > 	i386:tools/perf 
> > 	x86_64:tools/perf 
> > Qemu test results:
> > 	total: 349 pass: 349 fail: 0
> > 
> 
> Update: The build failure has been fixed with v5.0.8-94-ga6b9c7d1cb06.

Wonderful.  Sorry about the problems this round, thanks for the testing
and letting us know.

greg k-h

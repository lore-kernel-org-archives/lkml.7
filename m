Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2F9C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12237206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570533500;
	bh=Gd3Pu/Nb0ntm0YW3LjYFOaxIWAvHwAZ17nTXxiX/sg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jWJMX3NmTu/SANDvknxP1wBkP9LXoeF0sBZ7a7s1DTPzKptVLmtgaBITwPxRq4ejq
	 k/HjqiW9g27bMrmdKTgqh3jOeFhAtnn4uF3b6JJFd0Fmbl3DMVMoG9FyYPZa4Ec8Gv
	 Q89p5snyR5DTaqTan2QYc/g4vUnlCvLNREvvOV2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfJHLST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:18:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43797 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730494AbfJHLST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:18:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so10577965pfo.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 04:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FGMFRezLgrIqzqq7I8SRw2vYjiUHMW3qOaae3L+oggI=;
        b=GKnc87S3A+WeyqdKgLwSXSW2k7Cez5CQkC8cp4PN5UJrnGObsVADfbDmKpgg972fkg
         JIxAqbwwio/sUN9o5R6l5rTpGrzCAe39lIOQj3/c/pWmqzcxjFLRp4KSmRfftiJ88cCU
         cTEiAPktia+X9Bu/kFArWwe6k067jP4dQhYKvkpXtrT0rqC3t1bvNxEvhI9TnC8uv1/u
         P+7ZaSdJ/CVPXM0fnhA28VbwcrB8rHBEIDMcX5RuaniUrLZm4zVD48hrQxgkKa7hNKHi
         3odchRqw34Wl3VaPpiQ6NoAKepKeSLcAeWaO4FfMGeWZ2y4q/NyKReNP1ZyDqHu6VlQv
         2erw==
X-Gm-Message-State: APjAAAXsJzKbkRkilgS5rUoEolefEs+Jc4QnhEJ2IWjBstyNNkP3YWPP
        BfJzoFQkCJfd0Tvgrr1l4s0=
X-Google-Smtp-Source: APXvYqyv9Q0QZd3UsGBhJPPlaydQ1WupNJa/yX0cs/MrsAjBItNBmc8XSQZySRNkdziTvUB73wFxJg==
X-Received: by 2002:a17:90a:778a:: with SMTP id v10mr5075444pjk.26.1570533498163;
        Tue, 08 Oct 2019 04:18:18 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id e10sm21151133pfh.77.2019.10.08.04.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 04:18:17 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7D84040255; Tue,  8 Oct 2019 11:18:16 +0000 (UTC)
Date:   Tue, 8 Oct 2019 11:18:16 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Tuowen Zhao <ztuowen@gmail.com>, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, bhelgaas@google.com,
        kai.heng.feng@canonical.com
Subject: Re: [PATCH] mfd: intel-lpss: use devm_ioremap_uc for mmio
Message-ID: <20191008111816.GZ16384@42.do-not-panic.com>
References: <20190927175513.31054-1-ztuowen@gmail.com>
 <20190930110522.GT32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930110522.GT32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 02:05:22PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 27, 2019 at 11:55:13AM -0600, Tuowen Zhao wrote:
> > Write-combining BAR for intel-lpss-pci in MTRR causes system hangs
> > during boot.
> > 
> > This patch adds devm_ioremap_uc as a new managed wrapper to ioremap_uc
> > and with it forces the use of strongly uncachable mmio in intel-lpss.
> > 
> > This bahavior is seen on Dell XPS 13 7390 2-in-1:
> > 
> > [    0.001734]   5 base 4000000000 mask 6000000000 write-combining
> > 
> > 4000000000-7fffffffff : PCI Bus 0000:00
> >   4000000000-400fffffff : 0000:00:02.0 (i915)
> >   4010000000-4010000fff : 0000:00:15.0 (intel-lpss-pci)
> 
> +Cc: Luis as author of UC flavour of ioremap.
> 
> Luis, some BIOSes in the wild have wrong MTRR setting for PCI resource window
> and thus when Linux tries to allocate 64-bit MMIO address space (and in
> opposite to Windows, which does this from the end of available space towards
> beginning, Linux do this from the beginning towards end). Ideally we have to
> push vendors to fix firmware.
> 
> This patch AFAIU overrides MTTR/PAT settings for those pages and makes it
> possible to workaround firmware bug.
> 
> What do you think is the best approach here?

Indeed, such cases can come up, and yes _uc can be a workaround for such
cases.

> > +EXPORT_SYMBOL(devm_ioremap_uc);

EXPORT_SYMBOL_GPL() would be my preference. But other than that, this
makes sense.

  Luis

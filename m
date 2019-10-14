Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E1AECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DD121721
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="PPtoDEJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbfJNOvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:51:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34764 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfJNOvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:51:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19so16966684lja.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zl9j9N5g2XhcKzAZ6Cx7QAGYoUWVq9aZXTcu8wQiQfw=;
        b=PPtoDEJU0h4JnPMhPXkDkcYF4Pe2xnFKY77WyJmgnbwx/opDkf3EnHO/aSkQgb+Rr4
         U98tG+8u0Tj7hHDt1NIwZ6GLdUyKZfOTmkitZvXvH4Bt1ylpX7zMVXakUeWYk41ID0EK
         zq9ybPcOqkAU/37IUUlahKQeGr4nLG6cVkfBDWAzfGnw8ZaI4g16fIhpigjPNxQ09z47
         5BCHqsNVgO5pf9c+DUShNywqEcUVgeIdyQHSXWM6Qjw8dbzv5jfw6ZyO/DnJLDbJsPbs
         Qmy1Ki/10/Rh/k2iimoH7RrpMju9RUlqC91/56ewTgfbkpPd4zCYxzJ8+Ijcntg6Ysqr
         0vFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zl9j9N5g2XhcKzAZ6Cx7QAGYoUWVq9aZXTcu8wQiQfw=;
        b=g6Qqsf0OTDOeihmKN3L1NG61EnACeFnl3nGx9BjuIglFmUWxpWbLUObMxi5a0hsdfa
         xIv0Tp9UYBk34I/YhhF6tKGGHTT4cjeVs79X3cCRwC6L8CjUBROwJqJLzvu/U6x2wTeG
         qPkjfv13Ny7Azvsz1GJ0Ww11Peur1tG+oe/Wd2GZHhHcq8c56UQe84ELF7azZGvZ4PU9
         Og1tBbc+mImRPw8K6sV7dKryTZxShvG09FFUP7tEl3+bK9V1/QTAnG3S52p6ISZH/jDy
         j/vlHC9zapWFm8JxqpRUUXra8k1yxDFgDGOV7cLhRqur4s5pgUSY5nVg5G9z4DZv326B
         WWkg==
X-Gm-Message-State: APjAAAVwycka6myveXd3Bry+erxUrCLSYmarsrHbtmZ4GPnfJb6fY391
        DQ0TsuPS/Y8S/4FJr3JzOhOIIQ==
X-Google-Smtp-Source: APXvYqxUae3JOmHFPaEKUaEnf5tp7Lf4ZMZcnxinA7FNO7P2TrxkuYeHXeDS4ymI6ZKdgD2Ldu2SxQ==
X-Received: by 2002:a2e:a0ca:: with SMTP id f10mr18271484ljm.83.1571064705032;
        Mon, 14 Oct 2019 07:51:45 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x2sm4397741ljj.94.2019.10.14.07.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:51:44 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 70CAA101145; Mon, 14 Oct 2019 17:51:43 +0300 (+03)
Date:   Mon, 14 Oct 2019 17:51:43 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] mm/gup: fix a misnamed "write" argument: should be
 "flags"
Message-ID: <20191014145143.hyi6fj6s6uquohzj@box>
References: <20191013221155.382378-3-jhubbard@nvidia.com>
 <201910141316.DHpeevy3%lkp@intel.com>
 <d431c2cf-22bf-13be-05e5-c93512ac9ae5@nvidia.com>
 <20191014135234.7ak32pfir6du3xae@box>
 <acc39afa-ae6f-0eb9-fa31-1b63f8f86b2e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acc39afa-ae6f-0eb9-fa31-1b63f8f86b2e@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 08:14:04PM +0530, Aneesh Kumar K.V wrote:
> On 10/14/19 7:22 PM, Kirill A. Shutemov wrote:
> > On Sun, Oct 13, 2019 at 11:43:10PM -0700, John Hubbard wrote:
> > > On 10/13/19 11:12 PM, kbuild test robot wrote:
> > > > Hi John,
> > > > 
> > > > Thank you for the patch! Yet something to improve:
> > > > 
> > > > [auto build test ERROR on linus/master]
> > > > [cannot apply to v5.4-rc3 next-20191011]
> > > > [if your patch is applied to the wrong git tree, please drop us a note to help
> > > > improve the system. BTW, we also suggest to use '--base' option to specify the
> > > > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > > > 
> > > > url:    https://github.com/0day-ci/linux/commits/John-Hubbard/gup-c-gup_benchmark-c-trivial-fixes-before-the-storm/20191014-114158
> > > > config: powerpc-defconfig (attached as .config)
> > > > compiler: powerpc64-linux-gcc (GCC) 7.4.0
> > > > reproduce:
> > > >           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >           chmod +x ~/bin/make.cross
> > > >           # save the attached .config to linux build tree
> > > >           GCC_VERSION=7.4.0 make.cross ARCH=powerpc
> > > > 
> > > > If you fix the issue, kindly add following tag
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > 
> > > > All errors (new ones prefixed by >>):
> > > > 
> > > >      mm/gup.c: In function 'gup_hugepte':
> > > > > > mm/gup.c:1990:33: error: 'write' undeclared (first use in this function); did you mean 'writeq'?
> > > >        if (!pte_access_permitted(pte, write))
> > > >                                       ^~~~~
> > > >                                       writeq
> > > >      mm/gup.c:1990:33: note: each undeclared identifier is reported only once for each function it appears in
> > > > 
> > > 
> > > OK, so this shows that my cross-compiler test scripts are faulty lately,
> > > sorry I missed this.
> > > 
> > > But more importantly, the above missed case is an example of when "write" really
> > > means "write", as opposed to meaning flags.
> > > 
> > > Please put this patch on hold or drop it, until we hear from the authors as to how
> > > they would like to resolve this. I suspect it will end up as something like:
> > > 
> > > 	bool write = (flags & FOLL_WRITE);
> > > 
> > > ...perhaps?
> > 
> > Just use
> > 
> > 	if (!pte_access_permitted(pte, flags & FOLL_WRITE))
> > 
> > as we have in gup_pte_range().
> > 
> > And add:
> > 
> > Fixes: cbd34da7dc9a ("mm: move the powerpc hugepd code to mm/gup.c")
> > 
> 
> b798bec4741bdd80224214fdd004c8e52698e42 isn't this the commit that need to
> be mentioned in the Fixes: tag?

Ah. Okay, I see you point. Yes, this is the sourch of the breakage.

-- 
 Kirill A. Shutemov

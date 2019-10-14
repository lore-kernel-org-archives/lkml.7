Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BE2ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D21921835
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="IlQOIU9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbfJNNwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:52:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39085 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732082AbfJNNwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:52:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id y3so16732301ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 06:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f9b7DTnSxRvT+GcqfkPH2X9rmIgB3LKKUuDW26EPx+E=;
        b=IlQOIU9V0/k9WH69ItvmTZuFdztr2V9aDLo0xk1sMct4aWBwk8sRXReuLZ2LYneqgH
         Vptsx/PLN+PjP0htJydrqQuT1nUfCgV0tc5ViZ9q28KhfbJNEMFK83EAD/w0EGI4v10D
         edZ/JcU4ONw4IL6cytAtVgvQBUtUUYVZ0uSxldRnlxPF9NoZvpKJryi49k92yzUw/wWA
         ESv6noE0SESJPPPtgZvufaasJVDi6YWW7H0b6QsgMidIuYuBIPNP3hzS1bQUp6Nakfu4
         63Mh2/JSpTR9ZwkbzJtIP0hXSu+yA5U9vHNnAYjoDrJaqoe2KwcHl18SDmz5mJi3iRu5
         Wzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f9b7DTnSxRvT+GcqfkPH2X9rmIgB3LKKUuDW26EPx+E=;
        b=s9NVSEazeZnu25i/q4UqCOZqJA01E+VBjI5HxeSuaG/YDtgbYIzEb7XXty7jWPTYau
         f3vDsRQf+BWEUZKbOxrtBzxfuZIUWwkrCSBCi50JGYYZFLg5IgawA31ON3tCKAbqaq5A
         AaqNO82KNnQGxjuEdyREWqq3Y/W9qINlOOcKPxil3YcFHjca8+EXiT6PADLJK9kpBzXX
         ITXB7Z7bUmMcMtkf2483/4bFUQKMGpbMdb8oK3VC7vkYHYcDV1ko+MGnklnXIRyHOqDj
         UI0Cr8MFiMuXwygx27ECJGQLWL84sESPvCp1T9bV1Kh4d2Pip7fagXwuKEpanaD1O81A
         gpmQ==
X-Gm-Message-State: APjAAAVfSDaLd8NseOza8XPRzN1r1uoKoIqc5aGH/Q+hLdEAeR98h7pQ
        OUVCHsFiKUI1pywn8hhYsOD6FQ==
X-Google-Smtp-Source: APXvYqzCK6MZOUzCuyTxzwIH3ne+Pzp0UvqoxBQxOCxb6nOc31dDH5pWOjOnQwO5BaW1BeDb4dcgLw==
X-Received: by 2002:a2e:9112:: with SMTP id m18mr5930341ljg.75.1571061155925;
        Mon, 14 Oct 2019 06:52:35 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 207sm4961519lfn.0.2019.10.14.06.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 06:52:35 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A16C3101288; Mon, 14 Oct 2019 16:52:34 +0300 (+03)
Date:   Mon, 14 Oct 2019 16:52:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] mm/gup: fix a misnamed "write" argument: should be
 "flags"
Message-ID: <20191014135234.7ak32pfir6du3xae@box>
References: <20191013221155.382378-3-jhubbard@nvidia.com>
 <201910141316.DHpeevy3%lkp@intel.com>
 <d431c2cf-22bf-13be-05e5-c93512ac9ae5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d431c2cf-22bf-13be-05e5-c93512ac9ae5@nvidia.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2019 at 11:43:10PM -0700, John Hubbard wrote:
> On 10/13/19 11:12 PM, kbuild test robot wrote:
> > Hi John,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on linus/master]
> > [cannot apply to v5.4-rc3 next-20191011]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > 
> > url:    https://github.com/0day-ci/linux/commits/John-Hubbard/gup-c-gup_benchmark-c-trivial-fixes-before-the-storm/20191014-114158
> > config: powerpc-defconfig (attached as .config)
> > compiler: powerpc64-linux-gcc (GCC) 7.4.0
> > reproduce:
> >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          # save the attached .config to linux build tree
> >          GCC_VERSION=7.4.0 make.cross ARCH=powerpc
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >     mm/gup.c: In function 'gup_hugepte':
> > > > mm/gup.c:1990:33: error: 'write' undeclared (first use in this function); did you mean 'writeq'?
> >       if (!pte_access_permitted(pte, write))
> >                                      ^~~~~
> >                                      writeq
> >     mm/gup.c:1990:33: note: each undeclared identifier is reported only once for each function it appears in
> > 
> 
> OK, so this shows that my cross-compiler test scripts are faulty lately,
> sorry I missed this.
> 
> But more importantly, the above missed case is an example of when "write" really
> means "write", as opposed to meaning flags.
> 
> Please put this patch on hold or drop it, until we hear from the authors as to how
> they would like to resolve this. I suspect it will end up as something like:
> 
> 	bool write = (flags & FOLL_WRITE);
> 
> ...perhaps?

Just use

	if (!pte_access_permitted(pte, flags & FOLL_WRITE))

as we have in gup_pte_range().

And add:

Fixes: cbd34da7dc9a ("mm: move the powerpc hugepd code to mm/gup.c")

-- 
 Kirill A. Shutemov

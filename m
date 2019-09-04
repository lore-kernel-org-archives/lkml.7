Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32229C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0622C2339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kbRt0PBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388011AbfIDSB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:01:29 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33730 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388169AbfIDSB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:01:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id r5so20186104qtd.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+yojRW69JxaQ1YWeqMffbm7yLHLeYtlezXpC/ayb9A=;
        b=kbRt0PBSJ48HPVKqYf6ln5xrY0K3tPQUm2vMDVscw9cYbN6byjes7cgfaBiOH/g4Se
         bSV5QE+ivAav5Lo49RKTpLIuAmKnEIhwOObmqBuh3aDAtAgqiYZUoP025LEG6AO4xfOM
         Ad4rH+Rj4ColCBhR7VZeM0jzkWvmq5qUjtYyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+yojRW69JxaQ1YWeqMffbm7yLHLeYtlezXpC/ayb9A=;
        b=I0groZ1bagr8gPNVkmdIOVTUFk5j/rN78c0DHVr5C8GOJjgbKW4VJVN6hRTW3IcBjn
         ypAvVcrkMsQ5wXxyYwYsuHv+urNVyiL/OTyR0dfnt70jXuM41jI33dp/c10cndKr4L8Y
         UzOeHFDcXVAgmRYWtmYNL68cNFQlT/UwJXDuMFkyBrH9dg485TkEoyNRI1g3wg6W9ZHo
         eMrnRcLkpAf6fOWk72znsbGgRhUDik9qImEbNJML2fEYQOkMnTBX42h1ObMgiCyl6Q9v
         DeQ60ijur7L7ZqBuB2c+EvYfVSt/AYcAAeZ69I9VFi2wMOBPIlgFf8Qhfq11TMMPcvMg
         1oyQ==
X-Gm-Message-State: APjAAAW9TL6XTWx7papL1uiSmTyMFVt3veP+0YZDLd5A7uzHikPWmAYH
        CiK8yHDUOAQcKRsCesJp2UhhfqWlry1l40c+OuKtnQ==
X-Google-Smtp-Source: APXvYqwWC2X+OYzUl5J5ytQJfTXyJbSLc0g6beM03QYuEGvgG0SQAMDJ28TJJEMxAaAsJBpxWqCA1jWIOj3doc4HQKU=
X-Received: by 2002:ac8:44c7:: with SMTP id b7mr24636084qto.170.1567620084987;
 Wed, 04 Sep 2019 11:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190830231817.76862-1-joel@joelfernandes.org>
 <201909041108.RSjNvfDL%lkp@intel.com> <20190904050419.GA102582@google.com> <CAHp75Vdeoc1S_0Dn_vk2ULPRLk_sevWoxs8+Gscv9ki_kkPx4Q@mail.gmail.com>
In-Reply-To: <CAHp75Vdeoc1S_0Dn_vk2ULPRLk_sevWoxs8+Gscv9ki_kkPx4Q@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 4 Sep 2019 14:01:13 -0400
Message-ID: <CAEXW_YQyXSuT9o6pTdMJBM=7xRhUAGtVoteswY5hNcNZBc9bgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pci: Convert to use built-in RCU list checking
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 1:13 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Sep 4, 2019 at 8:07 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Wed, Sep 04, 2019 at 12:06:43PM +0800, kbuild test robot wrote:
> > > Hi "Joel,
> > >
> > > Thank you for the patch! Yet something to improve:
> > >
> > > [auto build test ERROR on linus/master]
> > > [cannot apply to v5.3-rc7 next-20190903]
> > > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > >
> > > url:    https://github.com/0day-ci/linux/commits/Joel-Fernandes-Google/pci-Convert-to-use-built-in-RCU-list-checking/20190901-211013
> > > config: x86_64-rhel-7.6 (attached as .config)
> > > compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
> > > reproduce:
> > >         # save the attached .config to linux build tree
> > >         make ARCH=x86_64
> >
> > This error seems bogus. I pulled -next and applied this patch and it builds
> > fine. I am not sure what is wrong with the 0day tree, and the above 0day link
> > is also dead.
> >
> > What's going on with 0day ?!
>
> I would rather to add Depends-on: ... tag to your patch if the
> dependency is going thru another tree at the same cycle.
> kbuildbot absolutely correct here.

The dependency is already in -next and I pulled it and applied the
patch. It is testing -next right?

thanks,

 - Joel

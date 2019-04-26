Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD46C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564A12077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YouWOTTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfDZSBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:01:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44172 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfDZSBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:01:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id y12so1908439plk.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 11:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QgpcjtM8GqhirZUjj4Yi3UaRcRfryKCQ0fsKcAS6iq4=;
        b=YouWOTTgmZcMgpt7BsgUdB1ht6uEf5kKEHHMVB5iGaAehC7W/GOidF6vCoZBSGn538
         UHsRrlZEJi8PNRrUi5n1IZArH/kSJjT+MUGdkOAshPUl08i5emUO6Fa7luH8a3b4aBBO
         MyrWYebW5hlKUwPgobG/hv+gGYU4UEuQ8jianmZP7n7TjrYeGq6dkHvo/iw5HAOAjQdC
         2zBMmlV8i0Smep96ysjgn9560upTf1fG7a3C+6vUt/U5xp0+ZMDf9v6gopbdsyM+wycl
         3sxkhfZo0ugHJT8wYWGZ9oBjk1w2RCb4aPWw89FcdTUU4/+taYyx/8qysXxBYwAQTUoF
         sSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QgpcjtM8GqhirZUjj4Yi3UaRcRfryKCQ0fsKcAS6iq4=;
        b=ZCOH7OgrTW2mLI6RvLAnUQN3xxP6uNY70vZxJYxCTh6mq2wvtZoPmT5s46gNbFW9AE
         778D+O6X/SBkiC1LUQZXbKGFjsEOMQdv0zbxTTUcByVXkhL0GLciNVktXuIQZ3eNJHE2
         8bOKMEOViuimcXD0k02FqzxseG4RJFHVt0smWP8gNyqbphJKngNWgt7X65T6mUsMG4Z8
         bofr7GrI0ZOWE92MdXiTB/o265aW/IJ3jLvL1Ol9Y7Yf/I2fSIwZLR8awBeAUrQ/TOTw
         L30XSis5eHQptp4BX1t4XkhC8tUipekofCLpYoTrxc/txtv6gr2T69bBsz0aAtKxff4X
         /h+g==
X-Gm-Message-State: APjAAAWUoDgdqb7Lrb0Z0nYcVcxrlAW2hBFDrN9NZbZUKSBQeGYxSzE3
        4Oy414JPHpEgCcH10EMZXmbbO2D7r4WQo+4oHJIB0w==
X-Google-Smtp-Source: APXvYqxlXWG7kfLW5uVwj0WUNXrrhVqZet8RCYND3XClYyu35n3cM60w5mnM6qy38ezgLNIvxM7VbodLmOGh/5yBthw=
X-Received: by 2002:a17:902:7d8f:: with SMTP id a15mr46673534plm.3.1556301660487;
 Fri, 26 Apr 2019 11:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190426155653.2cdebc5d@canb.auug.org.au> <20190426062548.GB5920@kroah.com>
 <CAO=notwQFWRVDtoH+NGWpm647pJHVFvVoPm3EKdKmdrRUmDZqw@mail.gmail.com>
In-Reply-To: <CAO=notwQFWRVDtoH+NGWpm647pJHVFvVoPm3EKdKmdrRUmDZqw@mail.gmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Fri, 26 Apr 2019 11:00:49 -0700
Message-ID: <CAO=notxMAQinwQrrbGwYAUD3JGq8zo42U314Km_QKQrnrkRoQA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the char-misc tree
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 7:30 AM Patrick Venture <venture@google.com> wrote:
>
> On Thu, Apr 25, 2019 at 11:25 PM Greg KH <greg@kroah.com> wrote:
> >
> > On Fri, Apr 26, 2019 at 03:56:53PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > After merging the char-misc tree, today's linux-next build (x86_64
> > > allmodconfig) produced this warning:
> > >
> > > drivers/misc/aspeed-p2a-ctrl.c: In function 'aspeed_p2a_mmap':
> > > drivers/misc/aspeed-p2a-ctrl.c:110:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
> > >   pgprot_t prot = vma->vm_page_prot;
> > >   ^~~~~~~~
> > >
> > > Introduced by commit
> > >
> > >   01c60dcea9f7 ("drivers/misc: Add Aspeed P2A control driver")
> >
> > Patrick, I thought you fixed all of these already?  Can you send a patch
> > again?
>
> I fixed the ones caught by the robot.  I'll have to switch up my build
> environment a bit to fault on warnings for the kernel, not sure why it
> isn't --

Verified the warnings being ignored isn't a local configuration issue,
but the way OpenBMC is configured.  Verified the warning via normal
kernel compilation and fixed the issue.  Reran and found no other
issues for that drivers.  Submitted patch for review.

>
> >
> > Can you also make the driver so it can build with CONFIG_COMPILE_TEST
> > enabled so that others can find your problems earlier in the review
> > process?

Verified the driver builds and produces no warnings.

Thanks,
Patrick

>
> Roger that.
>
> >
> > thanks,
> >
> > greg k-h

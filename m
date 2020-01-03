Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E0CC32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB8922314
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578069027;
	bh=9Ik8cMfPBaJNUHWmeVYHaV2wMG09CyYTlz0uvCUc4vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t+bYg0/ncXF8TlOlqOnxA4zQYkq7roAhrmXqsYXaakDm3Jr4ZzhEAAfZBw0vRGjfZ
	 23T9r9VNxQ9lo8EHLVaIMFFHZV1ppOXIbIm+HnvXS/I2nKDXEEbWiQSP7SuFsq/YDs
	 FkEV7aiyFyqxP90T9NTkFFmos4xVnVep6wJgqRIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgACQa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 11:30:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbgACQaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:30:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1507A21734;
        Fri,  3 Jan 2020 16:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578069024;
        bh=9Ik8cMfPBaJNUHWmeVYHaV2wMG09CyYTlz0uvCUc4vU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PSmXGRlShemnVOVqF7OVCtoOCif3mmdRlrF6xvtHYL72TL1I3xoAxAoUiPMwpK+bO
         fuXSE+Yebics1udKzuT45xqPSyZYRvxnfdPLpeASYZO3CTtFh2d/5XwA1bwUKHKsQd
         cxzO6Cn+2zizlhAvO+EJiINIwEkcTv1OOTSatYG4=
Date:   Fri, 3 Jan 2020 17:30:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>, LTP List <ltp@lists.linux.it>,
        Jan Stancek <jstancek@redhat.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 5.4 000/191] 5.4.8-stable review
Message-ID: <20200103163022.GA1205191@kroah.com>
References: <20200102215829.911231638@linuxfoundation.org>
 <CA+G9fYuPkOGKbeQ0FKKx4H0Bs-nRHALsFtwyRw0Rt5DoOCvRHg@mail.gmail.com>
 <CAK8P3a1+Srey_7cUd0xfaO8HdMv5tkUcs6DeDXzcUKkUD-DnGQ@mail.gmail.com>
 <CAK8P3a24EkUXTu-K2c-5B3w-LZwY7zNcX0dZixb3gd59vRw_Kw@mail.gmail.com>
 <180c36d7-336b-f7a9-66d4-49703eca2aa9@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <180c36d7-336b-f7a9-66d4-49703eca2aa9@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 07:48:49AM -0800, Guenter Roeck wrote:
> On 1/3/20 7:29 AM, Arnd Bergmann wrote:
> > On Fri, Jan 3, 2020 at 4:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > 
> > > On Fri, Jan 3, 2020 at 4:03 PM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > > 
> > > > On Fri, 3 Jan 2020 at 03:42, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > 
> > > -ENOENT is what you get when hugetlbfs is not mounted, so this hints to
> > > 
> > > 8fc312b32b2  mm/hugetlbfs: fix error handling when setting up mounts
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-5.4.y&id=3f549fb42a39bea3b29c0fc12afee53c4a01bec9
> > 
> > I see that Mike Kravetz suggested not putting this patch into stable in
> > 
> > https://lore.kernel.org/lkml/befca227-cb8a-8f47-617d-e3bf9972bfec@oracle.com/
> > 
> > but it was picked through the autosel mechanism later.
> > 
> 
> I think autosel is way too aggressive. This is an excellent example.

Why?  It fixes a bug, the text says so, and the code shows it.  This is
a great example of a patch that autosel _should_ be picking up.  Now the
fact that it happens to break existing functionality is not an
autosel-detectable thing.  Especially as that same functionality is now
broken in Linus's tree :)

Autosel assumes that patches are correct, it can't know that they are
buggy.  That should have been weeded out by the developers and testing
before they hit Linus's tree.

thanks,

greg k-h

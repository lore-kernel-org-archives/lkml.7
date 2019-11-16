Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BC1C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 09:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B597920733
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 09:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573896982;
	bh=xznUAJkLYLY4+gvqTcCjwxobcbNgpzJ3DyrGAFPEM5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E5rDHSkhnd/FpEcsOme/hZKohpStAZCdIyV10Nw9ZcqX845Bo+Hz4aR9QNr5nLh1u
	 PV1iODtVHLaQCm5nnbkUWgiNu+OrdYvCXhQRq0NjhSq5/bdb1zY0vXwtNZgCZWQXjt
	 1YhZbieOAB5QwZ3xIBrpIfiL8/bON/L92ypcxTUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfKPJgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 04:36:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfKPJgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 04:36:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0789820723;
        Sat, 16 Nov 2019 09:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573896977;
        bh=xznUAJkLYLY4+gvqTcCjwxobcbNgpzJ3DyrGAFPEM5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HsFTufcRGa4BlvI/+cWl2c9tuDHGp9NNTxA0pAU8967ylQqWo0DUYBkW9rQMBaQaw
         5HqAVz0NE29hoksAM/+XjLfDN3Q2ZnugqPBHa6gYjXs1O+qxOYa4ayAfKceEmzJ3+s
         gYZT4MJYoiqQc/z4XF8K8ZnNP4ws12JMgI5ScEQc=
Date:   Sat, 16 Nov 2019 10:36:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Daniel Axtens <dja@axtens.net>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Michael Neuling <mikey@neuling.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tty crash in Linux 4.6
Message-ID: <20191116093614.GB408484@kroah.com>
References: <573A5996.3080305@hurleysoftware.com>
 <573B3F84.5050201@hurleysoftware.com>
 <573B5E4C.8030808@hurleysoftware.com>
 <alpine.LRH.2.02.1607071855150.19053@file01.intranet.prod.int.rdu2.redhat.com>
 <CAEjGV6zRghiCCMC1+-n+YPeA0Lrq=-vcvdoYpbwE4G=TXWzY3Q@mail.gmail.com>
 <87po3wusq1.fsf@linkitivity.dja.id.au>
 <20180322140554.GA3273@kroah.com>
 <alpine.LRH.2.02.1803270818150.30055@file01.intranet.prod.int.rdu2.redhat.com>
 <87k1td913u.fsf@linkitivity.dja.id.au>
 <d8ba132f-e174-2acc-e74c-4e9aed945c30@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8ba132f-e174-2acc-e74c-4e9aed945c30@oracle.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 11:21:08AM -0800, Mike Kravetz wrote:
> On 4/11/18 9:09 AM, Daniel Axtens wrote:
> > Mikulas Patocka <mpatocka@redhat.com> writes:
> > 
> >> On Thu, 22 Mar 2018, Greg Kroah-Hartman wrote:
> >>
> >>> On Fri, Mar 23, 2018 at 12:48:06AM +1100, Daniel Axtens wrote:
> >>>> Hi,
> >>>>
> >>>>>> This patch works, I've had no tty crashes since applying it.
> >>>>>>
> >>>>>> I've seen that you haven't sent this patch yet to Linux-4.7-rc and
> >>>>>> Linux-4.6-stable. Will you? Or did you create a different patch?
> >>>>>
> >>>>> We are hitting this now on powerpc.  This patch never seemed to make
> >>>>> it upstream (drivers/tty/tty_ldisc.c hasn't been touched in 1 year).
> >>>>
> >>>> I seem to be hitting this too on a kernel that has the 4.6 changes
> >>>> backported to 4.4.
> >>>>
> >>>> Has there been any further progress on getting this accepted?
> >>>
> >>> Can you try applying 28b0f8a6962a ("tty: make n_tty_read() always abort
> >>> if hangup is in progress") to see if that helps out or not?
> > 
> > Sorry for the delay in getting the test results; as with Mikulas,
> > 28b0f8a6962a does not help.
> > 
> > Regards,
> > Daniel
> > 
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >>
> >> It doesn't help. I get the same crash as before.
> >>
> >> Mikulas
> 
> Reviving a really old thread.
> 
> It looks like this patch never got merged.

I do not see a patch in this email, so I have no idea what you are
referring to, sorry.

> Did it get resolved in some other way?  I ask because we have a
> customer who seems to have hit this issue.

Can you try with the latest kernel to see if it is resolved or not?

thanks,

greg k-h

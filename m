Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D390BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA462085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfCSTq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:46:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39690 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfCSTq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 15:46:26 -0400
Received: by mail-qt1-f193.google.com with SMTP id t28so23638596qte.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 12:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1wpvwfQmntYpdv9n0ZXwTfg+Rq759lNPmWUjH8arvk=;
        b=A74VbOFGWNAA6gavw/uz3C3LdhEb2VgueCzVHuRS35j+1FmE7TIxTBw0yCoKDcbnZC
         4JlyUDupSAz5cT3Eh/ptpKKWManrbX7MaN5z857jFaAJwWQKqc66tflQBqrSVEzgUOn8
         zq01xwUEZT667anMpY/MGxoADOXGpwrNql2TsI3bwy/GEVZHPmN2QweZ+vqMHfRasm/8
         AnJ6O9TJ/rMYnQnOzKEvqBB9WrJGe+jWYr1JwFD75QlPwTlLXV2ieuUEstfUnuWu4oED
         F7xVI520f3PuKCBuJSrqkE9tzf6oX+wAa2ZRM+R8u75CEDhKd5+M+jftkJkfFSFyDeZQ
         d9uw==
X-Gm-Message-State: APjAAAXMGaZklGWTmKZi1G2TwC0MJmRpgAk10xqVBk9l2RFZpTgAc07+
        AkWRM7TItsMRtXrtFZS6isgRUvMAD73NC3r1Xkc=
X-Google-Smtp-Source: APXvYqyNhnGFOa3ZG6skYfj6i2tGeeLhV1+YaDYnU9HW83+ZyBgKyiKM8c77eVi33aSLqjzoQhVf29pFeKRfSLsfdu0=
X-Received: by 2002:ac8:276b:: with SMTP id h40mr3591617qth.319.1553024784974;
 Tue, 19 Mar 2019 12:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
 <1552997064-432700-5-git-send-email-dragan.cvetic@xilinx.com>
 <CAK8P3a3uKOVW5HcQD9LLKfoeOkTnhE8M2rHsZuwjNUQv18=J_g@mail.gmail.com>
 <BL0PR02MB5681AEB47A24279266831D1BCB400@BL0PR02MB5681.namprd02.prod.outlook.com>
 <CAK8P3a115AM-iuGPgqEYfR7p9HMQL3fm9eL7370ogf3-DBrjbA@mail.gmail.com> <BL0PR02MB5681C0D1D5DB5F57E3640D9ACB400@BL0PR02MB5681.namprd02.prod.outlook.com>
In-Reply-To: <BL0PR02MB5681C0D1D5DB5F57E3640D9ACB400@BL0PR02MB5681.namprd02.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Mar 2019 20:46:08 +0100
Message-ID: <CAK8P3a01ufKsJxWNG09qeyLvVH12jiLpLchOxdKie0wzU2=WWQ@mail.gmail.com>
Subject: Re: [PATCH 04/12] misc: xilinx_sdfec: Add open, close and ioctl
To:     Dragan Cvetic <draganc@xilinx.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        Derek Kiernan <dkiernan@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 7:10 PM Dragan Cvetic <draganc@xilinx.com> wrote:
> > -----Original Message-----
> > From: Arnd Bergmann [mailto:arnd@arndb.de]
> > Sent: Tuesday 19 March 2019 15:36
> > To: Dragan Cvetic <draganc@xilinx.com>
> > Cc: gregkh <gregkh@linuxfoundation.org>; Michal Simek <michals@xilinx.com>; Linux ARM <linux-arm-kernel@lists.infradead.org>;
> > Derek Kiernan <dkiernan@xilinx.com>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH 04/12] misc: xilinx_sdfec: Add open, close and ioctl
> >
> > On Tue, Mar 19, 2019 at 3:59 PM Dragan Cvetic <draganc@xilinx.com> wrote:
> > > >
> > > > > +       /* Only one open per device at a time */
> > > > > +       if (!atomic_dec_and_test(&xsdfec->open_count)) {
> > > > > +               atomic_inc(&xsdfec->open_count);
> > > > > +               return -EBUSY;
> > > > > +       }
> > > >
> > > > What is that limitation for? Is it worse to open it twice than
> > > > to dup() or fork()?
> > > >
> > > The device can be opened only once.
> >
> > What I mean here is that preventing the double open() is
> > a fairly weak protection: it means you cannot have multiple
> > 'struct file' pointers attached to the same inode, but you
> > can still have the same 'struct file' being available to
> > multiple processes.
> >
> Could you please suggest the solution?
> My intention was to prevent more than one process access the same device.

Generally speaking, you can't prevent it, but you should make sure that
if two processes attempt to use the same device, nothing bad happens.
Usually it's enough to have appropriate locking.

        Arnd

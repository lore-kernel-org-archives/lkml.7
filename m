Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5295CC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211D9222CA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/jhTi+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbfJDIHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:07:53 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46107 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbfJDIHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:07:52 -0400
Received: by mail-lf1-f65.google.com with SMTP id t8so3787475lfc.13;
        Fri, 04 Oct 2019 01:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ovj8bEj4HNuJi9wzGQ8OVwnmOICDlpqX1bq8IYt67Es=;
        b=Q/jhTi+UlwNQHM5witg0l0JXLIzEdJ/rW9srp6N2OzBLSv7mBqDjBMKvZ6v+4iy5b2
         NLjuBqWxmHazrxWJUHwP7khFNYepJqamR7j310oIAIv8dzdxWx53TLpaDoJXyn7gAZAW
         pSG3QMQXArJ8708Px2rvlK0GfSMc6jfNZX0vD/I82V7gSsqjIz6WQmXQnIJoEwWoC0Rb
         xjRs1NvkZp8c/jjocrjJjdhgwL1svgoKjJWWFUYGWLuhqwJk2xPIMHFAK+0y/fCS72Cr
         Mk7a9+NRxRvtQzqXJgLQv8jH1EHKiq/Akeua+fHoGf74MbRPyoa14/KG+6KIi+hyCYqK
         fK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ovj8bEj4HNuJi9wzGQ8OVwnmOICDlpqX1bq8IYt67Es=;
        b=WaNsMaf5D1jmbCFF4Uq+aYUtrHSKGYXlXwQTksbTm0QiVFf7PP+lak4mHyU9ncDSVV
         Jxdm2XOWOG19E/d4HrXskd17DH1se4D8jpa080Z95Qb2J+cY6jbGQAiCZFYcgP5iv6rO
         tpyWdpDQyLLzRY+xYdtS4bC+7le6LN8cocHdxcqgSUJjndDgjmA4h8SGcv3k371/MXJL
         DQ6qVccaQN8y2HVWlqGa2oI/xAKQSnu5ouEUlKRFPDnJ8g1PLz9EZRluYbf5Gua/IVpo
         +k8UCsbz28SAKPhAINygISEgEj2hcRxTZVMRxqVEg8yGNIOxt7ltRMHbnB3LvP2lk/sm
         KWKw==
X-Gm-Message-State: APjAAAXrSdXMuJ9fvx8D674KUEJBMVBzhHrHgJsVZKkQrK4YOs8swiYs
        8kk4E4Wm20ZId1kCNhmbmextWqB5C3xtr1LtyowcpmtKH7RwOQ==
X-Google-Smtp-Source: APXvYqzYMszDMQ/FA4HCY2PrSn7ZJs0ldgaC21/IQl0TPQtTlaJE4mB8anVEBF4tMRUHKqRxGSeGkXTqYAojtiAns2o=
X-Received: by 2002:ac2:5a19:: with SMTP id q25mr8215023lfn.178.1570176470277;
 Fri, 04 Oct 2019 01:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-18-mika.westerberg@linux.intel.com> <184c95fc476146939b240557e54ee2c9@AUSX13MPC105.AMER.DELL.COM>
 <5357cb96013445d79f5c2016df8a194e@AUSX13MPC105.AMER.DELL.COM>
 <20191002083913.GG2714@lahna.fi.intel.com> <767f2f97059e4e9f861080672aaa18d3@AUSX13MPC105.AMER.DELL.COM>
 <CA+CmpXs4YsTA3QnD77SaXq3mRYX6oFwx+pm-3wEErwkF-02M+A@mail.gmail.com>
 <bb84da73d1df468da1707a2af09eb2de@AUSX13MPC105.AMER.DELL.COM>
 <20191003080028.GK2819@lahna.fi.intel.com> <06a04bff94494da99c5359a7fb645d19@AUSX13MPC105.AMER.DELL.COM>
 <20191004075426.GA2819@lahna.fi.intel.com>
In-Reply-To: <20191004075426.GA2819@lahna.fi.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Fri, 4 Oct 2019 11:07:34 +0300
Message-ID: <CA+CmpXsMkwZhCegGYPYQo2GwN6ROwDYbY3RVZTEeN+FfZ-PbMQ@mail.gmail.com>
Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        linux-usb@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        nicholas.johnson-opensource@outlook.com.au,
        Lukas Wunner <lukas@wunner.de>, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu,
        Anthony Wong <anthony.wong@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 10:54 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Thu, Oct 03, 2019 at 02:41:11PM +0000, Mario.Limonciello@dell.com wrote:
> > > -----Original Message-----
> > > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Sent: Thursday, October 3, 2019 3:00 AM
> > > To: Limonciello, Mario
> > > Cc: yehezkelshb@gmail.com; linux-usb@vger.kernel.org;
> > > andreas.noever@gmail.com; michael.jamet@intel.com;
> > > rajmohan.mani@intel.com; nicholas.johnson-opensource@outlook.com.au;
> > > lukas@wunner.de; gregkh@linuxfoundation.org; stern@rowland.harvard.edu;
> > > anthony.wong@canonical.com; linux-kernel@vger.kernel.org
> > > Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
> > >
> > >
> > > [EXTERNAL EMAIL]
> > >
> > > On Wed, Oct 02, 2019 at 04:00:55PM +0000, Mario.Limonciello@dell.com wrote:
> > > > > It's not even "same location - another meaning", the vendor ID comes from
> > > the
> > > > > DROM section, so it takes a few internal jumps inside the NVM to find the
> > > > > location. One of the "pointers" or section headers will be broken for sure.
> > > > >
> > > > > And after this, we need to find the NVM in LVFS and it has to pass validation
> > > in
> > > > > a few other locations. The chances are so low that I'd think it isn't worth
> > > > > worrying about it.
> > > >
> > > > And now I remember why the back of my mind was having this thought of
> > > wanting
> > > > sysfs attribute in the first place.  The multiple jumps means that a lot more of
> > > the
> > > > NVM has to be dumped to get that data, which slows down fwupd startup
> > > significantly.
> > >
> > > IIRC currently fwupd does two reads of total 128 bytes from the active
> > > NVM. Is that really slowing down fwupd startup significantly?
> >
> > Yeah, I timed it with fwupd.  Here's the averages:
> >
> > Without doing the reads to jump to this it's 0:00.06 seconds to probe a tree of
> > Host controller and dock plugged in.
> >
> > With doing the reads and just host controller:
> > 0:04.40 seconds
> >
> > With doing the reads and host controller and dock plugged in:
> > 0:10.73 seconds
>
> OK, it clearly takes time to read them. I wonder if this includes
> powering up the controller?
>
> Also if you can get the hw_vendor_id and hw_product_id from the kernel
> does that mean you don't need to do the two reads or you still need
> those?

Are those the chip vendor or the OEM, in case they are different?

Thinking about it again, I'd guess it shouldn't matter much, if the chip is from
Intel, the FW supports NVM upgrade, isn't it?

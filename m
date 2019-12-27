Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDE5C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 06:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9188C206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 06:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Byz1lPZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfL0GoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 01:44:21 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38819 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfL0GoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 01:44:21 -0500
Received: by mail-ot1-f66.google.com with SMTP id d7so30784490otf.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 22:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mdU0w4gUdMmG5AOoA1TY2dasBZn4XYG6FLZdbgOfXYY=;
        b=Byz1lPZv9ml9+56BjpudDP3VEyrR7s9gNKUMHNcc8SOwcsKFMxlAuy2fZ35LI23ba6
         cxkT8CrcBat62SZCcF+BtUmE1FyLFryX8TiM6rlCTAuPzGOwJDBi5dvNJ1PBbOSotCT7
         G9fSWLBr3+IPY4QyMR8Ek8SDT8yxf5h+itp1KV4SrytVELeLwSN3npJaZn4DTzBAmR/e
         Mb52L3HgLI+6FlyATSM2QT89OTTCnIVbiiIU6BgGOIs54F1S6Rr2gnpZyyMkSZTfoMNH
         /m6mKx8V4M1KmzkFHAqKAUq/FfjyrwgUAXK+LP8v0YJf9Ta0eihcxNarcF1wyscoCgoL
         G82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mdU0w4gUdMmG5AOoA1TY2dasBZn4XYG6FLZdbgOfXYY=;
        b=EdU2C5GNSHbFy4Z2I9FOlfcRvGG/sOe2wzSHa2L+PFQQ/b61g9GqzMCYSO1ObIeukM
         sHXiCyLEUGcXzGxE3MolFlvDlwHat2mB8uwCreKOXcaTjImx7nBTbAYOjEuIAYekU89r
         nvw+RRrN3Lvp8VizH5rR7FywmuM47mlY642SFVkPIyZKsP3ntXNOsTgGHS/jA8KgTrDr
         xydLzqmKHAqh37Gxj6OvDLty3+SaSIFGFs/lQgGufImlIwevBE5en9iQgYhkYQWbY3MH
         H/RUEoB0BaQrwf4APnYZc7KWBN+0OJMxMO53o9C8Fmvd/pVWJVGI3G6xA2wiLPUsOrff
         0cHA==
X-Gm-Message-State: APjAAAV2bzn+XG5rCRRM1XjLCwuKgShCPvVI54j7VP+bj+aRG2temfvM
        P6gE89oyILBP3L4PFy00vLI4OA==
X-Google-Smtp-Source: APXvYqxcH5C3WBfGpiKwCyPXqIco/rrK2Up7fzjmlwdICdDl+NJvkvZ24Lkqp9ErpF1QpXt2Okuzhw==
X-Received: by 2002:a9d:7315:: with SMTP id e21mr43759830otk.255.1577429060090;
        Thu, 26 Dec 2019 22:44:20 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1058-79.members.linode.com. [45.33.121.79])
        by smtp.gmail.com with ESMTPSA id d11sm6067383otl.20.2019.12.26.22.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Dec 2019 22:44:19 -0800 (PST)
Date:   Fri, 27 Dec 2019 14:44:13 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] tty: serial: msm_serial: Fix lockup for sysrq and
 oops
Message-ID: <20191227064413.GB4552@leoy-ThinkPad-X240s>
References: <20191127141544.4277-1-leo.yan@linaro.org>
 <20191127141544.4277-2-leo.yan@linaro.org>
 <CAD=FV=W2nENJF0fNpTzjuAVOo_AoZQryThua9vdtt-zsMk82qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=W2nENJF0fNpTzjuAVOo_AoZQryThua9vdtt-zsMk82qg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Thu, Dec 05, 2019 at 08:40:20AM +0800, Doug Anderson wrote:
> Hi,
> 
> On Wed, Nov 27, 2019 at 10:16 PM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > As the commit 677fe555cbfb ("serial: imx: Fix recursive locking bug")
> > has mentioned the uart driver might cause recursive locking between
> > normal printing and the kernel debugging facilities (e.g. sysrq and
> > oops).  In the commit it gave out suggestion for fixing recursive
> > locking issue: "The solution is to avoid locking in the sysrq case
> > and trylock in the oops_in_progress case."
> >
> > This patch follows the suggestion (also used the exactly same code with
> > other serial drivers, e.g. amba-pl011.c) to fix the recursive locking
> > issue, this can avoid stuck caused by deadlock and print out log for
> > sysrq and oops.
> >
> > Fixes: 04896a77a97b ("msm_serial: serial driver for MSM7K onboard serial peripheral.")
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  drivers/tty/serial/msm_serial.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> > index 3657a24913fc..889538182e83 100644
> > --- a/drivers/tty/serial/msm_serial.c
> > +++ b/drivers/tty/serial/msm_serial.c
> > @@ -1576,6 +1576,7 @@ static void __msm_console_write(struct uart_port *port, const char *s,
> >         int num_newlines = 0;
> >         bool replaced = false;
> >         void __iomem *tf;
> > +       int locked = 1;
> >
> >         if (is_uartdm)
> >                 tf = port->membase + UARTDM_TF;
> > @@ -1588,7 +1589,13 @@ static void __msm_console_write(struct uart_port *port, const char *s,
> >                         num_newlines++;
> >         count += num_newlines;
> >
> > -       spin_lock(&port->lock);
> > +       if (port->sysrq)
> > +               locked = 0;
> > +       else if (oops_in_progress)
> > +               locked = spin_trylock(&port->lock);
> > +       else
> > +               spin_lock(&port->lock);
> 
> I don't have tons of experience with the "msm" serial driver, but the
> above snippet tickled a memory in my brain for when I was looking at
> the "qcom_geni" serial driver, which is a close cousin.

Good point and thanks for sharing info.

> I seemed to remember that the "if (port->sysrq)" was something you
> didn't want.  ...but maybe that's only if you do something like commit
> 336447b3298c ("serial: qcom_geni_serial: Process sysrq at port unlock
> time")?

The patch you mentioned can allow to read sysrq chars without
acquiring port lock.

> Any way you can try making a similar change to the msm driver
> and see if it allow you to remove the special case for "port->sysrq"?

I was deliberately to add the case for "port->sysrq" in the function
__msm_console_write() when I prepared this patch.

Let's see the issue obersved: when the UART drive is deadlock by any
reason, when sent break + h to test system is alive or not, sysrq
tries to ouput log by calling __msm_console_write(), it tries to
acquire console's spinlock but also run into deadlock; finally it
doesn't have chance to output log for sysrq.

P.s. Sorry my long late and didn't follow good practice to reply
quickly due worked on other works.

Thanks,
Leo Yan

Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13799C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F6B20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554316711;
	bh=V/u4vrI32zu0XxILJyYxvWxNDQ8t/IJ2AafQS2QfFxQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yh+Q9wKAPzaI1Wv0kwFg8opZv8dY7ib1/0Vv2WPpAdOZNqRdz+avUgic4fxveCmmX
	 4ehT3ka1Ufiv3JxZxLM5bZx22pqB7z7TShSwOFzlzbuMYmbW72qsIQF67Vfj/IJQ2R
	 3PzXUfZl/JAKI6mFbaHFKCDvv+yZkdepYQ55omBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfDCSia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDCSia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:38:30 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18C4120882;
        Wed,  3 Apr 2019 18:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554316709;
        bh=V/u4vrI32zu0XxILJyYxvWxNDQ8t/IJ2AafQS2QfFxQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O6c+cCZaAgucRnn3uD6jhthX/ZfNTqvxrm+S6Zgz2VJoWzVSkRY8yqhh8GmhRiz8I
         fT8pki2XRKlZcw/4/wHABX/C5coiJ4DEwj3epGunSTxKdYeAejGShyQunSf8UWGXyu
         GgCAS5eBPbjG8cjw38lnuArmzbDYJ8nPqLd/9uTY=
Received: by mail-ed1-f53.google.com with SMTP id d26so15822990ede.10;
        Wed, 03 Apr 2019 11:38:29 -0700 (PDT)
X-Gm-Message-State: APjAAAVddOvx30VSjLqdst37sb/S3D5DuUbmevsnXHVK+qxLnh3KHn/+
        kNUgy29G+aNjDh2SseuQT/609ET520GZojEYyYk=
X-Google-Smtp-Source: APXvYqw1w58Q0G4INuVC3eKd03IXtThFd0rxtGSr/KikEHXi5LsletW79mT8LcXaWB6IGCIEuMDVj7StwVO9orwU4qo=
X-Received: by 2002:a17:906:a2c6:: with SMTP id by6mr771856ejb.134.1554316707650;
 Wed, 03 Apr 2019 11:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <1554243943-25507-1-git-send-email-richard.gong@linux.intel.com>
 <20190403142022.GB5752@archbook> <ee94981a-6562-9d26-ddc2-967596589599@linux.intel.com>
 <20190403164742.GC5752@archbook> <CANk1AXSoF3bhiO=t-XJRLhBH20emWYaZ+2LCPtqJsKyh4b+9KQ@mail.gmail.com>
In-Reply-To: <CANk1AXSoF3bhiO=t-XJRLhBH20emWYaZ+2LCPtqJsKyh4b+9KQ@mail.gmail.com>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 3 Apr 2019 13:37:51 -0500
X-Gmail-Original-Message-ID: <CANk1AXSJ31Q7X3J6NOsqVkQoJkjJz=xka0XiWvuYC36s1HiBuA@mail.gmail.com>
Message-ID: <CANk1AXSJ31Q7X3J6NOsqVkQoJkjJz=xka0XiWvuYC36s1HiBuA@mail.gmail.com>
Subject: Re: [PATCHv1] fpga: mgr: add FPGA configuration log
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Richard Gong <richard.gong@linux.intel.com>,
        linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 1:05 PM Alan Tull <atull@kernel.org> wrote:
>
> On Wed, Apr 3, 2019 at 11:47 AM Moritz Fischer <mdf@kernel.org> wrote:
> >
> > Hi Richard,
> >
> > On Wed, Apr 03, 2019 at 11:43:26AM -0500, Richard Gong wrote:
> > > Hi Moritz,
> > >
> > >
> > > On 4/3/19 9:20 AM, Moritz Fischer wrote:
> > > > Hi Richard,
> > > >
> > > > On Tue, Apr 02, 2019 at 05:25:43PM -0500, richard.gong@linux.intel.com wrote:
> > > > > From: Richard Gong <richard.gong@intel.com>
> > > > >
> > > > > Add a log for user to know FPGA configuration is successful
> > > > >
> > > > > Signed-off-by: Richard Gong <richard.gong@intel.com>
> > > > > ---
> > > > >   drivers/fpga/fpga-mgr.c | 1 +
> > > > >   1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> > > > > index c386681..559e046 100644
> > > > > --- a/drivers/fpga/fpga-mgr.c
> > > > > +++ b/drivers/fpga/fpga-mgr.c
> > > > > @@ -151,6 +151,7 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
> > > > >           }
> > > > >           mgr->state = FPGA_MGR_STATE_OPERATING;
> > > > > + dev_info(&mgr->dev, "Successfully programming FPGA\n");
> > > >
> > > > That info is available in FPGA manager's sysfs status entry, if at all
> > > > I'd make this a dev_dbg().
> > > >
> > > >  From my end I don't see how we need this really.
> > >
> > > We got requests from the field and they want to see a log to get know if
> > > FPGA configuration is successfully completed. They don't want use any
> > > additional command to get status.
> > >
> > > This log is useful for the user who performs FPGA configuration.
> > >
> > > I think we need use dev_info, since dev_dbg is not enabled by fault for most
> > > build.
> >
> > Well basically it boils down to:
> >
> > $ dmesg | grep "Sucessfully"
> >
> > vs
> >
> > $ cat /sys/class/fpga.../status
>
> it's state, not status for most fpga manager drivers.  It should
> return 'operating' if everything went well.
>
> It seems like there's a possible scenario where the FPGA starts up
> with the FPGA in 'operating' mode and the user messes up early enough
> that the state doesn't change.
>
> >
> > Personally not in favor of extra messages, but if we do it we should
> > change the message to "Sucessfully programmed FPGA".
> >
> > I think making it a dbg message is a good trade-off ...

dbg vs info... On the one hand, it is a usually a message the
developer wants to see so the developer would turn on debug messages.
But then again FPGA programming doesn't happen that often and it is a
kind of significant event since it is your hardware changing i.e. it
won't add a lot messages, but it is sort of an important one if it
happens.   If the system crashes after a FPGA reprogramming event, it
would be good to have this in the log by default.  I don't want to
argue too powerfully for adding extra messages though.  Is this a case
where info is worth it since fpga programming is significant?

> >
> > Moritz

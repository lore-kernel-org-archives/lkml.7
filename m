Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10406C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56B1204EC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554314765;
	bh=wmTHRlA1FDuWPhkE7qB7k8OSMIkejqOEp4johXdaXyk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aOZmb5IRa1484I2fe/Tk7tcHffriVteynttcIvuvt8d3/Y6pKg2t2D4cobcjub8oW
	 9shYErT2skip5YTV6n7YFt/4ki6+Wh9CdrQAM1I9i2Zx2wz5cPgeDMp3oP8BXNXsRd
	 BomsHJLCFQjGrMY/Cw+9nq+h6j/haqw8ha/MNBKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfDCSGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDCSGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:06:04 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CD68204EC;
        Wed,  3 Apr 2019 18:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554314763;
        bh=wmTHRlA1FDuWPhkE7qB7k8OSMIkejqOEp4johXdaXyk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iCgbiV9zLknNhqc67xIePSUyRnF0OnR/Xn7AdcG3X3fZKV5k+13PBpqNS1No0vnv+
         Rsg1V2CBnC8ZnWUO9uQidCSBMcGA9bTMV9+mPwGEcpgdzIIRJ+3HOVyGs9yngEDGsj
         9hA0O8TCELTuLLUte+U24XtzpGaIIMKNS/ApFRuw=
Received: by mail-ed1-f53.google.com with SMTP id p20so15752235eds.6;
        Wed, 03 Apr 2019 11:06:02 -0700 (PDT)
X-Gm-Message-State: APjAAAU2iTxJyPZx3uzhPmnH79Df4MBMKuPBCJB8tYYOtCaohD8StDvo
        8Z1HtAAhARfQqNolgt8bkT427qq/rMRnbzwv278=
X-Google-Smtp-Source: APXvYqyi5SiIXCC/KgMlRcs1pLw+9mv7Ye6mmc1wOtP+YjCtibfEnr2oXQWC0qz9mtnWCEtYkRiBr4FmrRB8cv3K2IE=
X-Received: by 2002:a50:a515:: with SMTP id y21mr644682edb.135.1554314761632;
 Wed, 03 Apr 2019 11:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <1554243943-25507-1-git-send-email-richard.gong@linux.intel.com>
 <20190403142022.GB5752@archbook> <ee94981a-6562-9d26-ddc2-967596589599@linux.intel.com>
 <20190403164742.GC5752@archbook>
In-Reply-To: <20190403164742.GC5752@archbook>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 3 Apr 2019 13:05:25 -0500
X-Gmail-Original-Message-ID: <CANk1AXSoF3bhiO=t-XJRLhBH20emWYaZ+2LCPtqJsKyh4b+9KQ@mail.gmail.com>
Message-ID: <CANk1AXSoF3bhiO=t-XJRLhBH20emWYaZ+2LCPtqJsKyh4b+9KQ@mail.gmail.com>
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

On Wed, Apr 3, 2019 at 11:47 AM Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi Richard,
>
> On Wed, Apr 03, 2019 at 11:43:26AM -0500, Richard Gong wrote:
> > Hi Moritz,
> >
> >
> > On 4/3/19 9:20 AM, Moritz Fischer wrote:
> > > Hi Richard,
> > >
> > > On Tue, Apr 02, 2019 at 05:25:43PM -0500, richard.gong@linux.intel.com wrote:
> > > > From: Richard Gong <richard.gong@intel.com>
> > > >
> > > > Add a log for user to know FPGA configuration is successful
> > > >
> > > > Signed-off-by: Richard Gong <richard.gong@intel.com>
> > > > ---
> > > >   drivers/fpga/fpga-mgr.c | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> > > > index c386681..559e046 100644
> > > > --- a/drivers/fpga/fpga-mgr.c
> > > > +++ b/drivers/fpga/fpga-mgr.c
> > > > @@ -151,6 +151,7 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
> > > >           }
> > > >           mgr->state = FPGA_MGR_STATE_OPERATING;
> > > > + dev_info(&mgr->dev, "Successfully programming FPGA\n");
> > >
> > > That info is available in FPGA manager's sysfs status entry, if at all
> > > I'd make this a dev_dbg().
> > >
> > >  From my end I don't see how we need this really.
> >
> > We got requests from the field and they want to see a log to get know if
> > FPGA configuration is successfully completed. They don't want use any
> > additional command to get status.
> >
> > This log is useful for the user who performs FPGA configuration.
> >
> > I think we need use dev_info, since dev_dbg is not enabled by fault for most
> > build.
>
> Well basically it boils down to:
>
> $ dmesg | grep "Sucessfully"
>
> vs
>
> $ cat /sys/class/fpga.../status

it's state, not status for most fpga manager drivers.  It should
return 'operating' if everything went well.

It seems like there's a possible scenario where the FPGA starts up
with the FPGA in 'operating' mode and the user messes up early enough
that the state doesn't change.

>
> Personally not in favor of extra messages, but if we do it we should
> change the message to "Sucessfully programmed FPGA".
>
> I think making it a dbg message is a good trade-off ...
>
> Moritz

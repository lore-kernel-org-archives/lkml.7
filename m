Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F3EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0422F206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554328720;
	bh=n9MizSFifBOp4+iFqTCqzgnorratvlaGO2SLnCeWxzY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qPDRK9/xq4Kab9OZVj296VV9Yvl8nCW8hNthqGae/SoJvTqFq1YFZF83IU2h1cEMs
	 ONvNax4xUwYPVbw/y7vXRdcYTCDuhiuT5z7eFlmekmHiPA9tZpgyKqXX3WZou1CIrn
	 KP+7TBmDG7R52bFvJFV6YMNbPW5TB/dMi5Za5M9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfDCV6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:58:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDCV6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:58:38 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33B0E2084B;
        Wed,  3 Apr 2019 21:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554328717;
        bh=n9MizSFifBOp4+iFqTCqzgnorratvlaGO2SLnCeWxzY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JJcND8pHcNsNKLnL4Y2EOP9KOi/cTEeMqqK6LJv/0FE0uzHlNzW3UxKpopBcQhDx+
         C+DA7nrXN93nSORoPnRO8qKsXf/7j6RQboW7dh80dUZnkntPjzMu+GX5F+0UOoWAxn
         MNpbBARe8C/zlr38fK32G55MMoFCCp44d+i0jN7Q=
Received: by mail-ed1-f47.google.com with SMTP id h22so301367edw.7;
        Wed, 03 Apr 2019 14:58:37 -0700 (PDT)
X-Gm-Message-State: APjAAAXIdA7GeUSHkXQvn/CciP1BGwdMfju6/y01IDfQZgQ/EgQgoSVZ
        TGvfcAQaCe5dlp/bjiEE4VQwineb3BjTAaeurLA=
X-Google-Smtp-Source: APXvYqwfxFHV2+lYaccmpc7qEjevN9OSbA5eMj7E2VdtAt04nkyjp+Qsa+qRPeEthUNzyaKtfRGnquYYAFoPlkj/6n4=
X-Received: by 2002:a17:906:b84c:: with SMTP id ga12mr1123602ejb.253.1554328715752;
 Wed, 03 Apr 2019 14:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <1554243943-25507-1-git-send-email-richard.gong@linux.intel.com>
 <20190403142022.GB5752@archbook> <ee94981a-6562-9d26-ddc2-967596589599@linux.intel.com>
 <20190403164742.GC5752@archbook> <CANk1AXSoF3bhiO=t-XJRLhBH20emWYaZ+2LCPtqJsKyh4b+9KQ@mail.gmail.com>
 <CANk1AXSJ31Q7X3J6NOsqVkQoJkjJz=xka0XiWvuYC36s1HiBuA@mail.gmail.com> <20190403200800.GE5752@archbook>
In-Reply-To: <20190403200800.GE5752@archbook>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 3 Apr 2019 16:57:59 -0500
X-Gmail-Original-Message-ID: <CANk1AXRtDJYAYS3WUvDhbhrN92pKFbsZYTbS8rXAJi78kAfbNA@mail.gmail.com>
Message-ID: <CANk1AXRtDJYAYS3WUvDhbhrN92pKFbsZYTbS8rXAJi78kAfbNA@mail.gmail.com>
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

On Wed, Apr 3, 2019 at 3:08 PM Moritz Fischer <mdf@kernel.org> wrote:
>
> On Wed, Apr 03, 2019 at 01:37:51PM -0500, Alan Tull wrote:
> > >
> > > it's state, not status for most fpga manager drivers.  It should
> > > return 'operating' if everything went well.
>
> Yeah, sorry :)
>
> > > It seems like there's a possible scenario where the FPGA starts up
> > > with the FPGA in 'operating' mode and the user messes up early enough
> > > that the state doesn't change.
>
> Huh, then we should fix that instead? :)
> > >
> > > >
> > > > Personally not in favor of extra messages, but if we do it we should
> > > > change the message to "Sucessfully programmed FPGA".
> > > >
> > > > I think making it a dbg message is a good trade-off ...
> >
> > dbg vs info... On the one hand, it is a usually a message the
> > developer wants to see so the developer would turn on debug messages.
> > But then again FPGA programming doesn't happen that often and it is a
> > kind of significant event since it is your hardware changing i.e. it
> > won't add a lot messages, but it is sort of an important one if it
> > happens.   If the system crashes after a FPGA reprogramming event, it
> > would be good to have this in the log by default.  I don't want to
> > argue too powerfully for adding extra messages though.  Is this a case
> > where info is worth it since fpga programming is significant?
>
> In the current setup, it doesn't happen often. Going forward people
> might have use-cases where this happens a lot more often.

Yes, then adding the message could become very spammy.

>
> I mean if y'all feel like this is required, sure, I still feel people
> shouldn't rely on dmesg output for functional verification :)

I agree with you that using sysfs to see what state the FPGA mgr ended
up in should be adequate most of the time.  We probably don't need
this.

>
> I don't wanna guarantee that this message is gonna be there always ...

Indeed...

Thanks,
Alan

>
> Cheers,
> Moritz

Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1214C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2012166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573163129;
	bh=+2u/MCrAxpfwO9VHiDi1QHr4uX2w6bjyxLIeb9aiSuM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VzQaK7SP/8vZO3F/ep9fh/wkr7cLmvZVyaGJyTVJK/77P09CMa9IeczW/rD2MAdBF
	 lgXhQckUx0RWcW5SmojuCpR455kbmCtQJbZ6l9FKwVLIqORMHCATaXrS1H0BMW4vCo
	 60ypuCbOg+8TJeHOPmh3iw7XuLagCtCoGhqtbdZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfKGVp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:45:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfKGVp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:45:28 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2B082166E;
        Thu,  7 Nov 2019 21:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573163126;
        bh=+2u/MCrAxpfwO9VHiDi1QHr4uX2w6bjyxLIeb9aiSuM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EeBOEpn5O9c3uDCStbIKsbOshbPZ5+KmIiaLNtaUY40Sjcn2KPWdB1MzA8gh8porv
         6cQ69EGhxOHOviQRLEB/XSKS338JqkXn88I+MyRe4k8oiOekm4iIrqAHDkjdW0ZFa7
         egkXfhnno87EqaQHt1MH42gYuJNPCVz7Hm7ZEHYk=
Received: by mail-qt1-f172.google.com with SMTP id o11so4051685qtr.11;
        Thu, 07 Nov 2019 13:45:26 -0800 (PST)
X-Gm-Message-State: APjAAAVXtwl6Q9N6tHEjPdKIMUSS35mDz8yCpHpJY8sUTG6pmcINeNkU
        p8gCaPFPtmRial/LYCW5kCAuJd70XbCRplabmw==
X-Google-Smtp-Source: APXvYqzKBN4P3iQsDG0cU0SvIyl2nJbDqpbmXRW32fH1yUlg+6382COgYZuSJvJDggzFTfWEPsdivu2KtE2+LyjYfgk=
X-Received: by 2002:ac8:458c:: with SMTP id l12mr6736244qtn.300.1573163125922;
 Thu, 07 Nov 2019 13:45:25 -0800 (PST)
MIME-Version: 1.0
References: <20191028215919.83697-1-john.stultz@linaro.org>
 <20191028215919.83697-7-john.stultz@linaro.org> <87h83rj4ha.fsf@gmail.com>
 <CALAqxLX47uELsGbdociUKdC6KgDba-1SBVALmgjD3=jxh=fd8g@mail.gmail.com> <87k18mhaiq.fsf@gmail.com>
In-Reply-To: <87k18mhaiq.fsf@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 7 Nov 2019 15:45:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL5_6vLJ4sfaNr=76S8kDWEpfKT05xaLktqFM_xH3puGA@mail.gmail.com>
Message-ID: <CAL_JsqL5_6vLJ4sfaNr=76S8kDWEpfKT05xaLktqFM_xH3puGA@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] usb: dwc3: Rework resets initialization to be more flexible
To:     Felipe Balbi <balbi@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 4:01 AM Felipe Balbi <balbi@kernel.org> wrote:
>
>
> Hi,
>
> John Stultz <john.stultz@linaro.org> writes:
>
> > On Tue, Oct 29, 2019 at 2:17 AM Felipe Balbi <balbi@kernel.org> wrote:
> >> John Stultz <john.stultz@linaro.org> writes:
> >> > The dwc3 core binding specifies one reset.
> >> >
> >> > However some variants of the hardware my not have more.
> >>                                         ^^
> >>                                         may
> >>
> >> According to synopsys databook, there's a single *input* reset signal on
> >> this IP. What is this extra reset you have?
> >>
> >> Is this, perhaps, specific to your glue layer around the synopsys ip?
> >
> > Likely (again, I unfortunately don't have a ton of detail on the hardware).
> >
> >> Should, perhaps, your extra reset be managed by the glue layer?

An extra clock or reset is a silly reason to have a whole other node
and driver. If there's additional blocks and registers, then yes a
glue node makes sense.

> > So yes the dwc3-of-simple does much of this already (it handles
> > multiple resets, and variable clocks), but unfortunately we seem to
> > need new bindings for each device added?  I think the suggestion from
> > Rob was due to the sprawl of bindings for the glue code, and the extra
> > complexity of the parent node.  So I believe Rob just thought it made
> > sense to collapse this down into the core?
> >
> > I'm not really passionate about either approach, and am happy to
> > rework (as long as there is eventual progress :).
> > Just let me know what you'd prefer.
>
> Well, I was under the impression we were supposed to describe the
> HW. Synopsys IP has a single reset input :-p

John is. His chip requires 2 resets to use the USB block and the
compatible provides that distinction. Maybe HiSilicon has a newer or
customized IP version that has 2 resets. The block could have external
RAMs (because every process has its own) which may have their own
reset. With NDA specifications and little knowledge of the full
revision history, we can really never know. Also, omitting clocks and
resets from the dwc3 node entirely is just as much not describing the
h/w (only the glue needs clocks?).

This block is the oddball. I think there's 1 or 2 other blocks where
this glue node was done, but please stop. If we did this every time
there's a variation in clocks or resets, we'd pretty much have glue
nodes everywhere.

Rob

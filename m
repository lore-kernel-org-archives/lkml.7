Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97D0ECE58A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF292133F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJCV21vc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfJBPEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:04:12 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35981 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfJBPEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:04:11 -0400
Received: by mail-io1-f65.google.com with SMTP id b136so57626529iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKEiSm5kf8Odz4O9V4syYYT9QXFs1CapfQip+K78N1Q=;
        b=UJCV21vcbOZDpnikF0Nwo722YgIaKo9iQ9l5Wdq2Q+hCARQ293ZG3YmIr2Dum7pslG
         YoF/4cJ+g6nR9uscySy3q/XQJgppI9+Ylh8HwkJhA7ND0phejKf4nys1J//ydAoNV/xR
         rpYfpdRISzWZRu8ikWhqck9OBuFxFR8LijNMWYuOcqkj0cTlVqcCK8q8oFtLsC64NtOi
         yLgChFxA96KayDjMnrUM+aIq8OBz272fah8XMV8IkIEFyMBUq+cK+VOylxZeoJ+Ym5Fn
         CUyCShhE6T0ksjHT/D4AsGkHiZKXpE4tA3aMcILeIqmHd4y3TNB8Q+/Z/7OFVoXKtVX4
         BmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKEiSm5kf8Odz4O9V4syYYT9QXFs1CapfQip+K78N1Q=;
        b=TFFoFMhhBRAdSNRpSugSv2IxEVZSeLqIzLFc4xVJHAXLmH3QAso5XuG8sm6zyU+gpV
         Lh2gQAbcjwe9odA0NVLB16gbxdMQfrApb5zbiqu6agetDCOUOjXXR+inwZDZZBWap1n2
         i0lsga9/Be24ByY9Vcx6ySXdzcGjn7ZjY4SOauBqm+gWp+DC69UX5DIl56g6+Hu2JJbU
         8pMZ67JTPXv5K92lK9f5NBdm3oyoW0YNwokmaOxZ3af9tP25bcwlsGWhT5JTBztRXy8v
         69YcY2PIbqPUVLnlAQ5pxRgK9Gz6Rj8Oaw32HKjAT1zREZ/+WXeHwnbwvjVimERbSDge
         M/Lg==
X-Gm-Message-State: APjAAAVj3plDeDzqzifRIJ02OA5fUn7XH/WgXoLr8woY21LDc/d4XFJq
        PadYLgfPdSiM/5yP/7VR8xLC4XwMkHZK0UZNny3w4Q==
X-Google-Smtp-Source: APXvYqz1KIa6msDQH9/EUGNRzs/VxrbR5gsZHhC/HB4q6k5M7vEahIK1t6Bzcy+BgoRBZDsMoygEHQdD7XiVP7sf82M=
X-Received: by 2002:a6b:6b06:: with SMTP id g6mr3755891ioc.72.1570028650863;
 Wed, 02 Oct 2019 08:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564550873.git.saiprakash.ranjan@codeaurora.org>
 <90114e06825e537c3aafd3de5c78743a9de6fadc.1564550873.git.saiprakash.ranjan@codeaurora.org>
 <CAOCk7NrK+wY8jfHdS8781NOQtyLm2RRe1NW2Rm3_zeaot0Q99Q@mail.gmail.com>
 <16212a577339204e901cf4eefa5e82f1@codeaurora.org> <CAOCk7NohO67qeYCnrjy4P0KN9nLUiamphHRvj-bFP++K7khPOw@mail.gmail.com>
 <fa5a35f0e993f2b604b60d5cead3cf28@codeaurora.org> <CAOCk7NodWtC__W3=AQfXcjF-W9Az_NNUN0r8w5WmqJMziCcvig@mail.gmail.com>
 <5b8835905a704fb813714694a792df54@codeaurora.org>
In-Reply-To: <5b8835905a704fb813714694a792df54@codeaurora.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 2 Oct 2019 09:03:59 -0600
Message-ID: <CANLsYkxPOOorqcnPrbhZLzGV9Y7EGWUUyxvi-Cm5xxnzhx=Ecg@mail.gmail.com>
Subject: Re: [PATCHv9 2/3] arm64: dts: qcom: msm8998: Add Coresight support
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        lkml <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019 at 12:05, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> On 2019-10-01 11:01, Jeffrey Hugo wrote:
> > On Tue, Oct 1, 2019 at 11:52 AM Sai Prakash Ranjan
> > <saiprakash.ranjan@codeaurora.org> wrote:
> >>
> >>
> >> Haan then likely it's the firmware issue.
> >> We should probably disable coresight in soc dtsi and enable only for
> >> MTP. For now you can add a status=disabled for all coresight nodes in
> >> msm8998.dtsi and I will send the patch doing the same in a day or
> >> two(sorry I am travelling currently).
> >
> > This sounds sane to me (and is what I did while bisecting the issue).
> > When you do create the patch, feel free to add the following tags as
> > you see fit.
> >
> > Reported-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> > Tested-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
>
> Thanks Jeffrey, I will add them.
> Hope Mathieu and Suzuki are OK with this.

The problem here is that a debug and production device are using the
same device tree, i.e msm8998.dtsi.  Disabling coresight devices in
the DTS file will allow the laptop to boot but completely disabled
coresight blocks on the MTP board.  Leaving things as is breaks the
laptop but allows coresight to be used on the MTP board.  One of three
things can happen:

1) Nothing gets done and production board can't boot without DTS modifications.
2) Disable tags are added to the DTS file and the debug board can't
use coresight without modifications.
2) The handling of the debug power domain is done properly on the
MSM8998 rather than relying on the bootloader to enable it.
3) The DTS file is split or reorganised to account for debug/production devices.

Which of the above ends up being the final solution is entirely up to
David and Andy.

Regards,
Mathieu

>
> Thanks,
> Sai

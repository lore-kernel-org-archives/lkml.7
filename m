Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F0DC32792
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B2C208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c5Glmxo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbfJDBgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 21:36:35 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42056 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDBgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 21:36:35 -0400
Received: by mail-vk1-f196.google.com with SMTP id f1so1110723vkh.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 18:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXr79tplPMG/Zt0zfwF4F6+aQSGWZv+mmd+AgMQBK1E=;
        b=c5Glmxo9r+Q388xRFQzMlIV9P7Mkn2/9vbjmPYRZjzTTQAy2kOhpgrGY8UnPjymeG1
         INa0zaJNSgo4ERqZs0zyldEQxPsmtrhAbw2qUbZT0Lfm8P2WU5Af62wMIPXFnnv4v9nf
         zBf/pjG8l4Z9YwRixZQ8wJHMPBejR7Aj3tMEsoYnSZOXzxqWGbRxLYmtjSbi/8XOuNCR
         QAe+mcOh2q5slk2/0CQmIKHAnywZni4bUeaCUrYAbrx7LZY0oAo+mNubCdr1kWy2pEip
         VHSUz/KhTPy8MKmuNPGsQVZjQxiGUMlAqeUx8bQV/V37/dqnTgUUQ/VCq3+WEA4yGE05
         O8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXr79tplPMG/Zt0zfwF4F6+aQSGWZv+mmd+AgMQBK1E=;
        b=gG+7kumuiYBuVi4hxlcWjswvn0PIXw7Q+5NkGF/GJZCRbCyAA4o39D2St8VwSjKbaQ
         YUmWApmFCLT4cOWimmRR7K68F9llIK90hFMB2wDMtViFCvBWORXqJlgxMWQxQYVzGGTm
         /KLCnlCGGo5Rv/2tnrC2jjW8HbeIpygW69R/XKg0xb9hODxHKIEcb3RcU8Yw93UNhayi
         wT1C3AtTRKFPDQY/+coOUZ7HnP19It3oliHGZeMlpzcCiSTGzbMox9cNSJ+l8MOFSnta
         7rB7JDwa18kNGeODTuAVAcvFp2tyqiq2FcpUsNj3RfeSyK4SMUWMMhPp3XWpY1x79Jk4
         9Euw==
X-Gm-Message-State: APjAAAVVSxQxlOEbzcG7xdIc+fM0jl2YU3gB7Zbi1sDSGpTJ/9ZtNbsZ
        f9hOQ7KKj3tULAICDlTNwMH2cPDcmAipU8LybnsnXQ==
X-Google-Smtp-Source: APXvYqzo67hR0s9Moxd/rtmHK4JioAJF9sIqmyxsozrBi47QUFkh02H55iad0F8vHaKnCkYexgecJLBAgkS++B7Po9M=
X-Received: by 2002:a1f:c55:: with SMTP id 82mr6948277vkm.9.1570152993761;
 Thu, 03 Oct 2019 18:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558430617.git.amit.kucheria@linaro.org>
 <49cf5d94beb9af9ef4e78d4c52f3b0ad20b7c63f.1558430617.git.amit.kucheria@linaro.org>
 <CAOCk7NptTHPOdyEkCAofjTPuDQ5dsnPMQgfC0R8=7cp05xKQiA@mail.gmail.com>
 <20191002091950.GA9393@centauri> <20191002092734.GA15523@centauri> <CAOCk7Nqqm6d3bR9hFJH6rp1jMPmx2e2qmJtnOuw5viaGWohEZA@mail.gmail.com>
In-Reply-To: <CAOCk7Nqqm6d3bR9hFJH6rp1jMPmx2e2qmJtnOuw5viaGWohEZA@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 4 Oct 2019 07:06:22 +0530
Message-ID: <CAHLCerN6T2WszczwDOeg=F2MQ3hHBkgYubCu9WyuhsOaAR=mMg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] arm64: dts: qcom: msm8998: Add PSCI cpuidle low
 power states
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Sibi Sankar <sibis@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 11:48 PM Jeffrey Hugo <jeffrey.l.hugo@gmail.com> wrote:
>
> On Wed, Oct 2, 2019 at 3:27 AM Niklas Cassel <niklas.cassel@linaro.org> wrote:
> >
> > On Wed, Oct 02, 2019 at 11:19:50AM +0200, Niklas Cassel wrote:
> > > On Mon, Sep 30, 2019 at 04:20:15PM -0600, Jeffrey Hugo wrote:
> > > > Amit, the merged version of the below change causes a boot failure
> > > > (nasty hang, sometimes with RCU stalls) on the msm8998 laptops.  Oddly
> > > > enough, it seems to be resolved if I remove the cpu-idle-states
> > > > property from one of the cpu nodes.
> > > >
> > > > I see no issues with the msm8998 MTP.
> > >
> > > Hello Jeffrey, Amit,
> > >
> > > If the PSCI idle states work properly on the msm8998 devboard (MTP),
> > > but causes crashes on msm8998 laptops, the only logical change is
> > > that the PSCI firmware is different between the two devices.
> >
> > Since the msm8998 laptops boot using ACPI, perhaps these laptops
> > doesn't support PSCI/have any PSCI firmware at all.
>
> They have PSCI.  If there was no PSCI, I would expect the PSCI
> get_version request from Linux to fail, and all PSCI functionality to
> be disabled.
>
> However, your mention about ACPI sparked a thought.  ACPI describes
> the idle states, along with the PSCI info, in the ACPI0007 devices.
> Those exist on the laptops, and the info mostly correlates with Amit's
> patch (ACPI seems to be a bit more conservative about the latencies,
> and describes one additional deeper state).  However, upon a detailed
> analysis of the ACPI description, I did find something relevant - the
> retention state is not enabled.
>
> So, I hacked out the retention state from Amit's patch, and I did not
> observe a hang.  I used sysfs, and appeared able to validate that the
> power collapse state was being used successfully.

Interesting that the shallower sleep state was causing problems.
Usually, it is the deeper states that cause problems. So you plan to
override the idle states table in the board-specific DT?

Why does the platform even rely on DT? Shouldn't we use the ACPI tables instead?

> I'm guessing that something is weird with the laptops, where the CPUs
> can go into retention, but not come out, thus causing issues.
>
> I'll post a patch to fix up the laptops.  Thanks for all the help.

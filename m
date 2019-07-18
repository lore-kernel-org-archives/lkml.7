Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ABDC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1F921019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sm2v261v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390659AbfGRPbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 11:31:12 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34585 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRPbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:31:12 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so52168875iot.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 08:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aKCPVJWUs1Jjo618+zN06BNfCZDhzZnUlux4ybl+pq0=;
        b=Sm2v261v5xekTmZUZ6N0X1DwSi7Qx28ytpUwnL6RR4/HA9RM1I1uHbxQ5Tr2RsDxnF
         uHfozpBvobDMz50HATWjhVmujLg+klkHLJ9pvtoaL0bSj4Xbwt0hy+2s95Bt9PrLwjHP
         9WrW9oAO56vn4LHlOWXQZlyF01y48G0k5vnVYgdbvDJLuIe7VXgftZScWAzSwPg4upTL
         MB0EMRjd0/GafWtn+YldSQCyNyizBD/TzUOX5f+PsG2DaEIfWwVFdiK2B/TZ6sY4lWjl
         Qi26tf9hfQYQ+MtdpFd3yi9DfJfOtWqxINoykwaPsPDhZbGjJpNY3h2J1aupKeY6xiGH
         YSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKCPVJWUs1Jjo618+zN06BNfCZDhzZnUlux4ybl+pq0=;
        b=dBe12+eva4jKh/Of1CTbn54voK41fykJeHZbH2BJXQa8DARYxHQWXwmHuJngjpcQd3
         s2HPMVYUTK8C7aDADQ7G23yeFPMMprEhL695y+eXmzSHu6an+S760i86rAE4WJtFfKFM
         F9vPZxPtp5An6l2N4usMykzVQsb2+XjgtKePTtWPgTLbVYn8x0/av6L5desLot5hN6u5
         PxRHl4edlAMy4jl/I+V9E0QlndoBqi5l2+CZOMCZ7pFjsaYhuYOR6SzAvbw6p8uLBpbU
         OZ3g+dRT3bbtzwY2uQQQm5Ysdu6UmqQ+YW6EcvPpjktwK/khP059CbCEyz59QL+OxXZq
         LNzg==
X-Gm-Message-State: APjAAAVX7xnxGtOstc36ktTwhOYYmnouhjTM1nI2YMAFYfw+Vm+lL9bt
        3YAdQGaLPmBH8gbLQhAwTISnEOpnTR/wIYifxr310g==
X-Google-Smtp-Source: APXvYqzG2U1bPJ/OOAVgRh5Mkg7P6+I1KqVOXN4mBoflGrY+UlQJR3tPL8mnMgJRePKuw3SKg/qvS4IJ79JZmTu478c=
X-Received: by 2002:a05:6638:517:: with SMTP id i23mr48290113jar.71.1563463871438;
 Thu, 18 Jul 2019 08:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1562940244.git.saiprakash.ranjan@codeaurora.org>
 <2fa725fbc09306f1a95befc62715a708b4c0fad0.1562940244.git.saiprakash.ranjan@codeaurora.org>
 <20190717170050.GB4271@xps15> <f28d9c8f-017c-c990-2f00-0ef5a62f3b40@codeaurora.org>
In-Reply-To: <f28d9c8f-017c-c990-2f00-0ef5a62f3b40@codeaurora.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 18 Jul 2019 09:31:00 -0600
Message-ID: <CANLsYkx9X36OJmczNK1255y8fKJfkyVq1zyQUDihqMewcU6Kxw@mail.gmail.com>
Subject: Re: [PATCHv8 3/5] arm64: dts: qcom: msm8996: Add Coresight support
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2019 at 23:47, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi Mathieu,
>
> On 7/17/2019 10:30 PM, Mathieu Poirier wrote:
> > On Fri, Jul 12, 2019 at 07:46:25PM +0530, Sai Prakash Ranjan wrote:
> >> From: Vivek Gautam <vivek.gautam@codeaurora.org>
> >>
> >> Enable coresight support by adding device nodes for the
> >> available source, sinks and channel blocks on msm8996.
> >>
> >> This also adds coresight cpu debug nodes.
> >>
> >> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> >> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> >> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Acked-By: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> ---
> >>   arch/arm64/boot/dts/qcom/msm8996.dtsi | 434 ++++++++++++++++++++++++++
> >>   1 file changed, 434 insertions(+)
> >>
> >
> > We've gone trhough 8 iteration of this set and I'm still finding checkpatch
> > problems, and I'm not referring to lines over 80 characters.
> >
>
> I only get below 2 checkpatch warnings:
>
> If you are talking about the below one, then it was not added manually.
> It was taken automatically when I pulled in the v7. Should I be
> resending this patch for this?

That depends if you want David and Andy to pickup your patches - I am
sure they'll point out exactly the same thing.

>
> $ ./scripts/checkpatch.pl -g 2fa725fbc09306f1a95befc62715a708b4c0fad0
> WARNING: 'Acked-by:' is the preferred signature form
> #14:
> Acked-By: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> WARNING: line over 80 characters
> #154: FILE: arch/arm64/boot/dts/qcom/msm8996.dtsi:763:
> +                       compatible = "arm,coresight-dynamic-replicator",
> "arm,primecell";
>
> total: 0 errors, 2 warnings, 440 lines checked
>
>
> -Sai
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

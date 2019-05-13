Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647B6C46460
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374F4206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FYcDKAyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfEMMix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:38:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37683 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbfEMMiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:38:52 -0400
Received: by mail-qt1-f193.google.com with SMTP id o7so14461424qtp.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 05:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=crSUv5H6P69IxzlT9Dzg2VCf7w3w/bVJXLfp7t6XXVI=;
        b=FYcDKAyQ4xDln7s4L02T2bgbqqE98ZDhKvDJrrQcV+hHKS11OTOCS+/3Fj+WzRhb1V
         D4IM9b3ph290ckg1VoGiFhrPPDHJJH883c5Vm8HJrFaoRWcyCFTG4ZMgEMefBRwRanLM
         K6IdDQxsVbrL4cba8IaKZGCr7VtDhjgkKFRBZunZG81srPXOjfHG2ebqi5ZKRnNU+ZGf
         lk5IUXIKKZd9EHt3fWn6mEqPN6TX6Iko65eQTkwpP0EooQFc1mzoKYRmXqlZh8wlTXsh
         BCdkQATDnytZpbN1f0hZUfq+3WjMjebb3hOhODgV883J1629hMZzCIdMFbMxztjgP81q
         W5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=crSUv5H6P69IxzlT9Dzg2VCf7w3w/bVJXLfp7t6XXVI=;
        b=igp60UiNzF19IXnWIpr7x9aoJmx7XeFGcpKMmnWGff6/67vP0Pialepy2izo4LV855
         PXzMhNjynlgyPuqCVbKGAzsoKt2w32hXdjfn+ja97IJQAhcVE3MiAFaduESgfnkaQ3rS
         tO53dhHNT2UpQuarPeOc658ddtYOH8aBRAVxZDqu7OHcfl2HpKlH1nNg3ujpRfzuaSgS
         BIYbcC0LZ3sxK/KmgogXV84OutblsacxO0T8lAkozw0TJlyGn5JK1H5W2jjTxqO5a2a2
         WGnHsq0HKV/20Nc6r77K0JtxisUVjp1M8TjhbmP561dH5KdSUScrXhVbM2BPjpiNgkI7
         tqUw==
X-Gm-Message-State: APjAAAUrL3+7tqa0eS7Gh3isAmJ5lX9JUF3t/J/lBDaF4DZ8F6vGaqz1
        i65dUcoNxcceiNbh/wZ0KmvIK8G6wV6UiKxxm3vCCz0SG88=
X-Google-Smtp-Source: APXvYqywQgossQwFmG5Ly/2D/VyGN3ByHJv/hIaF12lmEyl/TqH5uFuJQFFJHHQS0cxHZgxj5Ty+J0YIEsoRGHTmCjk=
X-Received: by 2002:ac8:a81:: with SMTP id d1mr18924863qti.276.1557751131755;
 Mon, 13 May 2019 05:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557486950.git.amit.kucheria@linaro.org>
 <0afe77d25490b10250f9eac4b4e92ccac8c42718.1557486950.git.amit.kucheria@linaro.org>
 <3de9c573-5971-15fc-1632-706fc30e90c2@free.fr> <CAP245DU7=h=t1_QoM9nMGE-Amduuh+GPQBnmEEG+NGDdXCiR=g@mail.gmail.com>
 <8292f259-d28b-9b37-d58e-3afb26da0646@free.fr>
In-Reply-To: <8292f259-d28b-9b37-d58e-3afb26da0646@free.fr>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 13 May 2019 18:08:40 +0530
Message-ID: <CAP245DXpB8tSXRiOZ=w2_RJ4jRUt-S0Rx5xkPE-4cYdfHp_DEQ@mail.gmail.com>
Subject: Re: [PATCHv1 7/8] arm64: dts: qcom: msm8998: Add PSCI cpuidle low
 power states
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 8:41 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> On 10/05/2019 16:12, Amit Kucheria wrote:
>
> > On Fri, May 10, 2019 at 6:45 PM Marc Gonzalez wrote:
> >>
> >> On 10/05/2019 13:29, Amit Kucheria wrote:
> >>
> >>> Add device bindings for cpuidle states for cpu devices.
> >>>
> >>> Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
> >>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> >>> ---
> >>>   arch/arm64/boot/dts/qcom/msm8998.dtsi | 32 +++++++++++++++++++++++++++
> >>>   1 file changed, 32 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> >>> index 3fd0769fe648..208281f318e2 100644
> >>> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> >>> @@ -78,6 +78,7 @@
> >>>                        compatible = "arm,armv8";
> >>>                        reg = <0x0 0x0>;
> >>>                        enable-method = "psci";
> >>> +                     cpu-idle-states = <&LITTLE_CPU_PD>;
> >>
> >> For some reason, I was expecting the big cores to come first, but according
> >> to /proc/cpuinfo, cores 0-3 are part 0x801, while cores 4-7 are part 0x800.
> >>
> >> According to https://github.com/pytorch/cpuinfo/blob/master/src/arm/uarch.c
> >>
> >> 0x801 = Low-power Kryo 260 / 280 "Silver" -> Cortex-A53
> >> 0x800 = High-performance Kryo 260 (r10p2) / Kryo 280 (r10p1) "Gold" -> Cortex-A73
> >
> > Hmm, did I mess up the order of the big and LITTLE cores?
> > I'll take a look again.
>
> Sorry for being unclear. I was saying I expected the opposite,
> but it appears the order in your patch is correct ;-)

OK :-)

> Little cores have higher latency (+5%) than big cores?

No, that is a result of me naively converting the downstream numbers
into cpuidle parameters for upstream. There is scope for tuning those
numbers with more instrumentation. My hope is that we will attract
more contributions once the basic idle states have landed upstream
i.e. change the story from "cpuidle isn't supported in upstream QC
platforms" to "cpuidle needs some tuning"

Regards,
Amit

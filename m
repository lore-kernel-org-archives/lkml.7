Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4A1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE5F218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HNIqRLDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfCUFvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 01:51:33 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54038 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfCUFvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 01:51:32 -0400
Received: by mail-it1-f195.google.com with SMTP id w85so2630852itc.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 22:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gK+8Up/Ey5WhloloBZQqFYaJnlaNpQykinPquqvWB5g=;
        b=HNIqRLDAfndDa8xndvgHX6Fp3EQvO6qV64hJMyBq9JUbTtL699K4+nbyc8v8Z/iZq2
         5KOnDhbtNItCFTrpWqccymK6Yi24vuV3MmuIZo6Q3cbobKmK+Ey8nB9NBBlO4iP606gQ
         6eu2NKcidzLW+Ch4k0kDXgJGnpz6vfYRW95fl6mefL3zQXf/+ACx4T9FcuWiMTET+Jit
         mS+lSAuk/VMxvoqpRQVmQY+Q+YDLI7zkWKVAWDQrtC5Tr2CoqAswHmf8Rw81ScJ2cj83
         DxKyaBvREFRD5btoRYfJ5rg2UxrB9AgHIEmKh/VcpzqLUIbnyDhrhs5DoPDwSxmts0pw
         tuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gK+8Up/Ey5WhloloBZQqFYaJnlaNpQykinPquqvWB5g=;
        b=iwx1Ts0S8AUr+0F6X7RFheQIXVzjFE2lzonz0WelqciJNE7tihRU/uDvIAKHdP9o8w
         AAMswz8WYYniTJpb5EWuSDDNCRPGTbxAOPG0c5AvDoWEoXs/tfG0Om82Dx1xEss1qMXu
         Qr/qNANBFGaKgxL2pUSEowAfFRufb7NDsVA4X4eOHoamgTpP/TNnEkkcsIXS6NJ2Z9Bb
         z01VvpNkx3PNx2Zq+gmi2/XyTAfRDVjXEmI89iu42nUVzUGr+9Kl1OAo8rWSMV0W79dg
         nO5KOWjEBKgbTeFAu2ldLMBvvZbp9Rilum9dUEJGV7JGHEsqozncOWsTEEeuVjhxlRqf
         uNdw==
X-Gm-Message-State: APjAAAVerg77ZyGeoKUSpMnoP2bJIg4qMuCPaAZ8DHXqp6j2MoOjbNIv
        kjHaq6gGtSmO4viVNHOVeriQvmWNyn5ozEkwhH0EMw==
X-Google-Smtp-Source: APXvYqwnkdLv7ENjzuDQmcYB+qCfSamAMLNtRTjqBVoe3B7N4LXkuUoofIkjG2GlEo5XrAuHm+c1dwePuh1dTaiD9K4=
X-Received: by 2002:a02:cd02:: with SMTP id g2mr1489648jaq.70.1553147491910;
 Wed, 20 Mar 2019 22:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190225065044.11023-1-vaishali.thakkar@linaro.org>
 <20190225065044.11023-5-vaishali.thakkar@linaro.org> <155138953788.16805.6820097041346672619@swboyd.mtv.corp.google.com>
 <CANNG1HWDc-PraBwG=8TBcfJSFFe+X+k6oVhOqyU=i5fAjpuoLw@mail.gmail.com> <155257912871.20095.1653828341120157988@swboyd.mtv.corp.google.com>
In-Reply-To: <155257912871.20095.1653828341120157988@swboyd.mtv.corp.google.com>
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
Date:   Thu, 21 Mar 2019 11:21:20 +0530
Message-ID: <CANNG1HV0Ai9oeUr55uk+wAf456vDn1qiYmeXYc3=rkpqhdoM4g@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] soc: qcom: socinfo: Expose custom attributes
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019 at 21:28, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Vaishali Thakkar (2019-03-14 04:25:16)
> > On Fri, 1 Mar 2019 at 03:02, Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Why can't we use the debugfs_create_u32 function? It would make things
> > > clearer if there was either a debugfs_create_le32() function or if the
> > > socinfo structure stored in smem was unmarshalled from little endian
> > > to the cpu native endian format during probe time and then all the rest
> > > of the code can treat it as a native endian u32 values.
> >
> > Thanks for the review. I've worked on the next version with all the
> > changes you suggested in the patchset but I'm kind of not sure
> > what would be the best solution in this case.
>
> Alright, thanks.
>
> >
> > I'm bit skeptical about introducing debugfs_create_le32 as we don't
> > really have any endian specific functions in the debugfs core at the
> > moment. And if I do that, should I also introduce debugfs_create_be32
> > [and to an extent debugfs_create_le{16,64}]? More importantly, would
> > it be useful to introduce them in core?
>
> I suppose it's ambiguous if the endianness should be swapped to be CPU
> native, or if it should just export them as little endian or big endian
> to userspace. I wouldn't introduce any APIs that aren't used, because
> it's just dead code. If the code is documented clearly and indicates
> what it does then it should be fine. This patch has pretty much already
> written the code, so it's just a matter of moving it into debugfs core
> now and getting gregkh to approve.
>
> >
> > In the case of converting it to cpu native during probe, I'll need to
> > declare an extra struct with u32 being the parsed version for it to be
> > correct. Wouldn't it add extra overhead?
>
> Yes it would be some small extra overhead that could be allocated on the
> kernel's heap. What's the maximum size? A hundred bytes or so?
>
> I don't see much of a problem with this approach. It simplifies the
> patch series because nothing new is introduced in debugfs core and the
> endian conversion is done once in one place instead of being scattered
> throughout the code. Sounds like a good improvement to me.
>

Yes, it's true that this approach is better than introducing new endian
functions in debugfs core but we should also keep in mind that this is
applicable only for 4 use cases. For other usecases, we want to print
string and hex values. So, I would either need new debugfs core
functions for the same. I tried introducing debugfs_create_str for string
values but we're ending up with introducing bunch of other helpers in
the core as simple_attr_read expects integer values. Similarly, for hex
values , I can't use debugfs_create_u32 as defined attributes in the
core has unsigned int as a specifier, will need to introduce some extra
helpers over there again.

Also, in case of keeping all other cases as it is, it'll look quite
asymmetric to use debugfs u32 function in init and using local macros
for other cases. I can have DEBUGFS_UINT_ADD like wrapper
macro for debugfs_create_u32 but again not sure if doing
all of this looks better than what we have at the moment as just having
3 local macros covering our all cases without having lot of duplicated
code.

 Let me know if about your opinion on the same. Thanks.

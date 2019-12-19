Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7824C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD68324650
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIjaEL+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfLSOUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:20:35 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42063 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSOUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:20:35 -0500
Received: by mail-io1-f67.google.com with SMTP id n11so4368981iom.9;
        Thu, 19 Dec 2019 06:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d3uNqyau+uqHl1+nVlgL9fnHSgknMtxXHMZq1PGXbPI=;
        b=fIjaEL+xy1liB8a19YiHcLE/YmTaQAcfoRDPTsFpSyJAWVR/R+GbGxWTkTlklsSPjX
         Yu3FCBgbImKi2S9yWuq/Npy+Idoa147eGtNr5dCggAIUGBVk7rz0wkRkoqvV/BU15Clo
         GOkz839U3L8RH6QMkA17wi+1ZGyFSpMmcZuNe1OmqmA/hLOkcCDBSCGGfk8C78vv+h3J
         UiwvHtSeS3wvhRDLAiBbY4YzDVmZwFGFV3Cp6Nts75kM7OaYbn5fJQS9eDpGjbIP+/Nr
         qiAi/fj7z/9aAFtIM+VhPKC7tMqGFjp4+IPHBCocWN/yTnJwqGvSNxQcbmtGQT/ieM/x
         01Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3uNqyau+uqHl1+nVlgL9fnHSgknMtxXHMZq1PGXbPI=;
        b=qsTzIjSzpy3fiz8FNlJqS3Vd6TlT1Kfff1fwbpZ430wg7XoXbJ+drERvkmHo5gYN03
         oDwT7cRV4WezTM8gZxkKWul8afSwwyTfRsYUZ19B2YyRirPQfbmAsqwwCYJILzElBE52
         KUKkXIKf9a0QfaTp2rzTOwEOvWOU4UPRWsWn+AVTJiDDsIgKOTn5B2/K1GYen+4QJPa2
         jSKPM2NoieSI5Hz6aNhPxhSO92vsjZgoaXDA3rEAdzNqX75Szi43Z74kVKBXZmxeof6f
         J4dZbWHInceMhu70bFlGTxajTGUS5MyA6q7k5VV+wY8iUB44jwjAvdWg8zn9Yg79TlQ+
         sd8g==
X-Gm-Message-State: APjAAAXsnqoyqpR3qcY4UZwE5A/VgjIEN59v2cxWzHvl1jIXJcd/o75H
        u3WPC9hC3OzLk5i8H5jtQTxUTSDrNIAtbBwAX8A=
X-Google-Smtp-Source: APXvYqyse2tZmLbWeTJHu9jPZ4y7jNwi6OE18BMIORT8ZvbIy8VS+HkWhe05B83mbuQvzggj2mMbqfwpJ8aQ0JO88YY=
X-Received: by 2002:a5d:9c4e:: with SMTP id 14mr6199922iof.166.1576765234271;
 Thu, 19 Dec 2019 06:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20191217171205.5492-1-jeffrey.l.hugo@gmail.com> <20191219060020.573342146E@mail.kernel.org>
In-Reply-To: <20191219060020.573342146E@mail.kernel.org>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Thu, 19 Dec 2019 07:20:23 -0700
Message-ID: <CAOCk7NpZmH8XahFmcKXSGsbT2nrY7kuWftGW1Ss6NdkqGs08cA@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: Make gcc_gpu_cfg_ahb_clk critical
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>, linux-clk@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 11:00 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Jeffrey Hugo (2019-12-17 09:12:05)
> > diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
> > index df1d7056436c..26cc1458ce4a 100644
> > --- a/drivers/clk/qcom/gcc-msm8998.c
> > +++ b/drivers/clk/qcom/gcc-msm8998.c
> > @@ -2044,6 +2044,7 @@ static struct clk_branch gcc_gpu_cfg_ahb_clk = {
> >                 .hw.init = &(struct clk_init_data){
> >                         .name = "gcc_gpu_cfg_ahb_clk",
> >                         .ops = &clk_branch2_ops,
> > +                       .flags = CLK_IS_CRITICAL, /* to access gpucc */
>
> Can we not do the thing that Bjorn did to turn on ahb clks with runtime
> PM for clk controllers that need them? See 892df0191b29 ("clk: qcom: Add
> QCS404 TuringCC").
>

Interesting.  I didn't think of that solution, nor was I aware of that
change.  Let me have a look.  Thanks for the tip.

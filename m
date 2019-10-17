Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B43CFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 20:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F5221835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 20:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CcY6khg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436862AbfJQUAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 16:00:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45468 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392579AbfJQUAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 16:00:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so2300500pfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 13:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=QIMZdUFoVDCCgi7u9KnfgFx2D+e8lBSYkgBbx8BMeec=;
        b=CcY6khg3q6nubSARTDJ5XR1igh/NxAZFgNsGtnScPCLDJ20bsPOxhJh8YD0Ifo1HK1
         UflIjODDTFl8CRWMZf1yBr9pBsZI/xNyhdGJtRt7j6N851Pii2fEu1phfhNvF5ERh0IY
         Zl7fuIIFWYgbudcD0dq4aT9k6ojiOfJJ6/w5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=QIMZdUFoVDCCgi7u9KnfgFx2D+e8lBSYkgBbx8BMeec=;
        b=DAdJ83EG65XFFcrB4nyrEHJY8zO6/UheYTGJG01IDKYO9lUvx9vGGWKTcAuFa5T4mS
         LmEpVmA7/n54UZAalRx+nZAQyhVdL5uq4sHoCCv3s3reiNuV4sLrXoSUrUwHrz810Xww
         w1B2DvCYQrsBX3NZCAMBIGH4LxAp+rK2BMx/QLL1wd9I6fV1ULbHLTmjEtcHSJSylPvJ
         incujg0aKjxoU5SsEuRV2AqT5v1Nvm3UQQS7+Rmk3twtGdNHLCKGjVFbZ5F/Wol4CfBK
         f6nQ1XH9OeMiBlQ7tJFNbk3cCJv1RHR85FloGrb/ggAz964pQe6IfWtSyaNpO361Zb7H
         cz0w==
X-Gm-Message-State: APjAAAUcbDFQ7hWnp+WUaigHaiGKvEOZWIeywxvhnZDGV0TcCwDFjiRL
        rWbMpi7BZLSZ+DEDyKZklSQznw==
X-Google-Smtp-Source: APXvYqxn4GjJKCMJ6/dMMs6TXVT3v+iRNGMNw4x8OnF002zaL0RZvbO7aIfYNtadR0MBs08MMHevpw==
X-Received: by 2002:a17:90a:5896:: with SMTP id j22mr6095736pji.55.1571342441026;
        Thu, 17 Oct 2019 13:00:41 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 74sm3834060pfy.78.2019.10.17.13.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 13:00:40 -0700 (PDT)
Message-ID: <5da8c868.1c69fb81.ae709.97ff@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ac7599b30461d6a814e4f36d68bba6c2@codeaurora.org>
References: <b3606e76af42f7ecf65b1bfc2a5ed30a@codeaurora.org> <20191011105010.GA29364@lakrids.cambridge.arm.com> <7910f428bd96834c15fb56262f3c10f8@codeaurora.org> <20191011143442.515659f4@why> <ac7599b30461d6a814e4f36d68bba6c2@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Marc Zyngier <maz@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, rnayak@codeaurora.org,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org>,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        andrew.murray@arm.com, will@kernel.org, Dave.Martin@arm.com,
        linux-arm-kernel@lists.infradead.org, marc.w.gonzalez@free.fr
Subject: Re: Relax CPU features sanity checking on heterogeneous architectures
User-Agent: alot/0.8.1
Date:   Thu, 17 Oct 2019 13:00:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2019-10-11 06:40:13)
> On 2019-10-11 19:04, Marc Zyngier wrote:
> > On Fri, 11 Oct 2019 18:47:39 +0530
> > Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> >=20
> >> Hi Mark,
> >>=20
> >> Thanks a lot for the detailed explanations, I did have a look at all=20
> >> the variations before posting this.
> >>=20
> >> On 2019-10-11 16:20, Mark Rutland wrote:
> >> > Hi,
> >> >
> >> > On Fri, Oct 11, 2019 at 11:19:00AM +0530, Sai Prakash Ranjan wrote:
> >> >> On latest QCOM SoCs like SM8150 and SC7180 with big.LITTLE arch, be=
low
> >> >> warnings are observed during bootup of big cpu cores.
> >> >
> >> > For reference, which CPUs are in those SoCs?
> >> >
> >>=20
> >> SM8150 is based on Cortex-A55(little cores) and Cortex-A76(big cores).=
=20
> >> I'm afraid I cannot give details about SC7180 yet.
> >>=20
> >> >> SM8150:
> >> >> >> [    0.271177] CPU features: SANITY CHECK: Unexpected variation =
in
> >> >> SYS_ID_AA64PFR0_EL1. Boot CPU: 0x00000011112222, CPU4: >> 0x0000001=
1111112
> >> >
> >> > The differing fields are EL3, EL2, and EL1: the boot CPU supports
> >> > AArch64 and AArch32 at those exception levels, while the secondary o=
nly
> >> > supports AArch64.
> >> >
> >> > Do we handle this variation in KVM?
> >>=20
> >> We do not support KVM.
> >=20
> > Mainline does. You don't get to pick and choose what is supported or
> > not.
> >=20
>=20
> Ok thats good.
>=20

I want KVM on sc7180. How do I get it? Is something going to not work?


Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA83C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE362086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nRlHbGH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391886AbfITWU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 18:20:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37445 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfITWU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 18:20:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id b10so3832350plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 15:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=G6ArsEBvUBRFvndBKzVZmq8gvZ8T+N7qYPjPD+3Z5yo=;
        b=nRlHbGH5wNwG5+TmN8Kv4+cFBbowXlpJ1u8t4kt1EkGEUblzPAiKYRS3o8mTTeSuWK
         jiQgSAlVukgSn/p9gKZzwOy0fFtmRQdU3027Bytif2lW1DugSKor9x03okTp0yc2RCXH
         +AUJjbXZcdcM1CTFdNGGh1ksWA14j1kdNkTgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=G6ArsEBvUBRFvndBKzVZmq8gvZ8T+N7qYPjPD+3Z5yo=;
        b=mvmuPrhM1n1VJ5TxGkcYa8ezY/wg9cBmCxTPJFt7bPjQ/G3P/PwLm+8ci/P3asR96g
         O+cMgQhAH1yG2KH4WrDZxCZKvK1RaCrYig+Yc5oJG3vUkWvm2M3zztxogoAIgEwCvx1o
         kk7uyUfKyXffgpnzmMeH+uXSBCDCg0qYU4HBYYHFQSskg+Kcrkv2l4mzfSHd216uEoHM
         VPcHtqNgpD11BEeSU6lcizYBF8ke0OQAOLyP6S0RLsK7lyVJMtau9yrUcouYKjSYZDqp
         Qyi4V8vVRGQYSk0MtD/MFCCmXnYXhfj3zgRNhxNIC9x+yEh1eqxaqb+Q1ha1HRFBGuIA
         rHHQ==
X-Gm-Message-State: APjAAAWdwQ7bFVbDqL0r2ev9NyfcTxnyVDG91Fpx/NzPTEFfZoy7U715
        A5s+zK/vrjnZyvywQ59VWfz7VQ==
X-Google-Smtp-Source: APXvYqxPOvFQKjjFVKyK+RgTiwbSXqMoV+qulfuBR8SdTO6EJKRGIkHEVxF3TOJ3gdJ4DQZv4biPHQ==
X-Received: by 2002:a17:902:a9c7:: with SMTP id b7mr19438785plr.133.1569018027798;
        Fri, 20 Sep 2019 15:20:27 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p88sm3152333pjp.22.2019.09.20.15.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 15:20:26 -0700 (PDT)
Message-ID: <5d8550aa.1c69fb81.39edc.83fc@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190917215020.GA15853@codeaurora.org>
References: <20190829181203.2660-1-ilina@codeaurora.org> <20190829181203.2660-6-ilina@codeaurora.org> <5d6d1b72.1c69fb81.ee88.efcf@mx.google.com> <102c9268-c4ce-6133-3b0a-67c2fcba1e7a@arm.com> <20190903170722.GA31716@codeaurora.org> <5d71a247.1c69fb81.2146f.7ed2@mx.google.com> <20190913195326.GA3293@codeaurora.org> <20190917215020.GA15853@codeaurora.org>
Cc:     Rob Herring <robh@kernel.org>, evgreen@chromium.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        mkshah@codeaurora.org, linux-gpio@vger.kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org, maz@kernel.org,
        sibis@codeaurora.org
To:     Lina Iyer <ilina@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH RFC 05/14] dt-bindings/interrupt-controller: pdc: add SPI config register
User-Agent: alot/0.8.1
Date:   Fri, 20 Sep 2019 15:20:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-09-17 14:50:20)
> On Fri, Sep 13 2019 at 13:53 -0600, Lina Iyer wrote:
> >On Thu, Sep 05 2019 at 18:03 -0600, Stephen Boyd wrote:
> >>Quoting Lina Iyer (2019-09-03 10:07:22)
> >>>On Mon, Sep 02 2019 at 07:58 -0600, Marc Zyngier wrote:
> >>>>On 02/09/2019 14:38, Rob Herring wrote:
> >>>>> On Thu, Aug 29, 2019 at 12:11:54PM -0600, Lina Iyer wrote:
> >>>These are not GIC registers but located on the PDC interface to the GI=
C.
> >>>They may or may not be secure access controlled, depending on the SoC.
> >>>
> >>
> >>It looks like it falls under this "mailbox" device which is really the
> >>catch all bucket for bits with no home besides they're related to the
> >>apps CPUs/subsystem.
> >>
> >Thanks for pointing to this.
> >>      apss_shared: mailbox@17990000 {
> >>              compatible =3D "qcom,sdm845-apss-shared";
> >>              reg =3D <0 0x17990000 0 0x1000>;
> >But this doesn't seem correct. The registers in this page are all not
> >mailbox door bell registers. We should restrict the space allocated to
> >the mbox to 0xC or something, definitely, not the whole page. They all
> >cannot be treated as a mailbox registers.

Well the binding is already done and this is the compatible string for
this node and register region. Sounds like this node is a mailbox plus
some more stuff in the same page.

> >>              #mbox-cells =3D <1>;
> >>      };
> >>
> >>Can you point to this node with a phandle and then parse the reg
> >>property out of it to use in the scm readl/writel APIs? Maybe it can be
> >>a two cell property with <&apps_shared 0xf0> to indicate the offset to
> >>the registers to read/write? In non-secure mode presumably we need to
> >>also write these registers? Good news is that there's a regmap for this
> >>driver already, so maybe that can be acquired from the pdc driver.
> >>
> >The register space collection seems to be mix of different types of
> >application processor registers that should probably not be grouped up
> >under one subsystem. A single regmap doesn't seem correct either.

Why isn't a single regmap correct? The PDC driver should be able to use
it to read/write into this register space. The lock on the regmap will
need to be changed to a raw lock though for RT. Otherwise it looks OK to
me.


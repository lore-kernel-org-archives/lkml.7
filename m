Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBFEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC04E2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S27FHGX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfCHNId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:08:33 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45693 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfCHNI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:08:28 -0500
Received: by mail-vs1-f66.google.com with SMTP id n14so6588445vsp.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 05:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5YYQ65gUiPk1+Pn0KZVlCx735nGsOzNoCRJuKV7a/Qk=;
        b=S27FHGX5Koc2u5V5GSwJ8YLboGsopCjYEABAcNB/MEmuUcSDcoZai4Cpxwy53p8VCY
         4ZwjnVdKs66Xc4EsLk6ChG5e+MzyHIlwj8jUMn+v7Blrh3XzJS9eO6lCFNKzkxsIiVAO
         DPBo0bKzcMlp6KG89Q41zXm+FdviSOtMrPA8fLniXa2pnEtRp5oarKknvMQvQFFxLMcr
         EJqhnH9JgJZr1uy3Ne0Bq940nxYXm+IIT2MnUW4b9IqZ4dSVSoCNoop2UOwUayz9HKnC
         aP6OHmAFXHNWwH1qzIOSH761aOw9DWNvGoC0fO1MFs6uYt53mQJU4Jf8h55hV4xoSQvC
         TEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YYQ65gUiPk1+Pn0KZVlCx735nGsOzNoCRJuKV7a/Qk=;
        b=LMycA31SaOQGAf54DnFjfUAmbgMJ/dTnHAk8Ydk7GLUPDQPX8QN/csKN1iw7OHUK0V
         4pqd63FsLpG7fqcf6QtNTGIcXzFjLNH08+MXTfSPiveueE9aio5aG3Tjg3X2dCGKxR7G
         VGUOV4jD95jptwFGDIVk842wkK2rC6Hjn011CsyiUO0ZK7OALEmARoyrrM+O4WVmEvg4
         9GBD7gNAHhcMb1IVK9MUsuaHHZZgpAwJsBZjaeocymh8MTtAQw+hbnkDgK9GmJx3mGQN
         5HeLW6+V4tzj9xVqEFKz8NVpQ3Un413k0Plf5+G/s2y/ljKoxLZ/HAQfhBUe88y24JKl
         Bi+A==
X-Gm-Message-State: APjAAAW7IwEjW/g/xdej3vbJ5vvyiab8u16NsQnGdOaATih7AKHAz7JD
        VUHX9IQt3Az/UyaUNWa82qVOTshyOdPXggyAuygMUA==
X-Google-Smtp-Source: APXvYqyFiXCi9C4u8PVbG9BNKnQV8WN5aMUPzD3l063JT+3VXBf+K5GLr2BfQbs70EktuN+27gNjP0de2pNFCkHkd0w=
X-Received: by 2002:a05:6102:157:: with SMTP id a23mr9825996vsr.34.1552050507102;
 Fri, 08 Mar 2019 05:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20190228135919.3747-1-ulf.hansson@linaro.org> <20190228135919.3747-6-ulf.hansson@linaro.org>
 <20190301172810.GR15517@lakrids.cambridge.arm.com> <CAPDyKFrqp6_NkTBVXZTa3j+-6y+m7aX2y6t=nH=Tjdo4BgMDtQ@mail.gmail.com>
 <20190306181519.GA3355@e107981-ln.cambridge.arm.com> <CAPDyKFrbu4rFyohv+YJkG7O03_r3+3gn1vib_FJUW0t-4REgTw@mail.gmail.com>
 <20190308114943.GA27731@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190308114943.GA27731@e107981-ln.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 8 Mar 2019 14:07:51 +0100
Message-ID: <CAPDyKFry_ZQXA-bj6gA8npdqkMmg8AUOZ+Kr4mnOaS8=xZ+MwA@mail.gmail.com>
Subject: Re: [PATCH 5/7] drivers: firmware: psci: Simplify state node parsing
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2019 at 12:49, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Mar 08, 2019 at 11:36:49AM +0100, Ulf Hansson wrote:
>
> [...]
>
> > Instead, my suggestion is according to what I propose in patch 4 and
> > $subject patch, which means minor adjustments to be able to pass the
> > struct cpuidle_driver * to the init functions. This, I need it for
> > next steps, but already at this point it improves things as it avoids
> > some of the OF parsing, and that's good, isn't it?
>
> I will take the patches Mark ACKed and send them for v5.2 as
> early as it gets in v5.1-rc* cycle.

Actually, may I suggest we funnel these through Rafael's tree, unless
you are expecting other PSCI changes for v.5.2, which could cause
conflicts?

The reason is, other PM core changes, to genpd for example, needs to
go via Rafael's tree. Those would then potentially block us for
applying any other changes to your tree (arm-soc?) for PSCI (as there
is dependency) until v5.3.

How about if you provides your explicit acks for those PSCI changes
your are happy with, then Rafael can pick them?

>
> For this one maybe you can post the changes on top and see what's
> the best way forward ?
>
> I agree that duplicating idle state parsing code across back-ends
> is silly - we just want to keep PSCI and kernel data structure
> decoupled.

Right. Let's continue this discussion later on and move forward here.
Make sense.

>
> Post the code on top and we will find a way forward, OK ?

Sure, let me do that.

Thanks and kind regards
Uffe

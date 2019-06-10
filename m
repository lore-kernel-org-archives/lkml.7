Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC12C28D16
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856DA20859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ed47JMDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389370AbfFJKVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:21:48 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40996 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388937AbfFJKVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:21:47 -0400
Received: by mail-vk1-f194.google.com with SMTP id l73so1524705vkl.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 03:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJxNCKHBqEq8hxmgfzQAJLVDLncAAe7CM9ROe+/BeNA=;
        b=ed47JMDehrtw98oo73hPrYOSdiClydVSZax5u/whwsvttI4jMeBg5r4kAaxNqyhRB5
         BQFS+aUFK4fp9pg9m4ABxFL8f8WSLttgJ/crALrwhCsB3v1rjfIrckms9BqtJaYXtlqc
         bzwWVino1iCNJq+uESFaHxZLWBnG33vgs3Qmd1+/6T3+zMmoiN7Dl812exIOVO1cl1F7
         +J34mbVL1NKVBr2n6AaV5gn/vEQktUbl74lRvHydB7/VR5zEDH8WVmV5fmMUTqQq4oUo
         jgFxnXWvvAWYApcTfNa6leYI+JjgeKGVBFkeuu7YRcJuNtctRfWgPTUPlWa5tSEu7aqi
         JNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJxNCKHBqEq8hxmgfzQAJLVDLncAAe7CM9ROe+/BeNA=;
        b=ALjKPJ3mEp6hN39LlJ3YzzdWDvr5M+P/g9rUwRn/ip493lU9lLOmGmMIPpAETNjxD6
         t45vEbgdo9hkqK0UDAGUYkgodLpcAAn/rtxJ672U7OlwmBtKC49axfn1ETZbzJLkUMW9
         0fJ4gNWVSrxs4X4gtHX5CiZh3L8jqvhc8jjjPb3hzmHbF3JG5WRX8W7vmm0yUxPaxCgV
         E9VDYM0lEVSpBb/f2HMYuUF4npUyDPZW56QrPfK5nn34CfpihDwFDFziBY5EVqTC08H/
         yhix+tc89NKqZ+LfNha7m7PYHPzncALOxLj5xBroHsUJnpbSXLmxnelIeaRkoUnBlQ/x
         CbGw==
X-Gm-Message-State: APjAAAU6C0guzgtiiB9b4Yx14ah+WYqzVAWmThm1wSunkDv4dGrCepiI
        T6MReCHc9hWXo0pPBwhA+MV9vaugG4Cv2WNLF0W52g==
X-Google-Smtp-Source: APXvYqw85yEyPCfVXgt5WHExarvGTTNSk7I/nOG6fWausDPOCC8pBQhB+ownP2Y9XmGBJmpJYjtZLrkebjzWM3KbGXc=
X-Received: by 2002:a1f:12d5:: with SMTP id 204mr12861074vks.4.1560162106571;
 Mon, 10 Jun 2019 03:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190513192300.653-1-ulf.hansson@linaro.org> <20190513192300.653-8-ulf.hansson@linaro.org>
 <20190607151716.GF15577@e107155-lin>
In-Reply-To: <20190607151716.GF15577@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Jun 2019 12:21:10 +0200
Message-ID: <CAPDyKFoKNLqLzVx8uj_-iuWAHGCvty28mVKnipFVgjKD8oDNkQ@mail.gmail.com>
Subject: Re: [PATCH 07/18] drivers: firmware: psci: Prepare to use OS
 initiated suspend mode
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jun 2019 at 17:17, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, May 13, 2019 at 09:22:49PM +0200, Ulf Hansson wrote:
> > The per CPU variable psci_power_state, contains an array of fixed values,
> > which reflects the corresponding arm,psci-suspend-param parsed from DT, for
> > each of the available CPU idle states.
> >
> > This isn't sufficient when using the hierarchical CPU topology in DT in
> > combination with having PSCI OS initiated (OSI) mode enabled. More
> > precisely, in OSI mode, Linux is responsible of telling the PSCI FW what
> > idle state the cluster (a group of CPUs) should enter, while in PSCI
> > Platform Coordinated (PC) mode, each CPU independently votes for an idle
> > state of the cluster.
> >
> > For this reason, let's introduce an additional per CPU variable called
> > domain_state and implement two helper functions to read/write its values.
> > Following patches, which implements PM domain support for PSCI, will use
> > the domain_state variable and set it to corresponding bits that represents
> > the selected idle state for the cluster.
> >
> > Finally, in psci_cpu_suspend_enter() and psci_suspend_finisher(), let's
> > take into account the values in the domain_state, as to get the complete
> > suspend parameter.
> >
>
> I understand it was split to ease review, but this patch also does
> nothing as domain_state = 0 always. I was trying hard to find where it's
> set, but I assume it will be done in later patches. Again may be this
> can be squashed into the first caller of psci_set_domain_state

You have a point, but I am worried that it would look like this series
is solely needed to support OSI mode. This is not the case. Let me
explain.

Having $subject patch separate shows the specific changes needed to
support OSI mode. The first caller of psci_set_domain_state() is added
in patch9, however, patch9 is useful no matter of OSI or PC mode.

Moreover, if I squash $subject patch with patch9, I would have to
squash also the subsequent patch (patch8), as it depends on $subject
patch.

So, to conclude, are you happy with this as is or do you want me to
squash the patches?

Kind regards
Uffe

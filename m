Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BB6C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFE720880
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hRS9tdns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389850AbfGRKfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 06:35:45 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33684 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfGRKfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 06:35:45 -0400
Received: by mail-vs1-f67.google.com with SMTP id m8so18807134vsj.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 03:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bPsZyaY1avB4NmRKihmlAbRWMA/+wWnkWYAQnUJy/uc=;
        b=hRS9tdns/W1JgD4gXX9suvoW/sEfa10WszlqRMNyTDVGE4pvXMTTfwq/5kkohrxDM7
         W7+I5ziWAyIuiHrX/lcoOj0SJw+f5YG4xCubaO4tE70Z+vieiYB4B26jaOQUvlMI4S+U
         xyN1krAtJQAXe2Vz8klpfFqYJMDNdZ8cfzuW9QcUmMv6R4UjK1Kq/58lPsgA4sCtpTzA
         0qFoFw674o5/tuQ1z4FPQeyxpwMSw1+qVsC8O6HgdTQBOqM/uGIyiyS0Pf5HCXETQW4d
         5Gyb4/sUE+H9nH3Nb/q1LqBqKoM5Uq2R4rYtA1XYgsHvHKaCOvYtSeHXrL6RULNV1DnO
         IYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bPsZyaY1avB4NmRKihmlAbRWMA/+wWnkWYAQnUJy/uc=;
        b=VVA4mmvYckGsbdP8DEL2z7+y3DqmFSHjkS3I+Of3q2uWER2AqtPMqoNlmd7Jj/Uisx
         h/scU236lsxjjs6V19GCiNxkda9xdUbWAo7O4Y1jBfE4q2F4b4js7m4pp3U0y3hJch0P
         2EWqP2S6+QOpxps9P3t0+9H/d7UadiyikVF3Ju02OiF5VHGi6VK5HPmVuFuqozlri4IT
         +QgR0xAhnObtUyKlC3Pza6u63abeb/pUb40CRMAFNDBUZ6J1GkRnIn3wPHNFFh7JsLwm
         SND50pcxjun+W+IRAbELLWOEsXF6To0+UKRaGTIJlivVz8aaQ+hmD255Eoho58enA8v1
         bXoA==
X-Gm-Message-State: APjAAAXwLiLdykNm8v0QShcmKEm0unwIfue1ilWN00P01ztxZ4cV5Tql
        q/QBTyOvMqlLbPJe7K10A+LP1kSvZ0n3zYGWVD1YYw==
X-Google-Smtp-Source: APXvYqzSx0aR/M+aRW6giaR+8hf163WchtvCdbWRJMcDQ/HVNG1W8viO5bTF5uxNvGiQXgL7jxarygjbk3mkugNqF9Q=
X-Received: by 2002:a67:ee16:: with SMTP id f22mr28548547vsp.191.1563446144144;
 Thu, 18 Jul 2019 03:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190513192300.653-1-ulf.hansson@linaro.org> <20190513192300.653-15-ulf.hansson@linaro.org>
 <20190716155317.GB32490@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190716155317.GB32490@e121166-lin.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 18 Jul 2019 12:35:07 +0200
Message-ID: <CAPDyKFrJ75mo+s6GuUCTQ-nVv7C+9YJyTVmwuBZ2RKFOvOi3Nw@mail.gmail.com>
Subject: Re: [PATCH 14/18] drivers: firmware: psci: Manage runtime PM in the
 idle path for CPUs
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2019 at 17:53, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Mon, May 13, 2019 at 09:22:56PM +0200, Ulf Hansson wrote:
> > When the hierarchical CPU topology layout is used in DT, let's allow the
> > CPU to be power managed through its PM domain, via deploying runtime PM
> > support.
> >
> > To know for which idle states runtime PM reference counting is needed,
> > let's store the index of deepest idle state for the CPU, in a per CPU
> > variable. This allows psci_cpu_suspend_enter() to compare this index with
> > the requested idle state index and then act accordingly.
>
> I do not see why a system with two CPU CPUidle states, say CPU retention
> and CPU shutdown, should not be calling runtime PM on CPU retention
> entry.

If the CPU idle governor did select the CPU retention for the CPU, it
was probably because the target residency for the CPU shutdown state
could not be met.

In this case, there is no point in allowing any other deeper idle
states for cluster/package/system, since those have even greater
residencies, hence calling runtime PM doesn't make sense.

>
> The question then is what cluster/package/system states
> are allowed for a given CPU idle state, to understand
> what idle states can be actually entered at any hierarchy
> level given the choice made for the CPU idle state.
>
> In the case above, a CPU entering retention state should prevent
> runtime PM selecting a cluster shutdown state; most likely firmware
> would demote the request to cluster retention but still, we should
> find a way to describe these dependencies.

See above.

[...]

Kind regards
Uffe

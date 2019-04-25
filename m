Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421B5C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0893E208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556186204;
	bh=p7gcO/tey9CZk2Vrhy0h7TUDheM1dlIFHFpjNdL8IZ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EqPIAhbyUZf1+exsZ3XAyyXukgV9LyWp1FFn53DWsM2G8vyB2Ed/pS/CXGoggqxeh
	 vM4FeWkTPnDUTSkJENJEbepfGfolcnveABt1x3JXMMBJxO8oES/S/ot5Cu5cc+URHJ
	 nXexuVDmi5kXilTY64gktC0JXzqphE46nLJgERSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfDYJ4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:56:43 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43721 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbfDYJ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:56:42 -0400
Received: by mail-ot1-f67.google.com with SMTP id u15so18857796otq.10;
        Thu, 25 Apr 2019 02:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kpUJHSGSVSfasemuOSXo7I60OKnWpgjskqVXdlDjlsE=;
        b=BPRU7PjzxynNPbSJyxN3Nevo5UOuHgp8U5DGA0Wd6MAcC7OOjrAJ5zzkkYmbm5q4LX
         U4nsr6q0PglVhnWVR/J7P9JXAvXBJlFFJUydQdKpVcpsuOtxJq1xNKkawRLQ4uodDZ+e
         18EFsqJQjUOUbCtPIq7NH11f24a40RzT/Qtl68Au4ZiTJNdNNQ9btvwgfSSVcItw0m7I
         9MdnwzWzhFtqahiLYCsftxUd00V2MbsOboYBXhUJbbW2aVlvcH4g4DWYJeX2hRjm8jXk
         j1b2IyjAm1ntDYohfxZfXDm1/765rttiBNtDTl6ikz7BbzhUfCr1gEKb1i3GQzfcSQ24
         j25Q==
X-Gm-Message-State: APjAAAVmSiJ4zWO836iK0ehVnD7YqFm38fsk/r+YGhM2GdWBQLbUt8em
        Yl9p19mpd29Ncn8YrswVyvb4wGm5sgnp3BPz2KY=
X-Google-Smtp-Source: APXvYqygjkp0v3UD+PQF/1OSxjEJHHBYEh9cI11NjJkvo0elY8re//aja/WvkvEtQIkYq9Vs1Ig4Fgykz5pZegZRt0U=
X-Received: by 2002:a9d:648f:: with SMTP id g15mr22116915otl.220.1556186201197;
 Thu, 25 Apr 2019 02:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190425090413.10700-1-ulf.hansson@linaro.org>
In-Reply-To: <20190425090413.10700-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Apr 2019 11:56:30 +0200
Message-ID: <CAJZ5v0jxGcFu-aqvyR4UgjRuCwB9q9fZCiXf+D3NL3TJ5OVEPA@mail.gmail.com>
Subject: Re: [PATCH 0/4] PM / Domains: Improve support for CPUs in genpd
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 11:04 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Recently genpd was extended to cope with devices belonging to CPUs. However,
> attaching CPU devices via genpd_dev_pm_attach_by_id|name() doesn't work,
> because of the virtual device that genpd allocates in this path.
>
> In this series, this limitation is addressed, together with a few other related
> fixes/cleanups.
>
> Ulf Hansson (4):
>   PM / Domains: Use the base device for
>     driver_deferred_probe_check_state()
>   PM / Domains: Drop unused in-parameter to some genpd functions
>   PM / Domains: Search for the CPU device outside the genpd lock
>   PM / Domains: Allow to attach a CPU via
>     genpd_dev_pm_attach_by_id|name()
>
>  drivers/base/power/domain.c | 73 ++++++++++++++++++-------------------
>  include/linux/pm_domain.h   |  1 +
>  2 files changed, 36 insertions(+), 38 deletions(-)

Are there any dependencies between this and the series you've recently posted?

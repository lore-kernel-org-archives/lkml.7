Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD25C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687C3214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZvx2YKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfDYKLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:11:46 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39895 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfDYKLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:11:46 -0400
Received: by mail-vs1-f67.google.com with SMTP id g127so12158356vsd.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 03:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=woQ78Cv5MbrmOzXRr57dM4FopiomlSeZvKoUqFf81qk=;
        b=KZvx2YKbb4zUXOK0WScQKmO9RHcAHYe/scmmXa2DE0fWbsQFxYzc9l1aR5qsNO5V2r
         IS0CBQQAm6HrJZmy9x4krphraqQxx7Qit/UznNO9V8WtCvnUXfDXPwOOLKqqtAShC8Ro
         m02nEo7swePDKGolhhdo7RyRZUwQc3XlittrsTwpHxetcUqZFfnwOopbV8ggeVDzFY0J
         gcivyLaJIxYNcaKWTChtC5bgDbUXqa9F34EINGrWT11RmHP6iWuaHZjDcfTBcsUp9bsO
         Mst/CqHtA24ERZkGZC/aFfu62WP2gPRkwXQSm7n8Itf5tYUGedrfiWmjsCqdYagOFRJq
         r8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=woQ78Cv5MbrmOzXRr57dM4FopiomlSeZvKoUqFf81qk=;
        b=cMT+bkmFJPLH8luV3r6jn6iXX+D0tU59Jx8VVl/IQoX4LSVvWsu5LLbrEpkBg2PYV/
         XDkF1bei/Y9Y2nl+sG7iaaZL8u2hVjPU71I9hJMm17osRKd1752J48Hvps0lvFN0hS5L
         uD81jqiPw/XbZIUw+JMuywn+FYxwXVmdRab2t8EaM/C7eTYrvdlJve1kIYNM2EDcRr9J
         G2VKniz3EdrQV4+UPvkCNMiS6r4NlS2naBFMxmQN2XpOlkfRDMZy/bpJ2ePBbqpJVQuL
         xkaYA9TLxuJbkGm7slnzKdzKCTyFIHFzvjsK1qziNCpqphQSHpTJlz1dOZXu8hHOg6Zw
         KlGQ==
X-Gm-Message-State: APjAAAVIHri6MSAWiz2ob/al0osi+IlMXlWVngVVzipooUVlbxfQpvzW
        vSGm5LRm0mwSwOgsfpVpegLDK1bjEw5wVkIyTIiBgg==
X-Google-Smtp-Source: APXvYqwr8vXnzIzOB9Ma6fpbr12D0teNaWREbzSwiNpY6obLIHr8eoc7QtlaNYVMnyfVWRbDZvyHLp53nKkxGjm8sK4=
X-Received: by 2002:a67:ee04:: with SMTP id f4mr20449446vsp.34.1556187105071;
 Thu, 25 Apr 2019 03:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190425090413.10700-1-ulf.hansson@linaro.org> <CAJZ5v0jxGcFu-aqvyR4UgjRuCwB9q9fZCiXf+D3NL3TJ5OVEPA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jxGcFu-aqvyR4UgjRuCwB9q9fZCiXf+D3NL3TJ5OVEPA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Apr 2019 12:11:09 +0200
Message-ID: <CAPDyKFqP+92wwscW2V3352DVS1QM=DjMZ3e0uty1eQ4=5JyHWA@mail.gmail.com>
Subject: Re: [PATCH 0/4] PM / Domains: Improve support for CPUs in genpd
To:     "Rafael J. Wysocki" <rafael@kernel.org>
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

On Thu, 25 Apr 2019 at 11:56, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Apr 25, 2019 at 11:04 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Recently genpd was extended to cope with devices belonging to CPUs. However,
> > attaching CPU devices via genpd_dev_pm_attach_by_id|name() doesn't work,
> > because of the virtual device that genpd allocates in this path.
> >
> > In this series, this limitation is addressed, together with a few other related
> > fixes/cleanups.
> >
> > Ulf Hansson (4):
> >   PM / Domains: Use the base device for
> >     driver_deferred_probe_check_state()
> >   PM / Domains: Drop unused in-parameter to some genpd functions
> >   PM / Domains: Search for the CPU device outside the genpd lock
> >   PM / Domains: Allow to attach a CPU via
> >     genpd_dev_pm_attach_by_id|name()
> >
> >  drivers/base/power/domain.c | 73 ++++++++++++++++++-------------------
> >  include/linux/pm_domain.h   |  1 +
> >  2 files changed, 36 insertions(+), 38 deletions(-)
>
> Are there any dependencies between this and the series you've recently posted?

Yep. I should have stated that, sorry. This should be applied on top.

Kind regards
Uffe

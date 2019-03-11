Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1B8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CA32075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j560akXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfCKLLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:11:38 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:34024 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfCKLLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:11:37 -0400
Received: by mail-lf1-f46.google.com with SMTP id y18so3098386lfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 04:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vS3tq15BOXycmG+0L9dL95AAn3SmMTT8YFN9HzsBt9k=;
        b=j560akXPXNItuCCagdoSai/cQNc1xV/fUXK1C6Wu+kut8RH2QMo8LaaVpxiRNdXihX
         9JjkS35l4yEkr21PucUsCl6SD6YxvEkd0G76godlcSRuGB+ClsSDrgETKBI+R4QyaLEO
         PlouYcrge5YP3E1jgvCrHWddIXILPiO8GrfTyiYAl1eElIsjSVQoFHGWNFehRP1dnF0g
         VG1gQx/pTaT8nX4rWbcbWpse152FWy3MSmwB1H1/EKlL8k9c15xM0oc7rJ2Nxs8YBwm/
         Q+/J+1VvxKHFG3Uv7Sf2YmFL9Wn4r5RAZgsdU6fCClVy7LLCNOaa/0ni0HxBDL4FvPJP
         CYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vS3tq15BOXycmG+0L9dL95AAn3SmMTT8YFN9HzsBt9k=;
        b=bjrV72kewNDPIAKA8TSdWvUIVbZbmSv0tZ4Daknc+g63vssshSx7x/oG/Gr5+rGrNY
         hMzdOMbyIclb8VmLzmWkRuWF32N8s/U5pm4DaxsJ+TQRhwLB6gZUdD48umfNYDOfoG6b
         jVuUK4/olRDIlOIuweUcYOfk7lPOovrv7o2pcrEJSqQ59yHE0FFfnecPDOscXp6+tdaF
         FhZTZsK4f7um3Fc+b8SORLSNPBDTJMeDiDBKhP/bLuPBsRHv4pdg+6MAjs9/FkIEU299
         Amtjx/oDLN8CuBaH1bARTVgdHx4eH/R3oQ/LgSNIdi4Bb0jlMT8KVDlZYK5/bUU1XdZ/
         wZFg==
X-Gm-Message-State: APjAAAXKnBO8VuNlBNZOHD/fgc0Q8/PhCmQv6oormOm0jkg1G9Vj1UT8
        qGuaQot6exj6C1GKJTPSBDAOme+d+eMBEKb2/hCEbA==
X-Google-Smtp-Source: APXvYqwqW/BADIQvbpWrWQwufv3Vv00aDyRLxOoKWu8RRAk+px2uzRZboHFIiRvjJlDQ5bfnBs3v24K39z02EQjFf0Y=
X-Received: by 2002:ac2:5638:: with SMTP id b24mr417925lff.18.1552302695523;
 Mon, 11 Mar 2019 04:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190107190555.GA18865@amd> <20190311102325.GB14118@amd>
In-Reply-To: <20190311102325.GB14118@amd>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 11 Mar 2019 19:11:24 +0800
Message-ID: <CAMz4kuJznvDiU8-mL=gS3NEJ1Q=4KP+uHq6B3jQsbUUrbHzXRw@mail.gmail.com>
Subject: Re: 5.0-rc1 Open circuit voltage tables -- 3afb50d7125bc
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Mon, 11 Mar 2019 at 18:23, Pavel Machek <pavel@ucw.cz> wrote:
>
> On Mon 2019-01-07 20:05:55, Pavel Machek wrote:
> > Hi!
> >
> > Can we do something with that code?
> >
> > First -- tables should not be necceessary. Formula for li-ion open
> > circuit voltage is well-known, and does not really depend on the
> > device -- only on the chemistry of battery.
> >
> > state of charge = f( voltage, current, internal resistance )
> >
> > (And yes, internal resistance depends on temperature and health of the
> > battery).

As we know, experiments had proved that the OCV had a steady
relationship with the state of charge for a given chemical
characteristic. So many companies' charging method will use OCV table
to look up the initial capacity of the battery according to the
current OCV value. That's why we introduce the OCV table.

> >
> > Second, even if we need tables, why is it doing multiple allocations?
> >
> > info->ocv_temp[index]        = -EINVAL;
> >
> > That's just wrong. Ocv_temp is temperature in celsius. Temperatures go
> > below zero.

This requirement is from Qualcomm. Since they have multiple OCV tables
in different temperatures.

>
> Ping? That code is just bad. Does someone care?

Sorry, I missed your previous email.
--
Baolin Wang
Best Regards

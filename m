Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD90C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FCC2083E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="camv0H9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfDHSo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:44:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44073 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfDHSo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:44:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id g12so7812996pll.11;
        Mon, 08 Apr 2019 11:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bVAjgFRmIyj6wQ5uSPVj7Ju/xEC2MZoI/4rYPWvDzHc=;
        b=camv0H9URV59ejKp70nQ9u4O+hune+ty8l4ZlQlNycUlolFONNvVrfhKjCGOZQfZDh
         oWlEa4Hq9G1bnFyoRuKiy+w47imus3RGP6y5cpwqWWHJ+EUclCxVQ46ZUC02ifAEZFvC
         Ety0N9LsA9hzeXprUHkQx9kbSv2VnomewbzWqQ43Tahb7Bd46tX4cLhKuDzCixVzyLKJ
         drRLIefrfdiGTphj9ZC2VUgNkkXi9+Y4mjK9lzZGBUs07hq0XqYwU2zU8/FKSeZXd4Ue
         zFGyOyBeeTW+mG7A89lfcx6E2lNA5qexnj3Qet/1yfQr6twMcfEJS5cqJL4P8ab07JTR
         AsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVAjgFRmIyj6wQ5uSPVj7Ju/xEC2MZoI/4rYPWvDzHc=;
        b=Op2w8KRiAhHdPEJhmMNiuDQXQ0ga8QV77dOYD+UEiSVgLNXNY877N6zaMSGtqbZl6o
         xD9AKgt+EIFITIaYpGNyHgQogYbsyvMent1uLpZSWOZDHcgHRHIUBagHcNlqW5D9Dvkz
         oLbaX3g63UcnWVsBB5vxICtzZX7J2DKyL2aw1T974xEXcMFXU2EaH173bUo/Sj082+eG
         CV9euYr7e7NSyQEvjBpDDYtAbBoOzunEriirebEsSUZHRyxnnV+mubmsw5PGn68gHEzv
         eJSQnFMqXSdw//+hK/+MvZs59sUtV5Vdzq+Ki1VVd9M++7WoJJizntupg7jV1JPulUQg
         7sfw==
X-Gm-Message-State: APjAAAVxNPKHfOvj15IskKcYvUCGkN6AQaQ1m8bzfBOVlqCAV4NOl4nB
        pnLiEUdwbunSNgImxMs1dNnK+aPD5hYzPNBQ32I=
X-Google-Smtp-Source: APXvYqyIcCPXFC/hx9CShRiq9RQj6ASj4C0TzGG+U0r30VH4PSQTy5sEfVAMlZQaCdYnvAJFIgzqgtRAO+yuFYqqnv4=
X-Received: by 2002:a17:902:2c83:: with SMTP id n3mr30862414plb.281.1554749095743;
 Mon, 08 Apr 2019 11:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190405203558.19160-1-rajatja@google.com>
 <CAHp75Vd+_aFxomzPP_-8y5D1p0crbYo6R+=7fGGOKW86D2+=CQ@mail.gmail.com> <CACK8Z6HcqsRxRNGhN9sTRGp5kx=kVCTgqL_cVGy_Tznu=gL6jQ@mail.gmail.com>
In-Reply-To: <CACK8Z6HcqsRxRNGhN9sTRGp5kx=kVCTgqL_cVGy_Tznu=gL6jQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Apr 2019 21:44:44 +0300
Message-ID: <CAHp75VfdE0upv1=HbNs35fcozTY6kXGpLt4tTAMVRDQZ90GHtw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] platform/x86: intel_pmc_core: Convert to a platform_driver
To:     Rajat Jain <rajatja@google.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Wysocki <Wysocki@google.com>,
        Rafael J <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Furquan Shaikh <furquan@google.com>,
        Evan Green <evgreen@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 9:43 PM Rajat Jain <rajatja@google.com> wrote:
> On Mon, Apr 8, 2019 at 9:51 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Apr 5, 2019 at 11:36 PM Rajat Jain <rajatja@google.com> wrote:

> > > +       switch (boot_cpu_data.x86_model) {
> >
> > I didn't get why this should be boot CPU?
> > Otherwise, leave the structure and leave the x86_match_cpu() call.
>
> I didn't quite understand the concern. The x86_match_cpu() also uses
> the same boot_cpu_data that I've used, am I missing something?

It's a detail of implementation, and instead of continue using nice
helpers, you open coded the similar.
Why?

-- 
With Best Regards,
Andy Shevchenko

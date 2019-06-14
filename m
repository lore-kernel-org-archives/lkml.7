Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703BCC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9DD21473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560518861;
	bh=ea08hvvFym2BqK0H+7qsxpRl3vGfVmwnYVFKyXYmfU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0hIbRiaEsl3W6l5bfuEdgp8OuTVCjyqaMtg1LeMBu+5Y42mJrUWB5oCe//6OQNmVl
	 fkTkWMW2Ggyr4i+NfSbpfOjti7rv2MArBfPcEZiYHSbNy+TwcaydDxI524xbOtyAB+
	 1mK+sZLvULAxPUQQjv47J1W+ru8HemmnmkU75Wuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfFNN1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:27:39 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46630 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbfFNN1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:27:39 -0400
Received: by mail-oi1-f195.google.com with SMTP id 65so1911654oid.13;
        Fri, 14 Jun 2019 06:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yo5M/62c1VWnHHchUf/18xtrzwn4K+cBzYArn3eS/wE=;
        b=eCFUja2kL4Pf7Htd7G8UpROAD9wjSYBflg2I3xkLKgfUh5NJUWlDxOeMKK+JBJAWxh
         12IL+B0zPVYWsdyIkFcBsUvQXH0XKWMToQxALALeVZ69vaZ/C3hvNJhF1veTmew6PIxs
         dPD8ip9PBIq9lVvHayfb4WwxpAJVUVrPx0aoDP5ACptbqXt+anygn9Xo0eByOGrRkQR6
         Qe7fqS+im3JT1s46v3irv2EASImbe1VuBbJTyzF4LguJ4IFxxCENEpWYvCAlwXB5C3Lw
         UEJmdldpcHtCQsgpkpjfOYGeQBq5EsS8CICn4EbpJAmIUOhIBBhoTfXC5gPCmyNkNkln
         c+KA==
X-Gm-Message-State: APjAAAV9aReLyG2R4E2LeVIKLImNU6aCwKZOIl5NMFq4626mAP95FWsP
        q7dyEj5G1WwzhFwaOiBzWe9ck0T02USDoXAh8RQ=
X-Google-Smtp-Source: APXvYqyrbvXm6KAxzVwYxHfUU+xwcdonSMTGkAdKWJ2RtMICDSE2DmK9NZiMC0hTqufaz5rm60KelQOQlT9gG+xeKr4=
X-Received: by 2002:aca:f089:: with SMTP id o131mr1890388oih.103.1560518858527;
 Fri, 14 Jun 2019 06:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190516193616.252788-1-furquan@google.com> <13361760.nMXA0SR1Mq@kreacher>
 <20190614104511.GC2640@lahna.fi.intel.com>
In-Reply-To: <20190614104511.GC2640@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jun 2019 15:27:26 +0200
Message-ID: <CAJZ5v0jRoajC=P9nGvi1bF8EwO5yShpeqtFSpdEm5aftFoLRqQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Clear wake-up device GPEs before enabling
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Furquan Shaikh <furquan@google.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 12:45 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Thu, Jun 13, 2019 at 10:24:41PM +0200, Rafael J. Wysocki wrote:
> > This patch may cause events to be missed if the GPE.  I guess what you reall mean is
> > something like the patch below.
> >
> > This should allow the kernel to see the events generated before the GPEs are
> > implicitly enabled, but it should clear them for the explicit users of acpi_enable_gpe().
> >
> > Mika, what do you think?
>
> Looks good to me. I also tested this with two TBT systems (Skull Canyon
> NUC and Dell XPS 9370) using ACPI hotplug and it did not cause any
> problems if I boot the system with device connected.

Awesome, thanks!

I'll add a changelog to it and post a full version over the weekend or
early next week.

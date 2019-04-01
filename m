Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08714C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24E420830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554111192;
	bh=KoLf12P/3akoOcOl92930vTedsno1qa4W37ItMjpWP0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kjmGIhhQio9fWjnWy8kbmKoJ/EQ9zbFWkSKnI+zY10G1ftAgRpfXmKvIOhKcKhiAx
	 beJ+cWt6eC04yCD+qLJ+5agvwTzxrLWD7dryleqnX0yyoyy2tThe4+lq7CHjVp62ze
	 gSz25lkPeaEKV88O3JW6PmPcKkKmAjownCu0PStc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfDAJdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:33:11 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42010 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfDAJdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:33:11 -0400
Received: by mail-ot1-f66.google.com with SMTP id 103so7888205otd.9;
        Mon, 01 Apr 2019 02:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KoLf12P/3akoOcOl92930vTedsno1qa4W37ItMjpWP0=;
        b=QfHMtIrfAiFNJAvfk/esYrLjv8SOtgKnkdDZV3ZrXK/3ojpvJ1c1fN776A+e1myDEg
         Xsl81bp1P5VxXefRP+2SU2mqxwhR4eMWm0LmG6cJewo8OadqSH4yTz2SRHpn6mmLEEPg
         7n4nPYLqIK8RFb9jq68/t/2R/aYCvagohBR0GscBCxzRbjJyxfrYx9F5zAtfju1XoiVy
         G/eXEp89WWiYURSqzuD3KK9nADAfdZqMvrjhWZvP/v02pper41y8RjXcfvNMDQRvw5Nf
         DYV+jP48GeAcKf/Mj00jLY/yXjW5Bp3tqRZVehEFJ0XaUahCSZ9I7CU7wkNfRLLUfxiU
         cEug==
X-Gm-Message-State: APjAAAVgs9HyJYoNKmz8+xeDmBNh3usRPcxRs1Q3XvxVOiA9r9+pFXZe
        uGHS1iHDOSwIUN8YfTYVzRmIXxPUp8lkEuHAB20=
X-Google-Smtp-Source: APXvYqydZvSb6ju6YfJ6+GXYiaGGlYUFzEPI/6kdI5KuPWKCePAibw6cqRUojuE9w1gBMlKI7cmehP4K5Ri1rcDkP6w=
X-Received: by 2002:a05:6830:13cd:: with SMTP id e13mr46038615otq.139.1554111190363;
 Mon, 01 Apr 2019 02:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190330112022.28888-1-bp@alien8.de> <20190330112022.28888-6-bp@alien8.de>
 <CAJZ5v0hDyx6t8UXj=tO78YUTMBqmdnNWEjs4SVwBoJya9pHu4A@mail.gmail.com>
In-Reply-To: <CAJZ5v0hDyx6t8UXj=tO78YUTMBqmdnNWEjs4SVwBoJya9pHu4A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Apr 2019 11:32:59 +0200
Message-ID: <CAJZ5v0gfqOB8r0dvTf3uRSkJCNOLYPe9qLaUV1BLGjTanmMbvg@mail.gmail.com>
Subject: Re: [PATCH 5/5] drivers/cpufreq: Convert some slow-path
 static_cpu_has() callers to boot_cpu_has()
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 11:31 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Mar 30, 2019 at 12:20 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > From: Borislav Petkov <bp@suse.de>
> >
> > Using static_cpu_has() is pointless on those paths, convert them to the
> > boot_cpu_has() variant.
> >
> > No functional changes.
> >
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Or I can queue it up if you prefer.

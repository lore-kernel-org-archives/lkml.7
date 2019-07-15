Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C81EC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46862086C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="e4FGYwqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404893AbfGOOvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:51:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40457 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732151AbfGOObg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:31:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so17329565wrl.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 07:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/kOuHIwdV1cmMgDdELPfBrpuX2BOQd/yGACKLJjUP3M=;
        b=e4FGYwqAaI4jLb4Z0KPbQ0yK1YMlM/CILrvUEl+SG3ooRm6VM2lnqwzf3NldmberP9
         6HwinXj0gqjPCOxdGUz2/1FKdYuIESyshiEu8Dda6Egk0TaNUelDsdVp/b/O+vuqQ/Sh
         lFafZYsYtewywPdAPJ/xnWCBhy05gJuEptPRhYuUWvKA8A3tk9+ULP4AhQk4pHND7FyP
         kt9rvOZpBhkYH3EaxEjHKiR3btyAx9dfJE1M9KvSP5GfyFAZ5nnFon+X7brtFooBjw7r
         xYjLFO+GcbP22eIB4t2rSTyO0iioQXbWkj+EWs0j1OL4Mc5seuzg2xcGvywE603taiho
         eQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/kOuHIwdV1cmMgDdELPfBrpuX2BOQd/yGACKLJjUP3M=;
        b=TcU9XZ1D/orsWzHnx/gtUkXP5JgIuk5gfL6dLxCmHvjiCErrequ+amBNo362DZAsws
         3FxHb2ouz2+glhr7ZCE5OfLfRobGYdBvSCZtOG3ke3Jxc+jzuRzptri3gTDfa7i/xlhW
         0USg8yDnca6/lOvvrmHFbKW/sUOjm/FWWY5JU21Fk1r3kRUw11Tn5lNQB+Rj4Y2VIC7h
         6inJswNyLBDCovonblB77lL4IBQhkdh50PpaWwYiOOwTWxijzRprxIH1/u7/+MYPI62s
         sXz8OygZflR/owZJ6+QLhVABTeaBjqLj0+qYt4oX7lJK6G/FNUe/2TxfN1GWQ7xpFXuh
         UEUA==
X-Gm-Message-State: APjAAAVj4gbnBKb0iQW+IjBrbWKof42ChGI43O10pop0tvgPE3T1qVnt
        eSPP4QxG7vmqJhzBB8tStjXO11vWZJ/Kq+9hsGjwnw==
X-Google-Smtp-Source: APXvYqxEFYaVkFCKSYyYJRZ9VyyeeGht77z9ZnbIbaqpGuILzPfl5OBcTvCYx1mkWojen86iw2roVhpWZPHBCOougv0=
X-Received: by 2002:adf:f28a:: with SMTP id k10mr30519437wro.343.1563201095116;
 Mon, 15 Jul 2019 07:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190715142109.3063-1-ubizjak@gmail.com>
In-Reply-To: <20190715142109.3063-1-ubizjak@gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 15 Jul 2019 07:31:23 -0700
Message-ID: <CALCETrXQaayeV-6n_2dycMo7ienQPizTqYQDEAy1C2KLPrCt8Q@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu/intel: Skip CPA cache flush on CPUs with cache self-snooping
To:     Uros Bizjak <ubizjak@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 7:21 AM Uros Bizjak <ubizjak@gmail.com> wrote:
>
> CPUs which have self-snooping capability can handle conflicting
> memory type across CPUs by snooping its own cache. Commit #fd329f276ecaa
> ("x86/mtrr: Skip cache flushes on CPUs with cache self-snooping")
> avoids cache flushes when MTRR registers are programmed. The Page
> Attribute Table (PAT) is a companion feature to the MTRRs, and according
> to section 11.12.4 of the Intel 64 and IA 32 Architectures Software
> Developer's Manual, if the CPU supports cache self-snooping, it is not
> necessary to flush caches when remapping a page that was previously
> mapped as a different memory type.
>
> Note that commit #1e03bff360010
> ("x86/cpu/intel: Clear cache self-snoop capability in CPUs with known errata")
> cleared cache self-snoop capability for CPUs where conflicting memory types
> lead to unpredictable behavior, machine check errors, or hangs.

It looks like this won't affect the SEV code paths, so I'm not
thinking of anything that this will break.  But Dave and Peter are
much, much more familiar with the messes this could cause than I am.

--Andy

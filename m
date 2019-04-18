Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4DCC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01700217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555616187;
	bh=VSkZFn5lWbUaE5ITrDz6UFsYlr69UKzItJpM0IIWuV0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w7jYRcbkrC2U0OIjcyG385vQp0zymnQwH2vZzVptOoq4Zn6/KOXY4idd0AcNTEUFm
	 5H/YhYU4x6YXi4RsCd6ze8g1XIYu+7gYKWHJIq3ksgyw9mrS4gUi4Eo6RAGck3nxN+
	 01UhGOnPiCqhUyud4kHx2+/3Qccn7nZi+HqfhqPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390008AbfDRTg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:36:26 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34976 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389944AbfDRTgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:36:25 -0400
Received: by mail-oi1-f196.google.com with SMTP id j132so2524907oib.2;
        Thu, 18 Apr 2019 12:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSkZFn5lWbUaE5ITrDz6UFsYlr69UKzItJpM0IIWuV0=;
        b=lhw+I6Xi5cgpdDAbJAneKn7cZbKU03AmNwu+TMzXtCWZSI2/OT6aKfebVBtdL83z09
         8tJJxx6QdhUFM57ct+wU4IC6b2XWx7gwWrar6+ZfS3RIhF3VdPmybDzu+Vj1bRuzltsr
         m3uiKh5o3vV7q/5zZAVyCMxtQnwcwZLc03ioqAFI2L1znVtpR2lZrJ/V+QDyAQnyxucF
         n3h3kU9cVTtBipqr+aJlm4x8wZh7Z30V9p9Is3zyZ2uoWJ6vc1tPACbp4gkLFcdL0hYA
         +hTO6SmUo3BMxOxpqpHEsr9POkYchyMqW0rxFg2d4jiHGNEGXW4rgVvOuO2t6YTvbY/h
         56IA==
X-Gm-Message-State: APjAAAVdp4Nq8ZgoFaxzRoF7IA1gRPjJCCNVDjd6hCaxUpBWAtHTw2fP
        PvZUQRTJYlm+x63RfTnCTbyMsNVwUoIouL6N/7c=
X-Google-Smtp-Source: APXvYqwqFFED/5rtxPODJXMeXE0jqlJ8yoysdwbmqm77gl5QtMcQVbg+cgKi0pM4mInga+2FzHIKhJ1uIto5+YC08Is=
X-Received: by 2002:aca:b841:: with SMTP id i62mr3351667oif.103.1555616184853;
 Thu, 18 Apr 2019 12:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <38900622.ao2n2t5aPS@kreacher> <20190418184040.GM27160@zn.tnic>
In-Reply-To: <20190418184040.GM27160@zn.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Apr 2019 21:36:15 +0200
Message-ID: <CAJZ5v0hyu5WcL2F-Vz8mGOjwGwEGzpeW-Agh+Gi1W6pomaZqyg@mail.gmail.com>
Subject: Re: [PATCH] x86: tsc: Rework time_cpufreq_notifier()
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 8:40 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Apr 18, 2019 at 04:11:37PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > There are problems with running time_cpufreq_notifier() on SMP
> > systems.
>
> Just a stupid question: that must be some old rust you're fixing because
> we set X86_FEATURE_CONSTANT_TSC on almost anything that is x86 nowadays
> and if that is set, we don't reg that notifier call...

That's totally correct.

It's never really worked AFAICS and even so, then by accident.

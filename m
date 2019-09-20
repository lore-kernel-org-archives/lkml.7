Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2640C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBEA218AE
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569022776;
	bh=4HiXLY7SR+iAroiaABOE6W7gGGt/ONbMyy8ANXwOep4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lM2XQmnkRiWl+VpvdrqCsVftLTFoIVatMl1O4IdL1WcqE6UwoQLnHvPKoBdIJCgws
	 k+0lPM0+rttOgh4jYKjNiEvqv77u+oNJcW/NLPl8NmmiFsDJ/KI/dAOnNjVaHzuSfs
	 mtR9K3CLLQ/S9M9e47aAew/BtT2BWvJptq6HLOXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407171AbfITXjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 19:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404477AbfITXjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:39:35 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C76E52086A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 23:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569022775;
        bh=4HiXLY7SR+iAroiaABOE6W7gGGt/ONbMyy8ANXwOep4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TiaMcIuGGLxPrOEAFlEHFcZlY+qvCuwR3Tv5RLwWD12MBqXhwYI4rAlcBvKkqj3qs
         P8rZaAUJJJvXe77eDw6atNAmSYg0RqipnbylR3+On+Ls/n6RkFVJkoCND2qw8Jkk4C
         EBENG9ZdejpTO41gWG6PlV2mrNmYgU3hurWjUSbw=
Received: by mail-wr1-f47.google.com with SMTP id b9so8390191wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 16:39:34 -0700 (PDT)
X-Gm-Message-State: APjAAAXv7Sw6PL/RwFYmMbXjHrZhIVCqayo2C/7zeWWuMKxlrM2MhQyf
        EY912N5Xik+J2rwdTExBhxbSqnKrih8v2RZpYMX9lw==
X-Google-Smtp-Source: APXvYqyttEaTBTtUv9CZjWf1dwnYpF+MAvwz70YHeSpaqrhzWfqT5ojsq0XrDIeFVEc/vxF0bimTJcWEcxSbUxwu+7o=
X-Received: by 2002:a5d:4c92:: with SMTP id z18mr12990388wrs.111.1569022773387;
 Fri, 20 Sep 2019 16:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190919150314.054351477@linutronix.de> <20190919150808.617944343@linutronix.de>
In-Reply-To: <20190919150808.617944343@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 20 Sep 2019 16:39:22 -0700
X-Gmail-Original-Message-ID: <CALCETrWHkRiXx_r8x6k=ArxTZc5YS0DewMQDVHFrjVY3Xt+H7A@mail.gmail.com>
Message-ID: <CALCETrWHkRiXx_r8x6k=ArxTZc5YS0DewMQDVHFrjVY3Xt+H7A@mail.gmail.com>
Subject: Re: [RFC patch 02/15] x86/entry: Remove _TIF_NOHZ from _TIF_WORK_SYSCALL_ENTRY
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 8:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Evaluating _TIF_NOHZ to decide whether to use the slow syscall entry path
> is not only pointless, it's actually counterproductive:
>
>  1) Context tracking code is invoked unconditionally before that flag is
>     evaluated.
>
>  2) If the flag is set the slow path is invoked for nothing due to #1

Can we also get rid of TIF_NOHZ on x86?

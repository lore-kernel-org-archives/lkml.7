Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AA3C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5DF20657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558029494;
	bh=o9uu3jc1SYVeRIrQY0mM3pGZJsoxn3Zuc4M3TNtGSFQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tHgD7zMe/hoPgZGVV7kLGlg36+5sPd4g6YyAib8gKtH2LEyv/zuFR36Xr7dQsxW1r
	 07cskfaeqUhYbJ/MPSl/VxyKWL2bDi5QPm6ADeLl1ToJv3qChyzEn7Jq3X63rYGANl
	 vMrmHqJqymGx/P59RKI064KEuLbMFmYIPfRChI2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfEPR6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 13:58:13 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:45694 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfEPR6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:58:13 -0400
Received: by mail-lf1-f44.google.com with SMTP id n22so3299867lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0/jD9z0ZN/51ank2Z04vMZo0I847Lvb8NBW8oztmHrE=;
        b=Ht8rs2Sb2xKw8C+nJGxSHbIJ+GwyzI94D2caymNWJdsOAUX78udJIiIBbnR4txPB8u
         q4mbp47ywXzX2sypuulNZJgkGU4owYEIz3x1FePSnMcCHCDej0Qe9jq9sAaG49U5mlXX
         oPLUqR/fEsTw35zzD7S9mtJ4PJsOsfVkrSnJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/jD9z0ZN/51ank2Z04vMZo0I847Lvb8NBW8oztmHrE=;
        b=gtYNcWHYugYNSb9/EQAl3p4tyiP67YxxnB5KAO8q3AZ6pgvB+L6rC+tBhcGrDpbNN8
         Nry6sf2tLAtdw+DqEaCWryOIEtIvvb1aY1Q6fQdZ2MlgSee78cHyYe8P1DV77RbzrlhB
         Dr2fQb4rS7RaV4qlHb/4QpQStxHElOFe6fVQUBWcU3ntbUKtL0hvMq6BnmhFzNUFNa5c
         pjsfqOGsuxTurTbocMCKVAbzfWlDBWPM1c88J5L8sAsyLwJx9f7JOuT3LcBb5ZlmmoVh
         a62ioLwlAKB8nmrpt3083muySJZcGELVYoR+56XUSjj3Fan9Iexhr1pjR0rF91xzXp1R
         MnBA==
X-Gm-Message-State: APjAAAW6GWu2ol4lUvyyRq6xXZjqQWxBs8tOnPp9hcpSDmV3qLRdxds7
        GTPP8hXm0NeJwmYxIonCjzXCc+Sp7eU=
X-Google-Smtp-Source: APXvYqzMRPjgQoGqrqLMO6VQO6F6dbpGgSqpbs9NZ7F6zTt+Qgd8vZ9HW164UPJef8dZmqAkSlLO0Q==
X-Received: by 2002:a19:f705:: with SMTP id z5mr24503996lfe.164.1558029490919;
        Thu, 16 May 2019 10:58:10 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id k20sm1082990lfm.30.2019.05.16.10.58.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 10:58:09 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id u27so3312022lfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 10:58:09 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr24482260lfg.88.1558029489242;
 Thu, 16 May 2019 10:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190516160135.GA45760@gmail.com>
In-Reply-To: <20190516160135.GA45760@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 May 2019 10:57:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgtHi5mT7y=0ij-AksQQOBQJqV1apk2bRaH2tfRTxyFcg@mail.gmail.com>
Message-ID: <CAHk-=wgtHi5mT7y=0ij-AksQQOBQJqV1apk2bRaH2tfRTxyFcg@mail.gmail.com>
Subject: Re: [GIT PULL] locking fix
To:     Ingo Molnar <mingo@kernel.org>, stable <stable@vger.kernel.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 9:01 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> A single rwsem fix.

Side note, this one isn't marked for stable, but I'm hoping stable
picks it up just from the "Fixes" tag.

Stable people, we're talking about

    a9e9bcb45b15 ("locking/rwsem: Prevent decrement of reader count
before increment")

that I just pulled into my tree, and needs to go in 4.9 and later.

              Linus

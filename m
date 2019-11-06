Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921DFC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B40217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MbWsBt9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfKFWx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:53:57 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36223 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfKFWx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:53:57 -0500
Received: by mail-io1-f68.google.com with SMTP id s3so133080ioe.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 14:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWwP0m6SqLRG+rteRbiBDc7/QsyVICBLBoO7IhUEkA4=;
        b=MbWsBt9JRPefZXp4V7YBgwnLmXu5L6g7ZNW4e3Yn+vtZpGUlfyipuDo4DhTpUiiIYE
         GWWtNUzW1i1cuB1GJAS3g1enLp0/xfCQ35eRURv9PJ4q8gPnHCy5RHlqzVPqygJSNTdT
         VP4EDnY69Vlpky3sSUUgz/4induxxdpMquyLMChBNluyDN/XT2OuXlIeSJnGkGf+NDm/
         Qf23ZtWfSG4vyO/TkZ1QfW8oCqvoU62SZA2+ViaWDxyfrz23Pb2N49hwwp3f1YsafcMs
         VfpFMwViiZoC8o/v5M5ab8IfX/NeMYFwOvQP1RnOBO9HI8JRh0hTRNnK9CyPWwoAvY7t
         A/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWwP0m6SqLRG+rteRbiBDc7/QsyVICBLBoO7IhUEkA4=;
        b=YSDVXjAWwJTuB0R4Sem6QQ0CTLQypvoLlHLnasp1Anvh1QQSBCCTCQqJJYDsJ6n9Xl
         xmMKS1stttiI7OyCeKX5Nqn2OcjJprYkwEo4zNJR/7LBsBLfDERRi8IqEVde0e9rrfRb
         dk++EclMzh7L+1aVWaow7/cKwaudL1taKaUSQoIy6vTZyhdu3JAzNVTHsHMED6yMo3nE
         OkEker0xXXZfKgxOEKsTjAWU515yaHWMGKFee8ZTWn0iS1NWNvTXu38ATC+l8BxGcBr2
         B7pltHasdwnfoaJmkYegQaCggL+2Vf5xWeF2fxpHp4MujGttz9EG5bPgZElXmxOrJCEl
         7dqQ==
X-Gm-Message-State: APjAAAUso6PZARNLlqakZ4WQw+yyICXWd2cfpnGh+A6mEj893KG1pw2Q
        MwKmlBfw9GbBt46emLuKm56IJBNQxPY2TASC5P+OAHRXiGU=
X-Google-Smtp-Source: APXvYqyNmeXLaksAr8Nl2Pam7oHSAtHGxBjGGzGx56rn/KBJsvcEm3oHyZSfK8yscXJ3Fkkfrs0LIJyLln81Fn3KcWw=
X-Received: by 2002:a5e:8e02:: with SMTP id a2mr64653ion.269.1573080835360;
 Wed, 06 Nov 2019 14:53:55 -0800 (PST)
MIME-Version: 1.0
References: <20191106174804.74723-1-edumazet@google.com> <157307905904.29376.8711513726869840596.tip-bot2@tip-bot2>
In-Reply-To: <157307905904.29376.8711513726869840596.tip-bot2@tip-bot2>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 6 Nov 2019 14:53:43 -0800
Message-ID: <CANn89iKXi3rWWruKoBwQ8rncwLvkbzjZJWuJL3K05fjAhcySwg@mail.gmail.com>
Subject: Re: [tip: timers/core] hrtimer: Annotate lockless access to timer->state
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 2:24 PM tip-bot2 for Eric Dumazet
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the timers/core branch of tip:
>
> Commit-ID:     56144737e67329c9aaed15f942d46a6302e2e3d8
> Gitweb:        https://git.kernel.org/tip/56144737e67329c9aaed15f942d46a6302e2e3d8
> Author:        Eric Dumazet <edumazet@google.com>
> AuthorDate:    Wed, 06 Nov 2019 09:48:04 -08:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Wed, 06 Nov 2019 23:18:31 +01:00
>
> hrtimer: Annotate lockless access to timer->state
>

I guess we also need to fix timer_pending(), since timer->entry.pprev
could change while we read it.

I will try to find a KCSAN report showing the issue.

Thanks !

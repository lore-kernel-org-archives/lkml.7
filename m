Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C25C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEC020820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LNdEkqpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfDJVpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:45:35 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42068 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDJVpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:45:35 -0400
Received: by mail-vk1-f195.google.com with SMTP id 195so914065vkx.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLagPqpW6N4N+Gd1dB6X7RAlxw+g5UzytWoDGPzoeEo=;
        b=LNdEkqpBhz5JiVYitnNU1MNMalLwJ1yZKUWlYPzBxefSZyOAmsAlcHP70FssuQoNj5
         +KlNO7QPOHpZ9k9ptwss5NKl6OZEismMr1VUs4Imv07dY3uZgTB80mVp9kCOiAOLnDTV
         mpA2Eq4sqmLX3s3MSjTS7OZRY9i1VqbBDHcOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLagPqpW6N4N+Gd1dB6X7RAlxw+g5UzytWoDGPzoeEo=;
        b=IoAyVnSa2mQL0SnFCLJMFG5KAuW1u0iDJJEjtdIRH3CuxbDB7FxOuXFuj0cxVKeU4N
         DcSAQScqPeFGrVfCAGJhLIuZs0AcgudMxW5sYhE6gtJLjSWmNec1sJ/2jYsvZ1Hc37nT
         NCQQKy0nionW1d71cf0lE3aUliFQylB99rvkZi5uSMQzLilwrjpd6Ub7+FTuftw8oNHB
         PgdTVmO9ksTjw3UY+reSRCLBo21Teovm5bq0/3iEKoSxgXeMf69lG/DllmZn221LcVkD
         p1Cki35Ur1Qx/VT1FzFifaZZmcgeROoNYmnAs9wozBs9Iw5P+p+CSniWOCsSio98sNmR
         Aafw==
X-Gm-Message-State: APjAAAXXU0lYLGzHYZGcZbajCYofQU8zHELRcTiAyBvbXfEVZCc1AEKf
        B732oPPLiQEaKtjLu4VBxu4AoDZF7DY=
X-Google-Smtp-Source: APXvYqxxFkE0l+C+82O9LQjwYZQoEy4eIGMeBpJOm3DMYlWdx94HWTxa6QeDg/05wS5Dfbf1Y/ATgw==
X-Received: by 2002:a1f:c288:: with SMTP id s130mr24747051vkf.0.1554932734017;
        Wed, 10 Apr 2019 14:45:34 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 2sm15689684vke.27.2019.04.10.14.45.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 14:45:33 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id c6so1328888uan.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:45:32 -0700 (PDT)
X-Received: by 2002:ab0:4eaa:: with SMTP id l42mr19349710uah.80.1554932732261;
 Wed, 10 Apr 2019 14:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190410212627.29514-1-okaya@kernel.org>
In-Reply-To: <20190410212627.29514-1-okaya@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 14:45:21 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+uBuPjDc+gGcxW_QoJJi7sQZ8m=Zg-Q2wKDxyTt7yGvg@mail.gmail.com>
Message-ID: <CAGXu5j+uBuPjDc+gGcxW_QoJJi7sQZ8m=Zg-Q2wKDxyTt7yGvg@mail.gmail.com>
Subject: Re: [PATCH v1] init: Do not select DEBUG_KERNEL by default
To:     Sinan Kaya <okaya@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 2:26 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> We can't seem to have a kernel with CONFIG_EXPERT set but
> CONFIG_DEBUG_KERNEL unset these days.
>
> While some of the features under the CONFIG_EXPERT require
> CONFIG_DEBUG_KERNEL, it doesn't apply for all features.
>
> The meaning of CONFIG_EXPERT and CONFIG_DEBUG_KERNEL has been
> mixed here.

I don't agree: the point of EXPERT is to show _everything_, which
means DEBUG_KERNEL should be selected to show those options as well. I
think this is fine as-is. What is the problem you want to solve?

I think of it as low (nothing selected) medium (DEBUG_KERNEL) and high
(EXPERT and DEBUG_KERNEL). So EXPERT enables DEBUG_KERNEL too.

-- 
Kees Cook

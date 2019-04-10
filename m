Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F6EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8EE20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cbc41JR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfDJW2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:28:24 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41641 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJW2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:28:24 -0400
Received: by mail-ua1-f68.google.com with SMTP id l22so1346128uao.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=py9DFkZ5m5zLcWJvd8evYxYNI1ShdpfFIvA+RxXWoTY=;
        b=cbc41JR7yWrLubHxevjXcNQpf3iMa08wc1IfrMesJCUA26Y05hX5a8KVFj8wrm6Av0
         5Bp3IyvNBgIy+SQFK3v2h9OZgw+arLQ1/DQGk4cQO9yBXXgtek+BV42tqHMvm7C3uTTo
         H9H9wOudLNzKx0RE4NjGtAABtt84zn5n9739g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=py9DFkZ5m5zLcWJvd8evYxYNI1ShdpfFIvA+RxXWoTY=;
        b=Gn+k3r6i4hyGKlwhHpJj8ny5WHndtE0Hm8rhwUpa6CnqqvP5y3orDo37pMMOIE6mnL
         7k6XrLxsmj2x/79aVN3+45L2NE4ZNGoawgBQbgf9ddLuqcC6gYCBeKiYVGJJd5YE1K6A
         dOpJLeOiqJr4Z+ObdPMlEyelwwyoEGbBgujwhm4cNxTUHgk/SMzrHRlb4+802jjUHVuu
         gYpEmWId1ffSREVizb+rDqrU6UXy+3P1p95tzsNdFYyYo/6ZOL5osc7Exx75RUB7zfel
         79ORNNaqLZmFLmQzF/e+iAMg4DsGRlklCbEw7xZKlcoW2xMkA6/ixSir4OGxxseSgj+u
         FTIA==
X-Gm-Message-State: APjAAAVGHC9V4TMvNGufcqcIBEC2x1z5rTCr1h6ZqqU8yvS5bc3ZrPt2
        3COWAOR9t5APxz6IaomRScSXYHktev0=
X-Google-Smtp-Source: APXvYqx4mIzYNoo6QxXaQCocYHLMq+at+HML8LRHLYPpEZKGb1605/Xi7ni1e0DNMmIycEitvc0JYw==
X-Received: by 2002:a9f:2c09:: with SMTP id r9mr22843690uaj.56.1554935302400;
        Wed, 10 Apr 2019 15:28:22 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id y127sm9596194vsc.26.2019.04.10.15.28.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 15:28:21 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id o10so2313264vsp.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:28:21 -0700 (PDT)
X-Received: by 2002:a67:1345:: with SMTP id 66mr24956096vst.30.1554935300829;
 Wed, 10 Apr 2019 15:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190410212627.29514-1-okaya@kernel.org> <CAGXu5j+uBuPjDc+gGcxW_QoJJi7sQZ8m=Zg-Q2wKDxyTt7yGvg@mail.gmail.com>
 <a9508cc3-3385-256e-2f27-c1e0a770ba69@kernel.org> <CAGXu5jLPxUESH9eMm6rvaTVue_9rNEdx+9dcxiV11kgi03jUmA@mail.gmail.com>
 <ac8f52a9-30a4-41fd-50f6-65c8ae859675@kernel.org> <CAGXu5jLsdSsgVmAU57rpBVAYK6-KxEhzDKj-w5-z2c+dsofD-Q@mail.gmail.com>
 <a4896565-9586-981b-06ea-03b0b7c41476@kernel.org>
In-Reply-To: <a4896565-9586-981b-06ea-03b0b7c41476@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 15:28:09 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+Qz4RTeXR8UYqoYnQtLf42QLn5duUue_OmdKQKq7MeZw@mail.gmail.com>
Message-ID: <CAGXu5j+Qz4RTeXR8UYqoYnQtLf42QLn5duUue_OmdKQKq7MeZw@mail.gmail.com>
Subject: Re: [PATCH v1] init: Do not select DEBUG_KERNEL by default
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, Apr 10, 2019 at 3:25 PM Sinan Kaya <Okaya@kernel.org> wrote:
>
> On 4/10/2019 6:21 PM, Kees Cook wrote:
> >> I can go after individual enables if you agree assuming Mathieu will
> >> go after the changes in the other email. Let me know otherwise.
> > How about you split it, but make DEBUG_KERNEL be "default EXPERT" that
> > way enabling EXPERT will enable DEBUG_KERNEL still in the default
> > case?
>
> Sorry, can you explain what you mean by split?

I mean when you disconnect them (i.e. remove the "select" in EXPERT)

> Do you mean move the things I need out of EXPERT? or something else?

So, for example, this:

diff --git a/init/Kconfig b/init/Kconfig
index c9386a365eea..7ce4a60ab3e9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1188,8 +1188,6 @@ config BPF

 menuconfig EXPERT
        bool "Configure standard kernel features (expert users)"
-       # Unhide debug options, to make the on-by-default options visible
-       select DEBUG_KERNEL
        help
          This option allows certain base kernel options and settings
           to be disabled or tweaked. This is for specialized
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d4df5b24d75e..6a9bc118b64a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -433,6 +433,7 @@ config MAGIC_SYSRQ_SERIAL

 config DEBUG_KERNEL
        bool "Kernel debugging"
+       default EXPERT
        help
          Say Y here if you are developing drivers or trying to debug and
          identify kernel problems.

Then you shouldn't need the KALLSYMS_ALL change, yes? But maybe I
misunderstood that.

-- 
Kees Cook

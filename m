Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974F6C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625F62173B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nzz1DnJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfEIQLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:11:55 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36779 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfEIQLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:11:40 -0400
Received: by mail-vs1-f68.google.com with SMTP id c76so1778473vsd.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGvBfOsWL3Wi+dnFRPgL2CSHV9bM5eevOaTWbHZZuDE=;
        b=nzz1DnJ9BjEj1kg7AW6KUgUZlu7zGHA9FSRGd+vLU/L8x1Ifys0nieltpWrVOTytwS
         EiyrtldcK6DQKdtKFp5okPwfl1DFhaKke1rI9Vb381WUOwsV9+l0ZKYix9zjra7pv/ON
         nxoU2ZAcc9KIgPu90LxZfOub19uzYZ98Qy1Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGvBfOsWL3Wi+dnFRPgL2CSHV9bM5eevOaTWbHZZuDE=;
        b=Hfa7CrSI4udHJmYEp7f7ortaRz5/FjeIVOsGkixsx8vnKd9fr+niWMVOTJ4kGxejqh
         BcHGOPWMmqMQvG/Z7qa6pjXE1t9p+0inTXMs0SdC+FJSy1pIoCX9n/Z/TOuFbG52hGmr
         Vo9jfvlP+4vzt+DpGnTbynSucmpnUXBblhaJrsBEmgIWHRE7RJYNmq/Ye4q0a9CIY+bV
         b86LMy0Af6gPM7n6Kz7SrmVj7Oosj/SV20iHZ19pMmaqu827MT2qnK+dKxYFJGbeddw1
         de68fsj1+FSOIrwTtKeMmzBtWf5aPefaq55G42McAfBIbAO8fT3W5Hle2yvz+yWop5VD
         cuVw==
X-Gm-Message-State: APjAAAWyN3nh3wq4ZOUpRcnkjEFWuOUZK846PZkrehaRLaZiaN/gS6UR
        /tl9r7VPEfSxkhjlturQ/CbAu1yZDBw=
X-Google-Smtp-Source: APXvYqyYZVaVLgBzF9Nofvn6MUw92aUAh9foSdRyWctAk8BAttk4j1uhdYsWZ2XrBeM8+LnMP/Ktvg==
X-Received: by 2002:a67:f849:: with SMTP id b9mr2889342vsp.188.1557418298523;
        Thu, 09 May 2019 09:11:38 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id k128sm1365788vkb.54.2019.05.09.09.11.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 09:11:37 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id l17so722534vke.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 09:11:37 -0700 (PDT)
X-Received: by 2002:a1f:9710:: with SMTP id z16mr2186751vkd.92.1557418296626;
 Thu, 09 May 2019 09:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190509064549.1302-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190509064549.1302-1-yamada.masahiro@socionext.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 9 May 2019 09:11:25 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKDELCthqEcnL3TvC8DtMnfoWnOd14wrKpcReUxubdMCg@mail.gmail.com>
Message-ID: <CAGXu5jKDELCthqEcnL3TvC8DtMnfoWnOd14wrKpcReUxubdMCg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add -Wvla flag unconditionally
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux@googlegroups.com,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 11:46 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> This flag is documented in the GCC 4.6 manual, and recognized by
> Clang as well. Let's rip off the cc-option switch.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

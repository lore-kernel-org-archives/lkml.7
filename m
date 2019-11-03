Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FF4CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 23:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B2C2086D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 23:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQpQbIVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfKCX5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 18:57:19 -0500
Received: from mail-il1-f181.google.com ([209.85.166.181]:44071 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbfKCX5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 18:57:18 -0500
Received: by mail-il1-f181.google.com with SMTP id w1so4406197ilq.11;
        Sun, 03 Nov 2019 15:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DcgIA0yPIvsIGKQnb70qIrRbOwcnGxkyD0NueTd0dnM=;
        b=mQpQbIVEcDI8CRk9oBXSsEWOIPA/u3lVHQtEmp62/AhDqcgq5susW8Vxp3qi+W27N/
         Jwgk5pLmPI9eQ4ZzQi+KXT/MBd6rk1bPKIMVw9A3WHlu9ebn7Z47dkEqNkL+JaqaKiJV
         2CRFfgYKvNWRPUBMgH++C8RNvTw9fZSy5ib0qf7oQNke18BttFMBnf1dA59IsanXEbyb
         e1nSY+RKs5Q9/WGf7akhzwwX/IpaGr3Eecs8KZnAkRSX3zhFKMdCd8MqULW/lAzP6cCM
         X8l1tpCp9fjC+qySDE62qrv/JRYo2DGYedkYvBDkTlqMoal8gNesB0QEsEjGkPseU2bO
         rkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DcgIA0yPIvsIGKQnb70qIrRbOwcnGxkyD0NueTd0dnM=;
        b=mXP6znkabUtgSDpOsPrNDT+ktEqSSCQD/dS8jtjIS9jkGi/UKqx8BHdfJgLmyJ1Zb3
         c2A4GEI7k5/CToy3I875cq5QTvnqGNKjkaRHEGWEgxjSSzR1I8NniIiSJjcPEPxU/5H3
         UHExHeRBitwKzFwQU/Se4DOrvwbkq0hLroOPd0iC18G4XS+nusaab5kJwpwk3Mc/2NCJ
         0L1tQ9VLb2TJv85vk07Ad4FRoYlRoJqZOnZRwJfC0nAcYD06We63XraZN45bqOxTncfv
         LPX8hZzGMsOCTysKRJekJ2ITLIgWX3VGg2KEQjfRYINascki6D8ooYimzmkQ5qnOuNwK
         waAA==
X-Gm-Message-State: APjAAAWaB5KadEM73C5eOZSglHNFDP2+ahWuykRSTiLoPolIafhmuNH3
        ysDWZALjoGWu2BSbqGGgh/Fq55R633kwc0fZDDM=
X-Google-Smtp-Source: APXvYqzsWmLb0DjMjZwq0MkhUknk7p77iFlglOlOoE6vmOhYuH2jllnY836U34CV+1ovT1Gc4DFK7Erea6o9XsK7iUI=
X-Received: by 2002:a92:395a:: with SMTP id g87mr26581440ila.206.1572825437554;
 Sun, 03 Nov 2019 15:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20190620062246.2665-1-e5ten.arch@gmail.com> <20191029210250.17007-1-e5ten.arch@gmail.com>
 <CBCA4048-A9C1-42E6-A821-1EE36AE8CDC7@zytor.com> <CAMEGPioV_MTKO9DK6JT5355b7x0py-D_K467etDDnxWSYAbEig@mail.gmail.com>
 <40DC5B42-6C0D-4A5B-B23E-884ADB0108F0@zytor.com>
In-Reply-To: <40DC5B42-6C0D-4A5B-B23E-884ADB0108F0@zytor.com>
From:   Ethan Sommer <e5ten.arch@gmail.com>
Date:   Sun, 3 Nov 2019 18:57:06 -0500
Message-ID: <CAMEGPiqq1aoVNgezkx5DdQO7Jm2NL+pZzzY-N0AoU=+s470LcQ@mail.gmail.com>
Subject: Re: [PATCH v3] replace timeconst bc script with an sh script
To:     "H . Peter Anvin" <hpa@zytor.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Corey Minyard <cminyard@mvista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The point isn't to make it work *now*, but getting it to *stay* work.
Since the only thing that can change to affect the outcome of the script
or program is the value of CONFIG_HZ, isn't knowing that it works within
a range of any reasonable values to set CONFIG_HZ to enough to know that
it will stay working? I just tested again using the bc script and my C
program, and this time I tested every possible value up to 100000, and
they both still matched output. It doesn't seem like there's something
that would cause the C program to stop working in the future due to
precision issues.

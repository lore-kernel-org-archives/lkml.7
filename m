Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC97C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF1C206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0d3mmTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfKFHDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 02:03:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40850 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731601AbfKFHDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 02:03:30 -0500
Received: by mail-pl1-f194.google.com with SMTP id e3so8860402plt.7;
        Tue, 05 Nov 2019 23:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WN6t2RxJTrcSpXWmkeYE7YP/Liw+XUS9WWZURfMVu18=;
        b=e0d3mmTA3q+QfxCGgXPi0MsudpNOZYUrnPNw83QkvDpwth/fkqJuxRIWo2EkiK6DLz
         IeJqc46wle64sFTk8FuEVNXLJrRk4prjD8RX/WOCZ3/OzvEtypYyfPtU5PDwGwVBfbER
         JZ0wW0gPRcE7OhCBImVi2VYJfOdqvaoQzUjUwOqUge+mExV/crPCKnPmNGjcnAxP6h/g
         kpEJECsmzWVub9jtDJw+OWKvohu1AcTJXc0BlSGYF18mnqPh6cQ7sE964JYSDrwXExk9
         ipSMejz88ZGZHsVszIpIEsBdqxIxj1pzUwHj3TFpbT4z1CfnxmrmnuDUWfIoCUysFjAc
         qxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WN6t2RxJTrcSpXWmkeYE7YP/Liw+XUS9WWZURfMVu18=;
        b=I6mHt/7wRhqQXrPE7pTLs641uAzSNpqG7uGqj8Y/0c5B5e/D1rDBfPSrPYLKNF8lCo
         Y76nNVUCl8gZtbn85gQML7oMY0cBIkveXX35DpcU2XOaAm9hWLTgeyk0Sb3OU8yso3ie
         VlLbXsOEhG1jZaJoUqLbhAeWL5Mns/QH144svv0GEnsiUuqvS1nlnZ2qyPjVhrisz0+g
         iy/1ECYv/97LIjYMiOcQN1Oj6pZTfHGkiun5Sk7woOWH9G9aGYDaV79j9iyPBn7rSnOC
         xYgdpYd6QZt4RNZIdlqG4saEoHeemsCKtI4TyRiFnzERZxeh5U6CzUwOgOOmF/bHE2QL
         R15w==
X-Gm-Message-State: APjAAAX7M97vjtRaNB+6oXdAU+triff4QK6tmxl9jYSnoGt/yfKIORV0
        +llJNJiRIhQ6bpnj5sYD7C5oOng+MLB1WE7rhZ0=
X-Google-Smtp-Source: APXvYqw4jyXL6u9kK1PwIkQAjG0ZoqTmBU33xW+M3eN+g5vMz4eih/Rdu9J4jTWVAlWUjIE3n3XB5B69aeDKKfte098=
X-Received: by 2002:a17:902:bb84:: with SMTP id m4mr1006603pls.255.1573023809520;
 Tue, 05 Nov 2019 23:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20191104213417.18036-1-leonmaxx@gmail.com> <20191104213907.18413-1-leonmaxx@gmail.com>
In-Reply-To: <20191104213907.18413-1-leonmaxx@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 Nov 2019 09:03:17 +0200
Message-ID: <CAHp75VfgTAa8TgTYn99gr_F4mmVuJZgEu=JcDE+bOnAO-pqqxA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] platform/x86: asus_wmi: Set default fan boost mode
 to normal
To:     Leonid Maksymchuk <leonmaxx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Chris Chiu <chiu@endlessm.com>,
        Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>,
        Kristian Klausen <kristian@klausen.dk>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 11:39 PM Leonid Maksymchuk <leonmaxx@gmail.com> wrote:
>
> Set default fan boost mode to normal for multiple reasons:
>
> 1) existing code assumes that laptop started in normal mode and that is
>    not always correct.
> 2) FX705DY/FX505DY starts in silent mode and under heavy CPU load it
>    overheats and drops CPU frequency to 399MHz [1]. Setting fan mode to
>    normal avoids overheating.
>
> [1] Link: https://bugzilla.kernel.org/show_bug.cgi?id=203733
>
> Signed-off-by: Leonid Maksymchuk <leonmaxx@gmail.com>

> +static int fan_boost_mode_set_default(struct asus_wmi *asus)
> +{
> +       int result = 0;
> +
> +       if (asus->fan_boost_mode_available) {
> +               asus->fan_boost_mode = ASUS_FAN_BOOST_MODE_NORMAL;
> +               result = fan_boost_mode_write(asus);
> +       }
> +
> +       return result;
> +}

This can be refactored

if (!foo)
  return 0;
...
return bar(asus);

-- 
With Best Regards,
Andy Shevchenko

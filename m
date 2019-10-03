Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5C9C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68FC215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HDnbvcVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbfJCMyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:54:35 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33757 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbfJCMye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:54:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id y127so1775942lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 05:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vsh1XlcqiCbV/88Hqb8SdUEhr0I4PfdhVYwP9WbaWkc=;
        b=HDnbvcVK0V61vUTZJgZ1ltT+xAb7sL8Eq9t4zdVEeMYUnUxdGezi6uaNdah1XaWkHW
         FbCVERnF3VQR3C5cP8nidxlTwVoA68xsuqnUCbQtbfbrrdulerIxyrrfXfU4R6qKdsMN
         3W/PA57dXkYb2xwQpzzKuIWYcqWJ3u6RZRDz9H4PyQZ4ovpIvPT1Em27gtDUZ6PT5gMW
         5uNJeip80oUeyDfp35poDXbSEI0kRX1Jy/Ct0L3oubqvhieRWGHXx1AK01GDeKF08zKK
         6DcMck0p2dAJ72r6WXNmwali2eFZF430J4rLAuYJPDLnDkBhvQWidZiAlaSc90PhsCjj
         tiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vsh1XlcqiCbV/88Hqb8SdUEhr0I4PfdhVYwP9WbaWkc=;
        b=dUfnAZ1ZGhGvnFacy8+8j0cqmYZqe1OGKPIEsyUBQ2A1oziQ3TKJK1XTLJbCa77xUZ
         Wx0XvrysGFb5jdZ76QTUGM9BJiv3KO81a/cuTs+72lXvYseuSPqjHqFoppL3UBaffIWB
         xnlF3gv7t+DbOOPiXIHzcCo0LaZB4dXKTOiwow8FT/BctQBmsqesmujsRBDUVlSn6C1h
         AWaZcAmBSXHFJYcKWFkH/S93SYy1RoSytJRjq82Xi17M2UmWoM1gNHBJ/+iOWNa56M+T
         aIGkH5rICk5v0DjtDi/MBBBRLCUBIpbFhXeW2bVJpOcsFeTCukDw6lwcUF+hwvWYFzjn
         xz0w==
X-Gm-Message-State: APjAAAVz/r+r1elY5qgvhYx9nuEHUR8RksjhQ5fpBGFUP2waNpvgBMHb
        hOKoUNbPKX0npuu+77z+Cei/ViJqC6K/mbh/6G3tFQ==
X-Google-Smtp-Source: APXvYqyU0/XkmTAMfgX7X2G6a1zIl0KzjJAR0ocDPRzs/WhQvO+9c7gr7UN9bMALbMJAx7kliOdpxbteMul42ZmbKXY=
X-Received: by 2002:a19:117:: with SMTP id 23mr5753856lfb.115.1570107272881;
 Thu, 03 Oct 2019 05:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191002124206.22928-1-will@kernel.org>
In-Reply-To: <20191002124206.22928-1-will@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Oct 2019 14:54:21 +0200
Message-ID: <CACRpkdYFzrUT9YE3VvRdWpx-n9szyvoOnEBM7GWLZAv8t1drww@mail.gmail.com>
Subject: Re: [RESEND PATCH] pinctrl: devicetree: Avoid taking direct reference
 to device name string
To:     Will Deacon <will@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 2:42 PM Will Deacon <will@kernel.org> wrote:

> When populating the pinctrl mapping table entries for a device, the
> 'dev_name' field for each entry is initialised to point directly at the
> string returned by 'dev_name()' for the device and subsequently used by
> 'create_pinctrl()' when looking up the mappings for the device being
> probed.
>
> This is unreliable in the presence of calls to 'dev_set_name()', which may
> reallocate the device name string leaving the pinctrl mappings with a
> dangling reference. This then leads to a use-after-free every time the
> name is dereferenced by a device probe:
>
>   | BUG: KASAN: invalid-access in strcmp+0x20/0x64
>   | Read of size 1 at addr 13ffffc153494b00 by task modprobe/590
>   | Pointer tag: [13], memory tag: [fe]
>   |
>   | Call trace:
>   |  __kasan_report+0x16c/0x1dc
>   |  kasan_report+0x10/0x18
>   |  check_memory_region
>   |  __hwasan_load1_noabort+0x4c/0x54
>   |  strcmp+0x20/0x64
>   |  create_pinctrl+0x18c/0x7f4
>   |  pinctrl_get+0x90/0x114
>   |  devm_pinctrl_get+0x44/0x98
>   |  pinctrl_bind_pins+0x5c/0x450
>   |  really_probe+0x1c8/0x9a4
>   |  driver_probe_device+0x120/0x1d8
>
> Follow the example of sysfs, and duplicate the device name string before
> stashing it away in the pinctrl mapping entries.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Reported-by: Elena Petrova <lenaptr@google.com>
> Tested-by: Elena Petrova <lenaptr@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Patch applied, sorry for not getting back to you earlier.

The fact that dev_set_name() is reallocating the name is a bit
scary, it doesn't feel super-stable, but I suppose there is some
particularly good reason for it.

I guess the look-up table still refers to the struct device *
directly so pin control functionality will work, but the pin controller
device name down in /sys/kernel/debug/pinctrl
is going to be bogus, am I right? Like the name given there
will be whatever the name was before the call to dev_set_name().

Yours,
Lnus Walleij

Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9173C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866F72083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kth8MnUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfFTT5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 15:57:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41351 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFTT5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 15:57:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so2245953pff.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 12:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s0dGUTL6eh2cw6ZjVrg36nefIFWQ8LGFInVMiQ8EtQo=;
        b=kth8MnUpjxyuCl9fAHan9Zr1btXnsrS+SXmfVZD6ide3lk4u8eIs3n/RAAPUA8Z69y
         yru8kEG3F4D99rdy9VTgkLr4G9S5TJn0iG9tXFPoK5cdux9yKfyH/ebl5pZrdZ3pG5U2
         erboCyCjhbRBtMSYG4yCmEM8EUTUmM9F0+b7ZG8qTOTTesY2zD7/4VHq7pn0A2p7SFVu
         f1/+A/RP6+PZUzRJCXhTTIQqJWEtVfeBtRGpH/oTpEEiq8R786PYepVmyBbk8+Szo64J
         jKHRObHwAotf01Dl4oRyjBCwvK8yXJmO40drgi8v866r4mf37GMhu8koCOarJU64u11F
         6wJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s0dGUTL6eh2cw6ZjVrg36nefIFWQ8LGFInVMiQ8EtQo=;
        b=ei7S7tPdkpi8/klS5jRjfulBNaRmZbmEcqxm3kB/vuI5O4tUoWQ0F/jk3OP9BQtmHh
         Apm8Et69Yt34haVk5EO/a2ElHe2ApvWpBpWiCf8GeJbdr/ARpiKiBEbTrOcPP+WO62Hy
         mJ861ugmC3Fz9/deNHxqSomTqmT+S6Kvf5qnPQ27UgRGWDA0ELKRiyItJLpoUXhjILSH
         lZasUPGg3pFVACfvcU7/ds7SJHYsrpHQx0JoYa+qtSSyECES6kXjOdhaqZnVBiusOj3j
         EUMfw6PVcPEY+pAtmjO6AuUJfYDkpNTWTG5prfL4vE4H08u9MyRD/eIovQL3d1nsKwEW
         46ow==
X-Gm-Message-State: APjAAAUx0w0OwaYXpZF8cTTUyjY6PTb+tffF9KsyW0B17Tpi0+b6dM/i
        yx1IKsbIjhLY38YgtmJhhyDROyTR8Snr73DFNJx1Kw==
X-Google-Smtp-Source: APXvYqzl/20aaRBmRoGXt3kETQ7Qhl+p14lzrG0EYxUeYrU0503TNSYKL4okd2K0mx/+BzbCHSRf44rXbKeGSuwULlo=
X-Received: by 2002:a62:2c8e:: with SMTP id s136mr88622095pfs.3.1561060629486;
 Thu, 20 Jun 2019 12:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190620155505.27036-1-natechancellor@gmail.com>
In-Reply-To: <20190620155505.27036-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 20 Jun 2019 12:56:58 -0700
Message-ID: <CAKwvOdk7ZTcWEXPTBASPzk1SjOdnONawtQJkR-jU=REFSo1hVQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: mtd-abi: Don't use C++ comments
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 8:55 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When compiled standalone after commit b91976b7c0e3 ("kbuild:
> compile-test UAPI headers to ensure they are self-contained"),
> a warning about the C++ comments appears:
>
>   In file included from usr/include/mtd/mtd-user.hdrtest.c:1:
>   In file included from ./usr/include/mtd/mtd-user.h:25:
>   ./usr/include/mtd/mtd-abi.h:116:28: warning: // comments are not
>   allowed in this language [-Wcomment]
>   #define MTD_NANDECC_OFF         0       // Switch off ECC (Not recommended)
>                                           ^
>   1 warning generated.
>
> Replace them with standard C comments so this warning no longer occurs.

Should there be a fixes by tag?
-- 
Thanks,
~Nick Desaulniers

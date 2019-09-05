Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BD6C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6242341C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JDhKLshl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbfIEHUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:20:19 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41237 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731879AbfIEHUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:20:18 -0400
Received: by mail-vs1-f66.google.com with SMTP id g11so500839vsr.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 00:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qDqZN7fS5F+EG0FlyTVmrynQo8TpwF01x1Wwh0NjrGQ=;
        b=JDhKLshl3g4lJiNgrOi1FCf80+dutqw3IsmtHMyJZ7VJI0h+WJrU7QtAj9etFuISE4
         fGegTZinnugsz4Wu/l2ZbFpdBeDupgEmp5sBQaUD+WS5wNT1rn1NCs4SKb/ljekD8JZS
         /kjweFfNlFk1snVP0nA7Fgk3W4tI2T3kV9+7fjbw5A1m8TlBDoLm5nLwl8ySZoYhIzu1
         H88WnLQW4A6RZ7MTts2XRY+HTB7mL0tN6c497k2HhkkvZ2GVpaTopOQ7L+dHIkCu+Rte
         Pu5/IkScDn+bPpeJ2aX8EoQA5OCl8o2ht0G8Jrlk7It1cpXdQvPdVom5efvFl9Cqcy9K
         TL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qDqZN7fS5F+EG0FlyTVmrynQo8TpwF01x1Wwh0NjrGQ=;
        b=YoTYz9FTSValdGUIbZAfY9H684Lx7A6FxzoaPUCovIvh9H2QSmC7FN8qJWvkOrYruz
         nzp5qlvBLYQe/u6efbxF8LLZx0yLTZIt9ysgi5JTQmi0uopHkuTGaMAqIlKdreylnlXx
         3OVrZos9QomH4xalxWgiai67agHea2KmKOLqFw5YupmZrK6I9ETi7PRHVLNAoSAEvx9b
         53wOBCMKExOAcNyYpsJbIR50enxuNm8UmV73EDDbp2oSAMyrR3m8WgZ0y1GtsRnJX9M8
         9wYtsQ5KQr0ZxKuN2NKQW5NYvBa9V0n7M5OcRLSXxtqAinNY5RsObMvzEeje31hBrZzP
         gtyA==
X-Gm-Message-State: APjAAAUeo7qepJ/tl6HLdvJQ6zRZRE7ObmwmqZmeyWdInpF+MDFeIdnP
        7GixcFazYnCF7OgRNsDPr5L7UMaWR33n0+JxEQ8bMw==
X-Google-Smtp-Source: APXvYqyCWubkmCdHsA5rv6+utUu8svk9Q5oiFeDScE/poY3B/xRiRre3XakE2UsLkiqCYXL5PUV3McOIS1uD2lNWMsc=
X-Received: by 2002:a67:e2cf:: with SMTP id i15mr953569vsm.165.1567668017695;
 Thu, 05 Sep 2019 00:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <d355e790-7c60-5681-3ea5-dc4fd6206628@zoho.com>
 <CAPDyKFqKxSo50FSmesuOBz+FfE_DEFsZmEHD5CiU8SORv1Jrow@mail.gmail.com> <5e787d78-1489-dde8-41bb-b22ce011599d@zoho.com>
In-Reply-To: <5e787d78-1489-dde8-41bb-b22ce011599d@zoho.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Sep 2019 09:19:40 +0200
Message-ID: <CAPDyKFqO9+Lodaks4vBguQTUKtOeFU=CJmoQbwcqqe7cJxqD8g@mail.gmail.com>
Subject: Re: Asus VivoBook Flip TP202NA-EH012T EMMC problem
To:     =?UTF-8?B?w5N2w6FyaQ==?= <ovari123@zoho.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Reynolds <tomreyn@megaglest.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019 at 23:09, =C3=93v=C3=A1ri <ovari123@zoho.com> wrote:
>
> Hi Uffe,
>
> Thank you for your email.
>
> Which version of the linux kernel would your patch land in?
>
> We are not experienced with git nor gpg.
>
> Is there a *.deb file with your patch that we can
> sudo dpkg -i *.deb
> with the live session of Ubuntu 18.04 LTS 64-bit/Linux Mint 19.x to repla=
ce the kernel on the bootable USB stick?
>
> Would this scenario be helpful if we:
>
> 1. Download the Ubuntu 18.04 LTS/Linux Mint 19.x iso
>
> 2. Create a USB Bootable stick from the iso
>
> 3. Live boot the USB stick
>
> 4. Replace the kernel on the USB bootable stick with the required kernel =
(would need your help/instructions on how to do achieve this)
>
> 5. Boot a live session from the USB stick on the production computer and =
extract the reports, error and otherwise, you require.
>
> What do you think?
>
> Steps 1-4 could be done on any computer.
>
> Step 5 would be done on the production computer.
>
> Would this work?
>
> Thank you
>
> =C3=93v=C3=A1ri

Hi Ovari,

I am sorry to disappoint you, but I simply don't have the bandwidth of
time to guide on this path. Perhaps look at the Ubuntu forums, I am
sure there is guide somewhere.

[...]

Kind regards
Uffe

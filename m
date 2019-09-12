Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BE6C49ED6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 03:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066A12087E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 03:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnG/cIC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfILDCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 23:02:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45794 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfILDCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 23:02:17 -0400
Received: by mail-io1-f67.google.com with SMTP id f12so50947038iog.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 20:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mXXFqHSKj7akMYz+2BHSRLbRi0+2gpnMvtcz77fab9g=;
        b=tnG/cIC0vOxQhpWDc/JR2MwNWbBgkfBw6AVBNFF3UyzID48WRYdPkLy0MyD1UCbrYW
         PuLUMJ3Rhu3yS8JL4G3mfbl7wKSxlxze32xco66YmRFi+laea4tm2iaFCUJZt6goac7S
         7OU2Cd3gr9gV5TIZEOKyKU/4JNF786l3vOWUxAxAS+I3AL/Ij6Ozgu3UVU5zMHRElfI6
         rO3dLdQP6wmpvtntYBSsY4FAmj4qBSY3tryar3O3g2HkxZc9J4Pc/gqmuTY/O/+oaxao
         hDa9hOs8lbSBQ0RmjXJZDwFJeiiqbDQnhDBUy17AqfAPXwBgwA/qsKLm0lvdHw2Ur74R
         dR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mXXFqHSKj7akMYz+2BHSRLbRi0+2gpnMvtcz77fab9g=;
        b=iz7NL3J7UdkTNcmF6JJI8V9NUFpQEhXAg7XiGt6bTgMN3v40NkVaNP5qJCdqMAFfnz
         8PnfllLpaIFsHgmRoroGhoswnazdjVUp1B4/Dh5DYKQWncCFREeQkuUIpLe2sZaPxyJt
         lVZrRXUmWC6ExBvvFRwOAjUAkaUNERvZoONBfa9CzySMz/dx5NkTp7Eue3yYIQdgHd/4
         rP8zsQLigcBQ2AQufCiF/5Hf+lZcfB0g2rp6qYcZfiERTd8xIxjNXl1VMCW8kvRQFvJQ
         57p9vEkIExmg2r01T7hXZQBXNy5zc6iPm4qgT3YCFPVXQ1eGoPUMeAPgZliie9vDkZ4w
         ky1w==
X-Gm-Message-State: APjAAAVp1ytaX4Tgwsk6pKj+NvF7x2TWYtWZTPnCKXqnZWHwG7HtYKGf
        vN1fsX2YycmzK8/PUjJ5AgSAaTNm0PWGL2Sapak=
X-Google-Smtp-Source: APXvYqyqZLMOU0VzjHFYOiUD2HDkk3NnFQ5jNE6dCmY9m+FlWLHNYgnVeiMEIBMwNVatbPiuILtRTWj9SDhyucuMkh0=
X-Received: by 2002:a5d:87ce:: with SMTP id q14mr1622011ios.248.1568257337009;
 Wed, 11 Sep 2019 20:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190907081446.3865-1-rain.1986.08.12@gmail.com> <20190910.175051.1032944353064959379.davem@davemloft.net>
In-Reply-To: <20190910.175051.1032944353064959379.davem@davemloft.net>
From:   Rain River <rain.1986.08.12@gmail.com>
Date:   Thu, 12 Sep 2019 11:06:37 +0800
Message-ID: <CAJr_XRAr+qBPKKsxRZQf=8Kb7mDMjsNeLSHko+B0ziTM4JzXTA@mail.gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: update FORCEDETH MAINTAINERS info
To:     David Miller <davem@davemloft.net>
Cc:     mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK. I will resend this very soon.

On Tue, Sep 10, 2019 at 11:50 PM David Miller <davem@davemloft.net> wrote:
>
> From: rain.1986.08.12@gmail.com
> Date: Sat,  7 Sep 2019 16:14:46 +0800
>
> > From: Rain River <rain.1986.08.12@gmail.com>
> >
> > Many FORCEDETH NICs are used in our hosts. Several bugs are fixed and
> > some features are developed for FORCEDETH NICs. And I have been
> > reviewing patches for FORCEDETH NIC for several months. Mark me as the
> > FORCEDETH NIC maintainer. I will send out the patches and maintain
> > FORCEDETH NIC.
> >
> > Signed-off-by: Rain River <rain.1986.08.12@gmail.com>
>
> Please resend this with netdev properly CC:'d, thank you.

Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7362EC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3963720848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpChBtU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfEQIIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 04:08:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33797 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbfEQIIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:08:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id j187so8727386wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 01:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JfYR82SrJwNVW06pJvRPW4k79pA13x1SVkcHvJx5clA=;
        b=rpChBtU/BLblhzIRB0YKed47JbgJMePYBfD45yam5dH3+203i3Rz0AIudOxQOKNoQK
         b3QzwfvqJeMQchb4iCTNTUR5Tyn+cMw+fKa+3PCfJSizLauF9TAunUE/cGE6NpE9FqjE
         zXS4hCm9OpkHg9uKNPppRzfk0T/EApeUcwjmJU+MCdzSNFVNbeDPvnb7t+04FNfyIKtN
         pyNqF/W+OQq/8Z8/07YJJ8MLquI0tUyh4bPIzR6c2qUmKgSgRRgDj5q8X3j+FV1wLOBH
         iCVSxsT2dyJZWNIcuzIWIF65mey4Sp/NS/I97gmcIdsSRtUioAQ+2CEScngaOMWxNdk3
         esyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JfYR82SrJwNVW06pJvRPW4k79pA13x1SVkcHvJx5clA=;
        b=dxvxSfGy1wDJoNzh/2FSXrl2ARo2usZ44RE0j5i4RFwKObMnty5RlG80hTSka7Rklz
         buP8cc5aw75HQ9d7Nvg4XHeBBjGYr/f/PP4foKimpD5JQZ9zWGTMICbn0EmJgjGz6vtd
         UJ/fmrk+VW2E7HyBW/kTG3J3xm0U0RV/n1koSdhoj0rgvuD9mlxs86f3vD4M9gZW7ACd
         U2aHN8eRa85YcJgT/QtDeec/Wu1Gq5nljz16KoPTpDVoxr+2clDhq5PD1ctrZ2xaTQBn
         BdGXa5AL10oPZRXmkX+ZSkE6qbqChDP/wt7tw7cbOfutiemSk7sdKEAsYaBC012kuWIw
         W4xg==
X-Gm-Message-State: APjAAAVDgz/QbN8GA1H3e5SFAJjov9noXYpa9z9AQxRn5Fpi+B7051kg
        w4d8AdWpEJs0I8X+2l5eikT3s1HprswiMpb8vXM=
X-Google-Smtp-Source: APXvYqwg2RzALCC9z6vUHJ9UiTDIM1iXYb5OAieioPqeEcdSlbhsUvyU17mYxRE6I875hxeldwXhsfyWu2yfttSuAEE=
X-Received: by 2002:a1c:4909:: with SMTP id w9mr1265084wma.17.1558080528334;
 Fri, 17 May 2019 01:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <1558024913-26502-1-git-send-email-kdasu.kdev@gmail.com>
In-Reply-To: <1558024913-26502-1-git-send-email-kdasu.kdev@gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 17 May 2019 10:08:36 +0200
Message-ID: <CAFLxGvwjqo27VQ092WV9=6N5RJr-M7aL0HYVWkeaCYbY3XWa1w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mtd: Add flag to indicate panic_write
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        LKML <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 6:42 PM Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>
> Added a flag to indicate a panic_write so that low level drivers can
> use it to take required action where applicable, to ensure oops data
> gets written to assigned mtd device.
>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>  drivers/mtd/mtdcore.c   | 3 +++
>  include/linux/mtd/mtd.h | 6 ++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 76b4264..a83decd 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -1138,6 +1138,9 @@ int mtd_panic_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
>                 return -EROFS;
>         if (!len)
>                 return 0;
> +       if (!mtd->oops_panic_write)
> +               mtd->oops_panic_write = true;
> +

You can set the flag unconditionally.
If it is set, it will stay so, and setting it again, won't hurt.

>         return mtd->_panic_write(mtd, to, len, retlen, buf);
>  }
>  EXPORT_SYMBOL_GPL(mtd_panic_write);
> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> index 677768b..791c34d 100644
> --- a/include/linux/mtd/mtd.h
> +++ b/include/linux/mtd/mtd.h
> @@ -330,6 +330,12 @@ struct mtd_info {
>         int (*_get_device) (struct mtd_info *mtd);
>         void (*_put_device) (struct mtd_info *mtd);
>
> +       /*
> +        * flag indicates a panic write, low level drivers can take appropriate
> +        * action if required to ensure writes go through
> +        */
> +       bool oops_panic_write;
> +

Maybe we find a better name for it.
panic_write_triggered?

-- 
Thanks,
//richard

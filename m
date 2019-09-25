Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA21C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AE72082F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnMdEFq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442719AbfIYIHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 04:07:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45322 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405820AbfIYIHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 04:07:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id u12so2061964pls.12;
        Wed, 25 Sep 2019 01:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I9xTtNwt/ddRBRmVEa6PjbkYWK8+44/EROKOCF09I4E=;
        b=FnMdEFq2NIVbnFZRgogBOoKNlAk7UQ1uFwN1UmbbAIbbHtmevrwcSS0FtIP097bW2j
         RYfYUTpgLp8usBIXdLx4eLQJO2eb4n/l1K20qUWO8nOx3gkAzpda7nnDJ8egOtxTFN7/
         b1Vqj13V3YToUF6IuV/5LeZu0x1Cmp2eDCKaJqso62vTNBMnnxH2dVG0jD5lM0nKQJ4n
         QMTe/1tTqut5KQkkrwVnlaDbXVL6cTJbzDQjXESEQh7Z8aRIwUHCW+4Ppu/+XZhAu8a3
         FW9yAILeemJE8gNCtEL34PzBu0Wbuncg5dSBuL6jImDZ86FI64yOGZWBUMvM9c8JkcJ6
         fv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I9xTtNwt/ddRBRmVEa6PjbkYWK8+44/EROKOCF09I4E=;
        b=U8ioSo4bWiEaS1qFv4ri6WEapwVMpuW5NWj2F6YKE3XKHvxKhsbd2cqObrmGN1IjFs
         bxePCZyRnfLwn9ycLg48SdTHCLWS2TOOYhW1AsEz7XhHzJ9wXL4r8Ii4QAOXDhA4pOgU
         M1ReW1lMW/4kPtp5I5tjwcaO6YfWeTQFsBRbSM9qoaDMKnkBbkLdFFBMCgbxWwA7OT4Z
         5DyEyzlxQwzkDP1ocWqPdTPETudQ+h+iSvM2gGQ506JIbtkm2ToenSIQGY3/7rUD841k
         nagN2HWrMJCBDdphvat/cIYkWvCn/wu/wkcYxr5rKDsUHm+Z0gygDFWye44z3C9bsIur
         ymaA==
X-Gm-Message-State: APjAAAV+I2pokk3ZZ/Xc8U7MlfiQDK9vW4eMXB70E4AcYE5rAEuzBuMY
        Tlnkp28WHWb76TjcdNlpFkuti8pUnszXYYglyzk=
X-Google-Smtp-Source: APXvYqx/NhfLui6xTKQiaj/7wEEQlMArZPw8hSSqB/XWTSjN+xlNNkkowlHUbqD+QVq2l7DiHZ/v08C83T1aPYeaXWw=
X-Received: by 2002:a17:902:b110:: with SMTP id q16mr7591414plr.262.1569398866679;
 Wed, 25 Sep 2019 01:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <156824368856.28378.14511879419677114177@WARFSTATION>
 <20190912073358.n5bxqosowhky5uhb@pali> <156882055514.9370.16951540573597044820@WARFSTATION>
 <20190922134323.mowwoyeuqoalpwsg@pali> <baba1f72c68f4699955d2b7a52df65e1@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <baba1f72c68f4699955d2b7a52df65e1@AUSX13MPC105.AMER.DELL.COM>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Sep 2019 11:07:35 +0300
Message-ID: <CAHp75VfjhuFzTRg7X_ici6ACj54sQKH0mR8x9M-XAYk5cbTQ7g@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: fix phantom kbd backlight on
 Inspiron 10xx
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Pacien TRAN-GIRARD <pacien.trangirard@pacien.net>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 4:24 PM <Mario.Limonciello@dell.com> wrote:
> > From: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > Sent: Sunday, September 22, 2019 8:43 AM
> > To: Pacien TRAN-GIRARD
> > Cc: Matthew Garrett; Darren Hart; Andy Shevchenko; platform-driver-
> > x86@vger.kernel.org; linux-kernel@vger.kernel.org; Limonciello, Mario
> > Subject: Re: [PATCH] platform/x86: dell-laptop: fix phantom kbd backlig=
ht on
> > Inspiron 10xx

> > We need to wait what Mario wrote about this particular problem.
> >
>
> I agree an Inspiron is unlikely to be updated 9 years later.  I think the=
 right thing
> to do in this instance is to blacklist this particular platform in kernel=
 driver.

Does it mean you are okay with the proposed patch? Can you give your tag th=
en?

--=20
With Best Regards,
Andy Shevchenko

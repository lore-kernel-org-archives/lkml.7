Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF2EC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15AA2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXESh+Fs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfGZIiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:38:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39478 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZIiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:38:01 -0400
Received: by mail-io1-f68.google.com with SMTP id f4so103207910ioh.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 01:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/+kSHe7XxYcBThVGLwt0uUISJ40WnHLaPRd+W+td1vA=;
        b=oXESh+FsZYfHtMolVoIYNjhn3bWS0GKBMPbqXcajI8Dx8KkwHwAcwS6FZ4uEPFQlUT
         NWUzoYNHtx7o53EUwHn1+LohgD885doZLuRPWj9Pqh2n8K/yxs7gF7ydj7qTu0FGKBfS
         P4m5lvv/MJzI+MvFYcyJc3riyu0XFPx4NsJ3YsgBTzKVaYsbrroP4OfeOkH9j42sWL7r
         sw4FIzg7/LLboG2iZVDWPqD3Jssk/tjuGlETmGMnBZHYv4jZa+RihRcuvYb5BwbYPnhv
         wtWAuaoWB/ZcgeTwD1DW4HYsQTNlfHqx0XfZ6KRDGSG6gC6aJsc7F87CBFnJtkMMmL10
         KgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/+kSHe7XxYcBThVGLwt0uUISJ40WnHLaPRd+W+td1vA=;
        b=eK/OuW/O7XXHo83xlJtkULYo3cJAdxdE4nWQo9Qj1tjSNA7LsSCv3w9fPZMhZ/q/tW
         8v9PMUMQnHLzmLXVRnuycpazHmVqGzr7T48wdXWoWDhCbWGj8gceVDMrIcF8O40JhR8v
         X/OciHW7QeZnKsO7Avz5T577h7rduX9DKQE/3osRgz2eQy1VmAezv5l+80jo8fEAPaNL
         z85qK1OL1/8SfyL8yWLJjj2giTmTBrxywXtuLceTtP40VxVxNzPs5fjER8QaK0BcE8rx
         Z7soc3VMrUvA+XkfhnqCufH4I4eWZYiG94ytc6C7URs9Yq30r0eSnU0KXFqJK0kiVNcC
         cBDg==
X-Gm-Message-State: APjAAAUO5CXE5Prs997KCA71TqrIoRNhkovBuhwkvSQffE2jyr7lVb3s
        MfVO7udYPQ5THNyBC1rplbV4az1b6l9GHXBo4IiDhtDCmYFFQA==
X-Google-Smtp-Source: APXvYqwV58wffbAxPLLOC/WhTaoUMprr52QREPBtUJHNLF/CR95aO6ozWQW7dhLertGHTMrEC+0FCjv9vKqA+u7jEoQ=
X-Received: by 2002:a5d:885a:: with SMTP id t26mr32910760ios.218.1564130280263;
 Fri, 26 Jul 2019 01:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190725063644.5982-1-gomonovych@gmail.com> <CAJKOXPd1sL_GqajZN6YAz+frapt2wCCW9WPvF8eYGsZ9iOdxsg@mail.gmail.com>
In-Reply-To: <CAJKOXPd1sL_GqajZN6YAz+frapt2wCCW9WPvF8eYGsZ9iOdxsg@mail.gmail.com>
From:   "Gomonovych, Vasyl" <gomonovych@gmail.com>
Date:   Fri, 26 Jul 2019 10:37:49 +0200
Message-ID: <CAHYXAnKKi6Uf2i0_Q8xGHU5DV63hw0Sa5YEPB12xBz0BWRN86Q@mail.gmail.com>
Subject: Re: [PATCH] extcon: max77693: Add extra IRQF_ONESHOT
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, myungjoo.ham@samsung.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, my bad, I have missed disabling place, and positive feedback
for max in other thread and push me to send it.

On Thu, Jul 25, 2019 at 9:23 AM Krzysztof Kozlowski <krzk@kernel.org> wrote=
:
>
> On Thu, 25 Jul 2019 at 08:37, Vasyl Gomonovych <gomonovych@gmail.com> wro=
te:
> >
> > Do not fire irq again until thread done
> > This issue was found by code inspection
> > Coccicheck irqf_oneshot.cocci
>
> Rationale does not look convincing. Do you fix real problem or just
> automatic fix from coccinelle? If the latter, then it looks wrong.
> This is virtual IRQ so no need for oneshot. The hardware IRQ has
> oneshot set. Otherwise please provide slightly more specific rationale
> for this commit.
>
> Best regards,
> Krzysztof
>
>
> >
> > Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
> > ---
> >  drivers/extcon/extcon-max77693.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-m=
ax77693.c
> > index 32fc5a66ffa9..68e42cd87e98 100644
> > --- a/drivers/extcon/extcon-max77693.c
> > +++ b/drivers/extcon/extcon-max77693.c
> > @@ -1142,7 +1142,7 @@ static int max77693_muic_probe(struct platform_de=
vice *pdev)
> >
> >                 ret =3D devm_request_threaded_irq(&pdev->dev, virq, NUL=
L,
> >                                 max77693_muic_irq_handler,
> > -                               IRQF_NO_SUSPEND,
> > +                               IRQF_NO_SUSPEND | IRQF_ONESHOT,
> >                                 muic_irq->name, info);
> >                 if (ret) {
> >                         dev_err(&pdev->dev,
> > --
> > 2.17.1
> >



--=20
=D0=94=D0=BE=D0=B1=D1=80=D0=BE=D1=97 =D0=B2=D0=B0=D0=BC =D0=BF=D0=BE=D1=80=
=D0=B8 =D0=B4=D0=BD=D1=8F.

Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31037C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A687206DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0qV8PRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391336AbfGYRo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:44:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36417 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388291AbfGYRo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:44:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so23392117pgm.3;
        Thu, 25 Jul 2019 10:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7+hFw6mo8dhy1omS9HVV0VfweWLThyGPqk2QfKYq4ZU=;
        b=H0qV8PRhmbegWi5YPtSs+i0ZmRxlyoLvpYoJUmvM9KU87v6d8tOcggo0tK84goVIZu
         GiLQk7yEnu6lO7FC3eHXF2bT4BCW5TKjmE8vjHwQooNqo/IOLsRdR0teaocYJNmmI+4D
         cCGiUwSrzGQTuty48IP638/Pi1E579bXekHLt4NmVK5VJfsT2driSWc/elEpRSTBYGsl
         j2r5Ky3IK8H4b2TJU2x9TOciXbIf9GCgt7GKSSGFe/N7w1oEEDgInsqdU58JH+VwrP29
         aHOrgxLMvxx0scD2kUi+W6qxnbLtu8cLWSYteTxV+RbEuPfQL6IUGJbeq6loWj+8dHZ7
         YRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7+hFw6mo8dhy1omS9HVV0VfweWLThyGPqk2QfKYq4ZU=;
        b=hJZnXYlyFBt33LQdScOW9znjbU6yAelEEFiqjCfamPFL3wBNARIRTMv2riDzU4LLvr
         KGU0FpqMVVM8lyH8n//NKOp6Aw/ZegQgZlz6IX+c59JMCdq+NtHqvOupnwD3P/qhTbkD
         7LA3pdilBEOcxfKGJFKFvPfjAwTXBDJ7zM2nACynO8McjBRYMvCbF7KG7YYRhB9ZBbbh
         TYtKoj6QWE0787x90L68HoFGoniBqOVW6PQMtV2ShbKrRnDwsXxVudJ6ELHM4bSDx7up
         9x2HC94ExgFhhjP+gzjbSOHxMdlyxK5Wlyg48VP6Wb/OPFgshwQE8P1l/9NZAg296Mz3
         jkHg==
X-Gm-Message-State: APjAAAVYC65RuNJXoLXWCjyzzXykYJ8gt20qyuYA0Csa3MKs6xqdPDpC
        sdYT0nPwUNrCy8RkmH1PJ1QXHt9BjY2KZhJcnfABWQiIRsE=
X-Google-Smtp-Source: APXvYqwlg7+rlIdaeVC3yQn1x571GTXmdJNlaBhqYAnDrq6lxpG7uy2bk/2gSfXMtbrz5Oz6TES072Y7A4293M7QT3Y=
X-Received: by 2002:a63:1020:: with SMTP id f32mr57898657pgl.203.1564076665322;
 Thu, 25 Jul 2019 10:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190710053326.26247-1-kai.heng.feng@canonical.com>
In-Reply-To: <20190710053326.26247-1-kai.heng.feng@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Jul 2019 20:44:13 +0300
Message-ID: <CAHp75VdO01EmsYXPjXdjyzqa4vvs26H3yJ0C+fhxmY1hrgg+Xg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: hp_accel: Add support for HP ZBook 17 G5
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Eric Piel <eric.piel@tremplin-utc.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 8:33 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> HP ZBook 17 G5 needs a non-standard mapping, x_inverted.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/platform/x86/hp_accel.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
> index f61b8a176e20..cfc0e36a7a5e 100644
> --- a/drivers/platform/x86/hp_accel.c
> +++ b/drivers/platform/x86/hp_accel.c
> @@ -239,6 +239,7 @@ static const struct dmi_system_id lis3lv02d_dmi_ids[] = {
>         AXIS_DMI_MATCH("HPB64xx", "HP EliteBook 84", xy_swap),
>         AXIS_DMI_MATCH("HPB65xx", "HP ProBook 65", x_inverted),
>         AXIS_DMI_MATCH("HPZBook15", "HP ZBook 15", x_inverted),
> +       AXIS_DMI_MATCH("HPZBook17G5", "HP ZBook 17 G5", x_inverted),
>         AXIS_DMI_MATCH("HPZBook17", "HP ZBook 17", xy_swap_yz_inverted),
>         { NULL, }
>  /* Laptop models without axis info (yet):
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko

Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DF6C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2287D20675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLVoOWMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEFMWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:22:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37738 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfEFMWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:22:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so6391084pgc.4;
        Mon, 06 May 2019 05:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PwfLp6D54bZUS8f0UxR3vu8Buzj/gb/Y+B4s3U4Ap1I=;
        b=DLVoOWMMYuCzhsYqdOG7eJJHzAU/0h3zN3lcCvIPlRo9tZjvJqXHKdBfmV3PUx4Q/T
         sTVKOWZ+VS9YDF1eiX4gTrMeiMqEZcBLcNua64unZoyW8N9HbyW/XHm6vrrX40thigVo
         w75ZkCEVu39VzuCCsPOFG7NaPKpoANQqbV+Fy8feaOxx8dx4mvzG3pxpACQivlYLz9BS
         xzNERBI4V8PthY9yBYbSGFLalBNOU6/mrYOSf5w8OqPHBgQg/bpT4g/0+e1XGKz45Mfr
         3Sqr57tkvnvLxyiEwlU2MxOb9qW/pOxTz3EG144SIJhPstsDUMjrTtNfXXuLJMhwrRgI
         /c2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PwfLp6D54bZUS8f0UxR3vu8Buzj/gb/Y+B4s3U4Ap1I=;
        b=nS8HWk7+MLFt7yTFhwuVim847aaBRlg2seb7PVHA/1yyD+gbokrb1q/SPj8VWahdMB
         BbZ8fXsFX5yyxfXbDVAZV34OsD2hxA3gnvDMIAqUEfQ6K8Oc83I4f/4MEAujDwEx06Vr
         oKg4+5KRDZPAWMyYPSohvFQFdshjUcQE2ewkIF1FrImRHXgIzgSNqllodbp3aOqu2Ng1
         053Mf/frHS3OygUC3Q3Ik+jNlmUhp/obh2yV0pF6E2dYjYQCFJB6PSCpfms0/W0xJYC6
         qtFHCbaraUpQrVvWndZ0i8jOCzkboqPmNB/ZDddUPc6O203RdQjJJJWWg5QJXEQQ5MEe
         3osw==
X-Gm-Message-State: APjAAAVGN/zQN4TlWOO+feyKgE9j00xNhvOZhEAMd1ZD6sB0KZzmwIhN
        1wWXR+9ygb+HXurScJLXH6x9LcjsopIaEHwZRLE=
X-Google-Smtp-Source: APXvYqx+1aqdahcbOQfkAGi/MjA14HI/uopLzP8/SRGyhyFEpk3iYg1WTCuSr98e/dDVq7oa4WsRymRbB68xWKZYXs8=
X-Received: by 2002:aa7:884b:: with SMTP id k11mr32683031pfo.49.1557145371156;
 Mon, 06 May 2019 05:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190424181543.GA31200@embeddedor> <CAGXu5jKRO45m1TRDPA09sv0j+cZCC8e1w+oQty4YfOttKP3FYA@mail.gmail.com>
 <13ba6003-ff33-4e5b-b88e-ef93bc68dc48@www.fastmail.com> <e1199dfe-86fe-0e42-74c7-15adf0b54406@embeddedor.com>
In-Reply-To: <e1199dfe-86fe-0e42-74c7-15adf0b54406@embeddedor.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 May 2019 15:22:40 +0300
Message-ID: <CAHp75Vep5tYDrcgNWFepj-GgbaCcRbHcDHyQ4mD=+yX7Jftt+Q@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Kees Cook <keescook@chromium.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 11:44 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 4/24/19 7:55 PM, ibm-acpi@hmh.eng.br wrote:
> > On Wed, Apr 24, 2019, at 16:05, Kees Cook wrote:
> >> On Wed, Apr 24, 2019 at 11:15 AM Gustavo A. R. Silva
> >> <gustavo@embeddedor.com> wrote:
> >>>
> >>> In preparation to enabling -Wimplicit-fallthrough, mark switch
> >>> cases where we are expecting to fall through.
> >>>
> >>> This patch fixes the following warnings:
> >>>
>
> [..]
>
> >>>
> >>> Warning level 3 was used: -Wimplicit-fallthrough=3
> >>>
> >>> Notice that, in this particular case, the code comments are modified
> >>> in accordance with what GCC is expecting to find.
> >>>
> >>> This patch is part of the ongoing efforts to enable
> >>> -Wimplicit-fallthrough.
> >>>
> >>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >>
> >> Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> > Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> >
>
> Thank you both, Kees and Henrique.
>
> Friendly ping:
>
> Who can take this?

Pushed to my review and testing queue, thanks!

>
> Thanks
> --
> Gustavo



--
With Best Regards,
Andy Shevchenko

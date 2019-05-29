Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CDFC04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 02:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084CC21019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 02:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1PafRzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfE2CkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 22:40:05 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:43243 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfE2CkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 22:40:04 -0400
Received: by mail-vk1-f195.google.com with SMTP id s18so65546vkb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 19:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nYC/ds12AXJwoKgwvftdDhBpYC+XwAHp1g5sINn1acs=;
        b=H1PafRzEgiSV2o9i7PNsYbuBS9nXBhB41lQoNu6FncrKhk6FnkhG5eiWmadBl1oENv
         kgiLE3FIQJm0jXeo3DnPWhkC2WF4LYve7bCCFh76NPaR7sxZ0Fhf8U94Dt8cDThoiUod
         gvA6WfKvoAzAgdYFgi0yDGSC+gS3B0CorbJlmgCI36fzJNzxzRndA91PcAnARE3SJcPE
         zLNN9Odvmyrcg/l70S8iWN380YF2/zShsJeJIDD4jXuOoyYEp5QLyJ9iqIyo7MaJiO1K
         P05RIgA5IQm3VbX0Ezfnap0jjnANULbnx3eZsB6+7nlFbuc0wmrjD7vdO5ehSxSj9Xys
         Xyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nYC/ds12AXJwoKgwvftdDhBpYC+XwAHp1g5sINn1acs=;
        b=p+qwK8LKRXhlButHpe8yiY+NyfqUz2r2dE+HmmyTk5wpO3foGH0VrfxV2h4VXTmBvW
         xbB9JD88Gl2Je5AfR5gJtNJ7nymJCbUkJdHuXQ+eVNJ8foWxowRcwseF8iZPL0Udyd5u
         MOhYVlG6DDwsEnntGJMFoISbByzh+t88WALhY+Bmja9a74XIcWF0toB2WngCqnNllFCG
         3zoPuEvvAHdmxGEMIrvfYtqmSc4DcbbU4NsQ7VIwRkBpMbWWD7u5krVvmBU5pkUYQAPh
         wvmmXg6iFGI8+X8/ueeMgSZ5k14AhVX61KFkbnFIdtvg4Dz0uYN5+c3PsRnLMdm3AhuW
         73pw==
X-Gm-Message-State: APjAAAVTOQ15ue+M+cNemM+pK5m/lJ33s7KsqCb5vti8SULyl6/3tiPP
        k+GcFnx6St096hPawKuXuK/wqUwcUoxwcRGPclo=
X-Google-Smtp-Source: APXvYqxsswYT6fHZMXnSzYgc0kGJpf1lpmvkbcuf8x2RzkG22skIeQGhVRVozjocRaQv1pkV/fnNF02bjphIJEUoxD8=
X-Received: by 2002:a1f:344e:: with SMTP id b75mr12403888vka.65.1559097603551;
 Tue, 28 May 2019 19:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAFbcbMATqCCpCR596FTaSdUV50nQSxDgXMd1ASgXu1CE+DJqTw@mail.gmail.com>
 <20190528071053.GL11013@uranus>
In-Reply-To: <20190528071053.GL11013@uranus>
From:   Dianzhang Chen <dianzhangchen0@gmail.com>
Date:   Wed, 29 May 2019 10:39:52 +0800
Message-ID: <CAFbcbMAi_QhoT=JyU6NjNiJJwFbXF4Z1eV8TtfLv9UWJT-K_CQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/sys.c: fix possible spectre-v1 in do_prlimit()
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Although when detect it is misprediction and drop the execution, but
it can not drop all the effects of speculative execution, like the
cache state. During the speculative execution, the:


rlim =3D tsk->signal->rlim + resource;    // use resource as index

...

            *old_rlim =3D *rlim;


may read some secret data into cache.

and then the attacker can use side-channel attack to find out what the
secret data is.


Virtually any observable effect of speculatively executed code can be
leveraged to create the covert channel that leaks sensitive
information[1].


A general form of spectre v1 would be[1]:

if (x < array1_size) {

    y =3D array1[x];

    // do something using y that is

    // observable when speculatively

    // executed

}


[1] https://spectreattack.com/spectre.pdf

Cyrill Gorcunov <gorcunov@gmail.com> =E4=BA=8E2019=E5=B9=B45=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=883:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, May 28, 2019 at 10:37:10AM +0800, Dianzhang Chen wrote:
> > Hi,
> > Because when i reply your email=EF=BC=8Ci always get 'Message rejected'=
 from
> > gmail(get this rejection from all the recipients). I still don't know
> > how to deal with it, so i reply your email here:
>
> Hi! This is weird. Next time simply reply to LKML (I CC'ed it back).
>
> > Because of speculative execution, the attacker can bypass the bound
> > check `if (resource >=3D RLIM_NLIMITS)`.
>
> And then misprediction get detected and execution is dropped. So I
> still don't see a problem here, since we don't leak info even in
> such case.
>
> That said I don't mind for this patch but rather in a sake of
> code clarity, not because of spectre issue since it has
> nothing to do here.
>
> > as for array_index_nospec(index, size), it will clamp the index within
> > the range of [0, size), and attacker can't exploit speculative
> > execution to make the index out of range [0, size).
> >
> >
> > For more detail, please check the link below:
> >
> > https://github.com/torvalds/linux/commit/f3804203306e098dae9ca51540fcd5=
eb700d7f40

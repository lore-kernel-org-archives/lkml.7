Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CA6C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111A020830
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YL5cHOV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfDIKb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:31:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37597 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfDIKb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:31:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so2698586wmf.2;
        Tue, 09 Apr 2019 03:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eQx2TaUwh8Ijip8QcXaY6f2a/ThB22gwO6hBQo1xRKk=;
        b=YL5cHOV71rwriAeEampk6JbeFmiSG0j85iHAvhFZNXiX9OQVvsvUamCtBYywWM2eIi
         oDs/1zdU1WXmI7gDpNMGLdrdCvyTsMQjTz0IS7uftjXst7+BEKzRqQHwLZKqs33GMylI
         s6RUJLYQsPiDhiAc0unP0lXR7It93WaLCpndtJpOGQbF+0XCbmx+jqB/TPc2IVzq+rXj
         FSJlhladz5v1HtjhkpSR1MyQiFUdAVFihOeYQdcmrlwQ8SZ8AU/TbloiEceD9m0pCCAQ
         rc0hC4kQMCVMKUKS3P/WmjBFlm/F3FCklNJfngDoTZ4IP4XAt4nBlbQU06Fir4pDMlwW
         aqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eQx2TaUwh8Ijip8QcXaY6f2a/ThB22gwO6hBQo1xRKk=;
        b=SQe/6skTJbT2u1GwLlRHzL8rgKmnz114VCqFKxYIMbALZ1gyBFn4FGhHmJeaVgvzgz
         sQhsc050MA6azbjiI6YKPRKuRdk6ndvc5dMwosJnq5n4nm+OghxRRWB+hDWwoxijVlhl
         zLoza5JNKykClfjKCnmGMtZXMZLkWNfr32avaoM4vQPj1efHcrw7bcuaoKh2d+z7k5mj
         8CMLwDhE4mO48Dxxk8mrYu06Rw4VpoJ62c2kTVD4ivM84lXRRdn2X3GX/aybqmes7hgL
         0pf0ZIOmXE0F4+DWMudE2QmBdWLMkDLN44iEzbpfCFRJjmWO+M24YlkBHCnmZNNt6dcP
         SwZA==
X-Gm-Message-State: APjAAAXAPgSdfejBQTjwLP6twvy+vqZ6r/hTgzXu5tFz9U7P3SeK5We5
        nFo/fA4RBLdyr+zsjPv7BRpa3TfDXhdwtiWne8E=
X-Google-Smtp-Source: APXvYqyfYm4sjCg0Aw7QlltewS2Hu9Nae8VwqVwaIoOtaZa+VQOvWaN/B3kt6yVllL3jgH1XYGKq/axasCzfDXmkbP8=
X-Received: by 2002:a1c:1f08:: with SMTP id f8mr19380750wmf.97.1554805884278;
 Tue, 09 Apr 2019 03:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <HE1PR0701MB2652FC3F5D8E46EA93AF033AFA5F0@HE1PR0701MB2652.eurprd07.prod.outlook.com>
 <CAK7LNAQEQyEyj_ozkARj8xjDf7EncHeBv0GY8xoP8e_Fn-qaag@mail.gmail.com>
 <77e11884-f520-d983-3d33-ccc3043ba604@nokia.com> <CAK7LNAR_Py_4_pPEcxd7_ZpicoD6rnjb-iyq=_h893m=7q7kug@mail.gmail.com>
In-Reply-To: <CAK7LNAR_Py_4_pPEcxd7_ZpicoD6rnjb-iyq=_h893m=7q7kug@mail.gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Tue, 9 Apr 2019 12:31:15 +0200
Message-ID: <CAOiHx=nnz33DQhZO5o7vK2GBDcFO58D9_y7OgEodcUk4ZYs+KA@mail.gmail.com>
Subject: Re: [PATCH] modpost: make KBUILD_MODPOST_WARN also configurable for
 external modules
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

=E6=9C=AC=E5=BD=93=E3=81=AB=E7=94=B3=E3=81=97=E8=A8=B3=E3=81=82=E3=82=8A=E3=
=81=BE=E3=81=9B=E3=82=93, I got sidetracked and completely forgot about it.=
 I
actually still have my old tree with the suggested changes for v2.

On Tue, 9 Apr 2019 at 11:01, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi.
>
> On Mon, Apr 8, 2019 at 5:03 PM Wiebe, Wladislav (Nokia - DE/Ulm)
> <wladislav.wiebe@nokia.com> wrote:
> >
> > Hi!
> >
> > On 07.04.2019 11:04, Masahiro Yamada wrote:
> > > (+CC Jonas Gorski)
> > >
> > >
> > > On Tue, Mar 26, 2019 at 6:58 PM Wiebe, Wladislav (Nokia - DE/Ulm)
> > > <wladislav.wiebe@nokia.com> wrote:
> > >>
> > >> Commit ea837f1c0503 ("kbuild: make modpost processing configurable")
> > >> was intended to give KBUILD_MODPOST_WARN flexibility to be configura=
ble.
> > >> Right now KBUILD_MODPOST_WARN gets just ignored when KBUILD_EXTMOD i=
s
> > >> set which happens per default when building modules out of the tree.
> > >>
> > >> This change gives the opportunity to define module build behaving al=
so
> > >> in case of out of tree builds and default will become exit on error.
> > >> Errors which can be detected by the build should be trapped out of t=
he box
> > >> there, unless somebody wants to notice broken stuff later at runtime=
.
> > >
> > > If an external module refers to a symbol
> > > provided by another external module,
> > > this patch will turn the warning into the error by default,
> > > which is probably a bad idea.
> >
> > Indeed, exactly this should happen. You should fix your external module
> > dependencies by providing their symbols. Please use e.g.
> > KBUILD_EXTRA_SYMBOLS instead of converting errors to warning and hoping
> > that things will work.
>
> I know this option.
> What I want to say is, this patch changes the behavior, and
> may annoy some people.
>
> > Or how do you want to make sure module A still
> > delivers all symbols needed by module B after an update/changes?
> > Manually comparing the logs after an update or waiting until it turns
> > out broken during run-time? I wouldn't say this is a good idea :-)
>
> OK, so the commit log should record both the behavior change
> and workarounds.
>
> - If an external module being built refers to symbols
>   in another external module, Kbuild previously showed a warning,
>   but going forward it will turn it into an error.
>
> - To work around this, you should pass a symbol table via KBUILD_EXTRA_SY=
MBOLS,
>   or KBUILD_EXTRA_SYMBOLS=3D1 to turn the error into a warning.

This sounds like a good middle ground. When you do the effort of
setting KBUILD_EXTRA_SYMBOLS, you are likely interested in proper
dependency resolution and being notified if it fails.

I would probably still use KBUILD_MODPOST_WARN=3D0 to force the warnings
as errors, to have it as the central switch for the behaviour. So the
behaviour would then become

- If KBUILD_MODPOST_WARN is set to any value, set -w accordingly
- else, set -w only when building for an external module and
KBUILD_EXTRA_SYMBOLS is empty

or

ifdef KBUILD_MODPOST_WARN
    KBUILD_MODPOST_WARN:=3D$(filter-out 0,$(KBUILD_MODPOST_WARN))
else
    KBUILD_MODPOST_WARN:=3D$(if $(KBUILD_EXTMOD),$(if $(KBUILD_EXTRA_SYMBOL=
S),,1))
endif

(completely untested)


Regards
Jonas

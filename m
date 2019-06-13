Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30653C31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09ADA208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSkroNIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390955AbfFMQCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:02:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46783 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731409AbfFMQCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:02:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so21335056wrw.13;
        Thu, 13 Jun 2019 09:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nd6aCrSjzkm1aMj9lM4ssykkYiRccO6zWy49Uehvbco=;
        b=CSkroNIttf5ygpwSln0gQNWe5WrdTUnKsWGQygY3KEMqhMwh3P134Gc2auf/eb4mBx
         LisWgeOU85BPWmvQPgkxLPQFf1rHZtl/OuOJIFDzgNf4DOff+pVvSFehTEd5EaHF92fo
         tr/YC+MER9kS+oAnHJsy92hT+BeBXsKIY+w1lXfG+V300DwROLHFa8/AF4EcgAFmuldZ
         6efyDI9zq5ja1+FWDA1zIvC5VHAzEeFBQapVtTHLLAa4+IDEbMSA1/kcoOo3Ldbqeqts
         Om8CvV5KGB2rbs8My7Vod1OlIkxH8gTecLwfDYIJLspPGjtO0NPQiL/iddPgQfcD37ZN
         6P3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nd6aCrSjzkm1aMj9lM4ssykkYiRccO6zWy49Uehvbco=;
        b=lEHwJ7/MZxdePV/b18QyGSm7qzF/5TKRaLMJd/0fUzysL9+UN3X+ZnaOQjxQqwOqZ2
         8vGSAe3qzHw2O/23T9fpfB+LNGyazZUoKD9IBH67rI970OoZMIcvRU3E0U4DvWqkcdXN
         1KxxiyqO/wvcb99wlLeWdG6KVeo7wYiaJ9NqVtsqHpY4XBuR80L/gSPCadBpB7dHAzpH
         kx8kOc7kS5lLJ6d4u2HM1XjSAWt15gOOE+Ve7texGT4Pqc9pbkeNtupR/njU7+QsUBXn
         HK0PgnWFaPm2tZAftID3aY2HwuGKNIcb8/ZEtSFUzoOUdyx7vPs5YRx8ZMBL125ye1gF
         ttLQ==
X-Gm-Message-State: APjAAAWIUMuJDBjE1nuYgffNmsYxvpEUe7KZE4JnUbWEptD/UB4/A6Lf
        VDFBMTGUrisymnSWZ4vPUnfCEHoI9d/hb0gYpFgLdZeS+fs=
X-Google-Smtp-Source: APXvYqxklstUrCVZEl1VUef3v/R6i7njg2hNjeLXXhKtOb8qhxhCjhXDazqTZogY3rUjkKvHqdX1ZOlDh6IiYA968oU=
X-Received: by 2002:adf:f68f:: with SMTP id v15mr10246252wrp.4.1560441732659;
 Thu, 13 Jun 2019 09:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190612170027.13dbb84b@canb.auug.org.au> <9b4f8e15-8f9f-51d9-c355-9c2e453921e3@infradead.org>
In-Reply-To: <9b4f8e15-8f9f-51d9-c355-9c2e453921e3@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 13 Jun 2019 12:02:00 -0400
Message-ID: <CADnq5_PRoeCdriQgzV6yKUpFHxpWfHL2Xwd9VW=FRoNYj7H_kQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Jun 12 (amdgpu: dcn10_hw_sequencer)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 3:27 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 6/12/19 12:00 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20190611:
> >
>
> on x86_64:
>
> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: I=
n function =E2=80=98dcn10_apply_ctx_for_surface=E2=80=99:
> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:23=
78:3: error: implicit declaration of function =E2=80=98udelay=E2=80=99 [-We=
rror=3Dimplicit-function-declaration]
>    udelay(underflow_check_delay_us);
>    ^

Fixed with:
https://patchwork.freedesktop.org/patch/310016/

>
>
>
> --
> ~Randy
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F71C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5F42081C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZapprxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfD3Q0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:26:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38606 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3Q0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:26:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id e18so7481270lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ddCJf1YFz8rA9DAzcZDKHt4qcSw5YF87Zwjmn6TTLgQ=;
        b=tZapprxtTa/zkdCqeQtj4TcNq9NfSDAlibhlVJo2licOsObGHwRLBrIBu1zL/JtVQD
         8K4/ZU1yTehXX2Ky7Fs033NsXRDf0VEeZMnOMtQMCJbZTwn/txNGL+GyaGFZ0OTbJWq8
         2EoXncyDNeqsUsHtuxW1CAVHWLM8+/BADn/F3VAXiuphoy66PsfupG/VmCpFshONT41/
         eTIyEEeWtYW1ySTRqU/vkugUd7lG19ZP8hJrCXbkzt2YZAzXmwQdzy0JmonGQEroEbqU
         UrsrBdf4e6nclu9Vm7C+jv4bfnv6cZf5gGH2cX0of5XTz7RZHheg9vlod4RizmXAFIzc
         iIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ddCJf1YFz8rA9DAzcZDKHt4qcSw5YF87Zwjmn6TTLgQ=;
        b=jyz353iCyvipNLqr3P0f1j6CWggJuq5aX4ZgklgnBk9h/89Vkx4pFeDBfNET29i3Bo
         6hAikN5qCClCdJL0Fm8lxAmJxSIGz98GEMndwOapiE+1wW/WatcmTT7//rmpBADUkGUK
         r/AvyGA3Eqlz8QAdVQARRwQJQbdXEVFCsrjYfEs+0vMuSxSpnsFQaSAU2jsMqYWF//zY
         f2JH0JFEH/lyuXYZronRA/ltBpY+sUesOxIDm6ZPoAm59yLFIkJbF5K7CqfBTBFZFzi1
         shApNU24MuzlUfBqmQJ8VJfpSdtHYTmapgEcbIGT0EO60+eUgThdLYvhm9+EJxljDt1O
         1hKQ==
X-Gm-Message-State: APjAAAVO4DHVAVe1JiktFceMJ81Txkqag8/xaZSLBtltIykrHsmVb17X
        nci55cuQCdwvOnSSyMzg7tSTwcLLwPNRmHL9zjY=
X-Google-Smtp-Source: APXvYqy1phY5J7LnTZQNjEpIIFzUXXXwv1OgOWpswwtC9tH9nkB5ncNQLVFA7+s1oTiDm9Wu6cc8fcjxH+xF/IAAfUA=
X-Received: by 2002:a2e:8794:: with SMTP id n20mr38305019lji.76.1556641582066;
 Tue, 30 Apr 2019 09:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <a45b70bae964b15317167304a89ba1094a769916.1556640947.git.agx@sigxcpu.org>
In-Reply-To: <a45b70bae964b15317167304a89ba1094a769916.1556640947.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 30 Apr 2019 13:26:14 -0300
Message-ID: <CAOMZO5DBzG_9SLQnjXBdb1+7rbR60t7gqjfuYY7SS4jTbOEY8A@mail.gmail.com>
Subject: Re: [PATCH] amd64: mxc: select CONFIG_SOC_BUS
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

On Tue, Apr 30, 2019 at 1:18 PM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> i.MX8 needs soc_device_register, otherwise the build fails like:
>
>   aarch64-linux-gnu-ld: drivers/soc/imx/soc-imx8.o: in function `imx8_soc=
_init':
>   soc-imx8.c:(.init.text+0x130): undefined reference to `soc_device_regis=
ter'
>   aarch64-linux-gnu-ld: soc-imx8.c:(.init.text+0x130): relocation truncat=
ed to fit: R_AARCH64_CALL26 against undefined symbol `soc_device_register'
>   make: *** [Makefile:1051: vmlinux] Error 1
>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
>
> ---
> This was seen on next-20190430.

A fix for this has been posted:
https://lkml.org/lkml/2019/4/24/256

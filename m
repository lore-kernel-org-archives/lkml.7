Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25192C3435C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5915524765
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="NnxJs1r1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfLMSbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:31:44 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:41313 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfLMSbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:31:44 -0500
Received: by mail-il1-f196.google.com with SMTP id f10so214718ils.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 10:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpB/xeUDM1+yO8SMRMjK9hxdyXvy8qn++zhfg+M4I6Q=;
        b=NnxJs1r1KqtlMmXaKnm83wZSyJ65551miQeW3U3EvBC1r1sQrTLC+QIbM050I8w2r/
         vgTCCNig/abM137ibwuQw+92bAx1Sfh3A+DspSFTewAoheB3YfSKANcubKFg6zVLAFu9
         u0NO1SaGNb4GEsOWy5T7umHFtXhDaqCUBW5tub+wE/L+9mVw9wPsgoPejjGa9Z0VsHDz
         boHMaxoYdmjrKEUHUd5ziYLGbTDJXe8CCDdbV3CbOi728N93DApHwWAGb78JDsRu3vOb
         xIH5CzdSOY2lVnqCWyGYfNjOcQ+8uonNmPNy0WHLvNH+8R9FlFpCtxeX61Q8OZBiL+2H
         OGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpB/xeUDM1+yO8SMRMjK9hxdyXvy8qn++zhfg+M4I6Q=;
        b=pOYdU+dT8xsRGqS2yl8PnnE5BRZZdCw+MgCvMu3zqDwgnd9dUraXRrWDYZFSLt8Vpg
         GvrRWsfI/ZTI8YPQhHFWtkW0aSUK6gCPg5BGkYFJphK4T6ql8PpG749GjFtC86ddjSmA
         Tf0WKEi0gvUZQ8xXJsjYlN86Lshl3eKWdJkaPHwDu/pQ26TV1xvj3WawtyQoHzcVOS+L
         m7Yat2DUmUAS5VTZs2FrXi+UFuYzR99HMEQBmQ/7VgNv88FDI/OvglQeh8v//HiIY8kc
         ywbrFAn6Sxa15P6G/AxCkgxh8zp3u7r0b0NGLiEqOxCloGyrW3fnqxwRxz14EdOetjWh
         Na7g==
X-Gm-Message-State: APjAAAU+bTenquGB+M7xhoFUmrmYni2wnrNKtjMqRf/SpvK8WfpaYfhE
        Pa/ncjzDUnIQ5yi3gVOTTUMpHILDLFm4Bt1XJ05qvQ==
X-Google-Smtp-Source: APXvYqwqKI1k9m7CKtca2pmdvVz5aHQxyrvRxqEo2nHabNcDV3oy5nCgJHZVFEPpvds+l9dkkylLJBJz+HgYesKXjvA=
X-Received: by 2002:a92:1655:: with SMTP id r82mr707357ill.72.1576261903292;
 Fri, 13 Dec 2019 10:31:43 -0800 (PST)
MIME-Version: 1.0
References: <20191210203409.2875880-1-arnd@arndb.de> <71a8139e603f697c734134faedfb3ce87067918f.camel@v3.sk>
In-Reply-To: <71a8139e603f697c734134faedfb3ce87067918f.camel@v3.sk>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 13 Dec 2019 10:31:32 -0800
Message-ID: <CAOesGMgVcoHp7W5QPu=ZXTMe1BcPOXOS+6vQOasXAZRyj_nC9g@mail.gmail.com>
Subject: Re: [PATCH] ARM: mmp: include the correct cputype.h
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Arnd Bergmann <arnd@arndb.de>, SoC Team <soc@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 12:41 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> On Tue, 2019-12-10 at 21:34 +0100, Arnd Bergmann wrote:
> > The file was moved, causing a build error:
> >
> > In file included from /git/arm-soc/arch/arm/mach-mmp/pxa168.c:28:
> > arch/arm/mach-mmp/pxa168.h:22:10: fatal error: cputype.h: No such file or directory
> >
> > Include it from the new location.
> >
> > Fixes: 32adcaa010fa ("ARM: mmp: move cputype.h to include/linux/soc/")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Lubomir Rintel <lkundrak@v3.sk>

For some reason patchwork didn't reply to this, but I applied it a
couple of days ago.


Thanks!

-Olof

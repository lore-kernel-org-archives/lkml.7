Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42C6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C03C222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFlIKo9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410435AbfJROZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:25:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40602 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410221AbfJROZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:25:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id 7so6431039ljw.7;
        Fri, 18 Oct 2019 07:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zpJMEPQDbJ/nc0AxzGGMfqLoipEdDfIG0ggcFKC9RTg=;
        b=uFlIKo9hsERR4cMkTwacTzHhUYTV42DVmed9NkXV8r9CIO9DSPt4+iSgE0p4O0BZRQ
         B5umZSeU01xKbF/zYnjGEXeEOydqyWWDHVu2/0OONZuWOGos/XzZV8MBJ0O4Lwwpvid1
         WZaYk4BiBZRs+OmjyN97fnpBtQtmJErzqpodrjSq7j/1dAgq193uvf4Wzu2sJvH634d7
         JXgr0mi/kNUFf5e3QB6CRE4PzCwMbNw2U1aDv++fYHIXwbwHtv+InbpSWkbNlQFawFxB
         UWMvm9draBFBKtzZc7asykvy2zAoUX6ycz/iDw43CgKOdMkINWi4d5wvrHoZPYsR0WWe
         JSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zpJMEPQDbJ/nc0AxzGGMfqLoipEdDfIG0ggcFKC9RTg=;
        b=M+uCvbzYpS0ujt0x4BtY68zR+oZHOAn8aNTPY4tasWOL+JLdloJW73Sgj04r6ztcGB
         z6EovTFEHaVlnGDOrEdPsb/5qK8MHCf6T89ou6PhcowZUz2x3NHRoq0WZYcU4OyhewSi
         i76x7XLI1yZ+HkOJ9PG4yWlcN1EmkV6kev9HyfU9whOdDEOS1rbS1xfScY7moXaAKJVL
         sRACS1ypeZ1toOgwi0qj3M9WEWu5IDoF0qocwpOAIPomRy6GYCS29LDsd9gLkujVb9Rc
         vWUVKLMknI/UUsMxSq1DxHic525IU6gAEN8NB74wzqVKluvhuYqoX0cLBECH62avlxy4
         J9zA==
X-Gm-Message-State: APjAAAVcPErmcnrCLEuAuhyF1wx9bVb3w4YCHDURzad9Ak439P3n/D1N
        t8MLSuFtn6muJ1GG7kUo1ZT3hUVIrSMDQc4Ma5s=
X-Google-Smtp-Source: APXvYqxvNw28jGvJ8QSk8fxvUbDSflOXpJikLOYCqFn+/NgZg58SC7ASIwkLHBvwrprjAZGfzfQl2eC2FAoWTL7BTHI=
X-Received: by 2002:a2e:42d6:: with SMTP id h83mr6317728ljf.21.1571408731603;
 Fri, 18 Oct 2019 07:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191017070923.6705-1-peng.ma@nxp.com>
In-Reply-To: <20191017070923.6705-1-peng.ma@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 18 Oct 2019 11:25:21 -0300
Message-ID: <CAOMZO5AK+wv0vAfqv7PC-gYF32MSD9nMqFCuRmLxMN6dYZdvGA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: fsl-edma: Add eDMA support for QorIQ LS1028A platform
To:     Peng Ma <peng.ma@nxp.com>
Cc:     Vinod <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
        Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Fri, Oct 18, 2019 at 7:08 AM Peng Ma <peng.ma@nxp.com> wrote:
>
> Our platforms with below registers(CHCFG0 - CHCFG15) of eDMA as follows:

Please be more specific: what does "Our platforms" mean?

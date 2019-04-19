Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DATE_IN_PAST_06_12,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09B1C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1DA20652
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="odEyI40I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfDST7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:59:16 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34555 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDST7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:59:15 -0400
Received: by mail-qt1-f194.google.com with SMTP id k2so6510542qtm.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zEmYG42997fsyjaYaZmaE1ykRnRfersPFJ/oD0sTshA=;
        b=odEyI40IMvi5MP7tCDzVdVz1h+UaPSmAnGKHWYL7fBgaugTj+icrxtGTbsirJXeW6A
         X9KcgDI1v/VUw1c4nl3KmC4Rxsnc/49z2OdwF4YNtoqKI1QfHVkmg/SRM+CskNooaPuo
         ohJMA0w4+y2400eQgKBYsJ9zR0firFE70aSZK1EfKHosfYjfK8S0IPB8tlawT0xD+X2y
         QmZo6N4Pk2xtnQJVDYYL8UdW5r8yOwpLWMEgH1r0GW/ZcseINxpycBYqTkrZNTnBGCM3
         Ctg9/4/q51urI4JKXl8ZogisRkjcnBpRcPjl4+cL5sfU4n3MNVqEKyG/H92S9blTQz6U
         Rmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zEmYG42997fsyjaYaZmaE1ykRnRfersPFJ/oD0sTshA=;
        b=bRAJ77mbYPF9YFTuvvMIiPgcnpEjZFhc5oB6ql9kD/JogqBGyFS367pGVo2TFni4UB
         rzZVeJavUypJK0b4//HxXk+h31Y7fZtIbjTvT1T5FyMIohUXHN4+lIH4+xeK3YUVIxkn
         6xe05LQZ+QoEdK6il2aEcTOe4WdvciNCcIWgHk49UeKhyCVP5ZaAxgLjv/O0KqdI48+9
         B+whdZhUtIb8jA+0iOvwuHuCfurAT7XPnY1K9BPWziMcOfYNPnVQjI7ckqhxBGFBtFjF
         6wru8s/Aato9X9ECpDybt8KaolXPX7DBJo/W6TIyIL4w0aifn+kIRgNwcUVSIQN/GprU
         GV5A==
X-Gm-Message-State: APjAAAURF1BOmJQq5ASs/m2fotEuYOvMW5IXg9rUHLyiGDBKFQhbzwez
        chg2oSgW0ynz7wQEizjdxgPIlRTjGYlMmPL+RsxpjSzIJ74=
X-Google-Smtp-Source: APXvYqwMFmFw/Lfml+YwoIXZS2kKcaDnjTcMWLqZcwLMyZPz7TJsUjPIatOXfdVIYIWURJd51WexAbmzC4xTTxxq17Q=
X-Received: by 2002:aed:3ac2:: with SMTP id o60mr3247300qte.158.1555677395126;
 Fri, 19 Apr 2019 05:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190318100605.29120-1-benjamin.gaignard@st.com>
 <20190318104343.GA15574@e107155-lin> <CA+M3ks6bsiGXCKEQmaFmzBRhWPVhV5wBjVhgyfCa-25DohnsOg@mail.gmail.com>
In-Reply-To: <CA+M3ks6bsiGXCKEQmaFmzBRhWPVhV5wBjVhgyfCa-25DohnsOg@mail.gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 19 Apr 2019 14:36:24 +0200
Message-ID: <CA+M3ks6g474AAVoVAvno6sJ7b7Hw4f1+bqod74dtrR9fULqsYw@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/7] Introduce bus domains controller framework
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        s.hauer@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-imx@nxp.com, kernel@pengutronix.de,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 18 mars 2019 =C3=A0 12:05, Benjamin Gaignard
<benjamin.gaignard@linaro.org> a =C3=A9crit :
>
> Le lun. 18 mars 2019 =C3=A0 11:43, Sudeep Holla <sudeep.holla@arm.com> a =
=C3=A9crit :
> >
> > On Mon, Mar 18, 2019 at 11:05:58AM +0100, Benjamin Gaignard wrote:
> > > Bus domains controllers allow to divided system on chip into multiple=
 domains
> > > that can be used to select by who hardware blocks could be accessed.
> > > A domain could be a cluster of CPUs (or coprocessors), a range of add=
resses or
> > > a group of hardware blocks.
> > >
> > > Framework architecture is inspirated by pinctrl framework:
> > > - a default configuration could be applied before bind the driver
> > > - configurations could be apllied dynamically by drivers
> > > - device node provides the bus domains configurations
> > >
> > > An example of bus domains controller is STM32 ETZPC hardware block
> > > which got 3 domains:
> > > - secure: hardware blocks are only accessible by software running on =
trust
> > >   zone.
> > > - non-secure: hardware blocks are accessible by non-secure software (=
i.e.
> > >   linux kernel).
> > > - coprocessor: hardware blocks are only accessible by the corpocessor=
.
> > > Up to 94 hardware blocks of the soc could be managed by ETZPC and
> > > assigned to one of the three domains.
> > >
> >
> > You fail to explain why do we need this in non-secure Linux ?
> > You need to have solid reasons as why this can't be done in secure
> > firmware. And yes I mean even on arm32. On platforms with such hardware
> > capabilities you will need some secure firmware to be running and these
> > things can be done there. I don't want this enabled for ARM64 at all,
> > firmware *has to deal* with this.
>
> We use ETZPC to define if hardware blocks can be used by Cortex A7 or Cor=
tex M4
> (both non-secure) on STM32MP1 SoC, this new framework allow to change har=
dware
> block split at runtime. This could be done even on non-secure world
> because their is
> nothing critical to change hardware blocks users.
> For example you can do "complex" tasks like display pipe configuration
> on Cortex A7
> where linux is running and handover the control of this hardware block
> to Cortex M4 to
> offload drawing on framebuffer.
>

Gentle ping to get more feedback on this series

Benjamin

> Benjamin
>
> >
> > --
> > Regards,
> > Sudeep

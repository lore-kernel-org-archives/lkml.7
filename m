Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908EAC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D2F20675
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgduG/cM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfENI1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 04:27:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33956 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfENI05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 04:26:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id p27so21661770eda.1;
        Tue, 14 May 2019 01:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8pF0Ay0b8Dgr2gdGhko9AZ082vGA43NgkUHSE5gdgZI=;
        b=OgduG/cMoh/3Sc/Gxac9dWTtWdVzzhFzEWOo95wV8BHwox3PuUmIk5DfLw+wrNKHFB
         jklYPI1DcXqo2DsLHuQmmG8YsjwEXNmaBTc4wNPoGxlRfPMS75lojToepR9tV6tBq6JL
         QCZBAzpEJ84AMXugniFV3xZ/S5ERhM65zI2tUmy8YzJkvRSi1PqlbVK4eymKbz0r2STD
         M+r49IJVSHzKJ6/syq4E3EBoXrE9uhAUGmqnr7hZXqHUC5+CMnHClRhKpvzlIK1ZiSv0
         felmRjiC/ujBmPn9IqF8Z/2BPaDts1CQSOwrXi+nV+EQNFnz5cb2n7RUEz/Wgsvfrixf
         10mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8pF0Ay0b8Dgr2gdGhko9AZ082vGA43NgkUHSE5gdgZI=;
        b=g0gYKmTTXhleGUHF6V+N1rjjxt9Q4hb5aRG6CRfjpejxmsRWt/RHB4Sl7J62UOqSLd
         EQbHoN2NPgmKYI89LDqfM/tAVB/3+OKc1dXe8kccFYG9uaUaKwwuO+XFqp87H5PsNW8C
         ST5/dJdRC3XMLIH4Onx7XK5/6B6XjMJBUQiOPiIhuJGFWsIxy6AVKgagoDRaW4O4x1RG
         9qCoBSnE+ccHEZWCq25qQAJxdPbTcRqkUp4Nd4fXVtTjNIopxV7REIRf/U5Ovr1h7kij
         EAUWb3diZ24L5d7+EeDfU6Qj2gdFL2lxj22CoYFaNcWsRavHbMZuRqqiCxHy5xr6grjJ
         OZLA==
X-Gm-Message-State: APjAAAX8kyXE5jHrHYg0HLMvT5xOwhn48JbYSU+hMPJm2sqfuaxHFMPA
        lLwQrIwvG6dJUq6e537gaWyK4Y2CTV6hLoV3+6o=
X-Google-Smtp-Source: APXvYqyJwXW1r146kB+f/e6hzh6KUROJ54XMwp/FqVdMFYzgc4rAU//wq4xtndEhJPfjzVSFFS+EgYWH0IITInluacI=
X-Received: by 2002:a50:91d0:: with SMTP id h16mr34769727eda.265.1557822415775;
 Tue, 14 May 2019 01:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <1557813807-3919-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557813807-3919-1-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 14 May 2019 11:26:43 +0300
Message-ID: <CAEnQRZBNHXHvUu=90DZQzZHM3gp6sABPPbh5yfGQrrd5jdCRhQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: Remove unnecessary blank lines
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 9:09 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Unnecessary blank lines do NOT help readability, so remove them.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

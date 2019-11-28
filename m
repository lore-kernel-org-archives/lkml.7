Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17007C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90732176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+E4ygaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfK1IQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:16:22 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40001 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfK1IQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:16:21 -0500
Received: by mail-lj1-f196.google.com with SMTP id s22so8450523ljs.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 00:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dlwaqEfjT5graM8RWQ1ek299Dj4eK17tSarlzL5nZUM=;
        b=l+E4ygaS3q5mYwlHDuFCSXQ77eYxgnZq4FdzjB4K2crLne5PNmNtouWf5MmH+0mP+a
         KyoynhY40PGrUD+TebyOwFZ7I8rILisxXtwWvkjSjp+QFIcKF3t6ro7XSoXsUbsGa8uH
         XHyTKCRmj/e/0OnKWOD2Y7d+xWz/TgL9/VHd5f1gwQc0UxFZ7PH3t3xWXhoCptaVW2I1
         QmskW4aj5jbewzlKdZv7gv1VOEU0aFmTaAujR/2y70Cbdydft/nWRUpxbAauXDasusdc
         q2007xskJ60GRtI5D8u2I2U9rHNvg6+7n279miEuRgOumNA8L9DgosI68SPwk/58zh8v
         WFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dlwaqEfjT5graM8RWQ1ek299Dj4eK17tSarlzL5nZUM=;
        b=gQ16TFmBB6ltH+DWAyjVg/7ESoIGebGaxIs0YBF7+vea43pxvmW3tcCBx2EiWrjp3+
         hPN7ic2oaiPx7RZsmunNAYs03sIsCoDYJPt+qsw+UJNxZj7QOSg7P7b++23XqTGzMZ21
         kb0Pb87s6yTzVl6MQ+ezjTrHjpTjN52f7rN1Cy77gfn+kUJ4+chY/SD9CANQiOJGNm42
         s+JS7qeKo10e0Yf7QRFk4SVFsMX/ng6uACYNr741pkaBRRGbnzwFl67px4Uz78kOBOc7
         Pr4U6/uK1TGtqs6O1RgVEEGDoKpBqX/qm8dogMgKBVxXnn5tPgBkgt0SzqLz/YewuJvi
         YeEg==
X-Gm-Message-State: APjAAAUCOCqLZLXUqfR7rBP5Xubv7LhDxJKcMz+Z0YpxbspL0tak9MK8
        V+LktVn5JcJzB4cjsqq3m3X7FG1HHYhPbQrApFC2bg==
X-Google-Smtp-Source: APXvYqyTE9eYnDMIvHYYYoLUZ9fGJAvAWhf7bt6cQqx4sbnSjEzG3In1wSpDQ95JnJ/UyfSwZGmvFUTCfZ/EW9cdkyw=
X-Received: by 2002:a2e:9699:: with SMTP id q25mr33605730lji.251.1574928978081;
 Thu, 28 Nov 2019 00:16:18 -0800 (PST)
MIME-Version: 1.0
References: <20191128080832.13529-1-rahul.tanwar@linux.intel.com> <20191128080832.13529-2-rahul.tanwar@linux.intel.com>
In-Reply-To: <20191128080832.13529-2-rahul.tanwar@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Nov 2019 09:16:06 +0100
Message-ID: <CACRpkdbKE6eHsyuCM5oCkhj=bP4H=omiFfdA6qf+g7xQzJBYQQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] pinctrl: Fix warning by adding missing MODULE_LICENSE
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 9:08 AM Rahul Tanwar
<rahul.tanwar@linux.intel.com> wrote:

> Fix below build warning
>
>    WARNING: modpost: missing MODULE_LICENSE() in
>    drivers/pinctrl/pinctrl-equilibrium.o
>
> Introduced by commit
>
>    1948d5c51dba ("pinctrl: Add pinmux & GPIO controller driver for a new SoC")
>
> by adding missing MODULE_LICENSE.
>
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>

Patch applied, I will send by express to Torvalds once the build
servers are happy :)

Yours,
Linus Walleij

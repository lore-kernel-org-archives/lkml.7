Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A23C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE6E206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="objkV4PX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLMIuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:50:25 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41449 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfLMIuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:50:25 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so1740832ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 00:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TGgb7xwhgScP+ifEx1vNfgq3tAn8rJOgb6ry9uS20cg=;
        b=objkV4PXcaGRC6MoR4cG6/mR3b7u4z4WM27nfvbBbflWIhpPa3OynS9PUftR8Nr+ew
         sxCoFCqJgdnn6bpGCn55nFrbny6jIIsNv4BW3i35xkjO4pzLHdA8iC4FNOEPSUXevV+N
         4BwBCXxATa6J6IozF42yIxaqT5pbGofnLs3cYsfbhBUa+DYIhmmL0DgKTMgfvWStB5zV
         Y5XceQ7TXee3FiW3dEO6vup+elwX5Um9TB7F87XzcHc5bN2XyiOarGKkwiDwdBuV82XD
         ULFNA9F16xN1LPVPs0Lqmbx1BWk5pDfDUbORtYvkAcNH8KUX0XvKn7CzrCrLu0P4ZlAy
         cpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TGgb7xwhgScP+ifEx1vNfgq3tAn8rJOgb6ry9uS20cg=;
        b=I4lWzg6Vxl3gn3E4aVB346ZmiTZjSEhKrszLcS2lZnxIyCSbEFc7W33f85hdTMmkHX
         nsEMf2L89AAqL51hswkXscpXPSS3V8+6Nb6EHhoI13kEs/26TqFRspL/zyHOFmi6uDyJ
         dtPnrXtxr+umxYS9dV5rlZ0K80w+Uono/+e1cPZTWlireuvwBCzfyHQPHN2JqiWJaQw2
         CfN2Rn5e0Zj5IBXc1Kb3Et3cx7wOn6+xVRC8FlyZQ3PTiHNThiDSAufiK6dgLrgvvSMK
         1m56oTcYmx2KDUO96QBolNDgcgTbSArI90jc9fyiQMWSZOi6zdp+QxAac7G36Tda+nts
         VY2A==
X-Gm-Message-State: APjAAAVsv3L9sBEzjgoNWN5j0VDV6k7/DBKSLMsiF9BsJdBi6x2Q7/Rf
        xCmLyHbjDY8vCIgNqW9nKrnikjp8qmVxIhRFbEejDA==
X-Google-Smtp-Source: APXvYqz2zgNPGMAvQfaiNvHxpSznCX04/tg0GeCVZSPwo2H7kSuIfZUvu+UYZEXnmdu9PEj35q7sRN9F/PMLgxMgiuk=
X-Received: by 2002:a2e:8045:: with SMTP id p5mr8733783ljg.251.1576227022964;
 Fri, 13 Dec 2019 00:50:22 -0800 (PST)
MIME-Version: 1.0
References: <20191203141243.251058-1-paul.kocialkowski@bootlin.com> <20191203141243.251058-4-paul.kocialkowski@bootlin.com>
In-Reply-To: <20191203141243.251058-4-paul.kocialkowski@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Dec 2019 09:50:11 +0100
Message-ID: <CACRpkdZjZjP4WM26tpjFiitrxHkVGPtpAOe5odhqw5QqRQvZ1g@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] dt-bindings: gpio: Document the Xylon LogiCVC GPIO controller
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 3:13 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:

> The Xylon LogiCVC display controller exports some GPIOs, which are
> exposed as a separate entity.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Patch applied.

Yours,
Linus Walleij

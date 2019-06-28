Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88B0C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889CE205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IKVorRDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfF1K2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:28:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33305 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfF1K2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:28:24 -0400
Received: by mail-lf1-f66.google.com with SMTP id y17so3656190lfe.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 03:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uNia+wXcww8hJhPTXh8yCLt0TR3O7aaW7PyNXd3ivCM=;
        b=IKVorRDRsqKEUM0hcVl2t5iU7B8+N4xQ56gnE/B0TdoxPE0f06DGV1Th3bnGVPq+1i
         qlOJbbrdlJWGYB2HGyV/JbdKNdMgZH9cyHeWFO9XiY5LT4+XFkdj4mO9fAtZF/PIRgRL
         QsOfuUs4WXfJQ9yaUWnoReSSMZtIgKJlc1k7j6J/e3aNmQoK5MC7YHX0WpUu/l6naqlC
         UFNH2eoSon5kdtoLPbZLbBRvk0s7tiEQVtwKkuuyAUuftFUTUMqeSmFrOXbLfmHfotyX
         k3wxCIRXYcHy6YjAhtcIkgNwuzbYoSWXsk/UZx3BWa6ZCuJupTnj5F5XXV3J4GKI/RjQ
         emoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uNia+wXcww8hJhPTXh8yCLt0TR3O7aaW7PyNXd3ivCM=;
        b=JMOsjYhGKkN8QEbCxsVYLm3Fs2YjsWyRj0OsnKy03YrFXvN3iM49HUVVUwnFuCz4gj
         Q8C22NMIbsuwrF7xnOclGWHJny3WA99x07ESySqoKJaO5H/os4Gv1yKxtGhhUOD0c6Cm
         sjjd7uW3uf7l1GzGC4oCqbOT94py2SL5KdzCI2yCYOSPrcF81ZwF9H0Bl3ImFRC3vPXa
         vbDuYLr0qRT8aHjeUVRdTm2BaIfjKgrfSPD407Oh5rDzgpZQxy6t8jw46QUmFl0alRXK
         yuMXMfQi6Tnn7Rfff1oiakWfk0YZnCxNqaUZZUkSw4mhUotMxUoMl3ygXC3CRGC8VAco
         EnMQ==
X-Gm-Message-State: APjAAAUinh0b9pJlCK0TbLMUMkxtwjxmuQc+6y/M1p8jJi5dMHTqDFBw
        luF/Yx/Zvfj/j3qopBbGNRm5XMLnH5dhA+Pw4JwBhA==
X-Google-Smtp-Source: APXvYqyTSELuCwdqtXQ6xfh9OQghPYDZrodDsVKXcdIIzGQolnUkGedUB3xgSLIxsiO7L8/FxlqG97FHQGkNNX4PzBg=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr4549883lfu.141.1561717702644;
 Fri, 28 Jun 2019 03:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190621111352.22976-1-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20190621111352.22976-1-pawel.mikolaj.chmiel@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Jun 2019 11:28:11 +0100
Message-ID: <CACRpkdYD7Z7XX9wXFtBehJG_4NCt=m_MNsR5cESPRnO3tomKmQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] extcon: Add fsa9480 extcon driver
To:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Donggeun Kim <dg77.kim@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 12:14 PM Pawe=C5=82 Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:

> This small patchset adds support for Fairchild Semiconductor FSA9480
> microUSB switch.
>
> It has been tested on Samsung Galaxy S and Samsung Fascinate 4G,
> but it can be found also on other Samsung Aries (s5pv210) based devices.
>
> Tomasz Figa (2):
>   dt-bindings: extcon: Add support for fsa9480 switch
>   extcon: Add fsa9480 extcon driver

This is surely an important driver since almost all elder Samsung
mobiles use this kind of switch. So
Acked-by: Linus Walleij <linus.walleij@linaro.org>

This driver I see is already sent to Greg for inclusion in the next kernel.
I just wonder if you guys are even aware of this driver for the same
hardware added by Donggeun Kim in 2011:
drivers/misc/fsa9480.c

That said I am all for pulling in this new driver because it is surely
better and supports device tree.

But can we please also send Greg a patch to delete the old driver
so we don't have two of them now?

The old driver have no in-tree users so it can be deleted without
side effects. Out-of-tree users can certainly adapt to the new
extcon driver.

If you want I can send a deletion patch for the misc driver?

Yours,
Linus Walleij

Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E79C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0630B20675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="j4Q5Hgg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfD2TT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:19:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45056 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2TT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:19:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so17632123wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 12:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=o99xvhRC5sFnq6ftH7UC6NOUl2mc2F/JHhODAhGJmOI=;
        b=j4Q5Hgg/pCWearQ9tNJdFKlIxNWXnA6VxAE6KZm5OKrvP3gX5PC7sXVA5OXNSxSAPA
         JfwKDfUYySqqmZByUh55GXaUq5RZ57lsty2Tjny/b/+5C5ERKA8raqBc/WuJ57ANtFnc
         m8espR+RY2lztpXSY1nTpQlqFiqZDuXIP9T3VZ/aSIikIKh0dlLqETf+cZldoCejkQv3
         Oq++XXVNkYPGJFPj6AHRlXRjeAMUFm2vKIZ3R+psEgjITF8A3xa2EFCeWZ3TE6vsDS8B
         2TYJ5P98wMFyraYxFHJigGr2MskC0DCNDNQRmryXw7idPHKFaWgpMSU4pJPFTEDKg8UU
         ifug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=o99xvhRC5sFnq6ftH7UC6NOUl2mc2F/JHhODAhGJmOI=;
        b=B5hpj9gUGiNNL4UykZ6dFUJPcO+qKjJX0Nfq+odcPvHiMvI1KZ1pY4XSKJEbi2c9Qv
         n5ikR7npgLLP8wYftLoxBCFuXxz0LWOO9KOX7GEp6awdgG2BUPHHSRz66kS4+Bus0RXP
         rZ6xEClpB9bk1ladantMV2ypoLtegPlvBGpTjgyIEaNVH10BxrKKDhwet/KMadfdEqyy
         2kHILbYVwOjMduRBadNIS2cvxWBBa1LAXCF6qjyaGMgkPhoNkruYuFnWBKwLFly7xEQg
         aelg7/M+VjVS1SjnTdR40oG+uqWrsV0E9I8BcDcEdKQQCtp/CUY2U4XIirBt3I+yl7JV
         Dxtw==
X-Gm-Message-State: APjAAAW+iiK99fkrqyJk+Zo0YYWysq29BoNqQjynpS8UpJ1Ix1oMtBEW
        fyNqi2qEN8k9qTqmV2WOXf0EtA==
X-Google-Smtp-Source: APXvYqwEXr8OYIPTGri/6F9PHbn5e5LQun9eok/Rf+idtRLZMn4WX5GSh+J0vBLZTxGXNwVeC+JJnw==
X-Received: by 2002:a5d:5343:: with SMTP id t3mr5278260wrv.262.1556565596087;
        Mon, 29 Apr 2019 12:19:56 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:f580:39a4:9be7:1974])
        by smtp.googlemail.com with ESMTPSA id d10sm551143wmb.15.2019.04.29.12.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 12:19:55 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: pinctrl: add a 'drive-strength-uA' property
In-Reply-To: <20190418124758.24022-2-glaroque@baylibre.com>
References: <20190418124758.24022-1-glaroque@baylibre.com> <20190418124758.24022-2-glaroque@baylibre.com>
Date:   Mon, 29 Apr 2019 12:19:48 -0700
Message-ID: <7hk1fcr54b.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

Guillaume La Roque <glaroque@baylibre.com> writes:

> This property allow drive-strength parameter in uA instead of mA.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> index cef2b5855d60..fc7018459aa2 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> @@ -258,6 +258,7 @@ drive-push-pull		- drive actively high and low
>  drive-open-drain	- drive with open drain
>  drive-open-source	- drive with open source
>  drive-strength		- sink or source at most X mA
> +drive-strength-uA	- sink or source at most X uA
>  input-enable		- enable input on pin (no effect on output, such as
>  			  enabling an input buffer)
>  input-disable		- disable input on pin (no effect on output, such as
> @@ -326,6 +327,8 @@ arguments are described below.
>  
>  - drive-strength takes as argument the target strength in mA.
>  
> +- drive-strength-uA takes as argument the target strength in uA.
> +
>  - input-debounce takes the debounce time in usec as argument
>    or 0 to disable debouncing

Can we get your input on this?

Linus W. is OK with this[1], but wants opinion/approval from DT
maintainers first.

Thanks,

Kevin

[1] https://lore.kernel.org/lkml/CACRpkdZ2dPzrtJQkxmN7V=f6+qYZAvrF+b0J77cN9hoRAgFqrw@mail.gmail.com/T/#u

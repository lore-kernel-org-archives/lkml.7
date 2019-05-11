Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5D1C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 16:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AC92183F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 16:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LX/bJj4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfEKQU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 12:20:27 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43690 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfEKQU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 12:20:26 -0400
Received: by mail-oi1-f194.google.com with SMTP id t187so3297996oie.10;
        Sat, 11 May 2019 09:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77CnbYxcDFDt6bYRAhtojcl8kTQMoV7pXqntwyNSY8Q=;
        b=LX/bJj4VhID9kspbovV0ckc2zTzKOogN2Wq84i8iW7Gh0BJqQj5pA/XFAykeaoQ6f+
         JzVMTu6EeJskGmnotL4uCE8PmOgItqy8+XAp6pZf23R05gMxxYPWSJPeLIZgU9o/aQ73
         qYJkbOyS2HxE4TBGu1oK0NCDF+zAeq+kFpOhJUJKvsatPpt7F/WauhqsTHZsvBhc2KOX
         dwTO25cgHSlJ6gicdUniZFxMDv94AbekXoIA/d7OqNiGbl/xw8lu8vQiWO5G66uAmHIM
         7iIaDknjhuSzLq7uIDciUvDKVgYi6PCfq1AoYlrKgzhZliH9VEy98UHsmInLliDHuG6+
         PQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77CnbYxcDFDt6bYRAhtojcl8kTQMoV7pXqntwyNSY8Q=;
        b=lOtnjlHcCu8THoSmCC3eCZgrFcjoXPUBw4FT2Ub7jlcZ/CNchePwCr9as5ytJisP1O
         Ooj88LbKUcNH6t0vR23d8oE9fqbkh9OZhTcFpQEYXyrCgnWQ4GAgvFhg58bbpWRdCpfT
         huBsi/86ruiVqCmIviSby8SayIrpa9WfrR8D5BVkgsT56bHBdex+VXvjs1SoGIwoYfrd
         OTHxOBrZV/5ls3wSoyAPWbY8rO0L8gtC2hEvDN+JIvNRS6vxJ3UeakfernJrlq+mn2A/
         xkHvAob1N0ZkcsOa+viFVmZ4fdPrPphd8jau307Cpb85omVJxnBq6X6cv3fuHjLMl7WB
         kqSw==
X-Gm-Message-State: APjAAAUxADqc0kKii2qsQe4m4c3GYN3kyyAqw4a20o6CMPtmwW6yoSB1
        0E/iq31VkWDKk+pav5xl96NQXMH5XcU8j4OVg9Q=
X-Google-Smtp-Source: APXvYqwq6IAPj/JGv5ZFn3C1jYA11WmZc9wcN5hpth+sOAk6/MejXQM5XnnRLBnSjbK3kiARzzTrXwXvp3HnndUUjqA=
X-Received: by 2002:aca:5b06:: with SMTP id p6mr9037315oib.129.1557591625391;
 Sat, 11 May 2019 09:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190510082324.21181-1-glaroque@baylibre.com> <20190510082324.21181-2-glaroque@baylibre.com>
In-Reply-To: <20190510082324.21181-2-glaroque@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 May 2019 18:20:14 +0200
Message-ID: <CAFBinCA9N=e_u0Vo-hVJDav2CZfaUOD3X6xqrVWtMx+e93sxLA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: pinctrl: add a 'drive-strength-microamp'
 property
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     linus.walleij@linaro.org, khilman@baylibre.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        jbrunet@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 10:23 AM Guillaume La Roque
<glaroque@baylibre.com> wrote:
>
> This property allow drive-strength parameter in uA instead of mA.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>

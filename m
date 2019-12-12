Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A14DC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B802464B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="brj8PL4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfLLKRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:17:03 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37335 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbfLLKRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:17:01 -0500
Received: by mail-lf1-f67.google.com with SMTP id b15so1265788lfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 02:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nsjxm/xsVTVDpo/VXg1VeJFF1h4DkTUUCH1h89G0Zd0=;
        b=brj8PL4uRioYXwXT/Qsa2ut7sivw5CPbNF/C1uVPOiQJ6SVBIruISlsjUZylmX0qYs
         nbs/TBXflqGc/q74nsX+LLqBffC0+NZdPRePM0euTQHeD0D/eVnLzpREh198aPS6FO7w
         PS4jtzJmeLnG8W+zoIkFBUU8+051+GehMsdKfTSEN5ncf4CuxUfSmmt5k09DlH7OKkT2
         AtGZrMcwbDhTitJ+eT9wV7R/oKPPTYz02xDt75vVU5LX9u0k4j+hWzCesZU1SYOSf1Lc
         ElDBwABojO+pYTEFhmAl8b2Y+vH2kGkr5bUk6kYM0LWGndflpvw6O0eDAGV5HW+levmy
         uBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nsjxm/xsVTVDpo/VXg1VeJFF1h4DkTUUCH1h89G0Zd0=;
        b=S+W0hHXXVtXhwflzT25yPlWjLwQzWLTKvD1EfNnXqM+lLfPKgpj6XatFngKyCx3iX4
         uh9HooKhbd/LzDIdKmoNozR/qdXTaD9Vv4IlIpSuc/0afpxXYnDCHf2v5oe7vN7fkbbq
         KF5tn4nGib8Rv0RY8U0JbP48AFXxSJdzPFElaBvReWpe7y1rMHMnW2nfaYTiv8uX0KZv
         5os5mb8RbyGqosv5rX+pOk84/GnOInSaydwfMTOONWYnwFQEvrpsCbnCdInQnbx/ej13
         8OBIjQzcrnhnENoQ34eLWUWhLjWWP+w8DVyKGYTW2n88uaOXghlqzsTlx26VLnn+v0iA
         WNbA==
X-Gm-Message-State: APjAAAWnJ52eoMcWo/1gxtZpSqt9BbPxDe3oMz8ImLWwIy29F8pKRpXZ
        UItUrVKukY7IGz+JePeEaNF1yZndwu3jaO04I/47Bg==
X-Google-Smtp-Source: APXvYqxyRNskvKt1YiIx2AO3iz21aIKpjYS1talkzQKvdDQ0CGu70+tqdA0tq0OfwohHhZzmsdo2c9dCihGvRXhHfMw=
X-Received: by 2002:a19:8a41:: with SMTP id m62mr5125013lfd.5.1576145819071;
 Thu, 12 Dec 2019 02:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20191211010308.1525-1-dan@dlrobertson.com> <20191211010308.1525-2-dan@dlrobertson.com>
In-Reply-To: <20191211010308.1525-2-dan@dlrobertson.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Dec 2019 11:16:47 +0100
Message-ID: <CACRpkdb9O7RjpXdUPCtN1M+PLC+2hPomhsw2Q5Ehhg4pEVOStQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: accel: bma400: add bindings
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

thanks for your patch!

On Wed, Dec 11, 2019 at 2:20 AM Dan Robertson <dan@dlrobertson.com> wrote:

> Add devicetree binding for the Bosch BMA400 3-axes ultra-low power
> accelerometer sensor.
>
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>
(...)

> +  Specifications about the sensor can be found at:
> +    https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMA400-DS000.pdf

As can be seen in page 113 in the manual this component
has VDD and VDDIO supplies and sooner or later someone
is going to have to model that so I'd say add vdd-supply and
vddio-supply regulator phandles as optional to the component
already from start.

Thanks!
Linus Walleij

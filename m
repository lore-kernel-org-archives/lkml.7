Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53668C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CD621925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gjNesBSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKLUwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:52:50 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33885 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfKLUwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:52:50 -0500
Received: by mail-oi1-f195.google.com with SMTP id l202so16169352oig.1;
        Tue, 12 Nov 2019 12:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V2BRORY0hBHLizKfzIfi2QGRpqicf8QMY3QuvWoI+ds=;
        b=gjNesBSfjAvc4kesedeMADClQCu4hYTWbOTzUGLfZvlLFHPbuM4uJjGELh0sbQgDWN
         8lrWkP3Yvl8mvcsN4mKb4KCZ3qe4W6A0A7z9ixxdQE383EV8AEXqsi6eCrI5JEytcBvH
         vHA+l6bcOI//BOa+LE7IUWgnSHG9QZwKwI/3YrPNpoUOah6UEQSffUi+8IzTzuDDYU92
         LkFRFw9yqI50wotbSj3BbpSdI2AI/irw9T4DcvU56MUdwu0JW0gIfdH+y+PHsEDXvZx9
         J0EYZEmpPKTRcSTm0s1R3uKbwhfWEINfK24+MPxL/QAyKUNs+iDoATkUt1gjVy3EDP13
         iQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2BRORY0hBHLizKfzIfi2QGRpqicf8QMY3QuvWoI+ds=;
        b=VdynA9QOd+eUviW+Zx4R4FPQjefDRyNaC9dnGJDi3o9J8JF0GvCMI9ZNYKHmOHF0oV
         3iwyqT+mTn3SXPIPysVfmwyTAKcOw691rQIc2h1ELFtdtnr1yV5dNMk0xyZ2SQiAQCXL
         euentSTjy18m7KwxtkQ9Hw5AbSRzkZCz7QEsz8sznqQ7RRAEcy9PCDMUckWeLBelD+ya
         MRSRW5XmPaIdH8hoShdNQ/GVZfaN5twLHBG8qf/KZgH+RHnXohRpPC2kcZbUxVeeGIXI
         0TVarFWBQkHzQULGiN7zXdUBp7UDUK1PsqaFUTe6/BhMTsWrTKGqrmSbZJOpR9wneWhp
         g6CQ==
X-Gm-Message-State: APjAAAXrpdqAAHub/XMXnZlUbfzNe96ql3UtK0eWNa/50lrjkwBiCw/+
        y1puLZ/77Ra47VdFIMiQm0OFH5RvXqhGg+CLR2o=
X-Google-Smtp-Source: APXvYqxRmF9qWBGxWM/Cn8ef+fuoL+vr7DkcDUoMRHpMSQl4VaTZvY3t+hLVbva6IXpLe8AdpMoa1ZtmkoCdXt1j/qw=
X-Received: by 2002:a05:6808:20f:: with SMTP id l15mr852673oie.39.1573591968888;
 Tue, 12 Nov 2019 12:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20191027162328.1177402-1-martin.blumenstingl@googlemail.com>
 <20191027162328.1177402-3-martin.blumenstingl@googlemail.com>
 <20191108221652.32FA2206C3@mail.kernel.org> <1jd0dxf1uz.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jd0dxf1uz.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 12 Nov 2019 21:52:38 +0100
Message-ID: <CAFBinCBnUs0JdHT3TS+1++NMHtgbMvoT7RYRCnB0eNgs4L-2CA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] clk: meson: add a driver for the Meson8/8b/8m2 DDR
 clock controller
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, Nov 12, 2019 at 6:20 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> >> +static const struct of_device_id meson8_ddr_clkc_match_table[] = {
> >> +       { .compatible = "amlogic,meson8-ddr-clkc" },
> >> +       { .compatible = "amlogic,meson8b-ddr-clkc" },
> >> +       { /* sentinel */ },
> >
> > Super nitpick, drop the comma above so that nothing can follow this.
>
> I don't think it is worth reposting the series Martin.
> If it is ok with you, I'll just apply it with Stephen comments
I am more than happy with this.
just to confirm, you would address all three comments from Stephen:
- including clk-provider.h
- use devm_platform_ioremap_resource
- trailing comma after the sentinel

> In the future, I would prefer if you could separate the series for clock
> (intended for Neil and myself) and the DT one (intended for Kevin)
sorry, we discussed this previously but I completely forgot about it
when I re-sent this series
I'll be more careful next time



Martin

Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3F9C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0F12082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k6LWMqWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfDCVch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:32:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33201 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfDCVcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:32:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so797628wrp.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 14:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ByAw7ZR6ppOZoPxGHhqQr9zSGZ2le3CNmTXxN67arNE=;
        b=k6LWMqWifaDFU8lghK1viRjprgiM3hWpKvBbTJGuVS3gn/61rRG/TCssLrlB0sW0By
         a+NsC46DmL7ZjsnfHJUmjEvl/MrmevNvM1+y9aY4KFZJg2/x02PJqqjnkOV71iuc1mJj
         His7QmshItXwiQTX1IotZuIM/5BOjxv0UAJ8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ByAw7ZR6ppOZoPxGHhqQr9zSGZ2le3CNmTXxN67arNE=;
        b=QQHxYv1TwK3ZxvPQHbrjqxHiFgam59t7X1FhhEOf7f+SKL8zBxwlC5BdSud8tnnEiW
         P82LdCISpomXP0JsTWYksUUfGxUiy2uHor1WvrQa4UiDIrXtj1dC0C/fyEu69nHONkqY
         vwtfMP6KBBctEkOfMMoqLeZTdMtJTlvDTrzJRCU7Ngjoi57qJcuocjbIxosfxLwmacqA
         aV4t/qIXDrs07vRTNnR7X5gOkpPF4qAAulnmbQJEMqpfvO111QGp98gbDacoDmoyt7y8
         ftUFzLx+BBrgi/yCbFfqJywZZxSJFTvmNhJkbWmwZWImhEFXDa5TIE0XHj6KbM3Km+C0
         u6oA==
X-Gm-Message-State: APjAAAX+YdYMhCBAb7m5aHoGvkOWVc+IOqCQsqAWjAvhSr/z7wceSAmj
        bxSuWrUiIucVO7XtBiFUPVEiqTSvYeZ2crpqocZWrA==
X-Google-Smtp-Source: APXvYqyybHIqkh2pKYvOzXs92i+nVJC9d95oCIe9e8S+Tn8H//cilWwXV/q7QEupZ2w8oWKjXec4J3hAi1xvEui/RTQ=
X-Received: by 2002:adf:f30b:: with SMTP id i11mr1285926wro.297.1554327150593;
 Wed, 03 Apr 2019 14:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190401205519.34023-1-fletcherw@chromium.org> <20190402050236.GV2059@sirena.org.uk>
In-Reply-To: <20190402050236.GV2059@sirena.org.uk>
From:   Fletcher Woodruff <fletcherw@chromium.org>
Date:   Wed, 3 Apr 2019 15:32:04 -0600
Message-ID: <CAN-6NYaO0bah_vFgTGrnU5_pUM95B+voDxsUR6K6o5wj5ZRD6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: rt5677: allow multiple interrupt sources
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Zhang <benzh@chromium.org>,
        Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        alsa-devel@alsa-project.org, Ross Zwisler <zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 11:02 PM Mark Brown <broonie@kernel.org> wrote:
> regmap-irq should support active high/low, and if it doesn't it can't be
> a unique thing that only this device wants to implement so the common
> code should be improved.

The rt5677 driver needs its own irq regardless for hotword detection.
If we implemented this in regmap-irq, we wouldn't be able to use it.

> This looks unrelated to the polarity of the interupt?

Yes this is separate. If a plug/unplug happens after regmap_read and
before regmap_write, it will not be registered, so we loop to make
sure that it's caught in a later iteration. I can clarify this in the
patch notes.

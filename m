Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C48C41514
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 01:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095B3217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 01:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el0TijmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbfHJBo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 21:44:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38895 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHJBo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 21:44:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id r12so62180085edo.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 18:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hba0YbyURevY2P3XTePra775mSMcCjjlB5vVgIy6gjI=;
        b=el0TijmMk/+XrZfsG46YQwvSxHXt319zM49YflOTMztmA+89S5Lfgta4z8J+Kt2+vh
         jPOTSbQeETNk48Ysk10IIOlzLc7j6JZeKhFnpjRsQVYfPXxGyQckZr8iut+4vE4FtPjK
         IJPUH3SBTfZdTUpZEoF4QmJMYj5o6tXY3Up3C7/yb0uoFdQf3Eu9jsd6OV1jrwzhXbvC
         h5lvkvfIo5Vw0rOWi73GVc+Nb1eN+TG+7BvY8+4RFKpY3h67nHjWzmOFA1QWKOfPmiPj
         gOFGH5zsottQ/TBYOnOYt2hW7MlPdI5d4stKCuxmyRWxYCi48ktuiLjSRZ6pHf4xe7fB
         MazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hba0YbyURevY2P3XTePra775mSMcCjjlB5vVgIy6gjI=;
        b=QsAJBBLtDNdDqp/xjYq7U6szC3+vyyxTaGhCvkd2R11g48c96tfmLl8hqW9UOC8nEn
         R4AXH7IQ95Aeuon+0YH+6slDr/HcKN0XlvOcw87dPQw4ZuNlnbLo1/bMoqJAIW6tFXTg
         ge07zPjBz1mDw4EVEQj4dhJyJo09oUXUshQGNro6pFAKgMS7kffyNVwq5syYKEisY+cu
         DWqKBhs7GXdgt6JsFJwhtIF04fcMk/btQNMk4wCN+bxIl5ilv8wDe1nu8he9zZjGb9JN
         uaHV7beZ+yDJdO6u4pW+LLh8ZP/OZCSHNlr0ZStKbh+sY1eAzBchQ8uL/WCqh/g4bqd6
         sDrg==
X-Gm-Message-State: APjAAAXfWkBjnjOduy3BLScO3yAPwzvZqKs956bh2srgA9bcVMrV7BL+
        qda09xtMTgeVHu5qyD5FXzqAw7tUQ7UPBmz/q3U=
X-Google-Smtp-Source: APXvYqz9uHUowNi7bb5V4sqy1jH7GExpXtBq6lg4IKumx3FWS8tXSJrfSb5dlgwUG0fe/l6LpXNR5VAB0zR3iADDQoE=
X-Received: by 2002:a17:906:4890:: with SMTP id v16mr21526067ejq.296.1565401496166;
 Fri, 09 Aug 2019 18:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190809030352.8387-1-hslester96@gmail.com> <20190809151114.GD3963@sirena.co.uk>
In-Reply-To: <20190809151114.GD3963@sirena.co.uk>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Sat, 10 Aug 2019 09:44:45 +0800
Message-ID: <CANhBUQ09+q9_=7nMs63w4KRLGOhW1=z-AnuwOzAnUrWRY6uC6A@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: Add devres versions of regulator_enable/disable
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 11:11 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Aug 09, 2019 at 11:03:52AM +0800, Chuhong Yuan wrote:
> > I wrote a coccinelle script to detect possible chances
> > of utilizing devm_() APIs to simplify the driver.
> > The script found 147 drivers in total and 22 of them
> > have be patched.
>
> > Within the 125 left ones, at least 31 of them (24.8%)
> > are hindered from benefiting from devm_() APIs because
> > of lack of a devres version of regulator_enable().
>
> I'm not super keen on managed versions of these functions since they're
> very likely to cause reference counting issues between the probe/remove
> path and the suspend/resume path which aren't obvious from the code, I'm
> especially worried about double frees on release.

I find that 29 of 31 cases I found call regulator_disable() only when encounter
probe failure or in .remove.
So I think the devm versions of regulator_enable/disable() will not cause big
problems.

I even found a driver to forget to disable regulator when encounter
probe failure,
which is drivers/iio/adc/ti-adc128s052.c.
And a devm version of regulator_enable() can prevent such mistakes.

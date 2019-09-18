Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC9EC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 00:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154EA21848
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 00:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5PwamKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfIRA5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 20:57:14 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36612 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfIRA5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 20:57:14 -0400
Received: by mail-io1-f67.google.com with SMTP id b136so12192054iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 17:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dwdc/YL4+bqs9bjjiQA5cxc9DWfp9aFFjJ7dv8TzkTw=;
        b=V5PwamKr2mcRDjS6eB+xwZ8r4Pg+o93T8x9ZDzuiRGDg1d/qkZODp94AIjTaJdcT7m
         j5HV98vbk4ywbXcqir31igTtgEvb545jl0QswRNVPCL9mATR/0hlXk95osj1f420ZHiu
         FQTv/V+8xF1Y8KdBcNwKbcgz5Ph5Mf0ylKG51p8TmIfHUZSNt2gtp/ENqbFXWvg2a0XT
         Mm8cQV18FUP0M23zCzHVjxKMkurBOBuFRRM085alA2xCsgnOxs4On+Pc33aRu/ycBXO3
         fCYwyridy8XP+a0VO9uiLnvyBsqBf8Op7dcZ9m5TptZkdA7g2JAbVucBYyPXOsTlZu9e
         mqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dwdc/YL4+bqs9bjjiQA5cxc9DWfp9aFFjJ7dv8TzkTw=;
        b=axKZMrfVP44ZMGHhfoWn4tn0NF9vtIcaOo/4emO4PekkMdJx1lWg4j+0oTvbpmk6ky
         dbjSQD11FDgt/gsFKbDcCnchgR768veJJaHRFBv2PZ+eMFFirigRjwcDV/0tPZui0URT
         kq9somjaCE3sXXoK8/l5Zn+ol0/LJkZeCLplh2HkaunucJgA/85AsxWmjkAXg/d2pvbX
         aAkq1X8+Jj0QMM8rR0g+bYqRdIBCdu+ag7HVAi/G5y84EMhyzLaaUAc60oVvxHIkiBPO
         6MU4amc6LN3WVdpw2M4yLj7PgzllZAy6fX0fGk0s7UGQ/43t5DHFO5AkQgS0qukbT3Sk
         JTxg==
X-Gm-Message-State: APjAAAUonhWmXAHmORSRICpPlfjuL4zz9PQM6B94ELS+dAKNfqjq99fK
        EtPdXO4udfro33eEMDeOux570yR+FgSsEjuUiR4=
X-Google-Smtp-Source: APXvYqyPDSKo9wB0laCujCdDMQIAv2E9jOorrck53i/PFZFoXXvmwRb7hwOWpK+i/RsqUsT5jW+qJLhPjLwZHlq6j/g=
X-Received: by 2002:a5d:8f02:: with SMTP id f2mr2200851iof.272.1568768232970;
 Tue, 17 Sep 2019 17:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190917154021.14693-1-m.felsch@pengutronix.de> <20190917154021.14693-4-m.felsch@pengutronix.de>
In-Reply-To: <20190917154021.14693-4-m.felsch@pengutronix.de>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Tue, 17 Sep 2019 17:57:01 -0700
Message-ID: <CAKdAkRSi+d0AXwXaxc4wx+p2kAf=+_P8HZnq-sJAKmbwuuKH4Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] regulator: core: make regulator_register()
 EPROBE_DEFER aware
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     zhang.chunyan@linaro.org, Doug Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, ckeepax@opensource.cirrus.com,
        lkml <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 4:42 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Sometimes it can happen that the regulator_of_get_init_data() can't
> retrieve the config due to a not probed device the regulator depends on.
> Fix that by checking the return value of of_parse_cb() and return
> EPROBE_DEFER in such cases.

Treating EPROBE_DEFER in a special way is usually wrong.
regulator_of_get_init_data() may fail for multiple reasons (no memory,
invalid DT, etc, etc). All of them should abort instantiating
regulator.

Thanks.

-- 
Dmitry

Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A66C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 07:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1847620637
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 07:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ApxNRYnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfKVHff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 02:35:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45471 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVHfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 02:35:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id n21so6142065ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 23:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDdbFgRZ/DftFdgsbV1nBG702kIvVQNLzAtOboImYho=;
        b=ApxNRYnw7RNF7PQvsGNN/DGujlE3iWNW2XQcseTQC8u0Pd8ru6z/ihzMNEJkIcm/re
         /LgurCblgfHcKgzlyNijDGy8esKo60XlrWoZ1jP96DaMcmnyTswzH1mSc50dWs1F1v6p
         DChNeXGO+KcAUNpmKRxK9PTjk3FytEiEkwFrTKUtmQOIPaecR9udfRrtBYCHvKOSuLG2
         ZI3L5jQyEbN/4DIT8GQGcITW7ZNT+bz3gtGpbhDn5CMS9SpsMJeQ4hkPudMH7bjIeYzi
         HG4QPdag6HJhjC3hXPzqpN3FoxrF8xrV+AgQDeJZvIllNJxedvTfZkEGoIf64zWC6KMQ
         2lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDdbFgRZ/DftFdgsbV1nBG702kIvVQNLzAtOboImYho=;
        b=AgY9jlrnlzS5Ajzi1kxMIaiP80tH5Lx2VErmY/7FtiDFwYSKL0Jh7SghVwSGqkU7OZ
         S74IkrrrZvQ7TzZKZ7zIcQNq8dZvfvyE8kILbtYvnPoQvKPe5THrglBwnBFxMQhgztRx
         1JU+PShf+FtwysQKqshT4D5Jzd1wNBAduU33yFUmFBxKaU9T/BxvWZZturbRl+wUmYR5
         fqbwCdLiKxluHBdc6Mk0Owe2vN5pJDLmrd7i+LHCiBl1/TJ34PbTGdhzx9OReHw8JHj7
         rqdL0IhdAejK/vK5JbUcA8J2Z9T5b9E92xluQRGy2FF/524Id4UO/osaRXPiwnoKm/fO
         CzSg==
X-Gm-Message-State: APjAAAUcWFInnhrk034InsM7XhGgdrZKt57UenrKQPPTsMUDvtA31ldZ
        brX3Gv5DqQVtVXZiC2F3BTeebvpIfqFijltsuJLPkA==
X-Google-Smtp-Source: APXvYqzL2vp/KKseaTOghvkAWrY9JxbNs0Ofv2U7rE+Ia0IND/xSVGjjfDmSUff7cjBMwjzExoBAvD7ZWm0tIyzIfVs=
X-Received: by 2002:a2e:9784:: with SMTP id y4mr11128660lji.77.1574408130240;
 Thu, 21 Nov 2019 23:35:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573797249.git.rahul.tanwar@linux.intel.com>
 <b59afc497e41404fea06aa48d633cba183ee944d.1573797249.git.rahul.tanwar@linux.intel.com>
 <CACRpkdYZi-0LRjih8+2cgWZ6u-eFN5+3sW1eV2ujYRd0UBoEKQ@mail.gmail.com> <bf8396af-3ace-7463-0fef-890b2f5cc487@linux.intel.com>
In-Reply-To: <bf8396af-3ace-7463-0fef-890b2f5cc487@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Nov 2019 08:35:17 +0100
Message-ID: <CACRpkdafN-NjGNqqu_6-Qz6qWkZ4VGuBz_iyGirgUscz-Qk6VA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] dt-bindings: pinctrl: intel: Add for new SoC
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 3:24 AM Tanwar, Rahul
<rahul.tanwar@linux.intel.com> wrote:

> Thanks. Yes, i have gone through Rob's generic pinctrl bindings patch
> seriesand i was double minded if you should still proceed with this
> patch or waitfor generic bindings patch to get merged.

It's a compromise actually.

It's a bit of struggle and tough sometimes since I care both
about the kernel and the autonomy of the DT bindings
communities.

We are in a transition phase to YAML bindings, and what is important
for me as maintainer is to have developer buy-in, and
it is more motivating for developers to work on this in-tree
than having patches held back. I personally know how
important it is to feel that things move forward in
development.

Now it should be a separate task on top of what we have,
which is less stressful and gives the feeling of a bit of
accomplishment.

When the new generic YAML bindings are proven to work
on two drivers or so I will be more demanding that people
use them in their bindings from day 1. But we need to make
sure it works first and that is a separate task.

Yours,
Linus Walleij

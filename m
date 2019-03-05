Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9905EC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E6B2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfCETWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:22:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35208 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfCETWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:22:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id y15so3709169wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 11:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zll7ce3TO026vX8dtCapNvJBA947Jz8NKAyubEMk/sk=;
        b=AYKqkJIQH4AbKUFeBHD8JPOMsMdB4U578/14yd3JVwztWLTr1CGJtRB5Qrps6piD/I
         nHPF/s+KOBo6dW48xdnRgivq1ZHEfd3XM4UAcgBHrdyMmCNqlUNqE2C1GdUgDkyrKSZs
         97yNteGa/aRofpTO+TSPmwcAB1eWQS8Px9V/aV1apVY0JreENgCGOB6u3pbeuq2T6G2j
         b2Sfop+9N2LPzMv5F9zah/JMoA/LlG1RNmq5e/Q6y3FHmecvKtxJ1ihhVveguFr+5U0w
         c1GomFhLrr7e1yZBYdU/n6UBsQy9h0/iYS55xgcQn/FKPKfbghXkMkUnlMjqpsurwXhH
         fhVA==
X-Gm-Message-State: APjAAAXNQHzi7Jq6G8v9J/oCgnGgHeyVy6As2yHbTDYqKdhDCexpoSgc
        uWfBOeGEna7I3XN6Tt9KuUyYfw==
X-Google-Smtp-Source: APXvYqwqhcQkEKQuEqMr7ec7T5r436L0OK611WbsC8H7nrRv1WjdGwm3x8DftN26abALe3yQFVTWYA==
X-Received: by 2002:a1c:e70a:: with SMTP id e10mr95312wmh.34.1551813726591;
        Tue, 05 Mar 2019 11:22:06 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id c1sm12491655wrw.7.2019.03.05.11.22.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:22:06 -0800 (PST)
Subject: Re: [PATCH v3 0/2] extcon: Intel Cherry Trail Whiskey Cove PMIC and
 external charger tweaks
To:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190303201613.19884-1-jekhor@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <81e492cc-80d5-c0f0-a6e2-522002913f5b@redhat.com>
Date:   Tue, 5 Mar 2019 20:22:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190303201613.19884-1-jekhor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03-03-19 21:16, Yauhen Kharuzhy wrote:
> At implementation of charging support for Lenovo Yoga Book (Intel Cherry
> Trail based with Whiskey Cove PMIC), two pitfalls were found:
> 
> - for detection of charger type by PMIC, bit 6 in the CHGRCTRL1 register
>    should be set in 0 (and set to 1 for Host mode). Pick up its definition
>    and logic from from Intel code drop[1];
> 
> - "#CHARGE ENABLE" signal of external charger (bq25892) in Yoga Book is
>    connected to one of PMIC outputs controlled by CHGDISCTRL register.
>    Enable charging at driver initialization. Pick up this from Lenovo's code
>    drop[2,3].
> 
> 
> v3 changes:
> - Don't restore of initial state of CHGDISCTRL and CHGRCTRL0 at exit but
>    switch them into HW-controlled mode (as discussed in mailing list);
> - Use regmap_update_bits() instead of regmap_readi()/regmap_write() in
>    the cht_wc_extcon_set_otgmode();
> - Coding style and constant names changed as Andy and Hans recommended.

Series looks good to me now, and I've also tested that it does not
cause any charging or 5v boost related regressions on a GPD pocket
laptop, so for the series:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



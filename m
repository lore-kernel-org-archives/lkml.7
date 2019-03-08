Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D053AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A502064A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvO23oii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfCHRtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:49:42 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46677 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCHRtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:49:42 -0500
Received: by mail-ot1-f66.google.com with SMTP id c18so18062705otl.13;
        Fri, 08 Mar 2019 09:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MTNl1rwamt9cDnnSLEMuhtMuFVnfdLMKI6z+8O7edB0=;
        b=JvO23oii6DCQ5ATq7a75/THPEfdqj9ChKDWeaaxPhdY1dpnnEflH4KkcMznbfQY/e4
         wMhxigPm73heGqXR/5DqTcedT0CWczbHinqLKtT0WiJThgg9kWwYr3lCXAH9amvWEnWj
         oA6avP63DeDuiOrRdWMXvGbRLD0yWPeAtnVZuRvI+b9COviVcefPQTrBOms/ZRlppsGS
         E3cdWycdvIgH1VO1Txml9TJEQISMBwm+lfxAbarDwe/LazIixHmiy+6Cjm8RHUhGHnyL
         ZRN3X8srLxxN0KJDR/c/8+41ODZ3claSXFZc9bF28M4sZrK40IjcuY+3jRagg41Wd+Sv
         jBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MTNl1rwamt9cDnnSLEMuhtMuFVnfdLMKI6z+8O7edB0=;
        b=kbeEOzV3tlywc9eCXBh5FHUkWI/+DOysZjw+0LMRTxMCTpuV2/2rWCYkOU4vLKZA4G
         MpwIdqQQicZ8+Q8lX2KTAEVZKS6nw/I+8Go55ILDtafGbziYWzZ3l+0Nyw/y0HhC2G7l
         frPHZGn9gje7WgBLvUUW75yM4uEXt6hoQzpld5NGiOPtwjk2xvfX/ZSw42WUvQs7HBMR
         QGvVjLAF7Sd8y+ENqDLEHt369KTAa9Lpo7vQtKoAY6pe4+GKgl7KtkB18+cktuKpnIa+
         Wr99pmYng2cLa62GJRqx7syPx7I4N0qrnXHrycbxhPeYXc0yHUPlCCjFSItBjaDdLS58
         E4Cw==
X-Gm-Message-State: APjAAAVXywVSCLG2q7GURtZnFPulbdf2GA1NCEPqUL0NbWZusivj5B4d
        NkwYFdG+EIrYV6nK32cTVFPr6U9+7jrufjdz+co=
X-Google-Smtp-Source: APXvYqyXvZegJOZuvMFOyzNpGAS6NuZehTnxCAn4m+JyNy98dC+ERfnCvaeClrPiyUcNmk0YPbFHekVhKSm6+xT0e1U=
X-Received: by 2002:a9d:75cc:: with SMTP id c12mr11530577otl.279.1552067381102;
 Fri, 08 Mar 2019 09:49:41 -0800 (PST)
MIME-Version: 1.0
References: <20190306174559.17362-1-TheSven73@gmail.com> <20190308171244.00001ec8@huawei.com>
In-Reply-To: <20190308171244.00001ec8@huawei.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 8 Mar 2019 12:49:30 -0500
Message-ID: <CAGngYiUGcKrs86_ZARgfZxC_4hOAhW-e69GMpK6yAJMjHrYs6Q@mail.gmail.com>
Subject: Re: [PATCH] iio: proximity: as3935: fix use-after-free on device remove
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 12:13 PM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> Your description makes it clear that there are multiple things in the patch.
> Don't do a 'while we were here' in a patch doing something else please.
> Separate patches.
>

The proposed solution (adding devm_) fixes multiple issues, so that can stay
as a single patch, right?

It's the 'while we're here' you'd like to see removed? Can do.

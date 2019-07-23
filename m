Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A746C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE26A21911
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nZgUga+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbfGWHG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:06:57 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40953 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfGWHG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:06:57 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so40905641qtn.7;
        Tue, 23 Jul 2019 00:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GcUNOoc2v5PTLCl4JCvdlXkVaBUqo/As5xzKXvt1t28=;
        b=nZgUga+xdY6jCBsaRAYXpJtpWzFaSwcNoELz9qOpXT8hmo7gBdsgpSngqnxCfBKYZM
         P4g1aOPWmbAX+Nc5Bj2fjFRnUt6rZJr8TjyqIb+xhXTtUatb01nagZGUADN8Oaph7PqD
         kQZOf9hL00RQiPfKeDSw14UqYPcucRmoRa93JQ1Omh10BvUhW+wkeyeGjcEAMdOS1BKx
         shToQF3CQ2VjInO6zdQP6BeZro3p/+Jpjc5gGQp/0zkhmobWIg5jOrNcvrMYkGBMrtr/
         zsn7O1u50ANw42ntEnkIF1s7uIq1PGh55oCM9fWdkc+o2UDhdkaushoRBNJtbJiPwPfa
         Txrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GcUNOoc2v5PTLCl4JCvdlXkVaBUqo/As5xzKXvt1t28=;
        b=HQapfhyUrBmbISyzGV+dg0SYse674wZspAtr2eG+uPDkKdnZmoFcCtJYMGxA+oNiOW
         9hTQT6D/XlO1sAIWx23Ey65zbjj9qcEApj/nHm3udfweeua5U8Jh87ItGWuM/fvDpoGZ
         8yVOhK3dqtg7tJMsO6WHSNGXVAJk6YDYtRmqdOSMRS3PSLS/R9boJY/xZgUoScygK4iw
         sm9o7LocHpy0g+ZHizW63o9PKyL/KsRvJ1QH6tUNbK7oEZrHS4tXH59pLzvBDGIq+2hB
         dW2dMeTlL6CF7OIbKP6T8GP8uN2v2TuhISeSfUH5OcUvK/mlOGlJ3fr4WY0F1F6Rp4I2
         O5Pg==
X-Gm-Message-State: APjAAAXygZvUkQI1WlhrummIasx1rm2DlfDKY8v/3TvSrlnGMO9J92SS
        P7TE+SLIt/lK1gprIi8FUzHl2NwORozn+yzHRdYfa8Or
X-Google-Smtp-Source: APXvYqwxSty+MvD3lHiYpDhtBuXFnrUGzTStnfnsjIG65bGrsjR80dVtKo79EfT8W52iUcDLgzvh8TVH483ZMx7ACyU=
X-Received: by 2002:ad4:5661:: with SMTP id bm1mr53662121qvb.119.1563865616201;
 Tue, 23 Jul 2019 00:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190704090205.19400-1-fe@dev.tdt.de> <20190704090205.19400-4-fe@dev.tdt.de>
 <cca95ba1-6ac0-a2eb-9ae6-914a8783c1ad@metux.net>
In-Reply-To: <cca95ba1-6ac0-a2eb-9ae6-914a8783c1ad@metux.net>
From:   Florian Eckert <eckert.florian@googlemail.com>
Date:   Tue, 23 Jul 2019 09:06:45 +0200
Message-ID: <CALPCC5wH_uAGYaHeM_d_yxxUZEd3f-MfhT7jdZSt9ythd08S9w@mail.gmail.com>
Subject: Re: [PATCH 3/3] platform//x86/pcengines-apuv2: update gpio button definition
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Florian Eckert <fe@dev.tdt.de>, info@metux.net,
        dvhart@infradead.org, andy@infradead.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd like to ack only the keycode change, but not the deprecated .gpio
> field. I'll post a separate patch for the keycode change only.

I am fine if we only change the keycode.
Do I have to send a v2 patch set?

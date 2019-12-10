Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7C7C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B898E2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="QLv9j1Kf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLJUQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:16:48 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37871 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfLJUQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:16:48 -0500
Received: by mail-ot1-f66.google.com with SMTP id k14so16713501otn.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 12:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fSpRuopSQsqIsBCQrngapk7qNizSkn5vIGLeu0YXzok=;
        b=QLv9j1Kf1pl339xnRMu5I9Hk1ydy8BS8j+X62qrsluuIpkDenW9aIF02vLfXSINlBb
         ll/3lIgfsmi0GezqLWed6FxZPbFy7G49/y2CU3OvGU0mcQ0pNRdyMAfObdGqDh+JqzvR
         mal68g8H0Wx8SSafpanwaf/B9n6O/Uvce4Vi1eEuoOMI1cF0OESPDK2QXK6bZIaJ0mlf
         BtgohwuOnJpGl8MznffMR/kLiYNGfOVZazfVlVVcMcBY5Cnl6+8fsT+nWiSx2+HwLtfX
         eMolb4Lkwlm7xSbxW1Oi2wR9nJKYGqXG/41u56UdnN0RLhNL/RVeWT0evf7YQJ9YvJOu
         QeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fSpRuopSQsqIsBCQrngapk7qNizSkn5vIGLeu0YXzok=;
        b=kqpjob4n48lUsBXwzAw/hn1RjTDzB6XiOlfWv90Muv2WOqDKaJBL0T2OJ+zm5K+4Uc
         UraOLkMkhP5JEn84Kw9Fk9Tvpl8Q8gH87DG4Y0XvHlFVzqoEBLM8Eaq8VlwPOFIEcRhM
         jtbkwyeeOtS55iexxQyz5KLxX73kNE2Hbh4yR1tPMCwYUJ0ApogxoISHh89yqe5Tu7c6
         IAfxF48mPRm3T+AhfgUNzti1sHap05WHJnMYsrYRscs59pz905bTlH11S96/hg5tAXju
         hFNmh6ypzOx5Jnc0mt7z6entqbHJ3YCuhu/25ytPPBv9dzCUU4xHZ+YidRBc/UFC1ScK
         ZLog==
X-Gm-Message-State: APjAAAVzPJfhAa+toLyFEiq+rPOXxZJm03SD1nhEd2DNFxwC0iLyRC+S
        YwtRG/5o3cJZGifFKUsRa+gMobRvSTI=
X-Google-Smtp-Source: APXvYqyaw0qhPHZY2Ts/ktriJuJUipqH6cUesR/fivT044fCZgT4Kq37YFOmki9dXprxX/iI+Sr5zw==
X-Received: by 2002:a05:6830:1185:: with SMTP id u5mr25528276otq.147.1576009007225;
        Tue, 10 Dec 2019 12:16:47 -0800 (PST)
Received: from ?IPv6:2605:6000:e947:6500:6680:99ff:fe6f:cb54? ([2605:6000:e947:6500:6680:99ff:fe6f:cb54])
        by smtp.googlemail.com with ESMTPSA id v20sm1813200otf.40.2019.12.10.12.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:16:46 -0800 (PST)
Subject: Re: [PATCH][resend] sh: kgdb: Mark expected switch fall-throughs
From:   Rob Landley <rob@landley.net>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <87o8wgy3ra.wl-kuninori.morimoto.gx@renesas.com>
 <35e63e37-6ec8-8a47-8e18-639c954732e0@landley.net>
Message-ID: <b220b69e-575d-0530-0f2d-65584df36ea2@landley.net>
Date:   Tue, 10 Dec 2019 14:20:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <35e63e37-6ec8-8a47-8e18-639c954732e0@landley.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/19 2:12 PM, Rob Landley wrote:
> On 12/10/19 2:38 AM, Kuninori Morimoto wrote:
>>
>> Hi Andrew
>>
>> I'm posting this patch from few month ago,
>> but it seems SH maintainer is not working in these days...
> 
> Again, I dunno where you're getting that.
> 
> (Me, I removed the -Werror...)

In fact I looked it up, _I_ didn't remove the -Werror, Rich acked a patch
removing the -Werror back in August:

  https://www.spinics.net/lists/linux-sh/msg55405.html

Rob

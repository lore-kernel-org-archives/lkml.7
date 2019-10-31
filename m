Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5958CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 08:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A244C2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 08:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tvdh0va1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfJaI4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 04:56:06 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:41602 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfJaI4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 04:56:06 -0400
Received: by mail-il1-f193.google.com with SMTP id z10so4667780ilo.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFfdHfuhP+nEEQfQbC0Ba4Z+OQ9QN7a/luiGoxHZNKI=;
        b=tvdh0va1KgpZTtjmMZNglpPZI03tvtnGrO5YO4cTV4BiVYA+11jNi3bTMfInJ1Up0a
         aoVUaXwQWYabwxtf4Ll8mfoLG2JyLcMYt0mam5/o6dAfujWHFAcY/46v7Oq6GsABGJ0M
         +Sds7J3eBBKmtI3m8OcMFpGgLP7p1VD1LZOFdfuKKY9IhTqlufbq0ZTaKFZ1OFbDTMeP
         wt5HuQunjysLqwvbwBOoStV1dcahtv0duyWC0YgjtTkXgEto0XoPkk72ntb5A93L/tE8
         itwFWMXuQOEeNIjk7rzz9dcNdf6oJotXCzlx94WWlSxwuvaLnbjM1f6Xg4BI8Xx9Mhky
         Kh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFfdHfuhP+nEEQfQbC0Ba4Z+OQ9QN7a/luiGoxHZNKI=;
        b=jvQ4JE/tU0PHzinWnCJa5gwwBsBSDGVfM4HbYoS0OVbUMfOWFbhfBbzg1xUBsDqaNh
         SJpcXX9605IjvQD9hBncywP1TlQhqG2+VnPWrOCeLEKJOonTkzAWj8gGNGcBYZjMSscM
         9RYtD2Z5KHax93cTHgfaWyhIghuzfX4cWjNwosacM8yVG44QBI//BBTR6rEIpSZIirY9
         uA5ApyslU304weVXvngfctm2TifoX2q3t6hdagzngZpDrzQkMrFS89bFBMrnIKnF2/9k
         LEbUdz7vS9T1oUTf21meaNwVxx5VFxnk0Y5ow9QGlVxL65nahFUQmsGQzah69bGkJYaf
         37PA==
X-Gm-Message-State: APjAAAVdzEHk1X+BRxRTjcW0Jq8ipOU1pu1fF2k6aSdLl4x9FiQwEp/j
        0YQ97i3fgYxGOsdU3uag6rKeYaOlTOQbzLCR/wZsAg==
X-Google-Smtp-Source: APXvYqwfX3ZfmayVc1DkCMbcevGUQ3Zmtj89LujmSEYYk2OKKpmSKfIAH39CJHL+4amH5NwNeo9lS0jhOjQEwNOQDnM=
X-Received: by 2002:a92:af19:: with SMTP id n25mr5445478ili.138.1572512164205;
 Thu, 31 Oct 2019 01:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191030091038.678-1-daniel.lezcano@linaro.org>
In-Reply-To: <20191030091038.678-1-daniel.lezcano@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 31 Oct 2019 14:25:52 +0530
Message-ID: <CAKohpomW1CHrHZmXTmOAw9Oj2YauLPQmrL0Tw-j92qZ2YqK_Bw@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: cpu_cooling: Remove pointless dependency on CONFIG_OF
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019 at 14:41, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The option CONFIG_CPU_THERMAL depends on CONFIG_OF in the Kconfig.
>
> It it pointless to check if CONFIG_OF is set in the header file as
> this is always true if CONFIG_CPU_THERMAL is true. Remove it.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  include/linux/cpu_cooling.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E14C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9682071B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VIOo/Pij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfKUNrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:47:49 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37022 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfKUNrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:47:49 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so2703414lfp.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 05:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=caR6qyLZA2YX7N7il9mca3/oNrJ97AvufKAxX/7X/t8=;
        b=VIOo/PijKlmTSU7k0uUlEiwuwGggZG8iMvFBgbHGqH3hmFkbc7hcNTpuA2Yt6Cn4Ad
         /lfSamtVILY6w7FdAeX0LJi3VKe0umgThLTkOJhBUEMxgI7AgmPV61OKo+0mS//DXmCh
         u9UnjJeDzQhddnd97dgJpVt9Z0YM7OEqiF7miH5p/LiPTrOS/czCCvaH/F1Y4NsmWsCq
         GpIg4Y0/44ndROWiiTsCfDKF2VAYDV248vAzZ3GJ3DIzDQo/H1DXLF8JYL/pE/UsjdZD
         VXfiOSZRONiaBM5yymz7ZzHrtf1sN3F1W+SpvLbJWMqPG565b9wKefLTwAM2HuZAuqpB
         jeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=caR6qyLZA2YX7N7il9mca3/oNrJ97AvufKAxX/7X/t8=;
        b=CRh4w/JAsLVgjZ8Qe2qKGVrQyd0Az/qGybKRIaoydPkoR4gfGVnieh7gyNJVG6PceP
         O+9e3aNXd4hQImSEH6B/Ony4XRkW8XHmPqyz3abW6ucCMvsfp+s+jco3hOBGSgSJbh2G
         V5H+eomMIKzK6/6P9Z+lJAxw1lO8pEN6hymAF37SZvM10kMp2GL/y7Q54MmPTpwg0ZJ3
         gNPj6uKqXSpX2Q3TeEh0YOqX5q1i5PX93ta9yI9Rov6YGdgQyYCp7v8dalucdHDmVwxk
         h3gqe3KmjnXCa0MfA7c7Xx1KlK9rQT0zExtwSn3jFi3EWT7CVSgUvodowADSK+3y1FlS
         4zag==
X-Gm-Message-State: APjAAAUL5Kc0NzA/7FKYjTteq7LVyarVk7ZmL3sH7S4Fj6mLZ9YnZYjt
        dQvREMDOR4sCxMyb5JkeFPyFc6b1uf6B0F2n16jflA==
X-Google-Smtp-Source: APXvYqwmI6/VvWRaqBNjK+cmiCSG+6Hkt0rYjH/6YkTQW3OXM2cQ1jv6rZofTokHslVnUliyq+XhtrmS88hodfLf9eU=
X-Received: by 2002:ac2:5b86:: with SMTP id o6mr7754208lfn.44.1574344067468;
 Thu, 21 Nov 2019 05:47:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573797249.git.rahul.tanwar@linux.intel.com> <33e649758b70490f01724a887c490d5008c7656d.1573797249.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <33e649758b70490f01724a887c490d5008c7656d.1573797249.git.rahul.tanwar@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Nov 2019 14:47:36 +0100
Message-ID: <CACRpkdaoiYvcMVCyJJTSyvSZUMAj6QsCcGG3=s4or31r08=hdg@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] pinctrl: Add pinmux & GPIO controller driver for a
 new SoC
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
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

Hi Rahul,

On Fri, Nov 15, 2019 at 10:25 AM Rahul Tanwar
<rahul.tanwar@linux.intel.com> wrote:

> Intel Lightning Mountain SoC has a pinmux controller & GPIO controller IP which
> controls pin multiplexing & configuration including GPIO functions selection &
> GPIO attributes configuration.
>
> This IP is not based on & does not have anything in common with Chassis
> specification. The pinctrl drivers under pinctrl/intel/* are all based upon
> Chassis spec compliant pinctrl IPs. So this driver doesn't fit & can not use
> pinctrl framework under pinctrl/intel/* and it requires a separate new driver.
>
> Add a new GPIO & pin control framework based driver for this IP.
>
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>

Thanks a lot for quick iterations and hard work on getting this
driver in such a nice shape in such a short time!

Patch applied for kernel v5.5.

If there are any remaining issues I am sure we can fix them up
in-tree.

Yours,
Linus Walleij

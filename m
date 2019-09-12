Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A94AC5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F60A20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NcYAwdsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbfILKLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 06:11:48 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43278 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731000AbfILKLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:11:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id d5so23027060lja.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 03:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4vEs9WeFlLNAO6DjHLn6Vtkhi8L0t325kmZ0jO3y+Wc=;
        b=NcYAwdsi28+vjx08eTFDNGKCd5XONjCjq2/QkOSeDBdhC+w3nD8DC27b+UvFvDLbLs
         /z8u3u9qYsBnfd/QOEG4/BwX4MI6VRxCCQculwd/WF1kd4hjYUzRY9lWo/6/He2OjzMD
         7VDz+b/xKsW/eAU/rIlfF5tzuV83nBGL/q63zj74cWBCppYPveJO3ntCM4Tg3VcvkQdj
         bs4Swi+W0EMkGOLnHmvc5u/fdozNpS/BPIg1qWJTeYPiuDre5tJ23HeewG5fTbolLIl4
         r9wq5vjgg9LgD+IBWnz6yzJYHf39aHZjSdZTlFbw7i1mT6ljfGyyhfEGSMXl6jWH8wEP
         GVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4vEs9WeFlLNAO6DjHLn6Vtkhi8L0t325kmZ0jO3y+Wc=;
        b=k7yTcWblYPh1aiIVkyT1C4Wj1/wWtHEGQCgXXJ+VvxicKusrXiLU1ACvUfn8jMl3et
         V/EoEU82OkEZPmab1WbpomFYyxUhDGCZieKFUkpFf3neuyYKIjYyR8KFdTpxF6Gpaa7M
         gYP0k9698xdcYyYIKk4kNyhm3ahGFkXViUJo9JOGbWreeFkNRDRK2k/L+NCaKVe1rhin
         eiJbHP4KJoaJhGAjqSyZjciBMOZ8rZxR/H7GmS3bD8XNwGfoasngC750LOR1X40maI5M
         yGGPuY9CUZEf273FSBIUeG70QEekrsHxDrbtUzA5IsMWDLHRhCaMO+igqSfc09XsM6Sn
         eptQ==
X-Gm-Message-State: APjAAAUfD//v03X7J+KX7bWdZp2pIbe8/BnnqQL99fesVD7SD/fg9O0d
        4FaSdtUQMLscNV7vqflzjf8C5zdnrIe6YQxsFxTM5g==
X-Google-Smtp-Source: APXvYqxb3KEOIkMavy8eX3cExL/IC+pSzxilfnvqDLs4HTLm858UzgLR2nTJiHu9gy8/sLKtJYCibJo1y8MYZwIb0sI=
X-Received: by 2002:a2e:9dc3:: with SMTP id x3mr22449421ljj.108.1568283104833;
 Thu, 12 Sep 2019 03:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568274587.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1568274587.git.rahul.tanwar@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 11:11:32 +0100
Message-ID: <CACRpkdb7bPo7oH9w5OhAsOoQXx=MWjJELd5JvBt3R1sPdMjnpw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] pinctrl: Add new pinctrl/GPIO driver
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul,

thanks for your patches!

On Thu, Sep 12, 2019 at 8:59 AM Rahul Tanwar
<rahul.tanwar@linux.intel.com> wrote:

> This series is to add pinctrl & GPIO controller driver for a new SoC.
> Patch 1 adds pinmux & GPIO controller driver.
> Patch 2 adds the dt bindings document & include file.
>
> Patches are against Linux 5.3-rc5 at below Git tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git

OK nice, I think you need to include Mika Westerberg on this review
as well, because I think he likes to stay on top of all things intel
in pin control. (Also included two other Intel folks in Finland who usually
take an interest in these things.)

Yours,
Linus Walleij

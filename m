Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59ECC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEEF24A67
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfFDJpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:45:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35056 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfFDJpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:45:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so12974649qto.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 02:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6AJnRKhpeKD4LvJlKPUoS2XaQAY2mvLLKuyP5Eoutk=;
        b=k1M4jltMr3chEMgH1OajFbZ7rSRUn/7qnqksFk+5LHOXpMnDtyPmBMG63l1yNSI9z7
         dki+zA1Eq84NrdpzoagB+yFAKkw4b8/g7cIsAVEgTcVfdfDIIOmIsD+xP+2Qa+hrtZpC
         FG0zVSk6/RgyyhvR7Mtgk756zj5opr/SPVivuQUqgCaz221+bKuGedC/ncRsScoe+FRv
         KHGrxsbgNY2XboVrykxAjkwfKFFhH8ldmByxQ/L+VBozsk8wm3eMbrnYfWqZdm2Bu4xV
         rcbNIhQhKcT6SeVEBMXl+GoNzVVT6pW3Ek8dDPb+4l1HW9Pm9jhISCDy1U16NAa9DhOT
         kBNA==
X-Gm-Message-State: APjAAAWXuIrIkBbEqtx37LkbeGqEEaCAq5MyxMgFTWpqqE1E89jeJemm
        1mdLnVW3OlVNjrJyGdhf9dXp/VrEYwgzGBEpzhY=
X-Google-Smtp-Source: APXvYqwDpfRVTt4MwaXXwiCTkknNuYqXrp2QKIQarEJls10EK6TW1TcKGQ/WwH1ov6xm8bl7ripCGWoZlTWbhTnFUAw=
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr22336435qtf.204.1559641519440;
 Tue, 04 Jun 2019 02:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com> <1559577023-558-48-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1559577023-558-48-git-send-email-suzuki.poulose@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 4 Jun 2019 11:45:03 +0200
Message-ID: <CAK8P3a22Uo9mLh7cLpZQQpxRFd=XJ1uKu66eu1c6_AMNzW8etg@mail.gmail.com>
Subject: Re: [RFC PATCH 47/57] drivers: mfd: Use driver_find_device_by_name helper
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 5:52 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Use the new driver_find_device_by_name() helper.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

I see that there are currently no callers of this function, and I never
liked the interface anyway, so how about just removing
syscon_regmap_lookup_by_pdevname instead?

       Arnd

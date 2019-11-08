Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46F7FC6198
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E902178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n1l47WbE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y4Gufeco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfKHV4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:56:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48610 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfKHV4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:56:16 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6081661288; Fri,  8 Nov 2019 21:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573250066;
        bh=hul8lX8VnIGCRS89b/7nULSqp+nszvVrJWi5PtzYDAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n1l47WbEkWPWppEnUKOW5qjxziM0B+8buvvyYcpp+Np0neYwio6vedWYzFmo8yDZG
         /FILx5ekf8uyiOhOvFBdHRLHi+x1ySWXPc9KzouN/LdXMFdjyP/zq11aOi+D6Vhvjd
         kHcP+YcMoW9JBWCB+GRRqFFMsKxX/btTI1xcL6lU=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5CE9161203;
        Fri,  8 Nov 2019 21:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573250065;
        bh=hul8lX8VnIGCRS89b/7nULSqp+nszvVrJWi5PtzYDAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4GufecoCySD4iWuwPYQZdHoon0DmqOfsgqrHzw96gGW+eSpfuDlqvQHmhambVNEG
         /cB2dWLmtMHni8VWeuNLNJxh34ZgbPzZSFJelArzg59JfOEXNV+qHLGzIyqfLtV3QR
         JxW/2gX38RfesP5AElS6spjmt0BA794FtpYsqtPg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CE9161203
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 8 Nov 2019 14:54:24 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, maz@kernel.org,
        LinusW <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        mkshah@codeaurora.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH RFC v2 04/14] drivers: irqchip: add PDC irqdomain for
 wakeup capable GPIOs
Message-ID: <20191108215424.GG16900@codeaurora.org>
References: <1568411962-1022-1-git-send-email-ilina@codeaurora.org>
 <1568411962-1022-5-git-send-email-ilina@codeaurora.org>
 <CAD=FV=WOVHQyk0y3t0eki6cBfBedduQw3T-JZW2dERuCk9tRtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAD=FV=WOVHQyk0y3t0eki6cBfBedduQw3T-JZW2dERuCk9tRtA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08 2019 at 14:22 -0700, Doug Anderson wrote:
>Hi,
>
>On Fri, Sep 13, 2019 at 3:00 PM Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> diff --git a/include/linux/soc/qcom/irq.h b/include/linux/soc/qcom/irq.h
>> new file mode 100644
>> index 0000000..85ac4b6
>> --- /dev/null
>> +++ b/include/linux/soc/qcom/irq.h
>> @@ -0,0 +1,19 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +
>> +#ifndef __QCOM_IRQ_H
>> +#define __QCOM_IRQ_H
>> +
>
>I happened to be looking at a pile of patches and one of them added:
>
>+#include <linux/irqdomain.h>
>
>...right here.  If/when you spin your patch, maybe you should too?  At
>the moment the patch I was looking at is at:
>
>https://android.googlesource.com/kernel/common/+log/refs/heads/android-mainline-tracking
>
>Specifically:
>
>https://android.googlesource.com/kernel/common/+/448e2302f82a70f52475b6fc32bbe30301052e6b
>
>
Sure, will take care of it in the next spin.

--Lina


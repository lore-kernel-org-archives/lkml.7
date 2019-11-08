Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2018EFC6198
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35862084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OByoOTNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732711AbfKHVWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:22:03 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35939 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732246AbfKHVWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:22:02 -0500
Received: by mail-il1-f193.google.com with SMTP id s75so6394016ilc.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 13:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hHbuppcDTbd6STg/n36IHSkDQvgwaovyTFQQvw2epkA=;
        b=OByoOTNcmFJNLtvHQftXOvJ3EwPlUZKslCtZ5oa/wAMLAtwIxqf/4frJZyKSq+/sQ4
         J9PsCN6ojbD99kHspY9uPywEaqNgmN1H3Kf5nbghcQekUG29P3ibVItxCqTZIN5k8LUV
         2MYKE8HQtDmNsxMOegMVxCNOlqm8GgCUV1N2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hHbuppcDTbd6STg/n36IHSkDQvgwaovyTFQQvw2epkA=;
        b=YFSf8Hnc0qvBnBlgncYKEhnGVbA1oNDtw/XxekRt7ZQEmE2Zzz2CuoLuUOGA1e7p7N
         4OEPZRzPgatKhA8iOYsuwNWIj/oJ0w5AzOse2uTqrlipbeM0KNAzZbht90++HZQsnMAp
         A7x5XtRYmsj1+O0C1+YSSYkoyJtpjI+pMDBeqSNgm7kS8kmBtjEq+tnP4Gi4QQGLr4zv
         kzHZU8WEtL0g5XjWSMOVwJF2yS2P/RRKhN9vIeL+eBpp2n89lBbWjh+8B/WiP7nLFdZ2
         r5/theiJnKJ5mbpR+XEByE1Wf1v7boxZKn5HhSWNg0eOojZJUZf10oIcQmp7RkL2CE93
         DrfA==
X-Gm-Message-State: APjAAAWZ8HyI8sA+VH+Evv6eLpWZ16+aBsgOVVw27m3CvUneWFj5Uc+T
        c4KD82kYOOM2Yp9w70n2p9UdBqF6hqo=
X-Google-Smtp-Source: APXvYqzV73TqO+xjXzLBhh9879bU+0JpbBryW6vB1QMnaoOl7c7w7Y548gTKNbRRkie62y9DbX0QBw==
X-Received: by 2002:a05:6e02:cd3:: with SMTP id c19mr15419401ilj.266.1573248121262;
        Fri, 08 Nov 2019 13:22:01 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id u10sm564160iol.43.2019.11.08.13.21.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 13:22:00 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id p6so7873967iod.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 13:21:59 -0800 (PST)
X-Received: by 2002:a5d:9059:: with SMTP id v25mr8937747ioq.58.1573248118962;
 Fri, 08 Nov 2019 13:21:58 -0800 (PST)
MIME-Version: 1.0
References: <1568411962-1022-1-git-send-email-ilina@codeaurora.org> <1568411962-1022-5-git-send-email-ilina@codeaurora.org>
In-Reply-To: <1568411962-1022-5-git-send-email-ilina@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 8 Nov 2019 13:21:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WOVHQyk0y3t0eki6cBfBedduQw3T-JZW2dERuCk9tRtA@mail.gmail.com>
Message-ID: <CAD=FV=WOVHQyk0y3t0eki6cBfBedduQw3T-JZW2dERuCk9tRtA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 04/14] drivers: irqchip: add PDC irqdomain for
 wakeup capable GPIOs
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, maz@kernel.org,
        LinusW <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        mkshah@codeaurora.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 13, 2019 at 3:00 PM Lina Iyer <ilina@codeaurora.org> wrote:
>
> diff --git a/include/linux/soc/qcom/irq.h b/include/linux/soc/qcom/irq.h
> new file mode 100644
> index 0000000..85ac4b6
> --- /dev/null
> +++ b/include/linux/soc/qcom/irq.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __QCOM_IRQ_H
> +#define __QCOM_IRQ_H
> +

I happened to be looking at a pile of patches and one of them added:

+#include <linux/irqdomain.h>

...right here.  If/when you spin your patch, maybe you should too?  At
the moment the patch I was looking at is at:

https://android.googlesource.com/kernel/common/+log/refs/heads/android-mainline-tracking

Specifically:

https://android.googlesource.com/kernel/common/+/448e2302f82a70f52475b6fc32bbe30301052e6b


-Doug

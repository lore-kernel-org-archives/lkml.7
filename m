Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C054C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E562175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uxaI6dHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfDWLDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:03:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42445 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfDWLDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:03:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id x13so2732605ljd.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 04:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ZrmVEW+4rbyZer3jV5srfa3CW9QKwyPr0mWzWI0Nsg=;
        b=uxaI6dHIRe+Kas94DaFQBvBJ5cSULd8S7RfJpAnmFy90zPpaHh7Je1fNc3t1lcTL/Y
         hRPYCblMix0znU93JybVN3SwRiRzz8uZ33TjZx+7HzY9RFw1cD2aK1KnN5nhFfdke0/U
         fur8KXxPd5TKySgX6MNGWIfpMRnF2Uxa8LqIpa/OzwAfZejCy/sr5NePSDeWeS/JIXLJ
         ZOdZFsMUQLB/xnukU9428TdjUAVJ8HJmilfubbyDQ19oOfPx4oUS/z/aWLtOrmjuWXOg
         9Pv4XBk/jXhFn73AWeMOR6JYvLwbkRj+lqQYNlVXXUi0dwjnCHfgeL38SQAFt2fZAlh5
         fiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ZrmVEW+4rbyZer3jV5srfa3CW9QKwyPr0mWzWI0Nsg=;
        b=hVOOnzMAvRa4vqRKV7whz0VvO3TK7szFGznlPESZMzhlCmTSCYO/jiKL91KcOSEyvy
         ppUQJl0PBM9IeWkdJaqFURUCHJeenIhDqLcV8X1nSqmG85jx5xp1S074j+p1pVosoKcR
         l/YvtFTifDRqn9US3aOpde4Al/Gj2ZX+IH1lYi/x4ZKZek2kjUe3smA7uGCsoIkT+K3E
         8rHSehn2ncWcAfGZ/W8xMMpgj8IuQcBD4Bu3XM46usK2y503zKKhSM6T+Cg8DePifG0I
         TEXen6igcpPUcPKHsmmAdMW1AkcJzkS2od/JgI443xafJ8w44zb4HBo1dpZdUdZsc/5j
         dUDw==
X-Gm-Message-State: APjAAAWhVemzybIJcIRb8IdLFr6Hq8ko2aCCKtqOjTnxrfqQFq6bk6Gb
        +znRos2MTsptFCYuyufTePaV0wODp1K0+xWopijNGg==
X-Google-Smtp-Source: APXvYqz+O8JUHzsgMTDGC/It8EJlsSM8u+XHCL0Hkx9VGoOTv1jzzzEj8J9h3GJZD1/FXPHh63YvFrGGfLEVXeS3tTc=
X-Received: by 2002:a2e:834d:: with SMTP id l13mr13700609ljh.97.1556017421635;
 Tue, 23 Apr 2019 04:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190416180556.18458-1-colin.king@canonical.com>
In-Reply-To: <20190416180556.18458-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 13:03:29 +0200
Message-ID: <CACRpkdbFUBy2L_Cfs9n1ML09NLOdTZ_=MekWHfGHuvW5+E+Kiw@mail.gmail.com>
Subject: Re: [PATCH] mfd: ab8500-debugfs: fix spelling mistake "intefer" -> "interfere"
To:     Colin King <colin.king@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 8:05 PM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a dev_warn message, fix this.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

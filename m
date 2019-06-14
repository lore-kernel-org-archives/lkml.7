Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12E9C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C144D2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kkl+hSSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfFNNUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:20:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39386 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbfFNNUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:20:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so2523793wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 06:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BtIRpYfmmNtV+f4PflSdP0iUXELkvzxOAHQGC9syvTI=;
        b=Kkl+hSSFO4wXIrBgYMmZDjEUm6hvl69U+fUZtsIgxOeG8sCiw3MQW4sZAdO8W790En
         UNJS3S1FxTkZi5TKG7Kn9bLMXihxGMsvW26AGUZNoHgzffpraZi+DEIuoGnWQ8SYAets
         QPFCSH0mGHWZQt/1y22XjvHdBFdL1qKWlhNPgs2v2Ir20ykWQKL6nU12/7o2+xrebrVm
         mVzFlDJghIpFktYQkYBo+HFZjre6CWl87R2kO9W4nm9xjGZqftyhlgQMM0sqnX4ufqnc
         uXZOa7CMrOxCPEq0LO9hyyMDG4A+1C8utZFo0Ib+kL9wcLym8m2L8xhgY7Gv9nSpOWou
         Q5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtIRpYfmmNtV+f4PflSdP0iUXELkvzxOAHQGC9syvTI=;
        b=UHsrPii3tkvv68EpAQilsb9QrF81XL/Zi/Z6yUmlik2Qic0iAJeS9/UkUZqhsqAZl6
         28tpFSbpe4rkQpDbMBXi30P9WeLqGYYVEQ6F5K2iGKLO+EzjpZD9N+97ueE+xKZKkn2I
         sPZFFLeBrDRrnHZJsoiGNR2b1/1v2iRmzS5Pt34pY0Pnlc8jCCFiYPmEonxjC+ggKfmq
         a5wH8DK1sEs6OQX0AaJrCoX3hOC+A5td3nHEPyZ8/X1lyXqcQxtbABYfrtu65tyYj3RA
         UzMWNd3dc9mOSe7a85GoHy5XhTUR66BMMT8bl4CK+LJWHLJrQ6uQBDA54z10VdaC3BSE
         fEsA==
X-Gm-Message-State: APjAAAWPsCualAxImyFvimCq2KN19dSwL/1j9x9hq+FSQsF3wQOdHwCs
        7lT4O6F8KXdEi5sZgbFC06TcSGyQ7cTNAxXDa8Jb
X-Google-Smtp-Source: APXvYqwL3CGs6bLZu+6IF9Wwx6mungc3BhJRtvox6UAkACZuuBzRa21xlIfkdahrH9pWzkGE9lpjUF4aBu6JBOZ9pk8=
X-Received: by 2002:a05:6000:146:: with SMTP id r6mr51629714wrx.237.1560518422586;
 Fri, 14 Jun 2019 06:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <1560507893-42553-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1560507893-42553-1-git-send-email-john.garry@huawei.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 14 Jun 2019 08:20:10 -0500
Message-ID: <CAErSpo6jRVDaVvH+9XvzUoEUbHi9_6u+5PcVGVDAmre6Qd0WeQ@mail.gmail.com>
Subject: Re: [PATCH v2] bus: hisi_lpc: Don't use devm_kzalloc() to allocate
 logical PIO range
To:     John Garry <john.garry@huawei.com>
Cc:     xuwei5@huawei.com, linuxarm@huawei.com, arm@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Zhichang Yuan <yuanzhichang@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Zhichang, logic_pio author]

On Fri, Jun 14, 2019 at 5:26 AM John Garry <john.garry@huawei.com> wrote:
>
> If, after registering a logical PIO range, the driver probe later fails,
> the logical PIO range memory will be released automatically.
>
> This causes an issue, in that the logical PIO range is not unregistered
> (that is not supported) and the released range memory may be later
> referenced
>
> Allocate the logical PIO range with kzalloc() to avoid this potential
> issue.
>
> Fixes: adf38bb0b5956 ("HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings")
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>
> Change to v1:
> - add comment, as advised by Joe Perches
>
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> index 19d7b6ff2f17..5f0130a693fe 100644
> --- a/drivers/bus/hisi_lpc.c
> +++ b/drivers/bus/hisi_lpc.c
> @@ -599,7 +599,8 @@ static int hisi_lpc_probe(struct platform_device *pdev)
>         if (IS_ERR(lpcdev->membase))
>                 return PTR_ERR(lpcdev->membase);
>
> -       range = devm_kzalloc(dev, sizeof(*range), GFP_KERNEL);
> +       /* Logical PIO may reference 'range' memory even if the probe fails */
> +       range = kzalloc(sizeof(*range), GFP_KERNEL);

This doesn't feel like the correct way to fix this.  If the probe
fails, everything done by the probe should be undone, including the
allocation and registration of "range".  I don't know what the best
mechanism is, but I'm skeptical about this one.

>         if (!range)
>                 return -ENOMEM;
>
> @@ -610,6 +611,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
>         ret = logic_pio_register_range(range);
>         if (ret) {
>                 dev_err(dev, "register IO range failed (%d)!\n", ret);
> +               kfree(range);
>                 return ret;
>         }
>         lpcdev->io_host = range;
> --
> 2.17.1
>

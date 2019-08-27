Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41968C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CA32070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GXtulx5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbfH0N4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:56:01 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45110 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbfH0N4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:56:00 -0400
Received: by mail-vs1-f66.google.com with SMTP id j25so13465612vsq.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 06:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQzhNAIFt5hn3lNj8VHzyzeNesjUsxuZGnqma8bu4p4=;
        b=GXtulx5b+8SWICbyuPjwDF9F7bv+zAAqlu3W0izJJ9FxbhtfIyDF2TP/yJ4bvTKKRJ
         kgNhO8/nY9YbctW58lDbFnAWR6Meq0ojGpQZmXLNP1dQZLvYE8QaHs6k0J0zlZ/SsYls
         PI8D1ZdYXfEXEnq9nmLbvAMn7hNxxdUoL4jaNKYRLdyyhhon6NVBCTXJ5tGKFO7KK9K1
         I+ZME+KKZOGOZnRBwyA0gD5Ki2Okp9WZUjEh7cnmTchfvMKoxZjQAMVRCi66JZLUezCE
         7R4sYFa3DMEvWHqp98Yh/W1rU58+BlXbxxZFO4cimlrY0k3gSvb56qpaixubm0OuJP7a
         tVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQzhNAIFt5hn3lNj8VHzyzeNesjUsxuZGnqma8bu4p4=;
        b=nLH2N34x6GI72vWVP17/V5lITq7dcMElzC0Lxj11UFu2m4botEPcwI41N6EaqicO1n
         MgqcrSxlaa2VlLCootK8kzo3fhqP1FruADa4f1CrNBUQ22/4wRux5LAIsKyOEbfyrPDT
         VJDq/Ra88xeS6cGDyV50pCskpLXAxSRiCHQMaat5sAH+ls/IHunBkw+mRQXo4gtOQvAo
         B5Q68j+7c4NfJoxsqfXPAPy6M1m/agRXHgaBlIFdHORAPVdx+dX/uBUdeW5J4JglM2OQ
         V1eAEoJnsHnSOkKYQWvcMMIEDyoJGqVJFePiGk+o5TQ94aaXl5reLZ0V4eXrSSm72Uq6
         yBFg==
X-Gm-Message-State: APjAAAVm8a58bcrxjAZtJ/Mwi/MnAZ+yTzG2clPiiIYqF6tYupLDFzRM
        kxgMTXwX5WkjLGNUUrwE3gvhF644HFOY0VGBUZqV6rTr
X-Google-Smtp-Source: APXvYqxyqinG9B1wk9mMD63rudWgHA96o+UjC3keLDloPcQN/XZg/h4S9AIvpCaBd00wLVyZueMl5UVixOOQudOS1oc=
X-Received: by 2002:a67:e287:: with SMTP id g7mr13489601vsf.200.1566914160059;
 Tue, 27 Aug 2019 06:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190827134337.GK13294@shell.armlinux.org.uk>
In-Reply-To: <20190827134337.GK13294@shell.armlinux.org.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Aug 2019 15:55:23 +0200
Message-ID: <CAPDyKFp7e2OD_idam3-2sEd0wJU5OcP=H04G1OvHmAUo2Y-bYw@mail.gmail.com>
Subject: Re: Continuous SD IO causes hung task messages
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 at 15:43, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> Hi,
>
> While dd'ing the contents of a SD card, I get hung task timeout
> messages as per below.  However, the dd is making progress.  Any
> ideas?
>
> Presumably, mmc_rescan doesn't get a look-in while IO is progressing
> for the card?

Is it a regression?

There not much of recent mmc core and mmc block changes, that I can
think of at this point.

>
> ARM64 host, Macchiatobin, uSD card.

What mmc host driver is it? mmci?

Kind regards
Uffe

>
> Thanks.
>
> root@arm-d06300000000:~# dd if=/dev/mmcblk1 | md5sum
> INFO: task kworker/2:1:52 blocked for more than 120 seconds.
>       Not tainted 5.2.0+ #309
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/2:1     D    0    52      2 0x00000028
> Workqueue: events_freezable mmc_rescan
> Call trace:
>  __switch_to+0xb0/0x198
>  __schedule+0x22c/0x604
>  schedule+0x38/0xc8
>  __mmc_claim_host+0xcc/0x1ec
>  mmc_get_card+0x30/0x3c
>  mmc_sd_detect+0x1c/0x78
>  mmc_rescan+0x1c4/0x35c
>  process_one_work+0x14c/0x408
>  worker_thread+0x140/0x3f4
>  kthread+0xfc/0x128
>  ret_from_fork+0x10/0x18
> INFO: task kworker/2:1:52 blocked for more than 120 seconds.
>       Not tainted 5.2.0+ #309
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/2:1     D    0    52      2 0x00000028
> Workqueue: events_freezable mmc_rescan
> Call trace:
>  __switch_to+0xb0/0x198
>  __schedule+0x22c/0x604
>  schedule+0x38/0xc8
>  __mmc_claim_host+0xcc/0x1ec
>  mmc_get_card+0x30/0x3c
>  mmc_sd_detect+0x1c/0x78
>  mmc_rescan+0x1c4/0x35c
>  process_one_work+0x14c/0x408
>  worker_thread+0x140/0x3f4
>  kthread+0xfc/0x128
>  ret_from_fork+0x10/0x18
> INFO: task kworker/2:1:52 blocked for more than 241 seconds.
>       Not tainted 5.2.0+ #309
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/2:1     D    0    52      2 0x00000028
> Workqueue: events_freezable mmc_rescan
> Call trace:
>  __switch_to+0xb0/0x198
>  __schedule+0x22c/0x604
>  schedule+0x38/0xc8
>  __mmc_claim_host+0xcc/0x1ec
>  mmc_get_card+0x30/0x3c
>  mmc_sd_detect+0x1c/0x78
>  mmc_rescan+0x1c4/0x35c
>  process_one_work+0x14c/0x408
>  worker_thread+0x140/0x3f4
>  kthread+0xfc/0x128
>  ret_from_fork+0x10/0x18
> INFO: task kworker/2:1:52 blocked for more than 362 seconds.
>       Not tainted 5.2.0+ #309
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/2:1     D    0    52      2 0x00000028
> Workqueue: events_freezable mmc_rescan
> Call trace:
>  __switch_to+0xb0/0x198
>  __schedule+0x22c/0x604
>  schedule+0x38/0xc8
>  __mmc_claim_host+0xcc/0x1ec
>  mmc_get_card+0x30/0x3c
>  mmc_sd_detect+0x1c/0x78
>  mmc_rescan+0x1c4/0x35c
>  process_one_work+0x14c/0x408
>  worker_thread+0x140/0x3f4
>  kthread+0xfc/0x128
>  ret_from_fork+0x10/0x18
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up

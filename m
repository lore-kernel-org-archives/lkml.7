Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F94DC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2204C22BEB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxwu/bjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391470AbfGWSYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:24:45 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46216 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391458AbfGWSYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:24:44 -0400
Received: by mail-ua1-f66.google.com with SMTP id o19so17343826uap.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2LM8ziNL3CjgvMJTgYt5n9A1u1GBpSBnH6t18zKFSsY=;
        b=dxwu/bjdyI5X0wkqDq4wvOZ2cgg85jGFAhDCjX4xY961JAzWPrWz8jRCox4IeAiTQe
         htUEExMwEN2xa6pU0eeuHLmFtROYIvA+KY46RqTVDKL0DMNG8f/ZrZYx4kQFKSROfM9D
         anTaec2xnlEoQZ3jLHkriu6aeuYEmnWZypEGlnHDGCGddHoYWW43+wqBeZC51eebDMuK
         nnY2IXNtXVImBNX1JSwDacrvAIdkb+37L6l7QRTlm2nKDmiDqAx2vSwVoBWNQclf938l
         9YGv8FSVg2QH/MbGx3RLtS2tYQtMwJ2+5LC1okLfHry+M2pSh3ccGC53S5pzUUEaXkYt
         eRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2LM8ziNL3CjgvMJTgYt5n9A1u1GBpSBnH6t18zKFSsY=;
        b=BVsAfE20AfGQ1AK6w1TO/vLQZcZb5RM+xdgI6nJmlmn41Yj7VzPdsjg/jCAR1O0x/D
         ftYbKc/fEp/WGsXEV05YD7pjOCXJsUPcKAfNWL8jkKiOxL+g/18YqDurtlbDP4FpHcwk
         IJjxTDI5LXqJuBfn63bbNCJM1AwEnMiZrRE0hlxgED0EEwBdQfdA8g5dfVWnACRTtZV8
         pg70SSOJYytS6/tp2vOfLUEIJo8uQQl/m0HVxnTpGkOPq4urgc97mhJFOAwcuY2xYuxa
         mGM8QKj+yIh9y3eiu5ny+lOn6vhFRCqEMoq+hFueU3cpV58HERaQid14vh9Nnw0TZPfm
         Ek0g==
X-Gm-Message-State: APjAAAUrTLO1hpyOM/yaO75A3LRrg24/Y43/mmsLDkfT5drSybj/5maW
        TujbVfhehKX5rrA/1zAiCmq/mnvVaHfjfL1uz58=
X-Google-Smtp-Source: APXvYqyehGC65PVaY+0eH4p3T4O9QClKnlD0GY/7lFy3Bk8wqhtz1YDy/+KqzXFlndu/if6IdKDgDZ9FcaOhQQ0nw4Y=
X-Received: by 2002:ab0:6798:: with SMTP id v24mr20659759uar.43.1563906283854;
 Tue, 23 Jul 2019 11:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190723124608.24617-1-hslester96@gmail.com>
In-Reply-To: <20190723124608.24617-1-hslester96@gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 23 Jul 2019 21:24:18 +0300
Message-ID: <CAFCwf11Y_wxeWdjy_838+Br_vPmMh-dZ0++TKapa6ib_swwbOA@mail.gmail.com>
Subject: Re: [PATCH v2] habanalabs: Use dev_get_drvdata
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 3:46 PM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v2:
>   - Split v1 into different subsystems
>
>  drivers/misc/habanalabs/habanalabs_drv.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
> index 6f6dbe93f1df..678f61646ca9 100644
> --- a/drivers/misc/habanalabs/habanalabs_drv.c
> +++ b/drivers/misc/habanalabs/habanalabs_drv.c
> @@ -295,8 +295,7 @@ void destroy_hdev(struct hl_device *hdev)
>
>  static int hl_pmops_suspend(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct hl_device *hdev = pci_get_drvdata(pdev);
> +       struct hl_device *hdev = dev_get_drvdata(dev);
>
>         pr_debug("Going to suspend PCI device\n");
>
> @@ -310,8 +309,7 @@ static int hl_pmops_suspend(struct device *dev)
>
>  static int hl_pmops_resume(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct hl_device *hdev = pci_get_drvdata(pdev);
> +       struct hl_device *hdev = dev_get_drvdata(dev);
>
>         pr_debug("Going to resume PCI device\n");
>
> --
> 2.20.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
And pushed to -next

Thanks,
Oded

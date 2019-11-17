Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F71CC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 23:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1705E206CC
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 23:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="0+akr7oq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfKQXAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 18:00:33 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:43199 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfKQXAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 18:00:32 -0500
Received: by mail-il1-f193.google.com with SMTP id r9so14230816ilq.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 15:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/1Y1QsI93gAHAKWqh4KEcte8aqnaRPIZE1b5kmVqj0=;
        b=0+akr7oqEpeSO2u3AMLVbtvvWyYay1wmJK9jgvoxAvQHfv6K0sf07DlcIcnsrq9TT4
         yEYe3e9WgTta6rK2pHa1RQJzSonqANR2Pu62/k522iBij0i3EX1MsfVSJgHfIIk6iq9Q
         2e3hlLPWuGiveuqjs+9Xi3E/ElfVs5vmilEMN7HgTo/VTH0cJp0Ktb9LCZ84B4LbSoKQ
         lh8l0cKzQKJ2OYfcyJJq8TU6aC5/WXnK/oz2cn1W/5gLamgrSGUehMTdliEVx13cnD76
         CTmxp1cHU6tL6gO0eHgBD+ziLaMOvLo0OOAzrCkFhdN5xe/rggFHr88x5FoZzRuBBiVj
         qdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/1Y1QsI93gAHAKWqh4KEcte8aqnaRPIZE1b5kmVqj0=;
        b=oLBKQash+F00twJNVmLgQ8CS/lG+F2MFBJjwFFX8cZ8U9nz2ryIKqdPt2s+HJFlUUR
         jwUU4I/RgPdCdBYhYNGAGLY+WoVeOtVEu65n9UxFE0rbymAb3pjMuGeAXhlJ9NylxQ4y
         B1RkGJ57Djy4OaWjuUKycZBpRUkBQjKeuHMUUF6I0LXk4Ub7wt/2R+YADJSgzazn41jz
         BJerlbIjvf1ShnXA7VUyyRbdtl4I514hVuIryV8grrYF/B8O6EXNwK6ZGBcgpO/T6J3b
         6L9joevVPsuYmnuO1h/pe6rvp/2MqRxONxBRPpNCQIiLHciP9XySS2E/zIiSTtlo+Lgo
         bMsw==
X-Gm-Message-State: APjAAAX2EUAzxpLbCH6EqA7/G8lCjsx/XKxrxNcH9DsclNz1HAB1StgG
        oCxhJGINJWDNltoUYKRu3BJZy167AIc200RwLLhlFw==
X-Google-Smtp-Source: APXvYqwWdy6zFjXkz0tCZCsaU/pcQL2aDpb3eh5HwQqdwpJhIQ195TtZ+VfqQFr+VhwLVGAEVyjVaDm+UpscebhFvXc=
X-Received: by 2002:a92:46c9:: with SMTP id d70mr11936574ilk.159.1574031631207;
 Sun, 17 Nov 2019 15:00:31 -0800 (PST)
MIME-Version: 1.0
References: <1573119336-107732-1-git-send-email-linjiasen@hygon.cn>
In-Reply-To: <1573119336-107732-1-git-send-email-linjiasen@hygon.cn>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Sun, 17 Nov 2019 18:00:17 -0500
Message-ID: <CAPoiz9wAJz=Hqb6Os=9AHHv_NGpZ8uCaAuOC=aUTkASKdfs9WQ@mail.gmail.com>
Subject: Re: [PATCH] NTB: Fix an error in get link status
To:     Jiasen Lin <linjiasen@hygon.cn>
Cc:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-ntb <linux-ntb@googlegroups.com>, linjiasen007@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 4:37 AM Jiasen Lin <linjiasen@hygon.cn> wrote:
>
> The offset of PCIe Capability Header for AMD and HYGON NTB is 0x64,
> but the macro which named "AMD_LINK_STATUS_OFFSET" is defined as 0x68.
> It is offset of Device Capabilities Reg rather than Link Control Reg.
>
> This code trigger an error in get link statsus:
>
>         cat /sys/kernel/debug/ntb_hw_amd/0000:43:00.1/info
>                 LNK STA -               0x8fa1
>                 Link Status -           Up
>                 Link Speed -            PCI-E Gen 0
>                 Link Width -            x0
>
> This patch use pcie_capability_read_dword to get link status.
> After fix this issue, we can get link status accurately:
>
>         cat /sys/kernel/debug/ntb_hw_amd/0000:43:00.1/info
>                 LNK STA -               0x11030042
>                 Link Status -           Up
>                 Link Speed -            PCI-E Gen 3
>                 Link Width -            x16

No response from AMD maintainers, but it looks like you are correct.

This needs a "Fixes:" line here.  I took the liberty of adding one to
this patch.

> Signed-off-by: Jiasen Lin <linjiasen@hygon.cn>
> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c | 5 +++--
>  drivers/ntb/hw/amd/ntb_hw_amd.h | 1 -
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index 156c2a1..ae91105 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -855,8 +855,8 @@ static int amd_poll_link(struct amd_ntb_dev *ndev)
>
>         ndev->cntl_sta = reg;
>
> -       rc = pci_read_config_dword(ndev->ntb.pdev,
> -                                  AMD_LINK_STATUS_OFFSET, &stat);
> +       rc = pcie_capability_read_dword(ndev->ntb.pdev,
> +                                  PCI_EXP_LNKCTL, &stat);
>         if (rc)
>                 return 0;
>         ndev->lnk_sta = stat;
> @@ -1139,6 +1139,7 @@ static const struct ntb_dev_data dev_data[] = {
>  static const struct pci_device_id amd_ntb_pci_tbl[] = {
>         { PCI_VDEVICE(AMD, 0x145b), (kernel_ulong_t)&dev_data[0] },
>         { PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
> +       { PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },

This should be a separate patch.  I took the liberty of splitting it
off into a unique patch and attributing it to you.  I've pushed them
to the ntb-next branch on
https://github.com/jonmason/ntb

Please verify everything looks acceptable to you (given the changes I
did above that are attributed to you).  Also, testing of the latest
code is always appreciated.

Thanks,
Jon


>         { 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, amd_ntb_pci_tbl);
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
> index 139a307..39e5d18 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.h
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
> @@ -53,7 +53,6 @@
>  #include <linux/pci.h>
>
>  #define AMD_LINK_HB_TIMEOUT    msecs_to_jiffies(1000)
> -#define AMD_LINK_STATUS_OFFSET 0x68
>  #define NTB_LIN_STA_ACTIVE_BIT 0x00000002
>  #define NTB_LNK_STA_SPEED_MASK 0x000F0000
>  #define NTB_LNK_STA_WIDTH_MASK 0x03F00000
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/1573119336-107732-1-git-send-email-linjiasen%40hygon.cn.

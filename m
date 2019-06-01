Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD7AC28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 05:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2CB27123
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 05:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw/tjc94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfFAFBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 01:01:40 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46572 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfFAFBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 01:01:40 -0400
Received: by mail-vs1-f65.google.com with SMTP id l125so8015595vsl.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 22:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbTpP+/2yl93ppGmlaruO15Di/JhyBXvOAuSPDJpxVU=;
        b=Qw/tjc941+hJg5QF5tAriOmNLHSScFajoTirD3Fq7Nlo6oGKtmSZ+EQphMNAwR+uIi
         +uZXuHN3IeTmJTfgmaKrn8Rb8q+rd9oeWZL8P1MlZITkoU1GNtn5PwbOINg6MYwFSjsr
         +ws1zG7/nBa+uhO7P1mEysMQS9kSI5t0HNoqgMH8CEy2zk+7E6pgygbZrcdRC7mtKyUd
         PcZxBTwrZbQX+7VmEzwvzOATVoo7nqf+gCX6V5P+PWOHqDZMIXVQq+Elx4uih+MphYTy
         84c2Ohqkg+Jp5twFprVNpv0wemocyppz+LCCrP8lHaGUQ/xVWKAhq/s28DHCvF5vMOl4
         Gs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbTpP+/2yl93ppGmlaruO15Di/JhyBXvOAuSPDJpxVU=;
        b=phHg0bg5j6b7cdGoJddxgU0izjnQmW2Z1BBay2Toy6S2J347oybm8vHhKGKnI8GOcF
         hyDe2mxpyoYDaL4pbCVH2utmqSwQCnFbWiyQa7eSWCH7OsIkbt7sOaLzNqyrZ7b2AXJw
         Wb09DCfCgSvEkM8fHoJzru+Wp5O5Yv9r1uLrX0+kbT19BynTrdMCqICkpysm92lwrAmb
         2R02JoS97uEat9/jJhR8slw2lYpCb5jHiQ5TcdnvRRWcVBLdF8z68zBDjpKXs8gm5NG4
         YxrOvYn3UccEO1zsCe2d0UX07gUz/wt9l2TN+7lI6yCvu4GZFn5hS2qtYRXhcqaH82dk
         LZTg==
X-Gm-Message-State: APjAAAVed9x0/Mq1fglCLzgIn/NEZ3J/AZBBR0gM7GhkuxVrn9aVp7No
        tADmMuaujbbzq7UtqtqLHRWAza10H9eEnvOiicams9Mr
X-Google-Smtp-Source: APXvYqzGcgn6eLPxHBhhgPPHlkhLOyZjeiv8XR4C7Qb08Hyw3W3UdP4cf6Y9FnnvdAjt8JTqcmHuAamUkC3xoPmJaPQ=
X-Received: by 2002:a67:b408:: with SMTP id x8mr7003287vsl.236.1559365299345;
 Fri, 31 May 2019 22:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190530084554.31968-1-dbenzoor@habana.ai> <20190530084554.31968-3-dbenzoor@habana.ai>
In-Reply-To: <20190530084554.31968-3-dbenzoor@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 1 Jun 2019 08:01:13 +0300
Message-ID: <CAFCwf13sxrNmwF+txKHy-vNkNDgsHSgbh66h0aYxVZStGY8GEg@mail.gmail.com>
Subject: Re: [PATCH 3/3] habanalabs: restore unsecured registers default values
To:     Dalit Ben Zoor <dbenzoor@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 11:46 AM Dalit Ben Zoor <dbenzoor@habana.ai> wrote:
>
> unsecured registers can be changed by the user, and hence should be
> restored to their default values in context switch
>
> Signed-off-by: Dalit Ben Zoor <dbenzoor@habana.ai>
> ---
>  drivers/misc/habanalabs/goya/goya.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index 87859c55b4b8..81c1d576783f 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -786,7 +786,6 @@ static void goya_init_dma_ch(struct hl_device *hdev, int dma_id)
>         else
>                 sob_addr = CFG_BASE + mmSYNC_MNGR_SOB_OBJ_1007;
>
> -       WREG32(mmDMA_CH_0_WR_COMP_ADDR_LO + reg_off, lower_32_bits(sob_addr));
>         WREG32(mmDMA_CH_0_WR_COMP_ADDR_HI + reg_off, upper_32_bits(sob_addr));
>         WREG32(mmDMA_CH_0_WR_COMP_WDATA + reg_off, 0x80000001);
>  }
> @@ -4560,10 +4559,12 @@ static int goya_memset_device_memory(struct hl_device *hdev, u64 addr, u64 size,
>  int goya_context_switch(struct hl_device *hdev, u32 asid)
>  {
>         struct asic_fixed_properties *prop = &hdev->asic_prop;
> -       u64 addr = prop->sram_base_address;
> +       u64 addr = prop->sram_base_address, sob_addr;
>         u32 size = hdev->pldm ? 0x10000 : prop->sram_size;
>         u64 val = 0x7777777777777777ull;
> -       int rc;
> +       int rc, dma_id;
> +       u32 channel_off = mmDMA_CH_1_WR_COMP_ADDR_LO -
> +                                       mmDMA_CH_0_WR_COMP_ADDR_LO;
>
>         rc = goya_memset_device_memory(hdev, addr, size, val, false);
>         if (rc) {
> @@ -4571,7 +4572,19 @@ int goya_context_switch(struct hl_device *hdev, u32 asid)
>                 return rc;
>         }
>
> +       /* we need to reset registers that the user is allowed to change */
> +       sob_addr = CFG_BASE + mmSYNC_MNGR_SOB_OBJ_1007;
> +       WREG32(mmDMA_CH_0_WR_COMP_ADDR_LO, lower_32_bits(sob_addr));
> +
> +       for (dma_id = 1 ; dma_id < NUMBER_OF_EXT_HW_QUEUES ; dma_id++) {
> +               sob_addr = CFG_BASE + mmSYNC_MNGR_SOB_OBJ_1000 +
> +                                                       (dma_id - 1) * 4;
> +               WREG32(mmDMA_CH_0_WR_COMP_ADDR_LO + channel_off * dma_id,
> +                                               lower_32_bits(sob_addr));
> +       }
> +
>         WREG32(mmTPC_PLL_CLK_RLX_0, 0x200020);
> +
>         goya_mmu_prepare(hdev, asid);
>
>         goya_clear_sm_regs(hdev);
> --
> 2.17.1
>
The patch-set is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>

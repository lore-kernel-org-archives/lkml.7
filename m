Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C35C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C122168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwhVp3jX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbfJPJNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:13:36 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45015 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfJPJNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:13:35 -0400
Received: by mail-vs1-f66.google.com with SMTP id w195so15089297vsw.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 02:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipeEMzhkOnzLxRec01CNpfZFCUUDDiAMbxb6yqTWXBA=;
        b=YwhVp3jXvvqcOhfdfczRJh1EKr5+6HoKBHcZx6gHHVyTtb4HVI3D0NnVyZtvBbamze
         2QAmeG0HKMlBTIPbmlhbXGyO2l1aHhfqqkouQCaZ37spLThYv+Rr3TYLnfiUIfXKAVBY
         C+WLBNLi+I4um0rvG3aAolHwF+Q3M0izXm4O23fR90FmAF/+PzGvOg1v9Yq461wCXr3p
         Zqy88yoPfQPXlPx0vnO6pULpXTRIt0ztVLhQrcA2aha0+04kH3ch3Lk77Euvbra6haj2
         pEuypRTL3b/yGQinH96Zckmig3xyv21svIzwof2O/MrXXTGufowhje33mrWBttIIy1FU
         aA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipeEMzhkOnzLxRec01CNpfZFCUUDDiAMbxb6yqTWXBA=;
        b=JhtXUc+OkxwghNE7YdZlPE0BXPoD2TanqQMuE4TlB+kanQ3M0KA7F7+uR59Ok38Trp
         gHIBXgJIRPVCK9wC0yZM4RyJ8v6FoL3n7aaR4v1J90rVjiMIr9hN5ECzBSUtJRu9mNAl
         2/RT9nAclsDdVWHHWs29E6HTeWbuQ6OICEcLl1a0TPwoLDOxGptLm/P2sgtU4a6PmYg8
         Ter12MnejNVpBj4TexvrIkZfcaah7L1HnSgw/2Ovuav6q1iCuvw4Bb3wFrIc6wuKO3zA
         rpiBr8/oc0xuaJm2VaghbhImmpeTKxMoiixea2NyTVMFkgnB8GxE9K1p3fHxXlWAdaeX
         zBLQ==
X-Gm-Message-State: APjAAAW7NBtmN79FtVPOcdjvDWKz4ay/xM3mLvnnFapAC2DQIv5M8vw2
        k0dMfo7Hs51jYl11mKJvDeb6Pf86ZylF/sxnoL0=
X-Google-Smtp-Source: APXvYqwvPz+okueO6liKcnbswClu66DZ/pQ8pTDxUw42psNY+AYLr68zWA+OHWK/KTz0h7RPWY7wot4rxEPB0hnatBY=
X-Received: by 2002:a67:5c41:: with SMTP id q62mr21584181vsb.236.1571217213101;
 Wed, 16 Oct 2019 02:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191016084632.26424-1-yuehaibing@huawei.com>
In-Reply-To: <20191016084632.26424-1-yuehaibing@huawei.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Wed, 16 Oct 2019 12:13:07 +0300
Message-ID: <CAFCwf11Zew-SdHxz7Nj3gFXRhfF74UgXPJdXJsXj8f=xth_mbg@mail.gmail.com>
Subject: Re: [PATCH -next] habanalabs: remove set but not used variable 'qman_base_addr'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomer Tayar <ttayar@habana.ai>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Dalit Ben Zoor <dbenzoor@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 11:48 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/misc/habanalabs/goya/goya.c: In function 'goya_init_mme_cmdq':
> drivers/misc/habanalabs/goya/goya.c:1536:6: warning:
>  variable 'qman_base_addr' set but not used [-Wunused-but-set-variable]
>
> It is never used, so can be removed.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/misc/habanalabs/goya/goya.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index 6fba14b..1ef34ec 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -1533,7 +1533,6 @@ static void goya_init_mme_cmdq(struct hl_device *hdev)
>         u32 mtr_base_lo, mtr_base_hi;
>         u32 so_base_lo, so_base_hi;
>         u32 gic_base_lo, gic_base_hi;
> -       u64 qman_base_addr;
>
>         mtr_base_lo = lower_32_bits(CFG_BASE + mmSYNC_MNGR_MON_PAY_ADDRL_0);
>         mtr_base_hi = upper_32_bits(CFG_BASE + mmSYNC_MNGR_MON_PAY_ADDRL_0);
> @@ -1545,9 +1544,6 @@ static void goya_init_mme_cmdq(struct hl_device *hdev)
>         gic_base_hi =
>                 upper_32_bits(CFG_BASE + mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR);
>
> -       qman_base_addr = hdev->asic_prop.sram_base_address +
> -                               MME_QMAN_BASE_OFFSET;
> -
>         WREG32(mmMME_CMDQ_CP_MSG_BASE0_ADDR_LO, mtr_base_lo);
>         WREG32(mmMME_CMDQ_CP_MSG_BASE0_ADDR_HI, mtr_base_hi);
>         WREG32(mmMME_CMDQ_CP_MSG_BASE1_ADDR_LO, so_base_lo);
> --
> 2.7.4
>
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Applied to -next
Thanks,
Oded

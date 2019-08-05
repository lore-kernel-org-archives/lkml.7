Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F111BC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C319120657
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw8ADuDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfHEHLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:11:49 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45021 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfHEHLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:11:49 -0400
Received: by mail-ua1-f66.google.com with SMTP id 8so31882725uaz.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 00:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TRCA+VNevmcLQM2/K8vG4I9XTdWP65F4N/hZ4l1EKgE=;
        b=Qw8ADuDw+szT7KFs/w6R7WdfILlwj/xRfSUW8JxxEsW7IPxwojjuX6lcUFrF8owiz3
         XM9+IGWsMDzqLuBfa0l6RtNCogoz4m5wGzYf2OBLW9ZBGzKDET04HT3G+Oz2lhLsT1Tu
         hpP3QU2vezl20fUSmNxKGtuxjMCoxz4jXEJwESIrS1FTYevJKgS85SQh6ZHx082g443K
         vQLVPrIqEdocdp1e3o8Mj33nknXodLdNb6gN3bTp/19haMG5K1frJrqKH/0P0mAacBnQ
         4HLc6gKNTQ7LoIUIOGvp9LuCMfe5gtqtLe5df8d4Ct+xKoJ5GnM5upn/avjh9AFD8Hr/
         bM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TRCA+VNevmcLQM2/K8vG4I9XTdWP65F4N/hZ4l1EKgE=;
        b=ruFqX7e082Pe3F65xPj0jRk4yU047ajiKXiEZMCcQ7rMh788e0gVhvqwPZrGBxXzZ4
         oKd/Pr4dIFWRJjN1BxPwEd+eqT2zgPiCwpuCc/TunjnaqfCPUc6hcZrkQtX0V3Gu38yK
         PMjJ4qoyRvsSep7Ogneoh9aEOEbm485wAdRf3FKM/iqkxCHMbpjRNHtQaxa7fEeMVh/e
         8SKN7AmjzT57kZCZyzpSo+2LhBMvKELpoCg4Zk4BT78UYBXjFgusPQ0vRgzRSu5xzh15
         mIOLOpMRpvHSGuar930hcvAywkPiDKppzV8TpYd9dLU0+vDYtRBTygtNtG6wkLHnW5YD
         fg9Q==
X-Gm-Message-State: APjAAAWw18zfqbhTZuLJKK44az2LocVv90uh17+xvU5KhstTRzfkderg
        +xbfiRuWd5qIw6jRaH1ApJe1zAIqTylNg7gQiXryCg==
X-Google-Smtp-Source: APXvYqx7sA1bvhNDDnVVuZsul9xeSiLyFwQRgd7T0ZCozpkszH3MzAh9VrVqHghcO8Qvl2rz76CBvc/sazCp9o0MeLM=
X-Received: by 2002:a9f:230c:: with SMTP id 12mr23129301uae.85.1564989108098;
 Mon, 05 Aug 2019 00:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190801142834.329-1-ttayar@habana.ai> <20190801142834.329-2-ttayar@habana.ai>
In-Reply-To: <20190801142834.329-2-ttayar@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 5 Aug 2019 10:11:22 +0300
Message-ID: <CAFCwf138nFfGEJmhW_rxXS-60LruyPhm+XNVX5ZW4LuyxkT5Ww@mail.gmail.com>
Subject: Re: [PATCH 2/2] habanalabs: Add descriptive name to PSOC app status register
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 5:28 PM Tomer Tayar <ttayar@habana.ai> wrote:
>
> Add a meaningful name to the general PSOC application status register
> which better describes its usage in keeping the HW state.
>
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> ---
>  drivers/misc/habanalabs/goya/goya.c                 | 4 ++--
>  drivers/misc/habanalabs/include/goya/goya_reg_map.h | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index 9699e7d4903e..6acda363983f 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -2468,7 +2468,7 @@ static int goya_hw_init(struct hl_device *hdev)
>          * we need to reset the chip before doing H/W init. This register is
>          * cleared by the H/W upon H/W reset
>          */
> -       WREG32(mmPSOC_GLOBAL_CONF_APP_STATUS, HL_DEVICE_HW_STATE_DIRTY);
> +       WREG32(mmHW_STATE, HL_DEVICE_HW_STATE_DIRTY);
>
>         rc = goya_init_cpu(hdev, GOYA_CPU_TIMEOUT_USEC);
>         if (rc) {
> @@ -5023,7 +5023,7 @@ static int goya_get_eeprom_data(struct hl_device *hdev, void *data,
>
>  static enum hl_device_hw_state goya_get_hw_state(struct hl_device *hdev)
>  {
> -       return RREG32(mmPSOC_GLOBAL_CONF_APP_STATUS);
> +       return RREG32(mmHW_STATE);
>  }
>
>  static const struct hl_asic_funcs goya_funcs = {
> diff --git a/drivers/misc/habanalabs/include/goya/goya_reg_map.h b/drivers/misc/habanalabs/include/goya/goya_reg_map.h
> index 554034f47317..cd89723c7f61 100644
> --- a/drivers/misc/habanalabs/include/goya/goya_reg_map.h
> +++ b/drivers/misc/habanalabs/include/goya/goya_reg_map.h
> @@ -29,4 +29,6 @@
>  #define mmUBOOT_OFFSET         mmPSOC_GLOBAL_CONF_SCRATCHPAD_30
>  #define mmBTL_ID               mmPSOC_GLOBAL_CONF_SCRATCHPAD_31
>
> +#define mmHW_STATE             mmPSOC_GLOBAL_CONF_APP_STATUS
> +
>  #endif /* GOYA_REG_MAP_H_ */
> --
> 2.17.1
>

The two patches are:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Applied to -next.
Thanks,
Oded

Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9DDC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D97F20675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557259838;
	bh=oTBgKL5aXOPYEaA0QsHuiiXhVpGLNi15rpzcfvlc1DU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xVSFMDVkpMyqikjCB+/B/nF8T7dYyt7E/58T7OtFk6Y7wM0ZpP77WQAXex0lCSq42
	 Bflnh10B6+HaFABcUTG5XGeyp0phF9kaeMRd7gBe89gMSy+JIYXrSSXaAFVemZbFNp
	 oZ6qBCF5NOdiiAYdxg6MTdsfP2VngyWEVUFC0zYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfEGUKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:10:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbfEGUKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:10:37 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF0F206A3;
        Tue,  7 May 2019 20:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557259836;
        bh=oTBgKL5aXOPYEaA0QsHuiiXhVpGLNi15rpzcfvlc1DU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VZjgbpZPTl/MncgPQqKajohmdLIAXZzdzcb/Bhhm/oAmiUiWlmtVoQxca7vspL/yU
         HAhS97V8BHdCSYRNeyXDgooemuMlOT29lwnuXoFZ2Lmv1i3VkgmsBpmUB0nbRgBixv
         uZajpFvPyz2ZQJHh9Yo4LwloBjWGpW8991VRkrFA=
Received: by mail-ed1-f50.google.com with SMTP id m4so19903423edd.8;
        Tue, 07 May 2019 13:10:36 -0700 (PDT)
X-Gm-Message-State: APjAAAWmbLDKUsDErv5oeTSC60iE/lUicQHCafwmXJDUCc0oXzwSS1Mz
        XsSrLIXz/m53Atchn1MufB66If7XahpOiXqRRUw=
X-Google-Smtp-Source: APXvYqyiCB9JXQ0wLTLu8EE9iNvVNOx/KZdH3UB/pccMW07rIEOkU5//tddBxsd+La7b72Op9PI0/zra1uHwU6biSAo=
X-Received: by 2002:a17:906:4c59:: with SMTP id d25mr14287057ejw.195.1557259834620;
 Tue, 07 May 2019 13:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190507194313.1618-1-mdf@kernel.org>
In-Reply-To: <20190507194313.1618-1-mdf@kernel.org>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 7 May 2019 15:09:57 -0500
X-Gmail-Original-Message-ID: <CANk1AXTgzAAH+c6oNe-ALZ5vHhUCcdhWYYAs9mbdYSB+bPabJQ@mail.gmail.com>
Message-ID: <CANk1AXTgzAAH+c6oNe-ALZ5vHhUCcdhWYYAs9mbdYSB+bPabJQ@mail.gmail.com>
Subject: Re: [PATCH v2] fpga: zynqmp-fpga: Correctly handle error pointer
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 2:43 PM Moritz Fischer <mdf@kernel.org> wrote:
>
> Fixes the following static checker errors:
>
> drivers/fpga/zynqmp-fpga.c:50 zynqmp_fpga_ops_write()
> error: 'eemi_ops' dereferencing possible ERR_PTR()
>
> drivers/fpga/zynqmp-fpga.c:84 zynqmp_fpga_ops_state()
> error: 'eemi_ops' dereferencing possible ERR_PTR()
>
> Note: This does not handle the EPROBE_DEFER value in a
>       special manner.
>
> Fixes commit c09f7471127e ("fpga manager: Adding FPGA Manager support for
> Xilinx zynqmp")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>

Acked-by: Alan Tull <atull@kernel.org>

Thanks!
Alan

> ---
>
> Changes from v1:
> - Address Alan's feedback regarding handling both occurences.
>
> ---
>  drivers/fpga/zynqmp-fpga.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> index f7cbaadf49ab..b8a88d21d038 100644
> --- a/drivers/fpga/zynqmp-fpga.c
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -47,7 +47,7 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
>         char *kbuf;
>         int ret;
>
> -       if (!eemi_ops || !eemi_ops->fpga_load)
> +       if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_load)
>                 return -ENXIO;
>
>         priv = mgr->priv;
> @@ -81,7 +81,7 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
>         const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
>         u32 status;
>
> -       if (!eemi_ops || !eemi_ops->fpga_get_status)
> +       if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_get_status)
>                 return FPGA_MGR_STATE_UNKNOWN;
>
>         eemi_ops->fpga_get_status(&status);
> --
> 2.21.0
>

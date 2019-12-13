Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D041C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 02:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFD9206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 02:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5c0q9mL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbfLMCJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 21:09:32 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37917 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfLMCJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 21:09:31 -0500
Received: by mail-ot1-f68.google.com with SMTP id h20so4330019otn.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 18:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vovJd+uHMVTrtqK/zCJZbzcPcP72DcTVR7QkhclYvEk=;
        b=q5c0q9mLNmokamXfmx9MFWb207RUgzaDGN2UhqWgLavf9rRxkkfCqgzGTsqhgsrz8O
         5lOWgoc0woysdcXfGOA4slOkpnZ67WEXrlZwCQis7QvIc+Wq+1uWrNoHvsrvRi/JVBul
         SANe+fNbq4okVnp9H6txdmfA+6CQAkMbh/BH6GvPR1Y3XviozV3pm/4MZRYQaKXxws6f
         5QzaGOq89tUTUQEtuMptuDInXjGssF0ST9Ua97ZpqN/ijGTG9Udnh8sK8rzvqtUSsB3r
         /gzkQsyGCt2RHX7s0rVBuFEvlHa/5TQOOFZ1uHt7osOgLBt1cmOwEyvDBOnivoLi6Fk+
         5/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vovJd+uHMVTrtqK/zCJZbzcPcP72DcTVR7QkhclYvEk=;
        b=pdgNv9sdIYTqC+n84Sl0u4LSTx8z9sswyAmuTYptOir8lQPZI6YB6Bwzpz9P4p39GZ
         tXzR7S1x+Nd1ofzcGOghxmUeS2/8WA+G8LTzOUnWf4Y/92TtvPa/OWvlPJTpC//Io7Ix
         dU1lCc8NJzh5QU7SMLpbHeKkMANuowyFi4sm5MA7JTDXPpaeCvNO2+dkRLk7iq0E9QwH
         CQE99egee4dqHzuNM1CfL5FHtWj7PpOGsHIsuQIWhGQL3EJZgTvh8NzIfGbq/u6ri6zp
         1wZePaszCv5tRffmXayxXeKxNxKioYP+q6wdy/mg2Kj2yJBittOwKza64heX1nEu643B
         qjdA==
X-Gm-Message-State: APjAAAXqyGXoR4VGZSEkI1eseZu5eG9gi9yaR/sxYVH2I61BeFxN3eGB
        jY5+KNjvPG2MvaW89u4iW4J6M0ipnuo2X6tO9lY=
X-Google-Smtp-Source: APXvYqywZZkqxjGj7LWVTn+9w8E+MgzSO1+JJ6BWsL03agkEYsJDN3v5Fz0L0r0wcxi2IwDsnu1PGOUXGuL4jP7lTwk=
X-Received: by 2002:a9d:6a8f:: with SMTP id l15mr11486859otq.59.1576202970718;
 Thu, 12 Dec 2019 18:09:30 -0800 (PST)
MIME-Version: 1.0
References: <1575976016-110900-1-git-send-email-chenwandun@huawei.com>
In-Reply-To: <1575976016-110900-1-git-send-email-chenwandun@huawei.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 13 Dec 2019 04:09:03 +0200
Message-ID: <CAFCwf13U7qcJEL=3qqtNSid7KBiviaJR-64+X5zsu-118-GODQ@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: remove variable 'val' set but not used
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tomer Tayar <ttayar@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Dalit Ben Zoor <dbenzoor@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 1:00 PM Chen Wandun <chenwandun@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/misc/habanalabs/goya/goya.c: In function goya_pldm_init_cpu:
> drivers/misc/habanalabs/goya/goya.c:2195:6: warning: variable val set but not used [-Wunused-but-set-variable]
> drivers/misc/habanalabs/goya/goya.c: In function goya_hw_init:
> drivers/misc/habanalabs/goya/goya.c:2505:6: warning: variable val set but not used [-Wunused-but-set-variable]
>
> Fixes: 9494a8dd8d22 ("habanalabs: add h/w queues module")
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>  drivers/misc/habanalabs/goya/goya.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index c8d16aa..7344e8a 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -2192,7 +2192,7 @@ static int goya_push_linux_to_device(struct hl_device *hdev)
>
>  static int goya_pldm_init_cpu(struct hl_device *hdev)
>  {
> -       u32 val, unit_rst_val;
> +       u32 unit_rst_val;
>         int rc;
>
>         /* Must initialize SRAM scrambler before pushing u-boot to SRAM */
> @@ -2200,14 +2200,14 @@ static int goya_pldm_init_cpu(struct hl_device *hdev)
>
>         /* Put ARM cores into reset */
>         WREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL, CPU_RESET_ASSERT);
> -       val = RREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL);
> +       RREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL);
>
>         /* Reset the CA53 MACRO */
>         unit_rst_val = RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
>         WREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N, CA53_RESET);
> -       val = RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
> +       RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
>         WREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N, unit_rst_val);
> -       val = RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
> +       RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
>
>         rc = goya_push_uboot_to_device(hdev);
>         if (rc)
> @@ -2228,7 +2228,7 @@ static int goya_pldm_init_cpu(struct hl_device *hdev)
>         /* Release ARM core 0 from reset */
>         WREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL,
>                                         CPU_RESET_CORE0_DEASSERT);
> -       val = RREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL);
> +       RREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL);
>
>         return 0;
>  }
> @@ -2502,13 +2502,12 @@ int goya_mmu_init(struct hl_device *hdev)
>  static int goya_hw_init(struct hl_device *hdev)
>  {
>         struct asic_fixed_properties *prop = &hdev->asic_prop;
> -       u32 val;
>         int rc;
>
>         dev_info(hdev->dev, "Starting initialization of H/W\n");
>
>         /* Perform read from the device to make sure device is up */
> -       val = RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
> +       RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
>
>         /*
>          * Let's mark in the H/W that we have reached this point. We check
> @@ -2560,7 +2559,7 @@ static int goya_hw_init(struct hl_device *hdev)
>                 goto disable_queues;
>
>         /* Perform read from the device to flush all MSI-X configuration */
> -       val = RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
> +       RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
>
>         return 0;
>
> --
> 2.7.4
>

Thanks!
Applied to -fixes
Oded

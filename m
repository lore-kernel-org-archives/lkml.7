Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACEBC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84752054F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbfHFIC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:02:58 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:43737 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732122AbfHFIC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:02:57 -0400
Received: by mail-vs1-f49.google.com with SMTP id j26so57755934vsn.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 01:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to;
        bh=M6h+ZLVGP5Nx+kft/9Cf+xMsyHHRiA7dp9KBoAgSGBE=;
        b=DgBSZCyu4R6atU1vUD8Ya3ipPUML7pl3gQqYktueClFmlo3hBFxCY8C7uFfG3AbhOt
         KnUWVrmz4FKW+vfR2OCdKt9uXB/9MV6ZoP8p+/OWplvN0UwVb4HD0eFgGdLDOugPXayQ
         FQ2AjMEO4ou1uoJ/wkhoMSUfQZ2d4S7Iv+NOrdXL99kHwV653ezTzoXQxPjQPuCJJizI
         RSiOuAWcRdZ/8Zl4xy5N11ex8daPcsm2sdOuo75qXP+tOmKR8WYqM4U4MzR/P+dpFNGB
         qQIWPVcYMg5gv15ClBjFI2n37sk3DSoQTrJdMNHELjz0bvNnEKboPJvtgNYADKHxUZIE
         5PVw==
X-Gm-Message-State: APjAAAUiZolOgZOfTx8qdiVzxjoYhwp4gJiTxr+bJI1vZ7Yx/DS0t+Ey
        Fqvf1/5Do9sRcBCzKIpCYaSvBZbcpJo=
X-Google-Smtp-Source: APXvYqzLwW2WXlOUtb9DMH7qABfUqWdZ5y/uGeYbj6wnW+VAfu+jM3MsGi1wJPYKHY/O+XrPob9zFw==
X-Received: by 2002:a67:ed81:: with SMTP id d1mr1457402vsp.157.1565078576647;
        Tue, 06 Aug 2019 01:02:56 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id j80sm17911531vkj.47.2019.08.06.01.02.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 01:02:56 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id h28so57716862vsl.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 01:02:56 -0700 (PDT)
X-Received: by 2002:a67:f795:: with SMTP id j21mr1395756vso.226.1565078576215;
 Tue, 06 Aug 2019 01:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJX_Q+21M+W6B2Ab9TZeNSSCVdLcU1J1LBCHO13CR0T+e=SVOQ@mail.gmail.com>
In-Reply-To: <CAJX_Q+21M+W6B2Ab9TZeNSSCVdLcU1J1LBCHO13CR0T+e=SVOQ@mail.gmail.com>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Tue, 6 Aug 2019 09:02:45 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+2TsdSwdZPYSG9k+c5DHSTv5V2Unyyj130-6xjWec8Dug@mail.gmail.com>
Message-ID: <CAJX_Q+2TsdSwdZPYSG9k+c5DHSTv5V2Unyyj130-6xjWec8Dug@mail.gmail.com>
Subject: Re: Question about mfd_add_devices and platform_data
To:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Can you help me with this question?

Thanks
Lucas

On Mon, Aug 5, 2019 at 2:43 PM Lucas Tanure <tanure@linux.com> wrote:
>
> Hi,
>
> I would like to understand mfd_add_devices call and platform_data section.
> An mfd device can have platform_data, which is kmemdup at
> platform_device_add_data from platform_device_add_data call inside
> mfd_add_device. And after this kmemdup the new mfd device receives the
> clone memory and the pointer given to platform_device_add_data is freed.
>
> All the drivers I read the platform_data is static, which in my view can
> not be freed and kfrees says:
>
> "Don't free memory not originally allocated by kmalloc() or you will run
> into trouble."
>
> So, my questions is : Should my driver kmalloc platform_data first and then
> call mfd_add_devices ? Or it's fine to give static memory to it ?
>
> Example driver:
>
> drivers/mfd/vexpress-sysreg.c:
>
> static struct syscon_platform_data vexpress_sysreg_sys_id_pdata = {
> .label = "sys_id",
> };
>
> static struct mfd_cell vexpress_sysreg_cells[] = {
> {
> .name = "syscon",
> .num_resources = 1,
> .resources = (struct resource []) {
> DEFINE_RES_MEM(SYS_ID, 0x4),
> },
> .platform_data = &vexpress_sysreg_sys_id_pdata,
> .pdata_size = sizeof(vexpress_sysreg_sys_id_pdata),
> },
>
> For this case mfd_add_devices will free vexpress_sysreg_sys_id_pdata, but
> it's static.
>
> Thanks
> Lucas

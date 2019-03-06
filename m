Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABBDC10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383A120661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCrIszJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfCFMCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 07:02:12 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39624 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbfCFMCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 07:02:12 -0500
Received: by mail-io1-f66.google.com with SMTP id x3so9966160ior.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 04:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fzj6yPpBGyW4gOpuAAbL2fwAcOWh2YoVhdgHI+EcGA4=;
        b=kCrIszJcTtk+3LdPm4ffSCk2J1dNdecrc0gcscf2vC/UrhS52XUqTEXNgU6I8C1oyB
         KZHYKLoI6rAGb859yq9Wu05fPEKCfqmKwspKJMQBOMhiE5a29bxuDao3QNc9qiR9Lu0p
         ao8VNjbTM5lLHOCm9nr5aD1ilZWwo7DQk7r5yZF39zSZIh8coFj7lfCP/ZYvngsBwKYi
         vs5F6NZlyLDnWQ9c+2z++WjNKYu63TEADoDIyDMLtT33SG2pfvHzsQfmq0lozqvUKQYJ
         cw2BdR5sp0lwvHpKcHh8cXrulxEDQU7F/Dnz+xXlQ6S2lDzrecB1Ieddme+0LRscNlPW
         M0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fzj6yPpBGyW4gOpuAAbL2fwAcOWh2YoVhdgHI+EcGA4=;
        b=PHZg2izBVJ+Ywkodg7z9+D0yw/z8++G4prynDF4Tz9sRv/PxJt9QeVCsofms+z/5JX
         K9oIm1PuQvs8WMg9u8PbPRVd7MUhZoigUhT08MEFvN3KM/NysZnAhuLqOhBQ7LtuRX36
         ol0PJs+L1Ifqrn1xVNUekxeT11j6iJyrCT3T2Hxn5CxDNNA1pYhsdscgO2w5gxxfYsKh
         Ef99MEGSIi6Aqg9XoTIe+i6xuD+Y4mB8jrt8rSDxL4uDdGoQXvB566IodbHJgyNu6QK7
         n5dlivBSSXleEI0X6nMt4e/GZv7PuuV8RUpbaONDVVhe3JduAWQx1t8YPbaPYTbxLV9F
         VLgw==
X-Gm-Message-State: APjAAAUHQIYo5E9MQFLo4vpgvCyvHGSIjV0Qvkjrb9eyHaD6yAO+IWa4
        rqkEV6q4WUW8Hxy5WqLPFaa/zhgRVyemObxlxFPuMOU=
X-Google-Smtp-Source: APXvYqwMULG/0LsNZs5dQ/vRRzS3aOp+5TFQKotnuB5Bf7TcMqNvyNQ2PwHkyaKIocekl24dvxlrjToFUb2taQpl1Go=
X-Received: by 2002:a6b:691c:: with SMTP id e28mr2748773ioc.295.1551873731203;
 Wed, 06 Mar 2019 04:02:11 -0800 (PST)
MIME-Version: 1.0
References: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn> <1551785646-46173-6-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1551785646-46173-6-git-send-email-wen.yang99@zte.com.cn>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Wed, 6 Mar 2019 14:02:01 +0200
Message-ID: <CAKKbWA45Fwd_7Eq7r3T9FAFE9WEfnN=pKjypYifz7NtBOJtTow@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] arm: npcm: fix a leaked reference by adding
 missing of_node_put
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wang.yi59@zte.com.cn, Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 1:33 PM Wen Yang <wen.yang99@zte.com.cn> wrote:
>
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
>
> Detected by coccinelle with the following warnings:
> ./arch/arm/mach-npcm/platsmp.c:52:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 31, but without a corresponding object release within this function.
> ./arch/arm/mach-npcm/platsmp.c:68:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 60, but without a corresponding object release within this function.
>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Avi Fishman <avifishman70@gmail.com>
> Cc: Tomer Maimon <tmaimon77@gmail.com>
> Cc: Patrick Venture <venture@google.com>
> Cc: Nancy Yuen <yuenn@google.com>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: openbmc@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> ---
> v2->v1: add a missing space between "adding" and "missing"
>
>  arch/arm/mach-npcm/platsmp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-npcm/platsmp.c b/arch/arm/mach-npcm/platsmp.c
> index 21633c7..fe63edc 100644
> --- a/arch/arm/mach-npcm/platsmp.c
> +++ b/arch/arm/mach-npcm/platsmp.c
> @@ -35,6 +35,7 @@ static int npcm7xx_smp_boot_secondary(unsigned int cpu,
>                 goto out;
>         }
>         gcr_base = of_iomap(gcr_np, 0);
> +       of_node_put(gcr_np);
>         if (!gcr_base) {
>                 pr_err("could not iomap gcr");
>                 ret = -ENOMEM;
> @@ -63,6 +64,7 @@ static void __init npcm7xx_smp_prepare_cpus(unsigned int max_cpus)
>                 return;
>         }
>         scu_base = of_iomap(scu_np, 0);
> +       of_node_put(scu_np);
>         if (!scu_base) {
>                 pr_err("could not iomap scu");
>                 return;
> --
> 2.9.5
>

Reviewed-by: Avi Fishman <avifishman70@gmail.com>
-- 
Regards,
Avi

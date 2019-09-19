Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8093AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E35A2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="u6+ZcWhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392415AbfISUDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 16:03:52 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36225 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390489AbfISUDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 16:03:51 -0400
Received: by mail-ot1-f65.google.com with SMTP id 67so4237628oto.3;
        Thu, 19 Sep 2019 13:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6fHpBKw6eUOwimptL+ITvgs75Vin3Zdq3uabBD6+JFk=;
        b=u6+ZcWhSl1aG3A35Qb0Fd19psh9JCrKFkP3pP+Kb5YWJrplnAx6n1LDAaQqhi5ZqeG
         jyg37wc0W5HHbAEgGWnj+/U231oZzC19ON9Rfo91cqTK1YiBcxFzRvsCGEFZVajL39BU
         IxICNwcDbn7lpr+dCbIjgaoc2l/rrdjuqH/1PUK9/IOAvehhnEUgJr2gT7AKWGJy3dA5
         reAGIbafrW81R9KGq+LLSQSM1d1f/MB5gldml/A6+cQDuet+ACqBeBdW1Y/SvRHoYzjg
         597/gCDnetAWPqfKHAI31kFYvBIe7V6Ypq6IqICtfmdAhkPA70pyiiGAGdCgFb7F4kwQ
         29kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6fHpBKw6eUOwimptL+ITvgs75Vin3Zdq3uabBD6+JFk=;
        b=kA2k3gFfWHGRUQM2reJ7g0yV9insWO1n9FTEw3m0muh99cvlTI78JasDT2GqisDxI2
         eXTKMDPH5d/fT7utNK1s8nvXqEyivj5AsNI1PGejnQQ7x6vuJP9s96iIcxO4C6AJHmT0
         9M2oB0/8jDjPjUg5vHOqixewIIn2GyHRI9pqXiTfT484vckQjR6N2JNe232lDy343QY1
         b/S95OgUkr45nUf/niVWlp9oMm01e77D0UbuVSn51A+J8uJw2VPpHBESXEyGrw6h2bjg
         JsSCL2GvfDmNTcyQXkYlTtTp2/UpVgk1+8tflfyVslga0EZ5UwyLXm0RIw4G/1K8GhuO
         X8Ow==
X-Gm-Message-State: APjAAAXsjbmU9HD1WyVS5Z7IkcKwiEQEyu7b9QDU60yLx0Y9zU6Bras7
        fIY/ke4Qb4PlPhm68o3NaupOFjh2KeeTqXE89vXEctNn
X-Google-Smtp-Source: APXvYqzbB6OA805TN6az8052Brpw/uRvuz3y/MdV7wEM646Gr4PT2OrZKwoWHj/BiQcf4dPqGRq77DOrFesFh5Oj13c=
X-Received: by 2002:a9d:6084:: with SMTP id m4mr7893739otj.6.1568923429439;
 Thu, 19 Sep 2019 13:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <1568895064-4116-1-git-send-email-jianxin.pan@amlogic.com> <1568895064-4116-3-git-send-email-jianxin.pan@amlogic.com>
In-Reply-To: <1568895064-4116-3-git-send-email-jianxin.pan@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 19 Sep 2019 22:03:38 +0200
Message-ID: <CAFBinCDv2m_0tP+rdT1tgXhMs-hPE_cJ9TmO8h9ftDvJXvby+g@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc: amlogic: Add support for Secure power domains controller
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Zhiqiang Liang <zhiqiang.liang@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianxin,

I added three comments below from a quick glance at this driver (I
didn't have time for a complete review)

On Thu, Sep 19, 2019 at 2:11 PM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
[...]
> +               pm_genpd_init(&dom->base, NULL,
> +                             (match->domains[i].get_power ?
> +                             match->domains[i].get_power(dom) : true));
.get_power is never NULL in this driver so the ": true" part is
effectively a no-op

[...]
> +static const struct of_device_id meson_secure_pwrc_match_table[] = {
> +       {
> +               .compatible = "amlogic,meson-a1-pwrc",
> +               .data = &meson_secure_a1_pwrc_data,
> +       },
> +       { }
many drivers use a /* sentinel */ comment inside { }

[...]
> +arch_initcall_sync(meson_secure_pwrc_init);
why arch_initcall_sync instead of builtin_platform_driver?
$ grep -R arch_initcall_sync drivers/soc/
$


Martin

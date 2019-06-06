Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B276CC28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8313620693
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559840991;
	bh=VJ78nIAOqbxKhvQ9fWU/8oqK8Ly4Neair/9DFPw853o=;
	h=In-Reply-To:References:To:Subject:From:Cc:Date:List-ID:From;
	b=myOiBhSjQdAVZwrMW0lsnmu8irvgM8tTyqrPIyN+uHNkz8/RgOn2G4Fop9CpyKzuN
	 hy6qTRhwR4nfxbUL+F0KyrbTuup3IkC244xpW6DQDO560p/0iL70keYo8jdLdQcoEv
	 UXMtXgurOJjeVxxs9I2cq/NIVMVY9EuaM5f2E9Jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbfFFRJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfFFRJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:09:50 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A46720652;
        Thu,  6 Jun 2019 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559840989;
        bh=VJ78nIAOqbxKhvQ9fWU/8oqK8Ly4Neair/9DFPw853o=;
        h=In-Reply-To:References:To:Subject:From:Cc:Date:From;
        b=vey45CAW9C6njeSvn2wtNwQSizkVfCIzbt/u6buG7aTNO2jr3w2AF7f3KI8o1O/Vv
         1MJmqEcfiW5KMdtPoUnvOL/IIuwZadTb4gQJek/tIaPZCdTnoHSWjLtjzdqGAnd5gV
         BjpBe2l91Mg6icC09KsC9BIyncbX9KXf9u3snZd0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190606142255.29454-5-nsaenzjulienne@suse.de>
References: <20190606142255.29454-1-nsaenzjulienne@suse.de> <20190606142255.29454-5-nsaenzjulienne@suse.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Viresh Kumar <viresh.kumar@linaro.org>, stefan.wahren@i2se.com
Subject: Re: [PATCH v2 4/7] cpufreq: add driver for Raspbery Pi
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mbrugger@suse.de, eric@anholt.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 10:09:48 -0700
Message-Id: <20190606170949.4A46720652@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicolas Saenz Julienne (2019-06-06 07:22:56)
> diff --git a/drivers/cpufreq/raspberrypi-cpufreq.c b/drivers/cpufreq/rasp=
berrypi-cpufreq.c
> new file mode 100644
> index 000000000000..99b59d5a50aa
> --- /dev/null
> +++ b/drivers/cpufreq/raspberrypi-cpufreq.c
[...]
> +
> +/*
> + * Since the driver depends on clk-raspberrypi, which may return EPROBE_=
DEFER,
> + * all the activity is performed in the probe, which may be defered as w=
ell.
> + */
> +static struct platform_driver raspberrypi_cpufreq_driver =3D {
> +       .driver =3D {
> +               .name =3D "raspberrypi-cpufreq",
> +       },
> +       .probe          =3D raspberrypi_cpufreq_probe,
> +       .remove         =3D raspberrypi_cpufreq_remove,
> +};
> +module_platform_driver(raspberrypi_cpufreq_driver);

How does this driver probe? Do you have a node in DT named
raspberrypi-cpufreq that matches and probes this? I would think this
would follow the drivers/cpufreq/cpufreq-dt-platdev.c design where it's
an initcall that probes the board compatible string.

Or, if it depends on clk-raspberrypi probing, maybe it could create the
platform device in that drivers probe function.

> +
> +MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de");
> +MODULE_DESCRIPTION("Raspberry Pi cpufreq driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:raspberrypi-cpufreq");

I don't think the module alias is needed anymore.


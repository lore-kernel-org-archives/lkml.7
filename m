Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8665AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5761A206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555313476;
	bh=JUQAB0Wo1WE/583zIpphIJODcSIKdzXmVISS33Hzwq8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gsV8BsEaZ19+ZfThljq73b7AqEXhh+L1gtaPR2vpNw+O0+mJdC8lGQJ5/7n5FOHIB
	 T++exRQS94ahC4aY8ZFjUXK9n4DQfLUd19wmWfa2JxN0t2qE87D12lxk4M0JH9Bb5G
	 /wE2K5/M6nZXhPVUafTD9bXtaQH9aCM53wgvKFQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfDOHbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbfDOHbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:31:11 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE472218EA;
        Mon, 15 Apr 2019 07:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555313471;
        bh=JUQAB0Wo1WE/583zIpphIJODcSIKdzXmVISS33Hzwq8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r5Gd7km7PiIFZvhyK+g2fbWN4QNzAMavYygNi41q2bF8NnG34PAJvqKltGjQW2hys
         nWshlaBxgace5X3dTwmE5Jf1eu3rXOcgJCz+7gFn22hn0qYcqofTfV5AwRqdyumE1l
         lVe7NvwV7ih8WSyP74GkALyep8Fg949gSTrdolfs=
Received: by mail-lj1-f169.google.com with SMTP id p14so14608314ljg.5;
        Mon, 15 Apr 2019 00:31:10 -0700 (PDT)
X-Gm-Message-State: APjAAAXkK8bdXjfZzKsxhzaEvyM0JBe0Z2tgi0fW/NGlKfo47Hp4FQqS
        yTAW2/z9eKuBtNJEHB8gGoqx1lfcEj3Jby2QxPI=
X-Google-Smtp-Source: APXvYqygSSnNnDcvGPSYtuR57Nph+AMxv0ORlfoBIvjb7XcvAcEXQW5TmMhAJV2v2I7viHrNM59HTyh+kevpTTHywCg=
X-Received: by 2002:a2e:500d:: with SMTP id e13mr40925411ljb.169.1555313468959;
 Mon, 15 Apr 2019 00:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
 <20190415012635.6369-1-matheus@castello.eng.br> <20190415012635.6369-5-matheus@castello.eng.br>
In-Reply-To: <20190415012635.6369-5-matheus@castello.eng.br>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 15 Apr 2019 09:30:58 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf=nPrmw6Vzi_=LmO=dVsV4Gvoc-q75XP2FBEgm9Gxv0A@mail.gmail.com>
Message-ID: <CAJKOXPf=nPrmw6Vzi_=LmO=dVsV4Gvoc-q75XP2FBEgm9Gxv0A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] power: supply: max17040: Send uevent in SOC changes
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 at 03:48, Matheus Castello <matheus@castello.eng.br> wrote:
>
> Notify core through power_supply_changed() in case of changes in state
> of charge. This is useful for user-space to efficiently update current
> battery level.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
> index f036f272d52f..db901ebf495d 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -208,10 +208,17 @@ static void max17040_check_changes(struct i2c_client *client)
>  static void max17040_work(struct work_struct *work)
>  {
>         struct max17040_chip *chip;
> +       int last_soc;
>
>         chip = container_of(work, struct max17040_chip, work.work);
> +       /* store SOC for check change */
> +       last_soc = chip->soc;
>         max17040_check_changes(chip->client);
>
> +       /* check changes and send uevent */
> +       if (last_soc != chip->soc)

chip->soc could be negative ERRNO so in such case I think user-space
should not be notified.

> +               power_supply_changed(chip->battery);
> +

You should also notify on online and status change (e.g. started
charging). User-space also wants to know that, e.g. to show the
charging icon or battery health status.

Best regards,
Krzysztof

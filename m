Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0D1C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40069218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555091036;
	bh=jvAFMMDpae1p/IQ/PzkYrbtU7HE9oltIPZ6DneyxPHw=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=TbMu1J7yfSDb1JKYwBVsefLSwBS2LNpKvEIBwfqV0ekmQcxbB0ul6w9mc98CePP6J
	 80/mF5zfDMY5tW0S9YWpz0NvMnKD0ZwSwZ2b+OObBV7i4BuZCkBGO1k8YX+H6Ty1vi
	 cvbujRva0mnEt+ZKVFTK/uKf/GqFc6RU4tRtXF80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfDLRnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbfDLRny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:43:54 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D099E2086D;
        Fri, 12 Apr 2019 17:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555091033;
        bh=jvAFMMDpae1p/IQ/PzkYrbtU7HE9oltIPZ6DneyxPHw=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=16ptWDuYN9R8/aKBaKbyxdFd67oDXmhjtt+sjQL0H7kDrS+Pfl3l9/oo2+ij5feJN
         i8adI3x03Oe98+usRp/5o/oFOyDvlAJeThXFS+fSphTleoYocbU8bdEvIhjn0pFd/0
         Ba7cOhkgHKnn4tC0rVJLnyo6WdgdK8JdWN8pR6oQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190412150625.28384-2-luca@z3ntu.xyz>
References: <20190412150625.28384-1-luca@z3ntu.xyz> <20190412150625.28384-2-luca@z3ntu.xyz>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 2/3] Input: add a driver for GPIO controllable vibrators
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Coly Li <colyli@suse.de>, Lee Jones <lee.jones@linaro.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:INPUT KEYBOARD, MOUSE, JOYSTICK , TOUCHSCREEN..." 
        <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Luca Weiss <luca@z3ntu.xyz>
To:     Luca Weiss <luca@z3ntu.xyz>
Message-ID: <155509103299.20095.15957232326393337000@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 12 Apr 2019 10:43:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Luca Weiss (2019-04-12 08:06:24)
> diff --git a/drivers/input/misc/gpio-vibra.c b/drivers/input/misc/gpio-vi=
bra.c
> new file mode 100644
> index 000000000000..3fd2dfd4f670
> --- /dev/null
> +++ b/drivers/input/misc/gpio-vibra.c
> @@ -0,0 +1,209 @@
> +
> +static int gpio_vibrator_probe(struct platform_device *pdev)
> +{
[...]
> +       vibrator->input->id.bustype =3D BUS_HOST;
> +       vibrator->input->close =3D gpio_vibrator_close;
> +
> +       input_set_drvdata(vibrator->input, vibrator);
> +       input_set_capability(vibrator->input, EV_FF, FF_RUMBLE);
> +
> +       err =3D input_ff_create_memless(vibrator->input, NULL,
> +                                     gpio_vibrator_play_effect);
> +       if (err) {
> +               dev_err(&pdev->dev, "Couldn't create FF dev: %d", err);
> +               return err;
> +       }
> +
> +       err =3D input_register_device(vibrator->input);
> +       if (err) {
> +               dev_err(&pdev->dev, "Couldn't register input dev: %d", er=
r);

All the printks in this file need a newline.

> +               return err;
> +       }
> +
> +       platform_set_drvdata(pdev, vibrator);
> +
> +       return 0;
> +}
> +
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id gpio_vibra_dt_match_table[] =3D {
> +       { .compatible =3D "gpio-vibrator" },
> +       {},

Nitpick: Drop the comma on the sentinel so nothing can go after it
without causing a compilation error.

> +};
> +MODULE_DEVICE_TABLE(of, gpio_vibra_dt_match_table);
> +#endif
> +

Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712E2C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB4320818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I415BZmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfEPNOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:14:55 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43474 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfEPNOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:14:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id u27so2585766lfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 06:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wh5JaYv97X/uxknn0B2RmMHAkSC5NRyR1TNumSEOFis=;
        b=I415BZmhf8ErYu3yvbYjy/r5AJlIKN4Zsw34Q91GVCUq+LibJECyU4xCsyIFCWH7Pb
         9rKrArLag217pZqhkK2gJLZcJ7mj29nV3BHLann1ycLke6SDAVlxkbR0MhRmyozqQoxO
         SasoVZLxpMlKIfabbsEiuVqgg3HK+CoD8d+OH8FtnVFE/OcYEKQqhMKyg1HDiyLmANji
         no8RPcfdGa/udJCAL7LopqbrttHHwcPwLf3wAZF2bDv3l5qusJFcuYTH/rkz1ACvcK9k
         VYgYa+s/ob6mmXfei6WPEHCsmYS7vlnbjHd4nAGSMMMkIsuApTY4eGb0Vc0w+kJno7/0
         sk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wh5JaYv97X/uxknn0B2RmMHAkSC5NRyR1TNumSEOFis=;
        b=NKtaluDkJLb1+NSwbJnyvOYcYVUzLH+TlbRHjnpR5YYx9UC+9F4iZGOgiJVxkZ3c8g
         mtZ1gaa0e1y/c8N/FdCuuVv+NKrx9/WJw/LRfE4tjpzKDlF65gQMCn9OG3KugXHWIhiM
         4VfxSjijvORsEkVlQVjmFgS10Sa03sNjT42ljbL3uVYcn7DYe9vmMh78gCxaPFIBdBEX
         ZJK+gIe6ZBwFP9BGHlCWSzYDYMVPk0as0JxPtdgvcdi6UW/TsqDF+4MYTbjeViX3JQJz
         /3pwDPHEntIQiogXX6UzueuHiTtsXGDM2bjF+7HRLqCGOaL1FGL4crxm20GNWo9zfQen
         emwA==
X-Gm-Message-State: APjAAAXfA/gpPAyyntTIuNvO2ZgdqEew/6y+Qmv1Qhse/6j+l4/A1SG+
        TFeydJ40VM15t/ZY9aTBFxnNOUqtp0ArMw5c95U=
X-Google-Smtp-Source: APXvYqxibpkmvr9pzW4mz+JKT7FFzpG9qkto6qjNjzt2jCqDdp/keibIZZlQFh/E5zE0FY7vNCJeXLrsf8rQZ1eqpAA=
X-Received: by 2002:a05:6512:6c:: with SMTP id i12mr5428680lfo.130.1558012493028;
 Thu, 16 May 2019 06:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <1558011640-7864-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1558011640-7864-1-git-send-email-viorel.suman@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 16 May 2019 10:14:42 -0300
Message-ID: <CAOMZO5C1jm=7tiui221B-N+ptEknK_ZdHvrjvSHfvQ=W-K54Qw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: AK4458: add regulator for ak4458
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Colin Ian King <colin.king@canonical.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Viorel Suman <viorel.suman@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 10:02 AM Viorel Suman <viorel.suman@nxp.com> wrote:

> +       for (i = 0; i < ARRAY_SIZE(ak4458->supplies); i++)
> +               ak4458->supplies[i].supply = ak4458_supply_names[i];
> +
> +       ret = devm_regulator_bulk_get(ak4458->dev, ARRAY_SIZE(ak4458->supplies),
> +                                     ak4458->supplies);
> +       if (ret != 0) {
> +               dev_err(ak4458->dev, "Failed to request supplies: %d\n", ret);
> +               return ret;

This would break existing users that do not pass the regulators in device tree.

Ok, in this case there is no ak4458 user in any dts, so that would not
be an issue.

Please update the dt-bindings with the regulator entries.

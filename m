Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD66C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 02:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804AD2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 02:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="ZfSBy0mA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfHSCUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 22:20:23 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43034 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHSCUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 22:20:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id b11so330375qtp.10;
        Sun, 18 Aug 2019 19:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b7rnR1qd4xgOUxyyaF6IjQnLml5tXyZWdkBe61/XKs8=;
        b=ZfSBy0mAR7LEIy8hyM1zGqml5g+qdngvkT5lgRQzobe8DZoZiyvOsHbDb4niMhGwPk
         DmVDkeIFtlyTEv8OZw8KneGVipNN4tY1Fkb6KDwQqloV43aVD3rLLppOikxeAWHkeGnh
         3Fk+Bj8lsj8Oq4jL9OGuEGGy8Sg1gF8Ch/qdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b7rnR1qd4xgOUxyyaF6IjQnLml5tXyZWdkBe61/XKs8=;
        b=Mf7zme+XL7L1gTK5TmZayWp3GLCZtFugxDhujDV1tFjgVyy3HKFan47Fvlcq0+Wcmt
         nIuYBPSy8CxK9SuFepJWnyhGan4MWrMad+Z3dM+ujAcXSEqM1u3pgC/8AkG3LNgFZnUV
         +pK5/tbB1gC/VCuuBMkbcAAp5P7cEG0/2ZIVzJIp5t/jqEYDLBK6tR7DDpzA/s77p+2L
         YTBGbHXB8+ia1DAN3onLqPDhH6rep7arICuZeKN5IkisPG/0mOE6bVtjZ7N9zs0u5vTE
         gcmDtpTf1qn2S9CjYyNsScjmZt8hQsYL0L2/xduhUGgVnJ3YuFIHz1GXf2H4Sb9oioDV
         eFpA==
X-Gm-Message-State: APjAAAUePrc7jtHLZcIcxAbZ/W+3ud8Z/BdCaSRbvNlzuOmxeO776TFV
        a8l71thCiXSpN85BNiPi0/35oQoT6KUZ6/gopNsSpmpE
X-Google-Smtp-Source: APXvYqzlVVWIt46DHe3BSDVNFq99MZ4mEWM467ZlIV1gDI6a+EYmDAWabohjbwWZMa5JgJ25PPU/sJa8NkSQbWUN5so=
X-Received: by 2002:ac8:46cc:: with SMTP id h12mr19146680qto.234.1566181222265;
 Sun, 18 Aug 2019 19:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190816101944.3586-1-wangzqbj@inspur.com>
In-Reply-To: <20190816101944.3586-1-wangzqbj@inspur.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 19 Aug 2019 02:20:10 +0000
Message-ID: <CACPK8XegTePdmykMzZHnW=g6hyEGr7jiW3TP8AvdzSwZGr=2gA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] hwmon: pmbus: Add Inspur Power System power supply driver
To:     John Wang <wangzqbj@inspur.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        duanzhijia01@inspur.com, Lei YU <mine260309@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019 at 10:19, John Wang <wangzqbj@inspur.com> wrote:
>
> Add the driver to monitor Inspur Power System power supplies
> with hwmon over pmbus.
>
> This driver adds sysfs attributes for additional power supply data,
> including vendor, model, part_number, serial number,
> firmware revision, hardware revision, and psu mode(active/standby).
>
> Signed-off-by: John Wang <wangzqbj@inspur.com>

> +static const struct i2c_device_id ipsps_id[] = {
> +       { "inspur_ipsps1", 0 },

Convention would be to use "ipsps" here, instead of "vendor_device"?
> +       {}
> +};
> +MODULE_DEVICE_TABLE(i2c, ipsps_id);
> +
> +static const struct of_device_id ipsps_of_match[] = {
> +       { .compatible = "inspur,ipsps1" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, ipsps_of_match);

Do we need the of match table? I thought the match on the device name
from the i2c table would be enough. I will defer to Guenter here
though.

Assuming the device tables are okay:

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel

> +
> +static struct i2c_driver ipsps_driver = {
> +       .driver = {
> +               .name = "inspur-ipsps",
> +               .of_match_table = ipsps_of_match,
> +       },
> +       .probe = ipsps_probe,
> +       .remove = pmbus_do_remove,
> +       .id_table = ipsps_id,
> +};

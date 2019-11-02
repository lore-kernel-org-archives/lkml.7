Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA48CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 15:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8449E20663
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 15:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljIIfMR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfKBPbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 11:31:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43627 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfKBPbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 11:31:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id l24so8308362pgh.10;
        Sat, 02 Nov 2019 08:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6SMiS6mgXXdUrJczi5rxbHURmOIbfDYKt9jnZjMxdUM=;
        b=ljIIfMR9UU1LQGDy+T0m4/GOZpNG+pfMu1Z466VWG+4CGbgpsK1cIn1oKgpqamJ7hA
         Sb+GqdxMDT1TiHbcIOs7LFeFwWEmg1Xvbe5EsESRa8AykJ8+QFr6mi1OrUGg9FZuQlGB
         w0EZQNBd+r3yyxWvBDXuJUlkMBoKqfioosy4w93MmigoAwG00fRYB9/MrMV51cyGX5FV
         qlK/zyfTQHmu7fPtzwTOwwEiUV50nXfBXLFYDKyJgj8CdsEyjTA9y4fY+RHjSyJz8kzE
         4lbdv3hBoDM0nkr/k4RwfKRHd5UVrbRA1ytAAp4BIvtSLSG24UMaaXQU3klhJ57OuWCP
         2ErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6SMiS6mgXXdUrJczi5rxbHURmOIbfDYKt9jnZjMxdUM=;
        b=siJ1rdE2t85WLQqpDke461v3G3N8BM6Zi5vrlOZ3sFTenb2pyTnx/xaUe9FqAqHhxB
         jSZVHIzLff7galvls69lqdGVVeDcsdzEPiDfrVcwbUJQWDs4fKuJ35fkuMUSbmv4It+c
         Tu+jerSWOY+iIEmK2KyL5XNk8IqMnZL+AbidESasBmM4RJ8VrasjJK1odDs9bTqLgqW8
         81jnXct3l6EfyWFSKbS71qlcGo6aEMQbYYnDAr8APxwRqp7dyB12p/lVQXCXyTyJbJpB
         Wp3AmAKdGtdOu1AXRhCfqOppOw5LYaTM54qT+fZa9ysDqFlj3GEPjqqMCHXiNE31TxTx
         2KRQ==
X-Gm-Message-State: APjAAAXORcIEhNlTP/R3PzGDTdmrx7dHN/3QxWxpJY/9v+V3en+wmViH
        emHG+FWed+QQDZVsBSCqdiA=
X-Google-Smtp-Source: APXvYqzzUiL8O/6XsZumWEGTrVbVXgZ9kPtXzC3z+zvYJ4g4uGthum08g9EKlHQCIKkYCILeDTZiYw==
X-Received: by 2002:a62:ce85:: with SMTP id y127mr18172312pfg.24.1572708676949;
        Sat, 02 Nov 2019 08:31:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k24sm9753324pgl.6.2019.11.02.08.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Nov 2019 08:31:16 -0700 (PDT)
Date:   Sat, 2 Nov 2019 08:31:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     rentao.bupt@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Subject: Re: [PATCH v2 2/2] docs: hwmon: Document bel-pfe pmbus driver
Message-ID: <20191102153115.GA5205@roeck-us.net>
References: <20191029182054.32279-1-rentao.bupt@gmail.com>
 <20191029182054.32279-3-rentao.bupt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029182054.32279-3-rentao.bupt@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 11:20:54AM -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Add documentation for bel-pfe pmbus driver which supports BEL PFE1100 and
> PFE3000 power supplies.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>

Applied after adding bel-pfe to index.rst.

Thanks,
Guenter

> ---
>  No change in v2.
> 
>  Documentation/hwmon/bel-pfe.rst | 112 ++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/hwmon/bel-pfe.rst
> 
> diff --git a/Documentation/hwmon/bel-pfe.rst b/Documentation/hwmon/bel-pfe.rst
> new file mode 100644
> index 000000000000..4b4a7d67854c
> --- /dev/null
> +++ b/Documentation/hwmon/bel-pfe.rst
> @@ -0,0 +1,112 @@
> +Kernel driver bel-pfe
> +======================
> +
> +Supported chips:
> +
> +  * BEL PFE1100
> +
> +    Prefixes: 'pfe1100'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: https://www.belfuse.com/resources/datasheets/powersolutions/ds-bps-pfe1100-12-054xa.pdf
> +
> +  * BEL PFE3000
> +
> +    Prefixes: 'pfe3000'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: https://www.belfuse.com/resources/datasheets/powersolutions/ds-bps-pfe3000-series.pdf
> +
> +Author: Tao Ren <rentao.bupt@gmail.com>
> +
> +
> +Description
> +-----------
> +
> +This driver supports hardware monitoring for below power supply devices
> +which support PMBus Protocol:
> +
> +  * BEL PFE1100
> +
> +    1100 Watt AC to DC power-factor-corrected (PFC) power supply.
> +    PMBus Communication Manual is not publicly available.
> +
> +  * BEL PFE3000
> +
> +    3000 Watt AC/DC power-factor-corrected (PFC) and DC-DC power supply.
> +    PMBus Communication Manual is not publicly available.
> +
> +The driver is a client driver to the core PMBus driver. Please see
> +Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
> +
> +
> +Usage Notes
> +-----------
> +
> +This driver does not auto-detect devices. You will have to instantiate the
> +devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
> +details.
> +
> +Example: the following will load the driver for an PFE3000 at address 0x20
> +on I2C bus #1::
> +
> +	$ modprobe bel-pfe
> +	$ echo pfe3000 0x20 > /sys/bus/i2c/devices/i2c-1/new_device
> +
> +
> +Platform data support
> +---------------------
> +
> +The driver supports standard PMBus driver platform data.
> +
> +
> +Sysfs entries
> +-------------
> +
> +======================= =======================================================
> +curr1_label		"iin"
> +curr1_input		Measured input current
> +curr1_max               Input current max value
> +curr1_max_alarm         Input current max alarm
> +
> +curr[2-3]_label		"iout[1-2]"
> +curr[2-3]_input		Measured output current
> +curr[2-3]_max           Output current max value
> +curr[2-3]_max_alarm     Output current max alarm
> +
> +fan[1-2]_input          Fan 1 and 2 speed in RPM
> +fan1_target             Set fan speed reference for both fans
> +
> +in1_label		"vin"
> +in1_input		Measured input voltage
> +in1_crit		Input voltage critical max value
> +in1_crit_alarm		Input voltage critical max alarm
> +in1_lcrit               Input voltage critical min value
> +in1_lcrit_alarm         Input voltage critical min alarm
> +in1_max                 Input voltage max value
> +in1_max_alarm           Input voltage max alarm
> +
> +in2_label               "vcap"
> +in2_input               Hold up capacitor voltage
> +
> +in[3-8]_label		"vout[1-3,5-7]"
> +in[3-8]_input		Measured output voltage
> +in[3-4]_alarm           vout[1-2] output voltage alarm
> +
> +power[1-2]_label	"pin[1-2]"
> +power[1-2]_input        Measured input power
> +power[1-2]_alarm	Input power high alarm
> +
> +power[3-4]_label	"pout[1-2]"
> +power[3-4]_input	Measured output power
> +
> +temp[1-3]_input		Measured temperature
> +temp[1-3]_alarm         Temperature alarm
> +======================= =======================================================
> +
> +.. note::
> +
> +    - curr3, fan2, vout[2-7], vcap, pin2, pout2 and temp3 attributes only
> +      exist for PFE3000.

Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D4AC28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7A320866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBnc+Vxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfFEUsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:48:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33857 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfFEUsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:48:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so51725pfc.1;
        Wed, 05 Jun 2019 13:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Du+0bbuODHKY++qb0cbQwd0FfOUyQQ1ecgU3jGLOTGg=;
        b=GBnc+VxaycEV8LoEJ1r8HyAudDX+mOEZkIjNkbqWn4+jiKHCaFAGK3s7nvzmPhASZL
         4wr4Gp4QaaYqAaTkhLRKbJkPXarMdPfzDWAQK4nqp/ZXMDKtqsayRM5VnlBYiGWaTiHO
         41Jp8E5EHr06q2z0R3qKRlchNlvxrrL/K0rVJXzhXqvEAGq+KzGARNzjOEOKKUW0OMf0
         gogNNJO4hJOpSPyt44rK2vlSI2SiBlybfnC+L7BMJvm1cPCyPCZ9hMdEYjym68Oh3qjF
         uq21T8xpRoyN6QTZ00I+jde4KZVuQlg1XYzVq0cPqmXhcyKXIFUx9vu21oV7i0hAqaJO
         InZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Du+0bbuODHKY++qb0cbQwd0FfOUyQQ1ecgU3jGLOTGg=;
        b=Iqkx2/dVM1k1onTqrLfh0+fWndTgJg5XcUCjTxkrYu9cVuLkyHUr6YG97KS0FToig8
         xb7q7mfZFEPmfbIvOiVvMNxgjJFMVCnrkX5hs+1ksP0I2667COKpZNQJ4UxQ6ib0qDsi
         1+nmnLAGAaJXI5XQKJI3yf5qW4e60CBDoonUkhxdjMolQMxHX9/MdMkPyAduac8fN3cD
         yOd/efq9cvSbNpum79Dbp+Oz2JdOnRW91j9w/VnSOLXTQw4oAPIDLKYCp3xCFEosj3Zd
         ENgo+MWUv4ZeTnCC/bdR5/A+fuF0IRJ5odqS5+2HH1Osx7ci3mp2BnW746O7LiffyrTm
         ZnqQ==
X-Gm-Message-State: APjAAAWsAbh4+EOhNfOcLRk2E3agtE1MVisfMxdTnwCKv3FamMopZCE/
        qN+5Z6l9NE+YSkjc1ugb1NM=
X-Google-Smtp-Source: APXvYqyQEyylARTcVGEVHqrWdPFSo3XEN3WJWVsYQ1m9KaMLN5RvfVM3nXPiK8CqcHgf+SRezDe/mQ==
X-Received: by 2002:a63:d008:: with SMTP id z8mr853667pgf.335.1559767694208;
        Wed, 05 Jun 2019 13:48:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v9sm20297166pfm.34.2019.06.05.13.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 13:48:13 -0700 (PDT)
Date:   Wed, 5 Jun 2019 13:48:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@jms.id.au,
        linux-aspeed@lists.ozlabs.org, sdasari@fb.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] Docs: hwmon: pmbus: Add PXE1610 driver
Message-ID: <20190605204811.GA32379@roeck-us.net>
References: <20190530231159.222188-1-vijaykhemka@fb.com>
 <20190530231159.222188-2-vijaykhemka@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530231159.222188-2-vijaykhemka@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 04:11:57PM -0700, Vijay Khemka wrote:
> Added support for Infenion PXE1610 driver
> 
Applied, after fixing
	s/Infenion/Infineon/
	s/Infinion/Infineon/

Guenter

> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
> Changes in v2:
> incorporated all the feedback from Guenter Roeck <linux@roeck-us.net>
> 
>  Documentation/hwmon/pxe1610 | 90 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/hwmon/pxe1610
> 
> diff --git a/Documentation/hwmon/pxe1610 b/Documentation/hwmon/pxe1610
> new file mode 100644
> index 000000000000..24825db8736f
> --- /dev/null
> +++ b/Documentation/hwmon/pxe1610
> @@ -0,0 +1,90 @@
> +Kernel driver pxe1610
> +=====================
> +
> +Supported chips:
> +  * Infinion PXE1610
> +    Prefix: 'pxe1610'
> +    Addresses scanned: -
> +    Datasheet: Datasheet is not publicly available.
> +
> +  * Infinion PXE1110
> +    Prefix: 'pxe1110'
> +    Addresses scanned: -
> +    Datasheet: Datasheet is not publicly available.
> +
> +  * Infinion PXM1310
> +    Prefix: 'pxm1310'
> +    Addresses scanned: -
> +    Datasheet: Datasheet is not publicly available.
> +
> +Author: Vijay Khemka <vijaykhemka@fb.com>
> +
> +
> +Description
> +-----------
> +
> +PXE1610/PXE1110 are Multi-rail/Multiphase Digital Controllers
> +and compliant to
> +	-- Intel VR13 DC-DC converter specifications.
> +	-- Intel SVID protocol.
> +Used for Vcore power regulation for Intel VR13 based microprocessors
> +	-- Servers, Workstations, and High-end desktops
> +
> +PXM1310 is a Multi-rail Controllers and it is compliant to
> +	-- Intel VR13 DC-DC converter specifications.
> +	-- Intel SVID protocol.
> +Used for DDR3/DDR4 Memory power regulation for Intel VR13 and
> +IMVP8 based systems
> +
> +
> +Usage Notes
> +-----------
> +
> +This driver does not probe for PMBus devices. You will have
> +to instantiate devices explicitly.
> +
> +Example: the following commands will load the driver for an PXE1610
> +at address 0x70 on I2C bus #4:
> +
> +# modprobe pxe1610
> +# echo pxe1610 0x70 > /sys/bus/i2c/devices/i2c-4/new_device
> +
> +It can also be instantiated by declaring in device tree
> +
> +
> +Sysfs attributes
> +----------------
> +
> +curr1_label		"iin"
> +curr1_input		Measured input current
> +curr1_alarm		Current high alarm
> +
> +curr[2-4]_label		"iout[1-3]"
> +curr[2-4]_input		Measured output current
> +curr[2-4]_crit		Critical maximum current
> +curr[2-4]_crit_alarm	Current critical high alarm
> +
> +in1_label		"vin"
> +in1_input		Measured input voltage
> +in1_crit		Critical maximum input voltage
> +in1_crit_alarm		Input voltage critical high alarm
> +
> +in[2-4]_label		"vout[1-3]"
> +in[2-4]_input		Measured output voltage
> +in[2-4]_lcrit		Critical minimum output voltage
> +in[2-4]_lcrit_alarm	Output voltage critical low alarm
> +in[2-4]_crit		Critical maximum output voltage
> +in[2-4]_crit_alarm	Output voltage critical high alarm
> +
> +power1_label		"pin"
> +power1_input		Measured input power
> +power1_alarm		Input power high alarm
> +
> +power[2-4]_label	"pout[1-3]"
> +power[2-4]_input	Measured output power
> +
> +temp[1-3]_input		Measured temperature
> +temp[1-3]_crit		Critical high temperature
> +temp[1-3]_crit_alarm	Chip temperature critical high alarm
> +temp[1-3]_max		Maximum temperature
> +temp[1-3]_max_alarm	Chip temperature high alarm

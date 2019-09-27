Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1014C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22DD2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shpIXuWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfI0V7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 17:59:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38680 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfI0V7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 17:59:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id w12so4765485wro.5;
        Fri, 27 Sep 2019 14:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nmWQQvfqWuf0mNpkURyNgi32z0SNup1KrWxjTu1cNXg=;
        b=shpIXuWOEsKbw5ZQpddLvQzjEZBqU7Oc0Dm+v1fIj2oSB5hSYmoD1FKn3pz7INBY41
         koSzQqGmWlNuHc08LIwKJ7VyY6aOewLLN0eoTm2xhWQ/WNCe2Trl/HB8LT8xc/SZFA3G
         SyiB71V3mhBNgV0mGxv5OjoNOLEYK5Y2okxStAk6Nct6d54TDkhumt5xlZJvWH7OZSDT
         vCMrl0JyaBbIJfmFocbXtifi3D5RvDkqRhPE0xqgWd05g7FJBsPi0E5c90Mz8jUXzPTn
         GWc9RdVWyUKfPsydH1tVzYu7TIVIX/lw18/zBfzX3pvhOPnEMie+/LTcx/K0ihaawZTf
         ycSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nmWQQvfqWuf0mNpkURyNgi32z0SNup1KrWxjTu1cNXg=;
        b=nT4U6FUR+U/0zN9mWRjEwOZMKYezmfgxQWHCYwdVaDk3vaxpYvII3URpc53OblGRet
         subuXY/iCPyqGgQQk6okUa0FpclOnaO3AL/ieeYbshpT/XZ3Rg53u2uhDXo8cJ4vedJ8
         HZ7QIQWilzR1qRZlrJLX+LGAHKt6rSSBzZbYPyPTy7xEuLe4y6EAh/VKoTHs9byaz2jJ
         UuGNQO+Zk4M4/muEMtPHa00Ms+sau/k5+rNRqQTmYlb8CEDwpioS2kpsjmoI60s9e1Qd
         HNIhvMZoLV1TTt3GMb69ONYrhVVB3nVSB2Yna5EfY93eJvLkgKcd4y5DIBxc4ZrC/Zn0
         KS/Q==
X-Gm-Message-State: APjAAAUiuHWn5jOwrK6tBynKwmRVsXLZgB0wpiNRxRx5r7hhy3VMarCb
        9yzt65lOcUkT+S2z+YEOLU8=
X-Google-Smtp-Source: APXvYqxhiYEa0AcqxlXM10edC7R6X0fKcS4A6xMBQbogEdHwDGqwC8YIvmD8pVUTF6n7bqoqzibSvA==
X-Received: by 2002:adf:a350:: with SMTP id d16mr4624804wrb.326.1569621539364;
        Fri, 27 Sep 2019 14:58:59 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id o22sm10924646wra.96.2019.09.27.14.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Sep 2019 14:58:58 -0700 (PDT)
Date:   Fri, 27 Sep 2019 23:58:56 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Pacien TRAN-GIRARD <pacien.trangirard@pacien.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] platform/x86: dell-laptop: disable kbd backlight on
 Inspiron 10xx
Message-ID: <20190927215856.v3zxxcg7klijanxh@pali>
References: <20190925082149.yjhmmb64i4h6sddi@pali>
 <156940489220.8635.14349142383780268583@WARFSTATION>
 <CAHp75VfkL3QGXYjeEEqr75SWCKo1SDEqS9q3YEQWYM4iXbUzcg@mail.gmail.com>
 <20190926081146.f4f26kun7ekwqsgj@pali>
 <156961914387.417.14261217089484891942@WARFSTATION>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <156961914387.417.14261217089484891942@WARFSTATION>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 September 2019 23:19:03 Pacien TRAN-GIRARD wrote:
> This patch adds a quirk disabling keyboard backlight support for the
> Dell Inspiron 1012 and 1018.
> 
> Those models wrongly report supporting keyboard backlight control
> features (through SMBIOS tokens) even though they're not equipped with
> a backlit keyboard. This led to broken controls being exposed
> through sysfs by this driver which froze the system when used.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=107651
> Signed-off-by: Pacien TRAN-GIRARD <pacien.trangirard@pacien.net>
> ---

Thank you for update! Now it is clear what is the problem
and you can add my

Reviewed-by: Pali Rohár <pali.rohar@gmail.com>

>  drivers/platform/x86/dell-laptop.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
> index d27be2836bc2..74e988f839e8 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -33,6 +33,7 @@
>  
>  struct quirk_entry {
>  	bool touchpad_led;
> +	bool kbd_led_not_present;
>  	bool kbd_led_levels_off_1;
>  	bool kbd_missing_ac_tag;
>  
> @@ -73,6 +74,10 @@ static struct quirk_entry quirk_dell_latitude_e6410 = {
>  	.kbd_led_levels_off_1 = true,
>  };
>  
> +static struct quirk_entry quirk_dell_inspiron_1012 = {
> +	.kbd_led_not_present = true,
> +};
> +
>  static struct platform_driver platform_driver = {
>  	.driver = {
>  		.name = "dell-laptop",
> @@ -310,6 +315,24 @@ static const struct dmi_system_id dell_quirks[] __initconst = {
>  		},
>  		.driver_data = &quirk_dell_latitude_e6410,
>  	},
> +	{
> +		.callback = dmi_matched,
> +		.ident = "Dell Inspiron 1012",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1012"),
> +		},
> +		.driver_data = &quirk_dell_inspiron_1012,
> +	},
> +	{
> +		.callback = dmi_matched,
> +		.ident = "Dell Inspiron 1018",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1018"),
> +		},
> +		.driver_data = &quirk_dell_inspiron_1012,
> +	},
>  	{ }
>  };
>  
> @@ -1493,6 +1516,9 @@ static void kbd_init(void)
>  {
>  	int ret;
>  
> +	if (quirks && quirks->kbd_led_not_present)
> +		return;
> +
>  	ret = kbd_init_info();
>  	kbd_init_tokens();
>  

-- 
Pali Rohár
pali.rohar@gmail.com

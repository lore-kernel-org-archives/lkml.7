Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_75_100
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9C5C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDDC20673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gmDROJ+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388734AbfJNSLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 14:11:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40327 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732457AbfJNSLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 14:11:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id v38so15611782edm.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 11:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gk2r9TOKis2O7+sYMkbDi2jOzbKULrha5w5kj+vj8CA=;
        b=gmDROJ+L97TDvlEzhKCql7m+dmFCXu8fHbug0ztHDkEfRtPTEqaAO3vlUyeqblJzH9
         3J0FQEPjlLV1txqpr9DhkNsWRWGZsfHeTfPOIeVzwSxdBMkXppCAOZJ9kn9+Lf0T05hv
         UIWa4agUZ7FmsoyIjjm3Y2ZKoPwwM+Mj92qjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gk2r9TOKis2O7+sYMkbDi2jOzbKULrha5w5kj+vj8CA=;
        b=XH8cf71OiE37NnkDgSAygdeWNCFL7nm+uv8l+hqHmwVm1Ge34YWJ0RoJFvSQJ1aYQ1
         mdbSNc4F1qhM3Addq8ui2Xn4maXEedwHUOFVjhLvmtRtbVybOv4ZzZJTkLtNlD2+mSDm
         iCZVSPNPoHhzOjd25DambfAfUux9hnFr9Yd+1ZgYdkkPgDfjBbP+zmYnINPZTj+H3xqM
         RGkCCVGrD374s7+cQ2j8VbOYTPsNM5UAzg6JeHFTncdps+mrTV35EWa0Yw+miUsaEcv9
         LBSMHQa7z8qCH09ZryORynYiLfUMtLZHGpJEZW0QJcifwDRNTaZurGA+AGQC0bevnlRB
         aHzA==
X-Gm-Message-State: APjAAAUuBIUx2aBx1m1Rs/siOllWREPxAZ1i1ApL52a/s10dhdD62+fY
        lawfZptxZZQK76/huQ4Nw+U0OhnuBYM=
X-Google-Smtp-Source: APXvYqwpTRwF/k2eeH3ZELtwLvOpAiHbSRILpDIZcOVrM6dM+xwsf6efeXmqHqwDDbnAe+wp/WS3pw==
X-Received: by 2002:a17:906:85d7:: with SMTP id i23mr30373833ejy.332.1571076665663;
        Mon, 14 Oct 2019 11:11:05 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id g17sm2450900ejb.80.2019.10.14.11.11.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 11:11:04 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id y18so11339096wrn.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 11:11:03 -0700 (PDT)
X-Received: by 2002:adf:9f08:: with SMTP id l8mr25812686wrf.325.1571076663001;
 Mon, 14 Oct 2019 11:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191011133901.11099-1-enric.balletbo@collabora.com>
In-Reply-To: <20191011133901.11099-1-enric.balletbo@collabora.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 14 Oct 2019 12:10:51 -0600
X-Gmail-Original-Message-ID: <CAHQZ30ArbtQb1MBHZ8vZ0RWEz-Rjr3RtrWUxycvkdOKZsBqtAQ@mail.gmail.com>
Message-ID: <CAHQZ30ArbtQb1MBHZ8vZ0RWEz-Rjr3RtrWUxycvkdOKZsBqtAQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_trace: Match trace commands with
 EC commands
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>, gwendal@chromium.org,
        Tzung-Bi Shih <tzungbi@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 7:39 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> There are some EC commands that are not included yet as trace commands,
> in order to get all the traces for the all supported commands match the
> commands accordingly.
>
> Note that a change, adding or removing an EC command, should be
> reflected in the cros_ec_trace.c file in order to avoid mismatches
> again.
>
> The list of current commands is generated using the following script:
>
>  sed -n 's/^#define \(EC_CMD_[[:alnum:]_]*\)\s.*/\tTRACE_SYMBOL(\1), \\/p' \
>         include/linux/platform_data/cros_ec_commands.h
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/platform/chrome/cros_ec_trace.c | 73 ++++++++++++++++++++++---
>  1 file changed, 66 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_trace.c b/drivers/platform/chrome/cros_ec_trace.c
> index 6f80ff4532ae..8e93cccfbcf5 100644
> --- a/drivers/platform/chrome/cros_ec_trace.c
> +++ b/drivers/platform/chrome/cros_ec_trace.c
> @@ -8,6 +8,11 @@
>  // Generate the list using the following script:
>  // sed -n 's/^#define \(EC_CMD_[[:alnum:]_]*\)\s.*/\tTRACE_SYMBOL(\1), \\/p' include/linux/platform_data/cros_ec_commands.h
>  #define EC_CMDS \
> +       TRACE_SYMBOL(EC_CMD_ACPI_READ), \
> +       TRACE_SYMBOL(EC_CMD_ACPI_WRITE), \
> +       TRACE_SYMBOL(EC_CMD_ACPI_BURST_ENABLE), \
> +       TRACE_SYMBOL(EC_CMD_ACPI_BURST_DISABLE), \
> +       TRACE_SYMBOL(EC_CMD_ACPI_QUERY_EVENT), \
>         TRACE_SYMBOL(EC_CMD_PROTO_VERSION), \
>         TRACE_SYMBOL(EC_CMD_HELLO), \
>         TRACE_SYMBOL(EC_CMD_GET_VERSION), \
> @@ -22,6 +27,8 @@
>         TRACE_SYMBOL(EC_CMD_GET_PROTOCOL_INFO), \
>         TRACE_SYMBOL(EC_CMD_GSV_PAUSE_IN_S5), \
>         TRACE_SYMBOL(EC_CMD_GET_FEATURES), \
> +       TRACE_SYMBOL(EC_CMD_GET_SKU_ID), \
> +       TRACE_SYMBOL(EC_CMD_SET_SKU_ID), \
>         TRACE_SYMBOL(EC_CMD_FLASH_INFO), \
>         TRACE_SYMBOL(EC_CMD_FLASH_READ), \
>         TRACE_SYMBOL(EC_CMD_FLASH_WRITE), \
> @@ -29,6 +36,8 @@
>         TRACE_SYMBOL(EC_CMD_FLASH_PROTECT), \
>         TRACE_SYMBOL(EC_CMD_FLASH_REGION_INFO), \
>         TRACE_SYMBOL(EC_CMD_VBNV_CONTEXT), \
> +       TRACE_SYMBOL(EC_CMD_FLASH_SPI_INFO), \
> +       TRACE_SYMBOL(EC_CMD_FLASH_SELECT), \
>         TRACE_SYMBOL(EC_CMD_PWM_GET_FAN_TARGET_RPM), \
>         TRACE_SYMBOL(EC_CMD_PWM_SET_FAN_TARGET_RPM), \
>         TRACE_SYMBOL(EC_CMD_PWM_GET_KEYBOARD_BACKLIGHT), \
> @@ -40,6 +49,8 @@
>         TRACE_SYMBOL(EC_CMD_LED_CONTROL), \
>         TRACE_SYMBOL(EC_CMD_VBOOT_HASH), \
>         TRACE_SYMBOL(EC_CMD_MOTION_SENSE_CMD), \
> +       TRACE_SYMBOL(EC_CMD_FORCE_LID_OPEN), \
> +       TRACE_SYMBOL(EC_CMD_CONFIG_POWER_BUTTON), \
>         TRACE_SYMBOL(EC_CMD_USB_CHARGE_SET_MODE), \
>         TRACE_SYMBOL(EC_CMD_PSTORE_INFO), \
>         TRACE_SYMBOL(EC_CMD_PSTORE_READ), \
> @@ -50,6 +61,9 @@
>         TRACE_SYMBOL(EC_CMD_RTC_SET_ALARM), \
>         TRACE_SYMBOL(EC_CMD_PORT80_LAST_BOOT), \
>         TRACE_SYMBOL(EC_CMD_PORT80_READ), \
> +       TRACE_SYMBOL(EC_CMD_VSTORE_INFO), \
> +       TRACE_SYMBOL(EC_CMD_VSTORE_READ), \
> +       TRACE_SYMBOL(EC_CMD_VSTORE_WRITE), \
>         TRACE_SYMBOL(EC_CMD_THERMAL_SET_THRESHOLD), \
>         TRACE_SYMBOL(EC_CMD_THERMAL_GET_THRESHOLD), \
>         TRACE_SYMBOL(EC_CMD_THERMAL_AUTO_FAN_CTRL), \
> @@ -59,10 +73,12 @@
>         TRACE_SYMBOL(EC_CMD_MKBP_STATE), \
>         TRACE_SYMBOL(EC_CMD_MKBP_INFO), \
>         TRACE_SYMBOL(EC_CMD_MKBP_SIMULATE_KEY), \
> +       TRACE_SYMBOL(EC_CMD_GET_KEYBOARD_ID), \
>         TRACE_SYMBOL(EC_CMD_MKBP_SET_CONFIG), \
>         TRACE_SYMBOL(EC_CMD_MKBP_GET_CONFIG), \
>         TRACE_SYMBOL(EC_CMD_KEYSCAN_SEQ_CTRL), \
>         TRACE_SYMBOL(EC_CMD_GET_NEXT_EVENT), \
> +       TRACE_SYMBOL(EC_CMD_KEYBOARD_FACTORY_TEST), \
>         TRACE_SYMBOL(EC_CMD_TEMP_SENSOR_GET_INFO), \
>         TRACE_SYMBOL(EC_CMD_HOST_EVENT_GET_B), \
>         TRACE_SYMBOL(EC_CMD_HOST_EVENT_GET_SMI_MASK), \
> @@ -73,6 +89,7 @@
>         TRACE_SYMBOL(EC_CMD_HOST_EVENT_CLEAR), \
>         TRACE_SYMBOL(EC_CMD_HOST_EVENT_SET_WAKE_MASK), \
>         TRACE_SYMBOL(EC_CMD_HOST_EVENT_CLEAR_B), \
> +       TRACE_SYMBOL(EC_CMD_HOST_EVENT), \
>         TRACE_SYMBOL(EC_CMD_SWITCH_ENABLE_BKLIGHT), \
>         TRACE_SYMBOL(EC_CMD_SWITCH_ENABLE_WIRELESS), \
>         TRACE_SYMBOL(EC_CMD_GPIO_SET), \
> @@ -92,33 +109,75 @@
>         TRACE_SYMBOL(EC_CMD_CHARGE_STATE), \
>         TRACE_SYMBOL(EC_CMD_CHARGE_CURRENT_LIMIT), \
>         TRACE_SYMBOL(EC_CMD_EXTERNAL_POWER_LIMIT), \
> +       TRACE_SYMBOL(EC_CMD_OVERRIDE_DEDICATED_CHARGER_LIMIT), \
> +       TRACE_SYMBOL(EC_CMD_HIBERNATION_DELAY), \
>         TRACE_SYMBOL(EC_CMD_HOST_SLEEP_EVENT), \
> +       TRACE_SYMBOL(EC_CMD_DEVICE_EVENT), \
>         TRACE_SYMBOL(EC_CMD_SB_READ_WORD), \
>         TRACE_SYMBOL(EC_CMD_SB_WRITE_WORD), \
>         TRACE_SYMBOL(EC_CMD_SB_READ_BLOCK), \
>         TRACE_SYMBOL(EC_CMD_SB_WRITE_BLOCK), \
>         TRACE_SYMBOL(EC_CMD_BATTERY_VENDOR_PARAM), \
> -       TRACE_SYMBOL(EC_CMD_CODEC_I2S), \
> -       TRACE_SYMBOL(EC_CMD_REBOOT_EC), \
> -       TRACE_SYMBOL(EC_CMD_GET_PANIC_INFO), \
> -       TRACE_SYMBOL(EC_CMD_ACPI_READ), \
> -       TRACE_SYMBOL(EC_CMD_ACPI_WRITE), \
> -       TRACE_SYMBOL(EC_CMD_ACPI_QUERY_EVENT), \
> +       TRACE_SYMBOL(EC_CMD_SB_FW_UPDATE), \
> +       TRACE_SYMBOL(EC_CMD_ENTERING_MODE), \
> +       TRACE_SYMBOL(EC_CMD_I2C_PASSTHRU_PROTECT), \
>         TRACE_SYMBOL(EC_CMD_CEC_WRITE_MSG), \
>         TRACE_SYMBOL(EC_CMD_CEC_SET), \
>         TRACE_SYMBOL(EC_CMD_CEC_GET), \
> +       TRACE_SYMBOL(EC_CMD_CODEC_I2S), \
> +       TRACE_SYMBOL(EC_CMD_REBOOT_EC), \
> +       TRACE_SYMBOL(EC_CMD_GET_PANIC_INFO), \
>         TRACE_SYMBOL(EC_CMD_REBOOT), \
>         TRACE_SYMBOL(EC_CMD_RESEND_RESPONSE), \
>         TRACE_SYMBOL(EC_CMD_VERSION0), \
>         TRACE_SYMBOL(EC_CMD_PD_EXCHANGE_STATUS), \
> +       TRACE_SYMBOL(EC_CMD_PD_HOST_EVENT_STATUS), \
>         TRACE_SYMBOL(EC_CMD_USB_PD_CONTROL), \
>         TRACE_SYMBOL(EC_CMD_USB_PD_PORTS), \
>         TRACE_SYMBOL(EC_CMD_USB_PD_POWER_INFO), \
>         TRACE_SYMBOL(EC_CMD_CHARGE_PORT_COUNT), \
> +       TRACE_SYMBOL(EC_CMD_USB_PD_FW_UPDATE), \
> +       TRACE_SYMBOL(EC_CMD_USB_PD_RW_HASH_ENTRY), \
> +       TRACE_SYMBOL(EC_CMD_USB_PD_DEV_INFO), \
>         TRACE_SYMBOL(EC_CMD_USB_PD_DISCOVERY), \
>         TRACE_SYMBOL(EC_CMD_PD_CHARGE_PORT_OVERRIDE), \
>         TRACE_SYMBOL(EC_CMD_PD_GET_LOG_ENTRY), \
> -       TRACE_SYMBOL(EC_CMD_USB_PD_MUX_INFO)
> +       TRACE_SYMBOL(EC_CMD_USB_PD_GET_AMODE), \
> +       TRACE_SYMBOL(EC_CMD_USB_PD_SET_AMODE), \
> +       TRACE_SYMBOL(EC_CMD_PD_WRITE_LOG_ENTRY), \
> +       TRACE_SYMBOL(EC_CMD_PD_CONTROL), \
> +       TRACE_SYMBOL(EC_CMD_USB_PD_MUX_INFO), \
> +       TRACE_SYMBOL(EC_CMD_PD_CHIP_INFO), \
> +       TRACE_SYMBOL(EC_CMD_RWSIG_CHECK_STATUS), \
> +       TRACE_SYMBOL(EC_CMD_RWSIG_ACTION), \
> +       TRACE_SYMBOL(EC_CMD_EFS_VERIFY), \
> +       TRACE_SYMBOL(EC_CMD_GET_CROS_BOARD_INFO), \
> +       TRACE_SYMBOL(EC_CMD_SET_CROS_BOARD_INFO), \
> +       TRACE_SYMBOL(EC_CMD_GET_UPTIME_INFO), \
> +       TRACE_SYMBOL(EC_CMD_ADD_ENTROPY), \
> +       TRACE_SYMBOL(EC_CMD_ADC_READ), \
> +       TRACE_SYMBOL(EC_CMD_ROLLBACK_INFO), \
> +       TRACE_SYMBOL(EC_CMD_AP_RESET), \
> +       TRACE_SYMBOL(EC_CMD_CR51_BASE), \
> +       TRACE_SYMBOL(EC_CMD_CR51_LAST), \
> +       TRACE_SYMBOL(EC_CMD_FP_PASSTHRU), \
> +       TRACE_SYMBOL(EC_CMD_FP_MODE), \
> +       TRACE_SYMBOL(EC_CMD_FP_INFO), \
> +       TRACE_SYMBOL(EC_CMD_FP_FRAME), \
> +       TRACE_SYMBOL(EC_CMD_FP_TEMPLATE), \
> +       TRACE_SYMBOL(EC_CMD_FP_CONTEXT), \
> +       TRACE_SYMBOL(EC_CMD_FP_STATS), \
> +       TRACE_SYMBOL(EC_CMD_FP_SEED), \
> +       TRACE_SYMBOL(EC_CMD_FP_ENC_STATUS), \
> +       TRACE_SYMBOL(EC_CMD_TP_SELF_TEST), \
> +       TRACE_SYMBOL(EC_CMD_TP_FRAME_INFO), \
> +       TRACE_SYMBOL(EC_CMD_TP_FRAME_SNAPSHOT), \
> +       TRACE_SYMBOL(EC_CMD_TP_FRAME_GET), \
> +       TRACE_SYMBOL(EC_CMD_BATTERY_GET_STATIC), \
> +       TRACE_SYMBOL(EC_CMD_BATTERY_GET_DYNAMIC), \
> +       TRACE_SYMBOL(EC_CMD_CHARGER_CONTROL), \
> +       TRACE_SYMBOL(EC_CMD_BOARD_SPECIFIC_BASE), \
> +       TRACE_SYMBOL(EC_CMD_BOARD_SPECIFIC_LAST)
>
>  #define CREATE_TRACE_POINTS
>  #include "cros_ec_trace.h"
> --
> 2.20.1
>

Acked-by: Raul E Rangel <rrangel@chromium.org>

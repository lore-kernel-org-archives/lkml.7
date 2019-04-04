Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFD4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DDB20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDCdyVGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfDDSja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:39:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37640 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfDDSj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:39:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id v13so3006236ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PNrm5ZvqyIO3flw+yxvvQFZ3RopGnN4GuMnZWR2rV0s=;
        b=NDCdyVGUuwAxZjc8gSl3az2JsLdZZsIyynbtjdeXuTJ/uqAT+dRbNUPw05TPHfUiTH
         c+V2Tighxy2lY3djJfjzdMPlrOkKkhiQxkKv2p2pzx6cmH0HbKbqqLQm9znPNqf54AXd
         Btsbd6dkUjclOl0X3HjwEuSHmi8Cs9fWmvkWtuw04dNkVvoYPt2/GPROJa2NuzynCzNX
         D064hpAID8kk+WgodY/BZ9Y8Gkuobro/AB6sPI5l+FRekx0HXzgH0MPDtUaHr7jGS/Qe
         MOF/QBwqWGSJxLAm4QJYK69ut0kqwwmm3J8ow5RbO54HaWhaLdoN/ztgT0C3WQSD0uZP
         I8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNrm5ZvqyIO3flw+yxvvQFZ3RopGnN4GuMnZWR2rV0s=;
        b=KoFoVvF6as3RFG7/mZ7zuI6wM3GRBT4M/ohdbRNV3tOFNf3SzclXLy6pafl+EOz/5x
         jfjbQeFVKhZM5d52HPCJa+FVCk+QqFegAmCpMZq+bsUcD/OjAJDIxo6Vrn65QtWcHF4j
         vTHTlWu9RiE+ANmyegGTBKUCiKnTAfHUAu5qC6xZbT0FMAngM038OvmH2GrTZWjykSOi
         XeQ9B5smmDwPHZecffTsUBxZVrFIstXq+s6F8Ix3eXTX/ukiIaRzPfx+nwAg/eJJn6ke
         UEbd9ndLyX/7yIkyN5nko7zJ/OsNJxAPgfvNuu67/qiW7tFGoIWCZlorSKxAGdgV7TBT
         OemQ==
X-Gm-Message-State: APjAAAVbtTZcUZYk3LRdUDKTrjAgzOKs2VWT9u6pb/Ppt5Qp91NKi9k5
        n7pV/4ie3Nma6A7EAbUz0tkGDv8DS0eZ3bsUS/rhaQ==
X-Google-Smtp-Source: APXvYqyap3Ba5QJ5kA6tGfEjLpV51fuMvj+4aILeFuWYTS9ka0MBX0GT/ROnwMteEfyj6FkAp9wNv8D60pB6YEvcC6A=
X-Received: by 2002:a2e:6a14:: with SMTP id f20mr4543410ljc.65.1554403166808;
 Thu, 04 Apr 2019 11:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190403213428.89920-1-evgreen@chromium.org> <20190403213428.89920-2-evgreen@chromium.org>
In-Reply-To: <20190403213428.89920-2-evgreen@chromium.org>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 4 Apr 2019 11:38:50 -0700
Message-ID: <CACK8Z6FMA+9+t4bs4AxwAHi02fSO8Q-1rmxuiXdeh491X-1erg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mfd: cros_ec: Add host_sleep_event_v1 command
To:     Evan Green <evgreen@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 2:34 PM Evan Green <evgreen@chromium.org> wrote:
>
> Introduce the command and response structures for the second revision
> of the host sleep event. These structures are part of a new EC change
> that enables detection of failure to enter S0ix. The EC waits a
> kernel-specified timeout (or a default amount of time) for the S0_SLP
> pin to change, and wakes the system if that change does not occur in
> time.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Rajat Jain <rajatja@chromium.org>

>
> ---
>
> Changes in v3: None
> Changes in v2:
> - Made unions anonymous
> - Replaced reserved union members with a comment
>
>  include/linux/mfd/cros_ec_commands.h | 57 ++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index fc91082d4c35..1cdb07c0ece1 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -2729,6 +2729,63 @@ struct ec_params_host_sleep_event {
>         uint8_t sleep_event;
>  } __packed;
>
> +/*
> + * Use a default timeout value (CONFIG_SLEEP_TIMEOUT_MS) for detecting sleep
> + * transition failures
> + */
> +#define EC_HOST_SLEEP_TIMEOUT_DEFAULT 0
> +
> +/* Disable timeout detection for this sleep transition */
> +#define EC_HOST_SLEEP_TIMEOUT_INFINITE 0xFFFF
> +
> +struct ec_params_host_sleep_event_v1 {
> +       /* The type of sleep being entered or exited. */
> +       uint8_t sleep_event;
> +
> +       /* Padding */
> +       uint8_t reserved;
> +       union {
> +               /* Parameters that apply for suspend messages. */
> +               struct {
> +                       /*
> +                        * The timeout in milliseconds between when this message
> +                        * is received and when the EC will declare sleep
> +                        * transition failure if the sleep signal is not
> +                        * asserted.
> +                        */
> +                       uint16_t sleep_timeout_ms;
> +               } suspend_params;
> +
> +               /* No parameters for non-suspend messages. */
> +       };
> +} __packed;
> +
> +/* A timeout occurred when this bit is set */
> +#define EC_HOST_RESUME_SLEEP_TIMEOUT 0x80000000
> +
> +/*
> + * The mask defining which bits correspond to the number of sleep transitions,
> + * as well as the maximum number of suspend line transitions that will be
> + * reported back to the host.
> + */
> +#define EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK 0x7FFFFFFF
> +
> +struct ec_response_host_sleep_event_v1 {
> +       union {
> +               /* Response fields that apply for resume messages. */
> +               struct {
> +                       /*
> +                        * The number of sleep power signal transitions that
> +                        * occurred since the suspend message. The high bit
> +                        * indicates a timeout occurred.
> +                        */
> +                       uint32_t sleep_transitions;
> +               } resume_response;
> +
> +               /* No response fields for non-resume messages. */
> +       };
> +} __packed;
> +
>  /*****************************************************************************/
>  /* Smart battery pass-through */
>
> --
> 2.20.1
>

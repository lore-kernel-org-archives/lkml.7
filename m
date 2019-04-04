Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AFAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C271B2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6MVobah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfDDOmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:42:35 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33712 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfDDOmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:42:35 -0400
Received: by mail-yb1-f194.google.com with SMTP id i10so1121356ybk.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8EWdg2WWUPmXtWmjr831CrRgjsfp2eohBMSY4dDu8rE=;
        b=D6MVobahcEFYb/ylP2NXTgBNRN8fDxDFtJ1uaXffsG0WBpIT/ETbxc86UxpfY4qbuh
         4sHO1xavGrFpfVWzP2AqwOJS52wq8MHyki3YOuIc7qUtNxZvXUBNx+pnIk0/CyswVmQY
         tyEyL6zJG09Rh8LW4/XaUzPY6Llth4+xhtb0JtK8XG81b5TK/9hiKyhTzfzPqftSfbvE
         OKjLfXmXTuV2Vg85H8w0TcIdXZPDGPxMMEAVrXzVirjxg4IRU+6bm+ssSVN1vMvp798M
         xY1iquo7TZSkMek8RmehqSBnEn1VjnlM7gnod5gNcGgp9Q3hTlTmCNK+3UKr3GY6p9Ap
         XKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8EWdg2WWUPmXtWmjr831CrRgjsfp2eohBMSY4dDu8rE=;
        b=G4D15oJd/5i1a4S00/wOpkx+Y/QtYJEX21XMweVJ8YtYpoXywrEjc4VZYV1P0ETamL
         4bxVXofymk+Ow4IDGazTFmGe0yG4Ig5dzFkraQQKnLqWywm0Lrrm4FNikmADFR+pRmBj
         4MvEDRNhc3hnYfqHASj9ofzCifIr10ZtaoVRowqDDAQjFPygoRs/3mIXuaW/MDNs3hlH
         GpI71Z1NINUdw7IM9gU18J4m4tu9kpDZ49AGyB7qp+Iad2qw02jxGaq6SQk2vjRutFw/
         HRGHQPA4KT51zKe6TLFLUt2bMfMiq/FIcPxoSzLpDnbSBg2Ab7dRZu6gvoZCLXtzw/x0
         tm9g==
X-Gm-Message-State: APjAAAV2UyHseeHTI8/1FYvciRSrGngUFsCsGxVMQsxZVLA3cSMe9SxO
        5bWPbxQnePD21a0Okr4c6/8TCv+2o7HZclko7oJYCQ==
X-Google-Smtp-Source: APXvYqzpFvFYLkckkGqCG9VYlCgwB1zLsU/nLkaCh1SidIZrHg1X5XWP1ibvTcHNPO6kF17AUaMerIVwKHBTMMawZ6A=
X-Received: by 2002:a25:c042:: with SMTP id c63mr5719992ybf.288.1554388953937;
 Thu, 04 Apr 2019 07:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190403213428.89920-1-evgreen@chromium.org> <20190403213428.89920-2-evgreen@chromium.org>
In-Reply-To: <20190403213428.89920-2-evgreen@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 4 Apr 2019 07:42:21 -0700
Message-ID: <CABXOdTdgcyhb+K6tW=yQx9R6c38u7aTyWR1OpM0N7EHX6GcW2Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mfd: cros_ec: Add host_sleep_event_v1 command
To:     Evan Green <evgreen@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

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

Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E9CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CA821917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCsJA9n3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfCUVbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:31:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45661 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfCUVbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:31:39 -0400
Received: by mail-qk1-f195.google.com with SMTP id z76so14387qkb.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 14:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K5qEJIfaP1FU+TlftVfWGQJyiXvp5tk0HeUMOFbMHTs=;
        b=VCsJA9n3CjybgQtvH6n8StUZl06dN+iBu9VBu3tEVR21Y+o9uYRAtJiSGOwKCTBA83
         J5HEaz/PY5SWF/vIQ8RsaiJWiGRHZTmqCdD63pPgcKiGo+GC3wlKOwMgfXSjBFoDW/So
         L3fAdTRz0ObGDB82qnxEqHcPGaC5Y0i1icgRpxd6uiz/Tgix+TwxIcvwIXwC0oaZP3Wz
         HxKDdp+oGZDqizGOAEiPaOSlm32wmqFkbhwMaDCtfgvS1wpmSio0Vsu6MXUCjFUpwqC+
         hSzGRWd0lFfbpnCFYFJmgaDK+r/arXQP3LbuqURnkA6IlRAgynv0pirb/d7J285c0QMN
         cbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K5qEJIfaP1FU+TlftVfWGQJyiXvp5tk0HeUMOFbMHTs=;
        b=FijGfl3vlIHFFqJtQ7vXBdEZXyet7+w58Om83TuIB0Kt6Cx1rG3Y1jyuBTgoHbmAFp
         uf+DrSG7OyUgr3uXSRIYztRSk5QdQsczZqHsn5suLsBuXD1CQxg763Pfcbh5n+gqj7+T
         JgM4HRBQeNol0hM1BuOgxKEnhqU0fLdXzknzdF6yrQGolVFJ44c5G+YWIpWfO5ICnXmk
         rMYL8mvZJvDAEsANxi39sX13TzBK0nizXXvZjBjDjjRFSNtyQDEgBmE/h/w3tHoZSo0u
         t2LsdxjZ3J43IoWeRILcrSQ/dKjHORm7Q0g2fErrGovoCj94ZeNN/EVKgCM8dOPS3mAx
         FOXQ==
X-Gm-Message-State: APjAAAUMUbkfIgzmJxBMEXrICJaDUXjA2WB4NIFVAH8U3W00Qy2NQN3X
        8RO1t5imeNAAkxCSOnMAoSMWdPeM+7Kg0K7Hh/lPoOFH
X-Google-Smtp-Source: APXvYqzZmcTKqVDyKqYVf4pkwAAoop0Xp9xuRCKqpQf0lMiOQ0tKk13pYTcZEPryEI1bTXMMBNqnDOcaIie1YHz+E2k=
X-Received: by 2002:a37:47cb:: with SMTP id u194mr846211qka.358.1553203898505;
 Thu, 21 Mar 2019 14:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190320212030.43682-1-evgreen@chromium.org> <20190320212030.43682-2-evgreen@chromium.org>
In-Reply-To: <20190320212030.43682-2-evgreen@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 21 Mar 2019 22:31:27 +0100
Message-ID: <CAFqH_52vsfsxGRQNNzLGjLySHeTXVjdqjBn+1v4EaGMt5ipkbw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mfd: cros_ec: Add host_sleep_event_v1 command
To:     Evan Green <evgreen@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,Thanks for sending this upstream, one comment below.
Missatge de Evan Green <evgreen@chromium.org> del dia dc., 20 de mar=C3=A7
2019 a les 22:24:
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
> ---
>
>  include/linux/mfd/cros_ec_commands.h | 59 ++++++++++++++++++++++++++++

We're trying to sync kernel cros_ec_commands.h with the EC protocol at
https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/e=
c_commands.h

Gwendal send a first patch [1] and a second version will be sent soon.
I don't see these definitions in the mentioned patch neither the
master ec_commands.h from the EC firmware repository. Is this a
feature that didn't land in the EC firmware yet?

[1] https://lkml.org/lkml/2019/2/27/723

Thanks,
 Enric

>  1 file changed, 59 insertions(+)
>
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cro=
s_ec_commands.h
> index fc91082d4c35..4db1240c28a8 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -2729,6 +2729,65 @@ struct ec_params_host_sleep_event {
>         uint8_t sleep_event;
>  } __packed;
>
> +/*
> + * Use a default timeout value (CONFIG_SLEEP_TIMEOUT_MS) for detecting s=
leep
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
> +                        * The timeout in milliseconds between when this =
message
> +                        * is received and when the EC will declare sleep
> +                        * transition failure if the sleep signal is not
> +                        * asserted.
> +                        */
> +                       uint16_t sleep_timeout_ms;
> +               } suspend_params;
> +
> +               /* Reserved space for non-suspend commands. */
> +               uint16_t reserved;
> +       } u;
> +} __packed;
> +
> +/* A timeout occurred when this bit is set */
> +#define EC_HOST_RESUME_SLEEP_TIMEOUT 0x80000000
> +
> +/*
> + * The mask defining which bits correspond to the number of sleep transi=
tions,
> + * as well as the maximum number of suspend line transitions that will b=
e
> + * reported back to the host.
> + */
> +#define EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK 0x7FFFFFFF
> +
> +struct ec_response_host_sleep_event_v1 {
> +       union {
> +               /* Response fields that apply for resume messages. */
> +               struct {
> +                       /*
> +                        * The number of sleep power signal transitions t=
hat
> +                        * occurred since the suspend message. The high b=
it
> +                        * indicates a timeout occurred.
> +                        */
> +                       uint32_t sleep_transitions;
> +               } resume_response;
> +
> +               /* Padding for non-resume responses. */
> +               uint32_t reserved;
> +       } u;
> +} __packed;
> +
>  /***********************************************************************=
******/
>  /* Smart battery pass-through */
>
> --
> 2.20.1
>

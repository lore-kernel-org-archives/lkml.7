Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4A2C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F1C2077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlYg36wO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfDOMjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:39:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44526 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfDOMjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:39:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id i2so8510213pgj.11;
        Mon, 15 Apr 2019 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYO1rIghbgKhztOG84RTNsXjVm4pflx9mXpppRrl+9Q=;
        b=PlYg36wOexW54J1RtiLMiIPf+i6CzvhLQlZVSGvZrbITJv26n1hGOxYZKpDtr7XV+2
         pLKFCtSPT3QC3FZIR4j9TVBimDzC/ojfc8NghGgRPSnHFR5qKjfHWDTHkPQgpBRVrwFK
         Qef63l/vSFs48fe2bVjT3XvDOHBprm/jmLg3DyzUkQ3H9JeNOSU4UbECZqhMd+tyuT4v
         1g7EED+CwCHu4vkCm0gmmwLML0Ya5EXRcBRpFaQBcgq2Q+666ZgmSqxeD1vuMBW44Pr/
         pRXb/D97QcAu36v9FVefs/JmM+hKZaFPVx8xacfIejYz/clzwCP6g4ucGXtzBzp1XxOF
         WdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYO1rIghbgKhztOG84RTNsXjVm4pflx9mXpppRrl+9Q=;
        b=IzkZmL8KMCOs71nmhCudAWYqoJLQA7WX/gNOESx/CDOfhk7BfWfkGON5My4LAtXkA9
         7LUna3LZy676zixq2FaLbClpmLUvRNo/kW3kQYZbIztuB4E2h9/xpoFISMO6iNcpUdKb
         e0jjE2hyy8epJgcLOWDmR7eBkT3HQ4zZP5pwLHcNqR2YnphAF/FRrWJSiW3MbIZpQP7y
         +CyZbXKbOqV3Ptl1FXKPPGDEsrctBAZcSFepwEM6Ofjqy88hnJoSyRIYEZA5WZsOw2GU
         91EDYz9tOnRJ1H1jic6ZfMrU9qSn/ORWtUV2+uQ+mi+seSEgj+oCHSbDT6WCNy+xW4ry
         3kXA==
X-Gm-Message-State: APjAAAURVP+Hgn61xyzgHTL/2/UDAC+aRidOwz8PU0NXUFfRuodJyLeq
        ZSG9g7RhP3/BDWBNRI6XHBTAY4/FeOSwufBZas8=
X-Google-Smtp-Source: APXvYqxYjb7KJ8LeoxUPDggINMXNPtZU9ryXSSMu4Fk9C5sDH04rJEUnkPMksjpD0w+j6FBQTpKAvtvxWh3j4DQ6dvg=
X-Received: by 2002:a65:4302:: with SMTP id j2mr66543604pgq.291.1555331958137;
 Mon, 15 Apr 2019 05:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com> <20190403124019.8947-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190403124019.8947-3-wsa+renesas@sang-engineering.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Apr 2019 15:39:07 +0300
Message-ID: <CAHp75VfvSWuXVJFsq7ZdWj3-XrpPXnFSV1Bk_oW9oS6Gm7msuA@mail.gmail.com>
Subject: Re: [PATCH 02/12] i2c: core: use I2C locking behaviour also for SMBUS
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Peter Rosin <peda@axentia.se>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 3:43 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> If I2C transfers are executed in atomic contexts, trylock is used
> instead of lock. This behaviour was missing for SMBUS, although a lot of
> transfers are of SMBUS type, either emulated or direct. So, factor out
> the locking routine into a helper and use it for I2C and SMBUS.
>

Reviewed-by Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/i2c-core-base.c  | 11 +++--------
>  drivers/i2c/i2c-core-smbus.c |  7 ++++++-
>  drivers/i2c/i2c-core.h       | 12 ++++++++++++
>  3 files changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index f8502064cd6b..ad14f38a67e4 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1946,14 +1946,9 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>          *    one (discarding status on the second message) or errno
>          *    (discarding status on the first one).
>          */
> -       if (i2c_in_atomic_xfer_mode()) {
> -               ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT);
> -               if (!ret)
> -                       /* I2C activity is ongoing. */
> -                       return -EAGAIN;
> -       } else {
> -               i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
> -       }
> +       ret = __i2c_lock_bus_helper(adap);
> +       if (ret)
> +               return ret;
>
>         ret = __i2c_transfer(adap, msgs, num);
>         i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> index 132119112596..357e083e8f45 100644
> --- a/drivers/i2c/i2c-core-smbus.c
> +++ b/drivers/i2c/i2c-core-smbus.c
> @@ -20,6 +20,8 @@
>  #include <linux/i2c-smbus.h>
>  #include <linux/slab.h>
>
> +#include "i2c-core.h"
> +
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/smbus.h>
>
> @@ -530,7 +532,10 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
>  {
>         s32 res;
>
> -       i2c_lock_bus(adapter, I2C_LOCK_SEGMENT);
> +       res = __i2c_lock_bus_helper(adapter);
> +       if (res)
> +               return res;
> +
>         res = __i2c_smbus_xfer(adapter, addr, flags, read_write,
>                                command, protocol, data);
>         i2c_unlock_bus(adapter, I2C_LOCK_SEGMENT);
> diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
> index 9d8526415b26..deea47c576e5 100644
> --- a/drivers/i2c/i2c-core.h
> +++ b/drivers/i2c/i2c-core.h
> @@ -39,6 +39,18 @@ static inline bool i2c_in_atomic_xfer_mode(void)
>         return system_state > SYSTEM_RUNNING && irqs_disabled();
>  }
>
> +static inline int __i2c_lock_bus_helper(struct i2c_adapter *adap)
> +{
> +       int ret = 0;
> +
> +       if (i2c_in_atomic_xfer_mode())
> +               ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT) ? 0 : -EAGAIN;
> +       else
> +               i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
> +
> +       return ret;
> +}
> +
>  #ifdef CONFIG_ACPI
>  const struct acpi_device_id *
>  i2c_acpi_match_device(const struct acpi_device_id *matches,
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko

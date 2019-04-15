Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF726C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8448D20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0wXy1DN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfDOMji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:39:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33085 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfDOMjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:39:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so8539038pgh.0;
        Mon, 15 Apr 2019 05:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/HtOjFwWdAVHvbLVQPYvvZRvwmUCmReqPVGi7m85lw=;
        b=D0wXy1DNq1xK0IaqHk7In1uCOlWLTABrMcIjtX2x01leLB1kdFztqaAh9KiGzrFQJ3
         jtK3TfNEnarw614R4TY1wL8CT2HhbkB4iiYr2MMv/KXtnBfpGUEF0J/xoPSQ4K+E1ZNJ
         m8cM46TUpqBSFnKeVzL74CP7xv/js2MbzNO4yhDzTIqCZlfemdKoum9G9QQP2duJ+Lgp
         2ZZmiiVLBEKaOaqpOdQ5aBYRhM0Ywl7MLgA3sb2nx1liqv0eRXuRLwxqOkdHBkJnNSbD
         qV0Y3htVMUMMvP0BO1m257Q3T/XBnXLqRS06uZvHN4vf7Bl6dVAyFt0vCoKl70tL7DgM
         xi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/HtOjFwWdAVHvbLVQPYvvZRvwmUCmReqPVGi7m85lw=;
        b=p7CiOQMcsswuOhkKkisjGJbOJFwq9v5dvdYqag0ucd0REkWHflanqb7mTzF2N4Qlax
         o84U7SD+SxbOd+ernm4hcirEBuG+hy4ohYhwXN+mjlO3FSMzVyOWXH2RkFZ7MgbJV9LN
         w+gmDLLa8uVIOvaK6sn6m+oA2PLGr6znwJ72s9w6dkrPauB2uGyzca13N3oWn2LqSygw
         IhUrbdRFabu55f3h+Lkxzolv1o9AwvCoZvRYtreFxyDhQqBkLmuPtDvIK5mbjvxXK6an
         4ij1rwgNw5ni7qk52GcZ708jhdWVU6/MU8YUnXB9ngJ9OkelAWldZJxPxE5wW40HZYcg
         f0sA==
X-Gm-Message-State: APjAAAULogUKmgOnCtHhq7qgFQzgx+3ol0TWVOgEU2mGaXMrJKlDUFIa
        JTXUkv3c5bGLHDjFALeRzdE5L0qCMLG2sDiviil3uOb+FH1sxg==
X-Google-Smtp-Source: APXvYqwE9HovC5WjrBjQLfLVNTGkPsz39b9AhQAC8lcNRfvoQJJxQPuFZ4OwQaOLQuHUUg7uo3oA71epvicPrv+bodE=
X-Received: by 2002:a65:6210:: with SMTP id d16mr67867747pgv.110.1555331976583;
 Mon, 15 Apr 2019 05:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com> <20190403124019.8947-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190403124019.8947-4-wsa+renesas@sang-engineering.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Apr 2019 15:39:25 +0300
Message-ID: <CAHp75VfmwPHvyryqHiA+SLPd7f9VS7zMBQ98bU8YRcZNx6dCrw@mail.gmail.com>
Subject: Re: [PATCH 03/12] i2c: core: introduce callbacks for atomic transfers
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
> We had the request to access devices very late when interrupts are not
> available anymore multiple times now. Mostly to prepare shutdown or
> reboot. Allow adapters to specify a specific callback for this case.
> Note that we fall back to the generic {master|smbus}_xfer callback if
> this new atomic one is not present. This is intentional to preserve the
> previous behaviour and avoid regressions. Because there are drivers not
> using interrupts or because it might have worked "accidently" before.
>

Reviewed-by Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/i2c-core-base.c  |  6 +++++-
>  drivers/i2c/i2c-core-smbus.c | 18 ++++++++++++++----
>  drivers/i2c/i2c-core.h       |  7 +++++--
>  include/linux/i2c.h          | 15 ++++++++++++---
>  4 files changed, 36 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index ad14f38a67e4..4e6300dc2c4e 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1890,7 +1890,11 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>         /* Retry automatically on arbitration loss */
>         orig_jiffies = jiffies;
>         for (ret = 0, try = 0; try <= adap->retries; try++) {
> -               ret = adap->algo->master_xfer(adap, msgs, num);
> +               if (i2c_in_atomic_xfer_mode() && adap->algo->master_xfer_atomic)
> +                       ret = adap->algo->master_xfer_atomic(adap, msgs, num);
> +               else
> +                       ret = adap->algo->master_xfer(adap, msgs, num);
> +
>                 if (ret != -EAGAIN)
>                         break;
>                 if (time_after(jiffies, orig_jiffies + adap->timeout))
> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> index 357e083e8f45..fdb0fb9fb9aa 100644
> --- a/drivers/i2c/i2c-core-smbus.c
> +++ b/drivers/i2c/i2c-core-smbus.c
> @@ -548,6 +548,9 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
>                      unsigned short flags, char read_write,
>                      u8 command, int protocol, union i2c_smbus_data *data)
>  {
> +       int (*xfer_func)(struct i2c_adapter *adap, u16 addr,
> +                        unsigned short flags, char read_write,
> +                        u8 command, int size, union i2c_smbus_data *data);
>         unsigned long orig_jiffies;
>         int try;
>         s32 res;
> @@ -562,13 +565,20 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
>
>         flags &= I2C_M_TEN | I2C_CLIENT_PEC | I2C_CLIENT_SCCB;
>
> -       if (adapter->algo->smbus_xfer) {
> +       xfer_func = adapter->algo->smbus_xfer;
> +       if (i2c_in_atomic_xfer_mode()) {
> +               if (adapter->algo->smbus_xfer_atomic)
> +                       xfer_func = adapter->algo->smbus_xfer_atomic;
> +               else if (adapter->algo->master_xfer_atomic)
> +                       xfer_func = NULL; /* fallback to I2C emulation */
> +       }
> +
> +       if (xfer_func) {
>                 /* Retry automatically on arbitration loss */
>                 orig_jiffies = jiffies;
>                 for (res = 0, try = 0; try <= adapter->retries; try++) {
> -                       res = adapter->algo->smbus_xfer(adapter, addr, flags,
> -                                                       read_write, command,
> -                                                       protocol, data);
> +                       res = xfer_func(adapter, addr, flags, read_write,
> +                                       command, protocol, data);
>                         if (res != -EAGAIN)
>                                 break;
>                         if (time_after(jiffies,
> diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
> index deea47c576e5..f9d0c417b5a5 100644
> --- a/drivers/i2c/i2c-core.h
> +++ b/drivers/i2c/i2c-core.h
> @@ -43,10 +43,13 @@ static inline int __i2c_lock_bus_helper(struct i2c_adapter *adap)
>  {
>         int ret = 0;
>
> -       if (i2c_in_atomic_xfer_mode())
> +       if (i2c_in_atomic_xfer_mode()) {
> +               WARN(!adap->algo->master_xfer_atomic && !adap->algo->smbus_xfer_atomic,
> +                    "No atomic I2C transfer handler for '%s'\n", dev_name(&adap->dev));
>                 ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT) ? 0 : -EAGAIN;
> -       else
> +       } else {
>                 i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
> +       }
>
>         return ret;
>  }
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 758a6db864c9..03755d4c9229 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -499,9 +499,13 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
>   * @master_xfer: Issue a set of i2c transactions to the given I2C adapter
>   *   defined by the msgs array, with num messages available to transfer via
>   *   the adapter specified by adap.
> + * @master_xfer_atomic: same as @master_xfer. Yet, only using atomic context
> + *   so e.g. PMICs can be accessed very late before shutdown. Optional.
>   * @smbus_xfer: Issue smbus transactions to the given I2C adapter. If this
>   *   is not present, then the bus layer will try and convert the SMBus calls
>   *   into I2C transfers instead.
> + * @smbus_xfer_atomic: same as @smbus_xfer. Yet, only using atomic context
> + *   so e.g. PMICs can be accessed very late before shutdown. Optional.
>   * @functionality: Return the flags that this algorithm/adapter pair supports
>   *   from the I2C_FUNC_* flags.
>   * @reg_slave: Register given client to I2C slave mode of this adapter
> @@ -512,9 +516,9 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
>   * be addressed using the same bus algorithms - i.e. bit-banging or the PCF8584
>   * to name two of the most common.
>   *
> - * The return codes from the @master_xfer field should indicate the type of
> - * error code that occurred during the transfer, as documented in the kernel
> - * Documentation file Documentation/i2c/fault-codes.
> + * The return codes from the @master_xfer{_atomic} fields should indicate the
> + * type of error code that occurred during the transfer, as documented in the
> + * Kernel Documentation file Documentation/i2c/fault-codes.
>   */
>  struct i2c_algorithm {
>         /*
> @@ -528,9 +532,14 @@ struct i2c_algorithm {
>          */
>         int (*master_xfer)(struct i2c_adapter *adap, struct i2c_msg *msgs,
>                            int num);
> +       int (*master_xfer_atomic)(struct i2c_adapter *adap,
> +                                  struct i2c_msg *msgs, int num);
>         int (*smbus_xfer)(struct i2c_adapter *adap, u16 addr,
>                           unsigned short flags, char read_write,
>                           u8 command, int size, union i2c_smbus_data *data);
> +       int (*smbus_xfer_atomic)(struct i2c_adapter *adap, u16 addr,
> +                                unsigned short flags, char read_write,
> +                                u8 command, int size, union i2c_smbus_data *data);
>
>         /* To determine what the adapter supports */
>         u32 (*functionality)(struct i2c_adapter *adap);
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko

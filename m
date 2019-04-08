Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA05C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E074620857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6pQhiq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfDHQJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:09:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39104 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbfDHQJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:09:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id a96so2916926pla.6;
        Mon, 08 Apr 2019 09:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FrxMVhvdyoOlylpEPXO5g0YRKZtTuBz1Vu42rKQkI4I=;
        b=K6pQhiq7zgTmFhGtH1WnztTe9Chcve4mhrts0E70DJPtbMRFuX7L6IgibSE1opw8WR
         N2CnpyA5lGmasEgnmALcnsGnRugo+aE67C1v2NsDO11r0iPL6Bvgel+WOLTavJVHmRN9
         rvcB2P5nADXmsyf8LGRCLaMN7tTG+pb9tSmLiCeorM/oTVJfn+QUojXjk/6FIky86HtL
         rrPvK4WvAawMIeIU4CKPXNBqkKo61gkqwelcRucBp+s4CfcoY6YyEL6n1Mj5baQ0RCxX
         Is2quzs9IydnoRBZZGgdjWzZasOZIvn/bZh//pdfQu2aBh1pKruTt1yiuhli8oWGUcKc
         XGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FrxMVhvdyoOlylpEPXO5g0YRKZtTuBz1Vu42rKQkI4I=;
        b=hMWVzEI0VZE1haRJ04buKmtQqBeg5pYRMT/9IIN/wdZRE2gjQ8dCB4rHCvbBAP0jX/
         ewyM5YuTrCpLoxE/2zm3F51m2GjzCQRxLZpNuUs9k+5LS2OyoZHf4u6qJAHzQ4SXJkUG
         elGRQnIzAkAi8Rcdx+SIg6Rl9rlYC1QQTY5UzzmVJgjEXgEuO97s/ZKMYc1ilkhO2VBP
         T3IIFXdobF+gDRFMOU7mET+jdPv0JBx/vFgMbdF50ccg+DMGKI7sAUsIiq+cZzz7aUtL
         Ge+wrDqPyWvRW4btp7safzXNzUV+287jYeo86yHqZVlM2ZT2xUiamxhxbjkLaWyrLdEt
         6qfQ==
X-Gm-Message-State: APjAAAUtUEP0ipgVmzeKDbwvI3z9apBzekC32nNmgTFBMXj5r6P+sZLp
        mumwqMcepte/2yZWNgU63cWJRnNCxV/bqWun/DE=
X-Google-Smtp-Source: APXvYqwDskG9fA8PFZE32VOvHVpF0lVkZgyUHSWOqLL94gI2KtjuBmDYPRkiA6svlcBiIG27m0V5J/2I57Fxnlwlpsk=
X-Received: by 2002:a17:902:e091:: with SMTP id cb17mr31789933plb.222.1554739767685;
 Mon, 08 Apr 2019 09:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190403164537.24643-1-heikki.krogerus@linux.intel.com> <20190403164537.24643-9-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190403164537.24643-9-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Apr 2019 19:09:15 +0300
Message-ID: <CAHp75VfQK_YHyfryMUO0uG_uwoKcgMn_NUXaRbiOXeXQz6xyYQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] platform/x86: intel_cht_int33fe: Provide software
 nodes for the devices
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 7:46 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Software nodes provide two features that we will need later.
> 1) Software nodes can have references to other software nodes.
> 2) Software nodes can exist before a device entry is created.

>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> +#include <linux/pci.h>

I understand your attitude to ordering here, but we already have it
ordered, why not to keep it that way?

> -static struct i2c_client *cht_int33fe_find_max17047(void)
> -{
> -       struct i2c_client *max17047 = NULL;
> -
> -       i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
> -       return max17047;
> -}

This sounds like a cleanup patch before actual change.
And I'm not sure, do we need to remove this function?

> +static int
> +cht_int33fe_max17047(struct device *dev, struct cht_int33fe_data *data)
> +{
> +       struct fwnode_handle *fwnode = data->node[INT33FE_NODE_MAX17047];
> +       struct i2c_client *max17047 = NULL;
> +       struct i2c_board_info board_info;
> +       int ret;
> +
> +       i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
> +       if (max17047) {
> +               /* Pre-existing i2c-client for the max17047, add device-props */
> +               max17047->dev.fwnode->secondary = fwnode;
> +               /* And re-probe to get the new device-props applied. */
> +               ret = device_reprobe(&max17047->dev);
> +               if (ret)
> +                       dev_warn(dev, "Reprobing max17047 error: %d\n", ret);
> +               return 0;
> +       }
> +
> +       memset(&board_info, 0, sizeof(board_info));
> +       strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
> +       board_info.dev_name = "max17047";
> +       board_info.fwnode = fwnode;
> +       data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
> +       if (IS_ERR(data->max17047))
> +               return PTR_ERR(data->max17047);
> +
> +       return 0;
> +}

This looks like a split from the original code with some changes.
Perhaps, split patch first.

>         /* Work around BIOS bug, see comment on cht_int33fe_find_max17047 */

After this patch, the comment here become outdated, care to fix?

> +       ret = cht_int33fe_max17047(dev, data);

Seems like the verb is missed in the name of the function.

> +       if (ret)
> +               goto out_remove_nodes;

-- 
With Best Regards,
Andy Shevchenko

Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13617C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C380C20857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdXOlRQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfDHQLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:11:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47017 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfDHQLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:11:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so7583417pll.13;
        Mon, 08 Apr 2019 09:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C75wt9iHaATt71XyxfdYG+wz/oR7VyvjcOxmmFFLecw=;
        b=TdXOlRQGDUj964aqhqVbcysV/xdXrMHdgSlJezey0DR77S2u/JBx7iCsdudLE423GY
         VNG9Z3Dt4As2MHl49vVmh/cRvqzZV2l7iNUFCQfHsz2lz7xaFevKmEu6l2oggzlPgYml
         xtvTcawxtuk/yZ3sTio+zSybAyE7GP4pzMps9KQcNIKpKuJMeuipQxvFQRbIOvyVfd+O
         Gr/NdVwvY3uFfs2Z8ufzQnwnkXosnjWZCFvuQT4hBHgK5zQ98kbXSWYdn2fhEPWhjsNJ
         5XPqOIwAIw0UuAm0umVXoL/oalAfIUsXgWhOCNsPtgA0gM6A+3aVRLdwV/6IFGNHSda5
         RjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C75wt9iHaATt71XyxfdYG+wz/oR7VyvjcOxmmFFLecw=;
        b=bSLOE6TyT/fx0Qo6JXqcJ9gIfdPGYsKtHOLQV+MZFB0G6FjepKWStywZfWoSyyFawQ
         +aWnUJpYA22YEfWT1g9m6B64pBRVXb7S8Ka2Zh7Hwh+9lvaDMQWiiwLsXXXR7zYE40p1
         vgtx+7gmIpbqtFmMSpP1bqw0gryOCQGn2eV/61rLojUED/feIy5AHetB7cbdjwSOKcs3
         8wH1VN4Sn+li+8qGtspRQFWpFjHh1GO5SYq+OoG28/+fQLMeAVVwi5Ez3G9MCW0onBPb
         joyxBCWpiCt+fDlBrlseLjQV8G3L7FKX3vTPSdDPdKOTcnpYVDPnoJXX1zCkK359qoqW
         5rXQ==
X-Gm-Message-State: APjAAAUPD60v7cvY1YkoJtWSg8BFwolUs5gMF2+W44YxyaI26unWS8sR
        H8vn6EBarByf4ui0jlvvEZf0Hp9HiTOIPqiNxFg=
X-Google-Smtp-Source: APXvYqyjISur4yXGB7CC3vawawNGdF8Q94UjfEYo2dBqsronKBS9K9Hf3MctqvwJndmlUdTBJCb90stbsoPolMs9YMM=
X-Received: by 2002:a17:902:e091:: with SMTP id cb17mr31798505plb.222.1554739860445;
 Mon, 08 Apr 2019 09:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190403164537.24643-1-heikki.krogerus@linux.intel.com> <20190403164537.24643-10-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190403164537.24643-10-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Apr 2019 19:10:49 +0300
Message-ID: <CAHp75Vcd==tp4VYrZ9iaYhz1k21EWD0uzVFdOSLKd83oFqcJxg@mail.gmail.com>
Subject: Re: [PATCH 09/11] platform/x86: intel_cht_int33fe: Provide fwnode for
 the USB connector
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
> In ACPI, and now also in DT, the USB connectors usually have
> their own device nodes. In case of USB Type-C, those
> connector (port) nodes are child nodes of the controller or
> PHY device, in our case the fusb302. The software fwnodes
> allow us to create a similar child node for fusb302 that
> represents the connector also on Intel CHT.
>
> This makes it possible replace the fusb302 specific device
> properties which were deprecated with the common USB
> connector properties that tcpm.c is able to use directly.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/platform/x86/intel_cht_int33fe.c | 37 ++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index 2f12ce154489..544e0b90aa07 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -25,6 +25,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/pci.h>
> +#include <linux/usb/pd.h>
>
>  #define EXPECTED_PTYPE         4
>
> @@ -32,6 +33,7 @@ enum {
>         INT33FE_NODE_FUSB302,
>         INT33FE_NODE_MAX17047,
>         INT33FE_NODE_PI3USB30532,
> +       INT33FE_NODE_USB_CONNECTOR,
>         INT33FE_NODE_MAX,
>  };
>
> @@ -112,9 +114,29 @@ cht_int33fe_max17047(struct device *dev, struct cht_int33fe_data *data)
>
>  static const struct property_entry fusb302_props[] = {
>         PROPERTY_ENTRY_STRING("linux,extcon-name", "cht_wcove_pwrsrc"),
> -       PROPERTY_ENTRY_U32("fcs,max-sink-microvolt", 12000000),
> -       PROPERTY_ENTRY_U32("fcs,max-sink-microamp",   3000000),
> -       PROPERTY_ENTRY_U32("fcs,max-sink-microwatt", 36000000),
> +       { }
> +};
> +
> +#define PDO_FIXED_FLAGS \
> +       (PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP | PDO_FIXED_USB_COMM)
> +
> +static const u32 src_pdo[] = {
> +       PDO_FIXED(5000, 1500, PDO_FIXED_FLAGS),
> +};
> +
> +static const u32 snk_pdo[] = {
> +       PDO_FIXED(5000, 400, PDO_FIXED_FLAGS),
> +       PDO_VAR(5000, 12000, 3000),
> +};
> +
> +static const struct property_entry usb_connector_props[] = {
> +       PROPERTY_ENTRY_STRING("name", "connector"),
> +       PROPERTY_ENTRY_STRING("data-role", "dual"),
> +       PROPERTY_ENTRY_STRING("power-role", "dual"),
> +       PROPERTY_ENTRY_STRING("try-power-role", "sink"),
> +       PROPERTY_ENTRY_U32_ARRAY("source-pdos", src_pdo),
> +       PROPERTY_ENTRY_U32_ARRAY("sink-pdos", snk_pdo),
> +       PROPERTY_ENTRY_U32("op-sink-microwatt", 36000000),
>         { }
>  };
>
> @@ -149,6 +171,15 @@ static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
>                 data->node[i] = fwnode;
>         }
>
> +       /* Node for the USB connector (FUSB302 is the parent) */
> +       fwnode = fwnode_create_software_node(usb_connector_props,
> +                                            data->node[INT33FE_NODE_FUSB302]);
> +       if (IS_ERR(fwnode)) {
> +               ret = PTR_ERR(fwnode);
> +               goto err_remove_nodes;
> +       }
> +       data->node[INT33FE_NODE_USB_CONNECTOR] = fwnode;
> +
>         return 0;
>
>  err_remove_nodes:
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko

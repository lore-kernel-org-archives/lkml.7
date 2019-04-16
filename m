Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328DAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C6A2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbfDPVfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:35:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38762 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730568AbfDPVfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:35:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so873100wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 14:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xhMXL/7/2KyboHREjt7Kx09EFnQ1GXMXtClPQEI62r0=;
        b=bUdHGMfwHTxnlAAuFakhpUfonOeAyOSKsnRGWEjB1h0eb8eEUbUB70X914bOW/BXSI
         mXSQAjVqsupSOJmPFeFGFAlFFuoV0zD8LYsXDei9qrFOrzZrbMlmoyecxoJneo0SZuJu
         XyWJrNnBEb0LctKvG19fLtU/bVFIVMMtaUsZg2brm1+62l52O1wWNgSyk64/qLak0Km2
         qXA9X25wINqwTHOlGmQxio93pk7bBV9eAFD3zukgA+bIqbntq2e/DoHN2ZC0wOiKMr83
         8ZrLze0tC+pZ9BaChddNMORAUOOA4cPdGYYRiseZw/2U/q0QfwN6Yhm5eB+10fPzYDwx
         WrLA==
X-Gm-Message-State: APjAAAWpoC3QAij8EiqyFpeR+QjpWY8rTkRfJPIxjt6iZq1CGtAGsHxz
        /KKj3KRKS9P86d2I5RNY2AdV1Q==
X-Google-Smtp-Source: APXvYqz/q/sfx6myLwvxsjJPgHJUn3c9whznWsj0UC861HTjxpzch2vt3wzJf6mdMJOQikBSMoDPKA==
X-Received: by 2002:a7b:c054:: with SMTP id u20mr28561719wmc.100.1555450538548;
        Tue, 16 Apr 2019 14:35:38 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 13sm434892wmf.23.2019.04.16.14.35.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 14:35:37 -0700 (PDT)
Subject: Re: [PATCH v3 13/13] platform/x86: intel_cht_int33fe: Replacing the
 old connections with references
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
 <20190412134122.82903-14-heikki.krogerus@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a91a1d75-f224-9c9d-873a-f80467d2fb0c@redhat.com>
Date:   Tue, 16 Apr 2019 23:35:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412134122.82903-14-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12-04-19 15:41, Heikki Krogerus wrote:
> Now that the software nodes support references, and the
> device connection API support parsing fwnode references,
> replacing the old connection descriptions with software node
> references. Relying on device names when matching the
> connection would not have been possible to link the USB
> Type-C connector and the DisplayPort connector together, but
> with real references it's not problem.
> 
> The DisplayPort ACPI node is dag up, and the drivers own
> software node for the DisplayPort is set as the secondary
> node for it. The USB Type-C connector refers the software
> node, but it is now tied to the ACPI node, and therefore any
> device entry (struct drm_connector in practice) that the
> node combo is assigned to.
> 
> The USB role switch device does not have ACPI node, so we
> have to wait for the device to appear. Then we can simply
> assign our software node for the to the device.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

So as promised I've been testing this series and this commit
breaks type-c functionality on devices using this driver.

The problem is that typec_switch_get() and  typec_mux_get()
after this both return the same pointer, which is pointing
to the switch, so typec_mux_get() is returning the wrong
pointer.

This is not surprising since the references for both are
both pointing to the fwnode attached to the piusb30532 devices:

	args[0].fwnode = data->node[INT33FE_NODE_PI3USB30532];

So the class_find_device here:

static void *typec_switch_match(struct device_connection *con, int ep,
                                 void *data)
{
         struct device *dev;

         if (con->fwnode) {
                 if (con->id && !fwnode_property_present(con->fwnode, con->id))
                         return NULL;

                 dev = class_find_device(&typec_mux_class, NULL, con->fwnode,
                                         fwnode_match);
         } else {
                 dev = class_find_device(&typec_mux_class, NULL,
                                         con->endpoint[ep], name_match);
         }

         return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
}

Simply returns the first typec_mux_class device registered.

I see 2 possible solutions to this problem:

1) Use separate typec_mux_class and typec_orientation_switch_class-es

2) Merge struct typec_switch and struct typec_mux into a single struct,
so that all typec_mux_class devices have the same memory layout, add
a subclass enum to this new merged struct and use that to identify
which of the typec_mux_class devices with the same fwnode pointer we
want.

Any other suggestions?

Regards,

Hans





> ---
>   drivers/platform/x86/intel_cht_int33fe.c | 93 +++++++++++++++++++-----
>   1 file changed, 76 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index 7711667a3454..e6a1ea7f33af 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -39,15 +39,22 @@ enum {
>   	INT33FE_NODE_MAX,
>   };
>   
> +enum {
> +	INT33FE_REF_ORIENTATION,
> +	INT33FE_REF_MODE_MUX,
> +	INT33FE_REF_DISPLAYPORT,
> +	INT33FE_REF_ROLE_SWITCH,
> +	INT33FE_REF_MAX,
> +};
> +
>   struct cht_int33fe_data {
>   	struct i2c_client *max17047;
>   	struct i2c_client *fusb302;
>   	struct i2c_client *pi3usb30532;
> -	/* Contain a list-head must be per device */
> -	struct device_connection connections[4];
>   
>   	struct fwnode_handle *dp;
>   	struct fwnode_handle *node[INT33FE_NODE_MAX];
> +	struct software_node_reference *ref[INT33FE_REF_MAX];
>   };
>   
>   /*
> @@ -280,6 +287,65 @@ static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
>   	return ret;
>   }
>   
> +static void cht_int33fe_remove_references(struct cht_int33fe_data *data)
> +{
> +	int i;
> +
> +	for (i = 0; i < INT33FE_REF_MAX; i++)
> +		fwnode_remove_software_node_reference(data->ref[i]);
> +}
> +
> +static int cht_int33fe_add_references(struct cht_int33fe_data *data)
> +{
> +	struct fwnode_reference_args args[2] = { };
> +	struct software_node_reference *ref;
> +	struct fwnode_handle *con;
> +
> +	con = data->node[INT33FE_NODE_USB_CONNECTOR];
> +
> +	/* USB Type-C muxes */
> +	args[0].fwnode = data->node[INT33FE_NODE_PI3USB30532];
> +	args[1].fwnode = NULL;
> +
> +	ref = fwnode_create_software_node_reference(con, "orientation-switch",
> +						    args);
> +	if (IS_ERR(ref))
> +		return PTR_ERR(ref);
> +	data->ref[INT33FE_REF_ORIENTATION] = ref;
> +
> +	ref = fwnode_create_software_node_reference(con, "mode-switch", args);
> +	if (IS_ERR(ref)) {
> +		cht_int33fe_remove_references(data);
> +		return PTR_ERR(ref);
> +	}
> +	data->ref[INT33FE_REF_MODE_MUX] = ref;
> +
> +	/* USB role switch */
> +	args[0].fwnode = data->node[INT33FE_NODE_ROLE_SWITCH];
> +	args[1].fwnode = NULL;
> +
> +	ref = fwnode_create_software_node_reference(con, "usb-role-switch",
> +						    args);
> +	if (IS_ERR(ref)) {
> +		cht_int33fe_remove_references(data);
> +		return PTR_ERR(ref);
> +	}
> +	data->ref[INT33FE_REF_ROLE_SWITCH] = ref;
> +
> +	/* DisplayPort */
> +	args[0].fwnode = data->node[INT33FE_NODE_DISPLAYPORT];
> +	args[1].fwnode = NULL;
> +
> +	ref = fwnode_create_software_node_reference(con, "displayport", args);
> +	if (IS_ERR(ref)) {
> +		cht_int33fe_remove_references(data);
> +		return PTR_ERR(ref);
> +	}
> +	data->ref[INT33FE_REF_DISPLAYPORT] = ref;
> +
> +	return 0;
> +}
> +
>   static int cht_int33fe_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -348,22 +414,14 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	/* Work around BIOS bug, see comment on cht_int33fe_check_for_max17047 */
> -	ret = cht_int33fe_register_max17047(dev, data);
> +	ret = cht_int33fe_add_references(data);
>   	if (ret)
>   		goto out_remove_nodes;
>   
> -	data->connections[0].endpoint[0] = "port0";
> -	data->connections[0].endpoint[1] = "i2c-pi3usb30532-switch";
> -	data->connections[0].id = "orientation-switch";
> -	data->connections[1].endpoint[0] = "port0";
> -	data->connections[1].endpoint[1] = "i2c-pi3usb30532-mux";
> -	data->connections[1].id = "mode-switch";
> -	data->connections[2].endpoint[0] = "i2c-fusb302";
> -	data->connections[2].endpoint[1] = "intel_xhci_usb_sw-role-switch";
> -	data->connections[2].id = "usb-role-switch";
> -
> -	device_connections_add(data->connections);
> +	/* Work around BIOS bug, see comment on cht_int33fe_check_for_max17047 */
> +	ret = cht_int33fe_register_max17047(dev, data);
> +	if (ret)
> +		goto out_remove_references;
>   
>   	memset(&board_info, 0, sizeof(board_info));
>   	strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
> @@ -398,7 +456,8 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>   out_unregister_max17047:
>   	i2c_unregister_device(data->max17047);
>   
> -	device_connections_remove(data->connections);
> +out_remove_references:
> +	cht_int33fe_remove_references(data);
>   
>   out_remove_nodes:
>   	cht_int33fe_remove_nodes(data);
> @@ -414,7 +473,7 @@ static int cht_int33fe_remove(struct platform_device *pdev)
>   	i2c_unregister_device(data->fusb302);
>   	i2c_unregister_device(data->max17047);
>   
> -	device_connections_remove(data->connections);
> +	cht_int33fe_remove_references(data);
>   	cht_int33fe_remove_nodes(data);
>   
>   	return 0;
> 

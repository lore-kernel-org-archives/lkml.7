Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705ADC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E88E2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbfHOIxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:53:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40399 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfHOIxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:53:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id h8so1528031edv.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 01:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XeKVU1y7K/0+7zxnhgeGuNaVnZh3R481wD54ua/mFUU=;
        b=dAQQFfOFwEjzqU+Fx0neVp/vAR93Bz1sQ5RlWi+oYdT7TL4vAp9eNQtUKNqHfm1LtY
         3YLIEVG+Y7/duxN+oYmXGJic5ugQdrfEmukG2GIZtkshT1bQfcAOpZkUDsgUtTGoi3Am
         JUHyWV1LhncQvF3cKj3jJcYNfIFeIb4w2BWoS7fVJLeFcqHHnFN6ZSwDNpFVwFfl8/+I
         iZdgWF6vzqDgUaFfKK+etiB7gDIc1lJ1blVx6j7+Jvjy9uYjzKe8lBME00P4KXQ3sMd4
         eZbgG8xf970I2U1asaXaXkFFSgOgJV/JLE5zTGfOlKUcImZMcz2wpEGIqK4iCiCP/iNy
         RaSw==
X-Gm-Message-State: APjAAAUNeKxO3kLkCBsm4D+RbHFcqS73bzY6QoodF2FC5aneN0ppYqJ8
        g98MabdEslDyQpXVy1ioQt8Mwg==
X-Google-Smtp-Source: APXvYqx6bJqgyrfjiTg9W4LAwi7QG4CNfgZ1HUY+uG8k1g5OEbD2MTyisBi/sxJX/RdsnxlpZuH/tg==
X-Received: by 2002:a17:906:8392:: with SMTP id p18mr3408377ejx.17.1565859188250;
        Thu, 15 Aug 2019 01:53:08 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s11sm440161edh.60.2019.08.15.01.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 01:53:07 -0700 (PDT)
Subject: for_each_child_of_node semantics are broken (was [PATCH] ata:
 libahci_platform: Add of_node_put() before loop exit)
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>, axboe@kernel.dk,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>
References: <20190815060014.2191-1-nishkadg.linux@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a469ccae-0b34-8a8f-376c-7cd176fd05bf@redhat.com>
Date:   Thu, 15 Aug 2019 10:53:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815060014.2191-1-nishkadg.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishka,

On 15-08-19 08:00, Nishka Dasgupta wrote:
> Each iteration of for_each_child_of_node puts the previous node, but
> in the case of a goto from the middle of the loop, there is no put,
> thus causing a memory leak. Add an of_node_put before three such goto
> statements.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>

Thank you for your patch.

I do not like doing an of_node_put for something which we did not
explicitly of_node_get. So I was thinking about maybe replacing the
goto-s with a break.

But even if we put a break in the for_each_child_of_node loop,
we still leak the reference. Which IMHO means that the semantics of
the for_each_child_of_node helper are broken, this certainly violates
the principle of least surprise which one would expect of a good API.

I see that there are quite a few callers of this function:

[hans@shalem linux]$ ack -l for_each_child_of_node drivers | wc -l
194

And doing a manual check of these (with the intend to stop after
a couple) I already find something suspicious in the second file
ack -l returns:

         for_each_child_of_node(parent, dn) {
                 pnv_php_detach_device_nodes(dn);

                 of_node_put(dn);
                 refcount = kref_read(&dn->kobj.kref);
                 if (refcount != 1)
                         pr_warn("Invalid refcount %d on <%pOF>\n",
                                 refcount, dn);

                 of_detach_node(dn);
         }

note this does an of_node_put itself and then continues iterating,
now this function looks pretty magical to me, so it might be fine...

4th file inspected, same issue with error returns as the libahci_platform
code, see drivers/pci/controller/pci-tegra.c: tegra_pcie_parse_dt
also should that function not do a a get on the node since it stores
it in rp->np if things do succeed ?

5th file: drivers/char/rtc.c:

         for_each_node_by_name(ebus_dp, "ebus") {
                 struct device_node *dp;
                 for_each_child_of_node(ebus_dp, dp) {
                         if (of_node_name_eq(dp, "rtc")) {
                                 op = of_find_device_by_node(dp);
                                 if (op) {
                                         rtc_port = op->resource[0].start;
                                         rtc_irq = op->irqs[0];
                                         goto found;
                                 }
                         }
                 }
         }

Also a leak AFAICT.

10th file: drivers/phy/phy-core.c:

                 for_each_child_of_node(phy_provider->children, child)
                         if (child == node)
                                 return phy_provider;

Another leak...

I'm going to stop now because this just aint funny, but I do believe this
nicely illustrates how for_each_child_of_node() is ridiculously hard to use
correct.

Regards,

Hans



> ---
>   drivers/ata/libahci_platform.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 9e9583a6bba9..e742780950de 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -497,6 +497,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>   
>   			if (of_property_read_u32(child, "reg", &port)) {
>   				rc = -EINVAL;
> +				of_node_put(child);
>   				goto err_out;
>   			}
>   
> @@ -514,14 +515,18 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>   			if (port_dev) {
>   				rc = ahci_platform_get_regulator(hpriv, port,
>   								&port_dev->dev);
> -				if (rc == -EPROBE_DEFER)
> +				if (rc == -EPROBE_DEFER) {
> +					of_node_put(child);
>   					goto err_out;
> +				}
>   			}
>   #endif
>   
>   			rc = ahci_platform_get_phy(hpriv, port, dev, child);
> -			if (rc)
> +			if (rc) {
> +				of_node_put(child);
>   				goto err_out;
> +			}
>   
>   			enabled_ports++;
>   		}
> 

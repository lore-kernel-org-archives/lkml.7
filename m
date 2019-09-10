Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807EDC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 05:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AD3207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 05:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390662AbfIJFLb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 01:11:31 -0400
Received: from mxout013.mail.hostpoint.ch ([217.26.49.173]:10178 "EHLO
        mxout013.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390362AbfIJFLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 01:11:31 -0400
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout013.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <lkml.sandro@volery.com>)
        id 1i7YR5-000LCo-Nn; Tue, 10 Sep 2019 07:11:27 +0200
Received: from [213.55.220.251] (helo=[100.66.103.90])
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <lkml.sandro@volery.com>)
        id 1i7YR5-000H1j-FK; Tue, 10 Sep 2019 07:11:27 +0200
X-Authenticated-Sender-Id: lkml.sandro@volery.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Sandro Volery LKML <lkml.sandro@volery.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] Staging: gasket: Use temporaries to reduce line length.
Date:   Tue, 10 Sep 2019 07:11:26 +0200
Message-Id: <73C0743C-6864-4868-829B-D567F12A9463@volery.com>
References: <20190910050557.GA8338@volery>
Cc:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joe@perches.com
In-Reply-To: <20190910050557.GA8338@volery>
To:     Sandro Volery <sandro@volery.com>
X-Mailer: iPhone Mail (17A5831c)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wow... I checked, compiled and still sent the wrong thing again. I'm gonna have to give this up soon if i can't get it right.

Sandro V

> On 10 Sep 2019, at 07:06, Sandro Volery <sandro@volery.com> wrote:
> 
> ﻿Using temporaries for gasket_page_table entries to remove scnprintf()
> statements and reduce line length, as suggested by Joe Perches. Thanks!
> 
> Signed-off-by: Sandro Volery <sandro@volery.com>
> ---
> drivers/staging/gasket/apex_driver.c | 20 +++++++++-----------
> 1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
> index 2973bb920a26..16ac4329d65f 100644
> --- a/drivers/staging/gasket/apex_driver.c
> +++ b/drivers/staging/gasket/apex_driver.c
> @@ -509,6 +509,8 @@ static ssize_t sysfs_show(struct device *device, struct device_attribute *attr,
>    struct gasket_dev *gasket_dev;
>    struct gasket_sysfs_attribute *gasket_attr;
>    enum sysfs_attribute_type type;
> +    struct gasket_page_table *gpt;
> +    uint val;
> 
>    gasket_dev = gasket_sysfs_get_device_data(device);
>    if (!gasket_dev) {
> @@ -524,29 +526,25 @@ static ssize_t sysfs_show(struct device *device, struct device_attribute *attr,
>    }
> 
>    type = (enum sysfs_attribute_type)gasket_attr->data.attr_type;
> +    gpt = gasket_dev->page_table[0];
>    switch (type) {
>    case ATTR_KERNEL_HIB_PAGE_TABLE_SIZE:
> -        ret = scnprintf(buf, PAGE_SIZE, "%u\n",
> -                gasket_page_table_num_entries(
> -                    gasket_dev->page_table[0]));
> +        val = gasket_page_table_num_simple_entries(gpt);
>        break;
>    case ATTR_KERNEL_HIB_SIMPLE_PAGE_TABLE_SIZE:
> -        ret = scnprintf(buf, PAGE_SIZE, "%u\n",
> -                gasket_page_table_num_simple_entries(
> -                    gasket_dev->page_table[0]));
> +        val = gasket_page_table_num_simple_entries(gpt);
>        break;
>    case ATTR_KERNEL_HIB_NUM_ACTIVE_PAGES:
> -        ret = scnprintf(buf, PAGE_SIZE, "%u\n",
> -                gasket_page_table_num_active_pages(
> -                    gasket_dev->page_table[0]));
> +        val = gasket_page_table_num_active_pages(gpt);
>        break;
>    default:
>        dev_dbg(gasket_dev->dev, "Unknown attribute: %s\n",
>            attr->attr.name);
>        ret = 0;
> -        break;
> +        goto exit;
>    }
> -
> +    ret = scnprintf(buf, PAGE_SIZE, "%u\n", val);
> +exit:
>    gasket_sysfs_put_attr(device, gasket_attr);
>    gasket_sysfs_put_device_data(device, gasket_dev);
>    return ret;
> -- 
> 2.23.0
> 


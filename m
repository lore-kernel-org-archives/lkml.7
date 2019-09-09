Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85282C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A275218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfIIWap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:30:45 -0400
Received: from smtprelay0138.hostedemail.com ([216.40.44.138]:33530 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726197AbfIIWap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:30:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 93C21180A6325;
        Mon,  9 Sep 2019 22:30:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brush24_2342836b7ea35
X-Filterd-Recvd-Size: 2792
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Sep 2019 22:30:42 +0000 (UTC)
Message-ID: <348e946eb5e90c1af3971fd50b5678668cc1a3d3.camel@perches.com>
Subject: Re: [PATCH] Staging: gasket: Use temporaries to reduce line length.
From:   Joe Perches <joe@perches.com>
To:     Sandro Volery <sandro@volery.com>, rspringer@google.com,
        toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 09 Sep 2019 15:30:41 -0700
In-Reply-To: <20190909202820.GA5060@volery>
References: <20190909202820.GA5060@volery>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-09 at 22:28 +0200, Sandro Volery wrote:
> Using temporaries for gasket_page_table entries to remove scnprintf()
> statements and reduce line length, as suggested by Joe Perches. Thanks!

nak.  Slow down.  You broke the code.

Please be _way_ more careful and verify for yourself
the code you submit _before_ you submit it.

compile/test/verify, twice if necessary.

You also should have cc'd me on this patch.

> diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
[]
> @@ -524,29 +526,25 @@ static ssize_t sysfs_show(struct device *device, struct device_attribute *attr,
>  	}
>  
>  	type = (enum sysfs_attribute_type)gasket_attr->data.attr_type;
> +	gpt = gasket_dev->page_table[0];
>  	switch (type) {
>  	case ATTR_KERNEL_HIB_PAGE_TABLE_SIZE:
> -		ret = scnprintf(buf, PAGE_SIZE, "%u\n",
> -				gasket_page_table_num_entries(
> -					gasket_dev->page_table[0]));
> +		val = gasket_page_table_num_simple_entries(gpt);

You likely duplicated this line via copy/paste.
This should be:
		val = gasket_page_table_num_entries(gpt);

>  		break;
>  	case ATTR_KERNEL_HIB_SIMPLE_PAGE_TABLE_SIZE:
> -		ret = scnprintf(buf, PAGE_SIZE, "%u\n",
> -				gasket_page_table_num_simple_entries(
> -					gasket_dev->page_table[0]));
> +		val = gasket_page_table_num_simple_entries(gpt);

 		break;
>  	case ATTR_KERNEL_HIB_NUM_ACTIVE_PAGES:
> -		ret = scnprintf(buf, PAGE_SIZE, "%u\n",
> -				gasket_page_table_num_active_pages(
> -					gasket_dev->page_table[0]));
> +		val = gasket_page_table_num_active_pages(gpt);
>  		break;
>  	default:
>  		dev_dbg(gasket_dev->dev, "Unknown attribute: %s\n",
>  			attr->attr.name);
>  		ret = 0;
> -		break;
> +		goto exit;
>  	}
> -
> +	ret = scnprintf(buf, PAGE_SIZE, "%u\n", val);
> +exit:
>  	gasket_sysfs_put_attr(device, gasket_attr);
>  	gasket_sysfs_put_device_data(device, gasket_dev);
>  	return ret;


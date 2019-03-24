Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1B9C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5B02147C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wc2Kk04/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfCXRVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:21:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60142 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfCXRVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pPyOl43Y8Zn1ztvpvRdZgkPMcL/uVfo6fvGYSDUWOEo=; b=wc2Kk04/BW3f5O46RA61cTSwbW
        ScP1Yt9wHwXzRETyArcZq9u1osuwheL0AHjMKhJbhYjlAFvekc9Pv9odCw4qTuTOisjUVuEDiWBdX
        UFMQoaO/gimxqZlWPWetKVfh/0AaS7fMDLNvB0vspRJDJ/n2xSGOQ9dBgcJQvxxt9sCZYGukJBqET
        KRLS31IxaPAG6XgmJZpudg7MZMglJ1sj8JsKz4Z2++Clvf0yf2jJ1VG3qG9Rz8+GozClbEjm7PNdZ
        aG8w31oEn1b2NESTOeFCt16sfKDgvnb3feC8PdIVbcURAD1X9S4GzCEhX242wv95Jy9rxSxdJOWpS
        1d9w3agw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h86oA-0003zF-Lm; Sun, 24 Mar 2019 17:21:19 +0000
Subject: Re: [PATCH 2/5] device property: Add fwnode_get_name for returning
 the name of a node
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-3-sakari.ailus@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7b29c2ef-c74b-e94d-6add-88c5db34dce7@infradead.org>
Date:   Sun, 24 Mar 2019 10:21:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322152930.16642-3-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/22/19 8:29 AM, Sakari Ailus wrote:
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 3f5ff6b23ae4..7ee3786bcde3 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -533,6 +533,18 @@ int device_add_properties(struct device *dev,
>  EXPORT_SYMBOL_GPL(device_add_properties);
>  
>  /**
> + * fwnode_get_name - Return the name of a node
> + *
> + * @fwnode - The firmware node

s/-/:/

> + *
> + * Returns a pointer to the node name.
> + */
> +const char *fwnode_get_name(const struct fwnode_handle *fwnode)
> +{
> +	return fwnode_call_ptr_op(fwnode, get_name);
> +}
> +
> +/**
>   * fwnode_get_parent - Return parent firwmare node
>   * @fwnode: Firmware whose parent is retrieved
>   *


-- 
~Randy

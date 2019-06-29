Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3BBC5B57B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 00:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9971021743
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 00:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfF2X7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 19:59:21 -0400
Received: from smtprelay0112.hostedemail.com ([216.40.44.112]:38532 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726952AbfF2X7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 19:59:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 5D94D182CF668;
        Sat, 29 Jun 2019 23:59:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: level91_6e35fe890bd1c
X-Filterd-Recvd-Size: 1915
Received: from XPS-9350 (unknown [172.58.27.65])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sat, 29 Jun 2019 23:59:17 +0000 (UTC)
Message-ID: <dbe411be6aa32a32aafc5a5b77f08e8507b45da3.camel@perches.com>
Subject: Re: [PATCH] Staging: most: fix coding style issues
From:   Joe Perches <joe@perches.com>
To:     Gabriel Beauchamp <beauchampgabriel@gmail.com>,
        gregkh@linuxfoundation.org, christian.gromm@microchip.com,
        colin.king@canonical.com, gustavo@embeddedor.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sat, 29 Jun 2019 16:58:46 -0700
In-Reply-To: <20190629234427.20746-1-beauchampgabriel@gmail.com>
References: <20190629234427.20746-1-beauchampgabriel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-06-29 at 16:44 -0700, Gabriel Beauchamp wrote:
> This is a patch for the core.[ch] files that fixes up warnings
> found with the checkpatch.pl tool.
[]
> diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
[]
> @@ -303,7 +303,8 @@ static ssize_t set_datatype_show(struct device *dev,
>  
>  	for (i = 0; i < ARRAY_SIZE(ch_data_type); i++) {
>  		if (c->cfg.data_type & ch_data_type[i].most_ch_data_type)
> -			return snprintf(buf, PAGE_SIZE, "%s", ch_data_type[i].name);
> +			return snprintf(buf, PAGE_SIZE,
> +					"%s", ch_data_type[i].name);
>  	}
>  	return snprintf(buf, PAGE_SIZE, "unconfigured\n");
>  }

Assuming the newline difference is unintentional,
(if not change "unconfigured" to "unconfigured\n")

How about using a single sprintf and reducing object code size too?

	char *type = "unconfigured";

	for (...)
		if (c-> etc...) {
			type = ch_data_type[i].name;
			break;
		}
	}

	return snprintf(buf, PAGE_SIZE, "%s", type);




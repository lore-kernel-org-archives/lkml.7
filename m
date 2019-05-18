Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37F1C04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 02:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A70B21773
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 02:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfERC6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 22:58:23 -0400
Received: from smtprelay0128.hostedemail.com ([216.40.44.128]:32949 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727367AbfERC6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 22:58:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id DEC82100E806B;
        Sat, 18 May 2019 02:58:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: knot77_2bcab207af217
X-Filterd-Recvd-Size: 1751
Received: from XPS-9350 (cpe-23-242-70-174.socal.res.rr.com [23.242.70.174])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 18 May 2019 02:58:20 +0000 (UTC)
Message-ID: <9e30f140e314f03057a2941f4d091d8965391c17.camel@perches.com>
Subject: Re: [PATCH 4/5] staging: kpc2000: kpc_i2c: use %s with __func__
 identifier in log messages
From:   Joe Perches <joe@perches.com>
To:     Geordan Neukum <gneukum1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Fri, 17 May 2019 19:58:19 -0700
In-Reply-To: <ffd66b415e67f6b03483a6ee57b7b3dc0bab388f.1558146549.git.gneukum1@gmail.com>
References: <cover.1558146549.git.gneukum1@gmail.com>
         <ffd66b415e67f6b03483a6ee57b7b3dc0bab388f.1558146549.git.gneukum1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-05-18 at 02:29 +0000, Geordan Neukum wrote:
> Throughout i2c_driver.c, there are instances where the log strings
> contain the function's name hardcoded into the string. Instead, use the
> printk conversion specifier '%s' with the __func__ preprocessor
> identifier to more maintainably print the function's name.

Might as well remove all of these and use the
builtin ftrace function tracing mechanism instead.

> diff --git a/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c b/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
[]
> @@ -142,7 +142,7 @@ static int i801_check_pre(struct i2c_device *priv)
>  {
>  	int status;
>  
> -	dev_dbg(&priv->adapter.dev, "i801_check_pre\n");
> +	dev_dbg(&priv->adapter.dev, "%s\n", __func__);

etc...


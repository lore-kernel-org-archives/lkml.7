Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F117C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA3B21479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfEJJOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 05:14:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44587 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbfEJJOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 05:14:34 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hP1bs-0004X1-DN; Fri, 10 May 2019 11:14:32 +0200
Message-ID: <1557479671.7859.2.camel@pengutronix.de>
Subject: Re: [PATCH] reset: fix potential null pointer dereference on
 pointer dev
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Colin King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 10 May 2019 11:14:31 +0200
In-Reply-To: <20190509160036.19433-1-colin.king@canonical.com>
References: <20190509160036.19433-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

[added Bartosz to Cc:]

On Thu, 2019-05-09 at 17:00 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer dev is being dereferenced when passed to the inlined
> functon dev_name, however, dev is later being null checked.
> Thus there is a potential null pointer dereference on a null
> dev. Fix this by performing the null check on dev before
> dereferencing it.
> 
> Addresses-Coverity: ("Dereference before null check")
> Fixes: 6691dffab0ab ("reset: add support for non-DT systems")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/reset/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 81ea77cba123..83f1a1d5ee67 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -691,12 +691,13 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
>  {
>  	const struct reset_control_lookup *lookup;
>  	struct reset_controller_dev *rcdev;
> -	const char *dev_id = dev_name(dev);
> +	const char *dev_id;
>  	struct reset_control *rstc = NULL;
>  
>  	if (!dev)
>  		return ERR_PTR(-EINVAL);

Thank you for the patch. I think this check should be removed instead,
though, as __reset_control_get_from_lookup is only ever called from
__reset_control_get, right after checking dev->of_node. So dev can not
be NULL here.

regards
Philipp

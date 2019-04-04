Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C8FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D864220651
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfDDUJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:09:10 -0400
Received: from gofer.mess.org ([88.97.38.141]:44553 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbfDDUJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:09:10 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 564FE60169; Thu,  4 Apr 2019 21:09:08 +0100 (BST)
Date:   Thu, 4 Apr 2019 21:09:08 +0100
From:   Sean Young <sean@mess.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Olli Salonen <olli.salonen@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: tuners: fix a missing check for regmap_write_bits
Message-ID: <20190404200907.3fet563fmagpdh6w@gofer.mess.org>
References: <20190324232110.2804-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324232110.2804-1-kjlu@umn.edu>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 06:21:10PM -0500, Kangjie Lu wrote:
> regmap_write_bits could fail and thus deserves a check.
> 
> The fix returns its error code upstream in case it fails.

Has this been tested on real hardware?

Sean

> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/media/tuners/tda18250.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/tuners/tda18250.c b/drivers/media/tuners/tda18250.c
> index 20d10ef45ab6..36ede1b02d23 100644
> --- a/drivers/media/tuners/tda18250.c
> +++ b/drivers/media/tuners/tda18250.c
> @@ -703,6 +703,8 @@ static int tda18250_set_params(struct dvb_frontend *fe)
>  
>  	/* charge pump */
>  	ret = regmap_write_bits(dev->regmap, R46_CPUMP, 0x07, buf[2]);
> +	if (ret)
> +		goto err;
>  
>  	return 0;
>  err:
> -- 
> 2.17.1

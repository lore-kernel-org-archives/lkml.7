Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A7BC4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 13:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6734E207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 13:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGGQ/n9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfCINmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 08:42:37 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44284 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfCINmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 08:42:37 -0500
Received: by mail-lf1-f66.google.com with SMTP id u9so317391lfe.11;
        Sat, 09 Mar 2019 05:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oKD3oXM7E538cMAEIk9ppvfbsy+jgNinUkCJBtcouy8=;
        b=VGGQ/n9iiSneCxhRcuZAfxYmhflOWSoyP486lSK8N/ZxYuTdivrGnIFEb4WOuX/AXe
         XOzYrtTb6Jb52R4sjqEooPlGKdB+mFhtqIr3Wx0LG0dDod+HZ8Y7K5BPPfd4qFCAtLAp
         tO2NQFC9vEbUYnqwe1GjGyNBMl0eGZvMayqgwpmYBcODMSn0xdsPXLGCM3XHMphen5Wr
         w/AJbahfe8lA6Ep6Er0738le6wc93za1cXfvKaJKpcgG2FoatUexy9D9euNzGIrICSPn
         m+zEk5V2l5jpv/4nXJ1Uxc3F8bggyUNr9XVPOVly2AyJsbITAsATLgCe2RqNKAU11Jus
         G1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oKD3oXM7E538cMAEIk9ppvfbsy+jgNinUkCJBtcouy8=;
        b=b48nj+L6Rdm0djFgZGFRKwQ+2U+ceUxRiHZNMAm33IXq87ilFa3NCsl73ua8pmhMbk
         MP5RMPIOwRDViygTSM5vWietTeLbr6F/6SgfveHwtl1niChRRSA4ARaon2fdSOTf9xH6
         zeTXitnfs9cKYsDrf9YWF4D8rvBzktzrP2EnvumfiREjBbIYLC8rzElyvEV8gMuQQ6WI
         L+JUlv1JMP5ZQfqax2qOBPmN/i9GTEj2XrliMYUWrkthoDAP3wsR5K4EBkXomTlYutjO
         9UEDqxyI57CEFJnFzm1cIPpDEZlOUQ6T/ZGhd8o/ocpb1qke3608z/1VHALRLqa5IDBF
         eAAQ==
X-Gm-Message-State: APjAAAUG+GqjbJrzqw3jROO8gJoiwkOzzJPGPEFfpoNZNZXmMUs2K78c
        Dcvji683REiLumwdojErEUE=
X-Google-Smtp-Source: APXvYqwDI7mUUyA7wtjaxOMANL2jZgaXi3a/mbvPymesyctiQEFPZMPTGfUQv4dUFNaAqn4KfHzY6g==
X-Received: by 2002:ac2:5386:: with SMTP id g6mr4640585lfh.88.1552138955060;
        Sat, 09 Mar 2019 05:42:35 -0800 (PST)
Received: from localhost (89-64-59-159.dynamic.chello.pl. [89.64.59.159])
        by smtp.gmail.com with ESMTPSA id f1sm123590lfc.48.2019.03.09.05.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Mar 2019 05:42:34 -0800 (PST)
Date:   Sat, 9 Mar 2019 14:42:09 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: hmc: fix a potential NULL pointer dereference
Message-ID: <20190309134208.GA7820@arch>
References: <20190309051533.14309-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190309051533.14309-1-kjlu@umn.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 11:15:32PM -0600, Kangjie Lu wrote:
> devm_regmap_init_i2c may fail and return NULL. The fix returns
> the error when it fails.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/iio/magnetometer/hmc5843_i2c.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
> index 3de7f4426ac4..c0cd0823f8d5 100644
> --- a/drivers/iio/magnetometer/hmc5843_i2c.c
> +++ b/drivers/iio/magnetometer/hmc5843_i2c.c
> @@ -58,8 +58,13 @@ static const struct regmap_config hmc5843_i2c_regmap_config = {
>  static int hmc5843_i2c_probe(struct i2c_client *cli,
>  			     const struct i2c_device_id *id)
>  {
> +	struct regmap *devm_regmap = devm_regmap_init_i2c(cli,
> +			&hmc5843_i2c_regmap_config);
> +	if (IS_ERR(devm_regmap))
> +		return PTR_ERR(devm_regmap);

This fixes only one part of the problem leaving identical spi issue
behind. I guess this check should be part of *common_probe().

> +
>  	return hmc5843_common_probe(&cli->dev,
> -			devm_regmap_init_i2c(cli, &hmc5843_i2c_regmap_config),
> +			devm_regmap,
>  			id->driver_data, id->name);
>  }
>
> --
> 2.17.1
>

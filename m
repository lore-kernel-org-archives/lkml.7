Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB39CA9EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 04:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044AA222C5
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 04:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfJSEZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 00:25:06 -0400
Received: from smtprelay0080.hostedemail.com ([216.40.44.80]:44528 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725385AbfJSEZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 00:25:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id D5C94180144BE;
        Sat, 19 Oct 2019 04:25:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tank37_ed58174bf857
X-Filterd-Recvd-Size: 2088
Received: from XPS-9350 (cpe-23-242-70-174.socal.res.rr.com [23.242.70.174])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sat, 19 Oct 2019 04:25:01 +0000 (UTC)
Message-ID: <0a5b872c48fb4047982c67d84f90bd075a0a357b.camel@perches.com>
Subject: Re: [PATCH v4 2/2] iio: (bma400) add driver for the BMA400
From:   Joe Perches <joe@perches.com>
To:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Date:   Fri, 18 Oct 2019 21:25:00 -0700
In-Reply-To: <20191018031848.18538-3-dan@dlrobertson.com>
References: <20191018031848.18538-1-dan@dlrobertson.com>
         <20191018031848.18538-3-dan@dlrobertson.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-18 at 03:18 +0000, Dan Robertson wrote:
> Add a IIO driver for the Bosch BMA400 3-axes ultra-low power accelerometer.
> The driver supports reading from the acceleration and temperature
> registers. The driver also supports reading and configuring the output data
> rate, oversampling ratio, and scale.

trivial logging note:

> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
[]
> +static int bma400_get_accel_reg(struct bma400_data *data,
> +				const struct iio_chan_spec *chan,
> +				int *val)
> +{
[]
> +		dev_err(data->dev, "invalid axis channel modifier");

All the logging should use \n terminations

		dev_err(data->dev, "invalid axis channel modifier\n");
[]
> +static int bma400_get_accel_output_data_rate(struct bma400_data *data)
> +{
[]
> +			dev_err(data->dev, "invalid ODR=%x", odr);
should be:
			dev_err(data->dev, "invalid ODR=%x\n", odr);

etc...



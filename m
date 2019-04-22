Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1071BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABAF20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555930459;
	bh=/QAiwKP4+G9FTK0UEiCN1XCLpPE/1N5adB8FE/sKgMQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VAyobmOn+XWbodX2Db+R0Dm8wZ2hq2PM6YipnUCNtxRGz9pNBYvGMrO0TRzLNWbmD
	 H4D+H26CcrQRqtI3exs411mMVEFUkZhPZOmtIdQZp8zdISrhVdx5Vc0PU6aXBD4r6d
	 nPpHp8uB1hi3pbyndiH9DLvldaCgmknrzP6fpLTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfDVKyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfDVKyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 06:54:18 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0C55204EC;
        Mon, 22 Apr 2019 10:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555930457;
        bh=/QAiwKP4+G9FTK0UEiCN1XCLpPE/1N5adB8FE/sKgMQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fbDXGIlhviMBGttRUbjRIg2o37FSNPKbauNxQLnncERL+3WKhgqk0c/++mCIbdrll
         V8m6jXa6JQzs7dg0pCui+0jqKeY9THIoFiWGYbAfSq4fB/me3jNXRLOeGmCmrKUW4g
         LTXTWr4YRkGw8ssY0Ys3h2Q4G977s0ywfVk/PHdg=
Date:   Mon, 22 Apr 2019 11:54:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5: Fix of-based module
 autoloading
Message-ID: <20190422115412.4e2f717a@archlinux>
In-Reply-To: <20190416234927.8888-1-bjorn.andersson@linaro.org>
References: <20190416234927.8888-1-bjorn.andersson@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 16:49:27 -0700
Bjorn Andersson <bjorn.andersson@linaro.org> wrote:

> The of_device_id table needs to be registered as module alias in order
> for automatic module loading to pick the kernel module based on the
> DeviceTree compatible. So add MODULE_DEVICE_TABLE() to make this happen.
> 
> Fixes: e13d757279bb ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
I'll take this via the next merge window because it's been there a little
while and in isn't a regression.  Obviously we are very late in this
cycle so I'd rather not do another fixes pull request.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 6a866cc187f7..21fdcde77883 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -664,6 +664,7 @@ static const struct of_device_id adc5_match_table[] = {
>  	},
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, adc5_match_table);
>  
>  static int adc5_get_dt_data(struct adc5_chip *adc, struct device_node *node)
>  {


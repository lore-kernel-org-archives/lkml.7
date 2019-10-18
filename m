Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBD4CA9EA3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC15A222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kmRTjgAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392915AbfJRKk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:40:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44104 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbfJRKk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:40:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9IAT9xc116999;
        Fri, 18 Oct 2019 10:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=b5MDK6LGdR/GvXJdv3nsIYA0QaZR8UpEYG+YaAb1gEQ=;
 b=kmRTjgAm/M89Z8JJfa9qP6DMYq0mcY9WlnvYpBrBZ+6CSxiaBOrMOf/w0aZt8Ccnty8a
 OShGbWInr9JnPEz1//uQLaXMFJ7rtqBBZSK3WIzQaCksehn9Avn/tLGIDE7GoGx+0w+O
 MqVMqOKMz9rpmhvsNN5f937eHzAfy468GTu+LH58iFSbBcO4EK0xSv2otw5GgauuUrWG
 8s/Sivy//zNLvy5CTYGD5HryBjS8gLOsYC++gt0wjJSL58cU8hVXgGDcA0jVhaZ2iG63
 f2UcPUTK1CPPoY6keZ7Ergv2uuykqsp6qwp+sH1TeiKo+qYEXffRHZUa5nR+eDVWdo5P WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vq0q431ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 10:39:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9IATY33094868;
        Fri, 18 Oct 2019 10:39:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vq0ew2y2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 10:39:24 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9IAdK63006116;
        Fri, 18 Oct 2019 10:39:21 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Oct 2019 10:39:20 +0000
Date:   Fri, 18 Oct 2019 13:39:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sanju R Mehta <sanju.mehta@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] ASoC: amd: ACP powergating should be done by
 controller
Message-ID: <20191018103910.GL21344@kadam>
References: <1571432760-3008-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1571432760-3008-6-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571432760-3008-6-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910180102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910180102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 02:35:44AM +0530, Ravulapati Vishnu vardhan rao wrote:
> diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
> index 7f435b3..b74ecf6 100644
> --- a/sound/soc/amd/raven/pci-acp3x.c
> +++ b/sound/soc/amd/raven/pci-acp3x.c
> @@ -19,11 +19,140 @@ struct acp3x_dev_data {
>  	struct platform_device *pdev[ACP3x_DEVS];
>  };
>  
> +static int acp3x_power_on(void __iomem *acp3x_base)
> +{
> +	u32 val;
> +	u32 timeout = 0;
> +	int ret = 0;
> +
> +	val = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
> +	if (val) {

Just flip this around.

	if (val == 0)
		return 0;

> +		if (!((val & ACP_PGFSM_STATUS_MASK) ==
> +				ACP_POWER_ON_IN_PROGRESS))
> +			rv_writel(ACP_PGFSM_CNTL_POWER_ON_MASK,
> +				acp3x_base + mmACP_PGFSM_CONTROL);
> +		while (true) {

while (++timeout < 500) {


> +			val  = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
> +			if (!val)
> +				break;

return 0;

> +			udelay(1);
> +			if (timeout > 500) {
> +				pr_err("ACP is Not Powered ON\n");
> +				ret = -ETIMEDOUT;
> +				break;
> +			}
> +			timeout++;
> +		}
> +		if (ret) {
> +			pr_err("ACP is not powered on status:%d\n", ret);

Just one error message is enough.

	pr_err("ACP is Not Powered ON\n");
	return -ETIMEDOUT;


> +			return ret;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int acp3x_power_off(void __iomem *acp3x_base)
> +{
> +	u32 val;
> +	u32 timeout = 0;
> +	int ret = 0;
> +
> +	val = rv_readl(acp3x_base + mmACP_PGFSM_CONTROL);

val is not used.  We want to turn on set but not used warnings
eventually.

> +	rv_writel(ACP_PGFSM_CNTL_POWER_OFF_MASK,
> +			acp3x_base + mmACP_PGFSM_CONTROL);
> +	while (true) {
> +		val  = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
> +		if ((val & ACP_PGFSM_STATUS_MASK) == ACP_POWERED_OFF)
> +			break;
> +		udelay(1);
> +		if (timeout > 500) {
> +			pr_err("ACP is Not Powered OFF\n");
> +			ret = -ETIMEDOUT;
> +			break;
> +		}
> +		timeout++;
> +	}
> +	if (ret)
> +		pr_err("ACP is not powered off status:%d\n", ret);
> +	return ret;

Same as above.

> +}
> +
> +
> +static int acp3x_reset(void __iomem *acp3x_base)
> +{
> +	u32 val, timeout;
> +
> +	rv_writel(1, acp3x_base + mmACP_SOFT_RESET);
> +	timeout = 0;
> +	while (true) {

	while (++timeout < 100) {

> +		val = rv_readl(acp3x_base + mmACP_SOFT_RESET);
> +		if ((val & ACP3x_SOFT_RESET__SoftResetAudDone_MASK) ||
> +							timeout > 100) {
> +			if (val & ACP3x_SOFT_RESET__SoftResetAudDone_MASK)
> +				break;


Duplicated needlessly.

> +			return -ENODEV;
> +		}
> +		timeout++;
> +		cpu_relax();
> +	}


	if (timeout == 100)
		return -ENODEV;

> +	rv_writel(0, acp3x_base + mmACP_SOFT_RESET);
> +	timeout = 0;
> +	while (true) {
> +		val = rv_readl(acp3x_base + mmACP_SOFT_RESET);

Split the "if (!val) break;" into it's own condition instead of part of
the ||.

> +		if (!val || timeout > 100) {
> +			if (!val)
> +				break;
> +			return -ENODEV;
> +		}
> +		timeout++;
> +		cpu_relax();
> +	}
> +	return 0;
> +}
> +
> +static int acp3x_init(void __iomem *acp3x_base)
> +{
> +	int ret;
> +
> +	/* power on */
> +	ret = acp3x_power_on(acp3x_base);
> +	if (ret) {
> +		pr_err("ACP3x power on failed\n");
> +		return ret;
> +	}
> +	/* Reset */
> +	ret = acp3x_reset(acp3x_base);
> +	if (ret) {
> +		pr_err("ACP3x reset failed\n");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int acp3x_deinit(void __iomem *acp3x_base)
> +{
> +	int ret;
> +
> +	/* Reset */
> +	ret = acp3x_reset(acp3x_base);
> +	if (ret) {
> +		pr_err("ACP3x reset failed\n");
> +		return ret;
> +	}
> +	/* power off */
> +	ret = acp3x_power_off(acp3x_base);
> +	if (ret) {
> +		pr_err("ACP3x power off failed\n");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
>  static int snd_acp3x_probe(struct pci_dev *pci,
>  			   const struct pci_device_id *pci_id)
>  {
>  	int ret;
> -	u32 addr, val, i;
> +	u32 addr, val, i, status;
>  	struct acp3x_dev_data *adata;
>  	struct platform_device_info pdevinfo[ACP3x_DEVS];
>  	unsigned int irqflags;
> @@ -63,6 +192,10 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>  	}
>  	pci_set_master(pci);
>  	pci_set_drvdata(pci, adata);
> +	status = acp3x_init(adata->acp3x_base);
> +	if (status)
> +		return -ENODEV;

Why do we need both "status" and "ret".  Preserve the error code?

> +
>  
>  	val = rv_readl(adata->acp3x_base + mmACP_I2S_PIN_CONFIG);
>  	switch (val) {
> @@ -132,6 +265,11 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>  	return 0;
>  
>  unmap_mmio:
> +	status = acp3x_deinit(adata->acp3x_base);
> +	if (status)
> +		dev_err(&pci->dev, "ACP de-init failed\n");
> +	else
> +		dev_info(&pci->dev, "ACP de-initialized\n");
>  	for (i = 0 ; i < ACP3x_DEVS ; i++)
>  		platform_device_unregister(adata->pdev[i]);
>  	kfree(adata->res);
> @@ -153,6 +291,11 @@ static void snd_acp3x_remove(struct pci_dev *pci)
>  		for (i = 0 ; i <  ACP3x_DEVS ; i++)
>  			platform_device_unregister(adata->pdev[i]);
>  	}
> +	i = acp3x_deinit(adata->acp3x_base);

Please don't re-use "i" like this.  Declare "ret" or "status" or
something.

> +	if (i)
> +		dev_err(&pci->dev, "ACP de-init failed\n");
> +	else
> +		dev_info(&pci->dev, "ACP de-initialized\n");
>  	iounmap(adata->acp3x_base);
>  
>  	pci_disable_msi(pci);

regards,
dan carpenter


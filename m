Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21830C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB421207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388183AbfJDJkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 05:40:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3243 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbfJDJkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 05:40:08 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DEEE194FBEF2EFAB3561;
        Fri,  4 Oct 2019 17:40:06 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 4 Oct 2019
 17:40:01 +0800
Subject: Re: [PATCH v2 10/22] mtd: spi-nor: Rework write_sr()
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "jonas@norrbonn.se" <jonas@norrbonn.se>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
 <20190924074533.6618-11-tudor.ambarus@microchip.com>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vz@mleia.com" <vz@mleia.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <83d62334-bd1c-20b7-3c58-225392c819f8@huawei.com>
Date:   Fri, 4 Oct 2019 10:39:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190924074533.6618-11-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2019 08:46, Tudor.Ambarus@microchip.com wrote:
> +}
> +
> +/**
> + * spi_nor_write_sr() - Write the Status Register.
> + * @nor:	pointer to 'struct spi_nor'.
> + * @sr:		buffer to write to the Status Register.
> + * @len:	number of bytes to write to the Status Register.
> + *
> + * Return: 0 on success, -errno otherwise.
>   */
> -static int write_sr(struct spi_nor *nor, u8 val)
> +static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
>  {
> -	nor->bouncebuf[0] = val;
> +	int ret;
> +
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
> +

Hi Tudor,

>  	if (nor->spimem) {
>  		struct spi_mem_op op =
>  			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
>  				   SPI_MEM_OP_NO_ADDR,
>  				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));

This be SPI_MEM_OP_DATA_OUT() in the current mainline code also, right?

I'm testing my under development driver on top of v5.4-rc1, and 
flash_lock -u is broken.

Cheers,
John

> +				   SPI_MEM_OP_DATA_OUT(len, sr, 1));
>
> -		return spi_mem_exec_op(nor->spimem, &op);
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +	} else {
> +		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
> +						     sr, len);
>  	}
>
> -	return nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
> -					      nor->bouncebuf, 1);
> +	if (ret) {
> +		dev_err(nor->dev, "error while writing Status Register\n");
> +		return ret;
> +	}
> +
> +	ret = spi_nor_wait_till_ready(nor);
> +
> +	return ret;
>  }
>
>  static struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
> @@ -741,161 +914,6 @@ static int winbond_set_4byte(struct spi_nor *nor, bool enable)
>  	return ret;
>  }



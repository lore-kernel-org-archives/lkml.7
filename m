Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA97C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F80A216C8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ttn9zXgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfGZLc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:32:27 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47841 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfGZLc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:32:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190726113224euoutp0286e37ff39006e4b00d3abeb2a02139af~08bhdbR831408314083euoutp02p
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 11:32:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190726113224euoutp0286e37ff39006e4b00d3abeb2a02139af~08bhdbR831408314083euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564140744;
        bh=3a9StrmoLxBMCfA62EA5ywia7Z262Mo1dxDYKM6yA9Y=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ttn9zXgKXW5G1VX0p2/cG4mTdBpaJahcx95O1ecR2+n9WTBVZ0w4g+ZESHWAtx2ij
         kDUJ58Q8JVZS6IgTh8Zp44erdZbCIJdSH+4iwLRMpkbWuY7OhLFHMfM7dC/Kcyo6hG
         G9xUI9HpHGgGnR2UYiCsyrQD5EYXZBXW76qr5oSw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190726113223eucas1p25be80fa835db8d7082e0576449fdf9b5~08bgt5BuZ1700717007eucas1p2s;
        Fri, 26 Jul 2019 11:32:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id ED.C1.04377.7C4EA3D5; Fri, 26
        Jul 2019 12:32:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190726113223eucas1p287f8f2df03f66658bd492c592fd426e6~08bgB68XN1777617776eucas1p2d;
        Fri, 26 Jul 2019 11:32:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190726113222eusmtrp20a2682aebebcebbe316bf09a2c75cb71~08bfz1fo42686026860eusmtrp2V;
        Fri, 26 Jul 2019 11:32:22 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-1c-5d3ae4c73668
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8E.34.04146.6C4EA3D5; Fri, 26
        Jul 2019 12:32:22 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190726113222eusmtip259fd6f809de77f2426c2f522cb28c5fe~08bfGHCve2293222932eusmtip2g;
        Fri, 26 Jul 2019 11:32:22 +0000 (GMT)
Subject: Re: [PATCH v2] 8250_lpss: check null return when calling
 pci_ioremap_bar
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, emamd001@umn.edu, kjlu@umn.edu,
        smccaman@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <afc360b9-6d05-72a6-4933-2fc0b84a7cf7@samsung.com>
Date:   Fri, 26 Jul 2019 13:32:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190719174848.24216-1-navid.emamdoost@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3bOdo7LI5/T8tXCalSalGYKnczMomjRP10tKrOVB+9TNrXU
        JDPQNVHMpOGYt1ZqUjmG9yBLwUtqFqnFNBWUEsEQVNQwze0o+d/D8/7e73le+GhC0iJ0oSMU
        8ZxSIY+WisRkbetCz762Mb/g/VVGNzY7XStgfz7QCtmHhioRm2+cErDtRd0U+7VRL2K7DNkU
        m91RT7BPZ55RbMNgOxEoljXoflAyU+Ujkayo45ysqfAVJauq7iNlfaXplGza5HqWuir2D+Wi
        IxI5pVfATXG4cfG3IG4K39WOzhJpaJbRIBsasC/UmBZIDRLTElyBYOGzWWgZSPAMgpEmZ34w
        jSCjO51a2yidbSV5qByB5rkPD00iGM0yWiEHfAFMar31JUfsBSUjowILROBMAQy+G7FCIuwH
        jzMrkUUzOAB61L+smsS7YKhDb03YhK/AcKtRyDP20FEwZvVt8FEoGDCILJrATmAeKxbwehvU
        TeoJSxjgfgpalodXa5+AoYoCgtcOMNFWvepvheWGYgG/8AbBX/X46nYdgvInSyKeOgwtbV9W
        atArEXugqtGLt49BRet70mIDtoPvk/Z8CTvIq9USvM2AOkPC07vBWGYUrcVqGl4SuUiqW3ea
        bt05unXn6P7nliCyEjlxCaqYME51QMHd8VTJY1QJijDP27ExJrTytTqX2mbqUePirWaEaSS1
        ZdwrDwVLhPJEVVJMMwKakDoyNfUrFhMqT0rmlLEhyoRoTtWMttCk1IlJ2TByTYLD5PFcFMfF
        ccq1qYC2cUlD1YaE8IG0cj/99eS9ktyc1wcHSk4qb1zx1vxxnqvZzPTSnTmLH8LnUmX+2Df4
        /Oyp2vnA+/GGS0Hb85eDLscxn7zdCiIzxo+cdncJMSm+9WRW153vMt9TM/5lGwsdsoRpHnFv
        L85PnHFN2enT/7F/p23vZPdxc0lk/tWoHdq8VPcXUlIVLvf2IJQq+T/INZGVVgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7rHnljFGkz7bmLR2zSdyeJZ43RW
        i+bF69kspmz4wGRxYt5ZdovLu+awWZxZ3Mtu0XtyB7PFtC+L2C123jnB7MDlsXPWXXaPTas6
        2TzmnQz02D93DbvH+i1XWTyuLmxi9/i8SS6APUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jE
        Us/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY8Ofd0wFHwQqpj/+ytzA+JW3i5GTQ0LARGLh12Ms
        XYxcHEICSxklrm89ytbFyAGUkJE4vr4MokZY4s+1LjaImteMEov33GYDSQgLBEts6pjDCmKL
        COhLLHjwmAnEZhZoZ5LofGYPYgsJZEv8bfgBVsMmYCUxsX0VI4jNK2Ancb7jOZjNIqAqce/k
        HBYQW1QgQuLM+xUsEDWCEidnPgGzOQXsJWbeXswGMV9d4s+8S8wQtrjErSfzofbKS2x/O4d5
        AqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiBMbrt2M/NOxgv
        bQw+xCjAwajEw3thuWWsEGtiWXFl7iFGCQ5mJRHerTuAQrwpiZVVqUX58UWlOanFhxhNgZ6b
        yCwlmpwPTB95JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYUyOL
        v8rv+P7mqubDm+Icqy9PN49/dGr+uh6WhvantovE2NZyhnHxT0o6zZ2oI+E9w1/xgUrHzWVr
        mSO/3FzxsyPVyTy663HIqzf1FmXfp+8vzrcLr2DbPzva3rhp6l3BzQoL9J63efPutpsxOarh
        aLh67xIz7qqp01+vY3ZtaTXoTz2ZHiatxFKckWioxVxUnAgAMexjsOcCAAA=
X-CMS-MailID: 20190726113223eucas1p287f8f2df03f66658bd492c592fd426e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190726113223eucas1p287f8f2df03f66658bd492c592fd426e6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190726113223eucas1p287f8f2df03f66658bd492c592fd426e6
References: <20190719151519.GO9224@smile.fi.intel.com>
        <20190719174848.24216-1-navid.emamdoost@gmail.com>
        <CGME20190726113223eucas1p287f8f2df03f66658bd492c592fd426e6@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 7/19/19 7:48 PM, Navid Emamdoost wrote:
> pci_ioremap_bar may return null. This is eventually de-referenced at 
> drivers/dma/dw/core.c:1154 and drivers/dma/dw/core.c:1168. A null check 
> is needed to prevent null de-reference. I am adding the check and in case
>  of failure. Thanks to Andy Shevchenko for the hint on the necessity of 
> pci_iounmap when exiting.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 53ca9ba6ab4b..d07e431110d9 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -169,10 +169,12 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>  	struct pci_dev *pdev = to_pci_dev(port->dev);
>  	int ret;
>  
> +	chip->pdata = &qrk_serial_dma_pdata;
>  	chip->dev = &pdev->dev;
>  	chip->irq = pci_irq_vector(pdev, 0);
>  	chip->regs = pci_ioremap_bar(pdev, 1);
> -	chip->pdata = &qrk_serial_dma_pdata;
> +	if (!chip->regs)
> +		return;
>  
>  	/* Falling back to PIO mode if DMA probing fails */
>  	ret = dw_dma_probe(chip);

pci_iounmap() should also be called on dw_dma_probe() failure (in such
case param->dma_dev is NULL so pci_iounmap() in qrk_serial_exit_dma()
won't be called during exit).

> @@ -195,11 +197,15 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>  pci_iounmap
>  static void qrk_serial_exit_dma(struct lpss8250 *lpss)
>  {
> +	struct dw_dma_chip *chip = &lpss->dma_chip;
>  	struct dw_dma_slave *param = &lpss->dma_param;
>  
>  	if (!param->dma_dev)
>  		return;
> -	dw_dma_remove(&lpss->dma_chip);
> +
> +	dw_dma_remove(chip);
> +
> +	pci_iounmap(to_pci_dev(chip->dev), chip->regs);
>  }
>  #else	/* CONFIG_SERIAL_8250_DMA */
>  static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

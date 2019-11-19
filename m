Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6681C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DFB222D1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kwYmH3N4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfKSOpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:45:18 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50916 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfKSOpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:45:18 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAJEitb1007682;
        Tue, 19 Nov 2019 08:44:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574174695;
        bh=Xb17bFFvyyPqVZH3JQh33Q09iDlqcgXHhX0DKwO4lwQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kwYmH3N4LCqQEjuhK3qaWi51suMy+3umddzaTsp68YsDKKJpN9AxFnguws3i5Ylik
         0QP08Mym8xE93voINGsQByrWfLgeOhHk4hGcMMCRFi+VVIgEbCrwxqxBN2MSQ4ZkcY
         i+Y1p1VfHx69Y1Uen+jVcHTgFxJs+MsO4l6VuPaU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAJEituH016789
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Nov 2019 08:44:55 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 19
 Nov 2019 08:44:54 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 19 Nov 2019 08:44:54 -0600
Received: from [10.250.33.226] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAJEirca010193;
        Tue, 19 Nov 2019 08:44:54 -0600
Subject: Re: [PATCH 1/2] can: m_can_platform: set net_device structure as
 driver data
To:     Pankaj Sharma <pankj.sharma@samsung.com>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <rcsekar@samsung.com>, <pankaj.dubey@samsung.com>,
        Sriram Dash <sriram.dash@samsung.com>
References: <1574158838-4616-1-git-send-email-pankj.sharma@samsung.com>
 <CGME20191119102155epcas5p34ca3dfaba9eef8de24d1bc9d64ef5335@epcas5p3.samsung.com>
 <1574158838-4616-2-git-send-email-pankj.sharma@samsung.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <cb975009-2d89-40b9-8c28-e5cf40bf20a2@ti.com>
Date:   Tue, 19 Nov 2019 08:43:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574158838-4616-2-git-send-email-pankj.sharma@samsung.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pankaj

On 11/19/19 4:20 AM, Pankaj Sharma wrote:
> A device driver for CAN controller hardware registers itself with the
> Linux network layer as a network device. So, the driver data for m_can
> should ideally be of type net_device.
>
> Fixes: f524f829b75a ("can: m_can: Create a m_can platform framework")
>
> Signed-off-by: Pankaj Sharma <pankj.sharma@samsung.com>
> Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
> ---
>   drivers/net/can/m_can/m_can_platform.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
> index 6ac4c35..2eaa354 100644
> --- a/drivers/net/can/m_can/m_can_platform.c
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -107,7 +107,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
>   
>   	mcan_class->is_peripheral = false;
>   
> -	platform_set_drvdata(pdev, mcan_class->dev);
> +	platform_set_drvdata(pdev, mcan_class->net);
>   
>   	m_can_init_ram(mcan_class);
>   

Thanks for the fix.

Acked-by: Dan Murphy <dmurphy@ti.com>


Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136DBC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EEE206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jXgd8d1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbfDYKFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:05:22 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38626 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfDYKFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:05:22 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3PA5DuW031693;
        Thu, 25 Apr 2019 05:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556186713;
        bh=n6We9u0YVFu6BkGTUjZMuv7muCNOIm37EIbnAFUWC8g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jXgd8d1YGWqAWDpKPaUvtj++fpSX74D5AGeYkivKJFL+DV4DpwH1wfm+hwtJYzjSf
         CVlTXFxBNfHkbpOHxIizsc/eHVDQFyv8ovg/TSl+Ji4fQ+zbwJyqK1/jXau56+WE55
         bjpoXbCZpcaQpISq1iRTb29MIEYHRPxozf5R6wAg=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3PA5DkL006119
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Apr 2019 05:05:13 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 25
 Apr 2019 05:05:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 25 Apr 2019 05:05:13 -0500
Received: from [172.22.129.216] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3PA5A8f033746;
        Thu, 25 Apr 2019 05:05:10 -0500
Subject: Re: [RFC PATCH v3 net-next 01/11] net: ethernet: ti: cpts: use
 devm_get_clk_from_child
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Vecera <ivecera@redhat.com>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
 <1556144667-27997-2-git-send-email-grygorii.strashko@ti.com>
 <20190424224607.GB23779@lunn.ch>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <3aae7697-3b7f-492b-0600-b6d1382511c3@ti.com>
Date:   Thu, 25 Apr 2019 13:05:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190424224607.GB23779@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.04.19 01:46, Andrew Lunn wrote:
> On Thu, Apr 25, 2019 at 01:24:17AM +0300, Grygorii Strashko wrote:
>> Use devm_get_clk_from_child() instead of devm_clk_get() and this way allow
>> to group CPTS DT properties in sub-node for better code readability and
>> maintenance.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>  drivers/net/ethernet/ti/cpts.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
>> index 499806ce4cd5..aad118e71b61 100644
>> --- a/drivers/net/ethernet/ti/cpts.c
>> +++ b/drivers/net/ethernet/ti/cpts.c
>> @@ -572,7 +572,7 @@ struct cpts *cpts_create(struct device *dev, void __iomem *regs,
>>  	if (ret)
>>  		return ERR_PTR(ret);
>>  
>> -	cpts->refclk = devm_clk_get(dev, "cpts");
>> +	cpts->refclk = devm_get_clk_from_child(dev, node, "cpts");
>>  	if (IS_ERR(cpts->refclk)) {
>>  		dev_err(dev, "Failed to get cpts refclk\n");
>>  		return ERR_CAST(cpts->refclk);
> 
> Hi Grygorii
> 
> Does this break backwards compatibility for existing DT blobs?
> Maybe you need to look in both the old and new locations?

No. It doesn't - default node is cpsw->dev->of_node.

Then Patch 7 changes it fro new driver to 
-	cpsw->cpts = cpts_create(cpsw->dev, cpts_regs, cpsw->dev->of_node);
+	cpts_node = of_get_child_by_name(cpsw->dev->of_node, "cpts");
+	if (!cpts_node)
+		cpts_node = cpsw->dev->of_node;
+
+	cpsw->cpts = cpts_create(cpsw->dev, cpts_regs, cpts_node);

-- 
Best regards,
grygorii

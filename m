Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50299C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17773206CB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FgApXMvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfKTHXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 02:23:07 -0500
Received: from mail-eopbgr800082.outbound.protection.outlook.com ([40.107.80.82]:6443
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbfKTHXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 02:23:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bS0Mc23GTWXKs6JfWSZGgx6dTSe0+yz1I43mb8eIwB9LPzVUg/oA12R04yE7NeEzZDcc3xEZE+ZbyCkdttgnwhQy96VS3c0dmw2hSKtqKJShA5y4V4CxM50HEQB2VAZRGGhPzue9hCbA4uS1Kip7uaqRs6/nkFp3kkqrNwjF1oVfx3SiJ7a63rvS+A2vM/Sg0DxE8y6u0EC9J7ua+/GD3gqK68td9/C9RH8vH8AMpWoNFjlEHIPU6DkjR4bit27BauqlHE279uCls0ldWD7M+CzqAjD45NL/e1oyQRlPWhX3nWm4TXboSfpaXvnRHxveOs/cpsWPEcdxjJAHNlG0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrA6lfHkkSG5JFFMl2zXibCPTy88ZMGIk8qRyfwNvAU=;
 b=b2e9K/fpnyJ0gzeVOYzNEenQ9AX+JT3xKXblRXgOxTDE/NXMJM5DCoU0PFm1cXvJ6WJleekGvTaGzFLBUaWhC0V721LtnwUvubaFkbIpOYJkiu/lnwkDOUkcY22BxhSDOJbXEIYfTy72BAaiYuK4/vi0C6UsemMBG2CAOs/6Sb4YTiTX9GGvnwHzXgCz0cRzoFG3WPNlYsEhNr5NaS5f4Jitfij3eO48mr7Y9D3oQoBIfPsBBQwdF8RWhx2rKtQf4ZNt08vK+49s8PSPzUxXY2hZzX/7wSyOCgByolZe242FdqvEPAfztdlnz92eBDICz9FO3mW9trM7R7XQFpcmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrA6lfHkkSG5JFFMl2zXibCPTy88ZMGIk8qRyfwNvAU=;
 b=FgApXMvgHTQtxJIExy3/C92El/6Hqgfe+xeO34qG/ETN56piEszLzTlos0XJoblTwFRjTKYOIbbqXLQBzRQUf+qUtfcCIHdOuRyD9ALTwt1WccMKoANbXXzBSWv8vTTkbCxzN6jM7wKehTYvMUZ58kR7XlLgAGKJmqfRph93J1Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vishnuvardhanrao.Ravulapati@amd.com; 
Received: from DM6PR12MB3868.namprd12.prod.outlook.com (10.255.173.213) by
 DM6PR12MB3417.namprd12.prod.outlook.com (20.178.30.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Wed, 20 Nov 2019 07:23:03 +0000
Received: from DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::ac0a:4c84:7bb:2843]) by DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::ac0a:4c84:7bb:2843%5]) with mapi id 15.20.2474.015; Wed, 20 Nov 2019
 07:23:02 +0000
Subject: Re: [alsa-devel] [PATCH v8 2/6] ASoC: amd: Refactoring of DAI from
 DMA driver
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Akshu.Agrawal@amd.com,
        Mark Brown <broonie@kernel.org>, djkurtz@google.com,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Alexander.Deucher@amd.com
References: <1574155967-1315-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1574155967-1315-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <0c3d3545-b0ee-4bb3-558a-045633a30e46@linux.intel.com>
From:   vishnu <vravulap@amd.com>
Message-ID: <991a1c7a-6f34-caab-132d-5687b1f1bfa0@amd.com>
Date:   Wed, 20 Nov 2019 12:51:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <0c3d3545-b0ee-4bb3-558a-045633a30e46@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::18) To DM6PR12MB3868.namprd12.prod.outlook.com
 (2603:10b6:5:1c8::21)
MIME-Version: 1.0
X-Originating-IP: [165.204.159.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 167deef1-f8f2-49f7-dec7-08d76d8a7a78
X-MS-TrafficTypeDiagnostic: DM6PR12MB3417:|DM6PR12MB3417:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3417D4084FBE63753EED2AE6E74F0@DM6PR12MB3417.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(199004)(189003)(3846002)(6436002)(186003)(2870700001)(6116002)(4326008)(478600001)(6486002)(2906002)(6512007)(76176011)(52116002)(14454004)(99286004)(2486003)(446003)(486006)(2616005)(476003)(305945005)(81166006)(81156014)(11346002)(23676004)(58126008)(26005)(229853002)(316002)(54906003)(6636002)(53546011)(6506007)(386003)(25786009)(6246003)(8676002)(110136005)(66066001)(50466002)(31696002)(65956001)(14444005)(65806001)(8936002)(5660300002)(36756003)(47776003)(31686004)(6666004)(66476007)(66556008)(66946007)(7736002)(43062003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3417;H:DM6PR12MB3868.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y45gXViBWtYARt6vaM1Ngnw761F5CFW+eSea1mnHWSIHB+FUbJqx61RzaTfGigzMUQY3JkqdF5s7+IOte/ggc0x8mJe1pv/vkd5Z8iqukY5Are9eMi6TFAAD68M2cSjlF74Vnwadi9S6u8tQbs0u0d8Ab3kv+Ihdvd/7UktFV5MCSCARFd6mP0pY5w+Hf4z0z9tfActcW9dXy3lXo5jI9YPdxRDlhqtSe9eqGbY0ym9u+e+tznIsjkw5faKuz7bViDPZ7+kmz/tWyykPbDfob1uvwtEnbzAwBavAnntXAW6CXH//7Rxo1mvTkSdGWcMtGINrXacE4aIsUq9J3kubpnVn9+iBcebVDpQ0NU6XmjDGxkbaPrgiiGpLhwxG2DcBbPrQdznRrXb95A1ZvCoIzaKoWRAywG//cTUIYW1OQrec2gMzaioOOR1syI2U1Fcs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167deef1-f8f2-49f7-dec7-08d76d8a7a78
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 07:23:02.4930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fl18ZA590kROyAY1eTu89WoHWtRf9UndQVUkxITU4DsuxnuwNO86yD6WsZB3wnNRRGVaTmSS5yUKsQ1ttbbbGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3417
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/11/19 7:23 PM, Pierre-Louis Bossart wrote:
> 
> 
>> +static int acp3x_dai_probe(struct platform_device *pdev)
>> +{
>> +    struct resource *res;
>> +    struct i2s_dev_data *adata;
>> +    int status;
>> +
>> +    adata = devm_kzalloc(&pdev->dev, sizeof(struct i2s_dev_data),
>> +            GFP_KERNEL);
>> +    if (!adata)
>> +        return -ENOMEM;
>> +
>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    if (!res) {
>> +        dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    adata->acp3x_base = devm_ioremap(&pdev->dev, res->start,
>> +            resource_size(res));
>> +    if (IS_ERR(adata->acp3x_base))
>> +        return PTR_ERR(adata->acp3x_base);
>> +
>> +    adata->i2s_irq = res->start;
>> +    dev_set_drvdata(&pdev->dev, adata);
>> +    status = devm_snd_soc_register_component(&pdev->dev,
>> +            &acp3x_dai_component, &acp3x_i2s_dai, 1);
>> +    if (status) {
>> +        dev_err(&pdev->dev, "Fail to register acp i2s dai\n");
>> +        return -ENODEV;
>> +    }
>> +    pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
>> +    pm_runtime_use_autosuspend(&pdev->dev);
>> +    pm_runtime_enable(&pdev->dev);
> 
> question: here you want to use pm_runtime for this platform device...
> 
>> +    return 0;
>> +}
>> +
>> +static int acp3x_dai_remove(struct platform_device *pdev)
>> +{
>> +    pm_runtime_disable(&pdev->dev);
>> +    return 0;
>> +}
>> +static struct platform_driver acp3x_dai_driver = {
>> +    .probe = acp3x_dai_probe,
>> +    .remove = acp3x_dai_remove,
>> +    .driver = {
>> +        .name = "acp3x_i2s_playcap",
> 
> ... but here there is no .pm structure and I don't see any 
> suspend/resume routines for this driver...
> 
>> +    },
>> +};
> 
>> @@ -774,13 +586,14 @@ static struct platform_driver acp3x_dma_driver = {
>>       .probe = acp3x_audio_probe,
>>       .remove = acp3x_audio_remove,
>>       .driver = {
>> -        .name = "acp3x_rv_i2s",
>> +        .name = "acp3x_rv_i2s_dma",
>>           .pm = &acp3x_pm_ops,
>>       },
> 
> ... but for this other platform_driver you do have a .pm structure and 
> suspend-resume implementations.
> 
> Wondering if this is a miss or a feature?
> 

As per our design, ACP IP specific changes like ACP power on/off will be 
handled in ACP pci driver(parent device for DMA device and I2S 
controller(nothing but CPU DAI))

Where as In DMA driver during runtime suspend/resume interrupts will be 
disabled and enabled.

But in DAI driver there is nothing to be done in suspend and resume just 
returning zero so we have not added PM suspend/resume here in DAI.

So is it expected to add the suspend resumes with returning zero.Or if 
pm runtime is not needed in CPU DAI shall we remove the existing PM 
related calls in DAI.

Please suggest us.


Thanks,
Vishnu

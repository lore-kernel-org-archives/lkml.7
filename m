Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A33FC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56592075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BG0LbPlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfKRJA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:00:27 -0500
Received: from mail-eopbgr730062.outbound.protection.outlook.com ([40.107.73.62]:23712
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbfKRJA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:00:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klHf3Rizmad0VfPibEkaiA+3857FB/xjrwRbmohoPJNYDuw1em7JKTTXlEKlD+pi4nQnJdAgAC8B7znyHJrOvKgJSfX9sPXpuiA0OAeZ3H2o2DiQ5Qn4ly9akbzut7ssu0L3jGzfh4GFrbKM9ZbPKTikTXmjyBhkn6juFdp1r/1UATJEiOMD4Zbm0mcWbyFPW6XBVPZCmUFSGwts76Wr/pJ2brceN+Z4mn+NMN5Wz1ClENTHKCMJOYqmnnmBsehzGobouxaE66SQKf6nPWB65WwMBoTMHUVt7hr2IhruRVOtf7TC14rVLiwYpBfcjkb6LNyrATWgHSzmJlCyqd4klA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS7VdiPVvtFRMC6pL5f27Fj/QvHpX3PETFgvnf55qTs=;
 b=lMn7Ci0dJrDrVhCewa/qWOlPaKn3oEX9ndDsZD6YMbOoICO+X2/Cq1ldKbvu3PfZ/W0CbS8lEgqCoUUQ+TyFCkBmTs7SEugTUesM0Hcv/be9mGAFQcObOrV+d4NS8Wn+sxTUFGsnyFtIqZyhzhzi2hhTCYt+Nwr/gh1kDcJ+qn2u8OdG1ioaNEE07aCn+osjBhLlgIMVolhCqD6wIGRjr/sepdM1je0cRcAJP067nyYD0FKJqy4pZkCgdMf86XtqvTQZ2EeO/npupaGVqxWfPajfIGYTUjJ9NwUlngolC8fZrVhIQ981z/iMEFcrnRrPyMPLjwHlptG9+uHU3JTdVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS7VdiPVvtFRMC6pL5f27Fj/QvHpX3PETFgvnf55qTs=;
 b=BG0LbPlhTte0XWI3aquAumzhwWyQRU1ZdTqDVe2FsXKOCcZWOBmItHC/S47sEJMMpSzeQlP/v0HE1QKQ/nV6iplGPHP4G787ywBWe00dcsd/JXCRgQYihJdmuEDpftNYUuoE4gp29L4+5stDzLhQuNBfX//+YtmOHM+1iA4cI6A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vishnuvardhanrao.Ravulapati@amd.com; 
Received: from DM6PR12MB3868.namprd12.prod.outlook.com (10.255.173.213) by
 DM6PR12MB2698.namprd12.prod.outlook.com (20.176.118.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Mon, 18 Nov 2019 09:00:21 +0000
Received: from DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::ac0a:4c84:7bb:2843]) by DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::ac0a:4c84:7bb:2843%5]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 09:00:21 +0000
Subject: Re: [PATCH v5 1/6] ASoC: amd:Create multiple I2S platform device
 Endpoint (fwd)
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, djkurtz@google.com,
        Akshu.Agrawal@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        Sanju R Mehta <sanju.mehta@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org
References: <alpine.DEB.2.21.1911171159570.2641@hadrien>
From:   vishnu <vravulap@amd.com>
Message-ID: <ff992812-3bf1-4cc0-1e07-e11392cf5dca@amd.com>
Date:   Mon, 18 Nov 2019 14:29:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <alpine.DEB.2.21.1911171159570.2641@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::21) To DM6PR12MB3868.namprd12.prod.outlook.com
 (2603:10b6:5:1c8::21)
MIME-Version: 1.0
X-Originating-IP: [165.204.159.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9766913e-b9fa-497d-8099-08d76c05bdf5
X-MS-TrafficTypeDiagnostic: DM6PR12MB2698:
X-MS-Exchange-PUrlCount: 6
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB26989254FF6D541457E450F0E74D0@DM6PR12MB2698.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(316002)(14444005)(47776003)(66946007)(6512007)(81166006)(6246003)(7736002)(478600001)(31696002)(8936002)(230700001)(6306002)(6486002)(3846002)(6116002)(2906002)(229853002)(4326008)(6666004)(52116002)(23676004)(2486003)(386003)(6506007)(53546011)(186003)(476003)(26005)(486006)(76176011)(446003)(11346002)(2616005)(36756003)(58126008)(65956001)(66066001)(65806001)(110136005)(7416002)(31686004)(54906003)(8676002)(6436002)(81156014)(4001150100001)(30864003)(14454004)(966005)(25786009)(5660300002)(305945005)(6636002)(66556008)(99286004)(66476007)(50466002)(43062003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2698;H:DM6PR12MB3868.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nDWmslRDb8QzPctFq/cMuZBkPixQNE1lWboFA7//1dzJanxws70LH+Owd1mvCUZqtRz4ymyp7K0nfTgWjUdB+GtNUv71vsdUTxPCldEGC381y1abz0CO9o3LrcuxQWEwYAHoZVSyOZFunk6kPuXgQQp45I8Zmknae9Tgj+2hN+jF5N9UludBk3nXWGJrVoN6ajiVY3L9bKlO+I+bLXZOlkYGwgjl44ZEdsglxFqR96xnwqAhlBL2UoM7OdfbmAQv6qlxmuOyIWBd11e2Tdd15Cgb8owsDELlfP609Lx9iP5WdLlrRda90RenHK4asbzCxtXlPGG2umU1TdSuc2BryJFApOhsDCfY+DsvSIFlLm86u6wPFPM2cIWuit6eNpoLjehZ9uIMdf882/fasCpXQ/zVd3L8Wy891HVT+QEzbwuTzHe9Djdwc3YJ5mV/Y5JR/h/ttvhQ1WbwNAkt+L72JfKsLm1gpzUy0CAevIE/TSM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9766913e-b9fa-497d-8099-08d76c05bdf5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 09:00:21.5552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOMVarBQtksi+ed6BzOznu1oAdvhF/pUCq3ErN5aJHPc8+ReBLMFKpTx3Ql437MyU27PeaOEOlkXK4zx3JjjYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2698
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

This is not latest version.I have already send V6 version.
The comment which you gave is for v5 old version.


Thanks,
Vishnu

On 17/11/19 4:31 PM, Julia Lawall wrote:
> On line 70, adata->res is allocated with a devm function, so it shouldn't
> be passed to kfree later; that will lead to a double free.
> 
> julia
> 
> ---------- Forwarded message ----------
> Date: Sun, 17 Nov 2019 11:44:07 +0800
> From: kbuild test robot <lkp@intel.com>
> To: kbuild@lists.01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: Re: [PATCH v5 1/6] ASoC: amd:Create multiple I2S platform device
>      Endpoint
> 
> In-Reply-To: <1573629249-13272-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
> References: <1573629249-13272-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
> 
> Hi Ravulapati,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on asoc/for-next]
> [cannot apply to v5.4-rc7 next-20191115]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Ravulapati-Vishnu-vardhan-rao/ASoC-amd-Create-multiple-I2S-platform-device-Endpoint/20191113-230604
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> :::::: branch date: 4 days ago
> :::::: commit date: 4 days ago
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> 
>>> sound/soc/amd/raven/pci-acp3x.c:142:1-6: WARNING: invalid free of devm_ allocated data
> 
> # https://github.com/0day-ci/linux/commit/79701559637a30a0708febfd5119ad05128b2ba5
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 79701559637a30a0708febfd5119ad05128b2ba5
> vim +142 sound/soc/amd/raven/pci-acp3x.c
> 
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   21
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   22  static int snd_acp3x_probe(struct pci_dev *pci,
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   23  			   const struct pci_device_id *pci_id)
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   24  {
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   25  	int ret;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   26  	u32 addr, val, i;
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   27  	struct acp3x_dev_data *adata;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   28  	struct platform_device_info pdevinfo[ACP3x_DEVS];
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   29  	unsigned int irqflags;
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   30
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   31  	if (pci_enable_device(pci)) {
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   32  		dev_err(&pci->dev, "pci_enable_device failed\n");
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   33  		return -ENODEV;
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   34  	}
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   35
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   36  	ret = pci_request_regions(pci, "AMD ACP3x audio");
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   37  	if (ret < 0) {
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   38  		dev_err(&pci->dev, "pci_request_regions failed\n");
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   39  		goto disable_pci;
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   40  	}
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   41
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   42  	adata = devm_kzalloc(&pci->dev, sizeof(struct acp3x_dev_data),
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   43  			     GFP_KERNEL);
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   44  	if (!adata) {
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   45  		ret = -ENOMEM;
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   46  		goto release_regions;
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   47  	}
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   48
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   49  	/* check for msi interrupt support */
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   50  	ret = pci_enable_msi(pci);
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   51  	if (ret)
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   52  		/* msi is not enabled */
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   53  		irqflags = IRQF_SHARED;
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   54  	else
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   55  		/* msi is enabled */
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   56  		irqflags = 0;
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   57
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   58  	addr = pci_resource_start(pci, 0);
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   59  	adata->acp3x_base = ioremap(addr, pci_resource_len(pci, 0));
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   60  	if (!adata->acp3x_base) {
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   61  		ret = -ENOMEM;
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   62  		goto release_regions;
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   63  	}
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   64  	pci_set_master(pci);
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12   65  	pci_set_drvdata(pci, adata);
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   66
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   67  	val = rv_readl(adata->acp3x_base + mmACP_I2S_PIN_CONFIG);
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   68  	switch (val) {
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   69  	case I2S_MODE:
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   70  		adata->res = devm_kzalloc(&pci->dev,
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   71  					  sizeof(struct resource) * 4,
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   72  					  GFP_KERNEL);
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   73  		if (!adata->res) {
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   74  			ret = -ENOMEM;
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   75  			goto unmap_mmio;
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   76  		}
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   77
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   78  		adata->res[0].name = "acp3x_i2s_iomem";
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   79  		adata->res[0].flags = IORESOURCE_MEM;
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   80  		adata->res[0].start = addr;
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   81  		adata->res[0].end = addr + (ACP3x_REG_END - ACP3x_REG_START);
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   82
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   83  		adata->res[1].name = "acp3x_i2s_sp";
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   84  		adata->res[1].flags = IORESOURCE_MEM;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   85  		adata->res[1].start = addr + ACP3x_I2STDM_REG_START;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   86  		adata->res[1].end = addr + ACP3x_I2STDM_REG_END;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   87
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   88  		adata->res[2].name = "acp3x_i2s_bt";
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   89  		adata->res[2].flags = IORESOURCE_MEM;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   90  		adata->res[2].start = addr + ACP3x_BT_TDM_REG_START;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   91  		adata->res[2].end = addr + ACP3x_BT_TDM_REG_END;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   92
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   93  		adata->res[3].name = "acp3x_i2s_irq";
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   94  		adata->res[3].flags = IORESOURCE_IRQ;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   95  		adata->res[3].start = pci->irq;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13   96  		adata->res[3].end = adata->res[3].start;
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   97
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   98  		adata->acp3x_audio_mode = ACP3x_I2S_MODE;
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12   99
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  100  		memset(&pdevinfo, 0, sizeof(pdevinfo));
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  101  		pdevinfo[0].name = "acp3x_rv_i2s_dma";
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  102  		pdevinfo[0].id = 0;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  103  		pdevinfo[0].parent = &pci->dev;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  104  		pdevinfo[0].num_res = 4;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  105  		pdevinfo[0].res = &adata->res[0];
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  106  		pdevinfo[0].data = &irqflags;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  107  		pdevinfo[0].size_data = sizeof(irqflags);
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  108
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  109  		pdevinfo[1].name = "acp3x_i2s_playcap";
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  110  		pdevinfo[1].id = 0;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  111  		pdevinfo[1].parent = &pci->dev;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  112  		pdevinfo[1].num_res = 1;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  113  		pdevinfo[1].res = &adata->res[1];
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  114
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  115  		pdevinfo[2].name = "acp3x_i2s_playcap";
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  116  		pdevinfo[2].id = 1;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  117  		pdevinfo[2].parent = &pci->dev;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  118  		pdevinfo[2].num_res = 1;
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  119  		pdevinfo[2].res = &adata->res[2];
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  120  		for (i = 0; i < ACP3x_DEVS ; i++) {
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  121  			adata->pdev[i] =
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  122  				platform_device_register_full(&pdevinfo[i]);
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  123  			if (IS_ERR(adata->pdev[i])) {
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  124  				dev_err(&pci->dev, "cannot register %s device\n",
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  125  					pdevinfo[i].name);
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  126  				ret = PTR_ERR(adata->pdev[i]);
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  127  				goto unmap_mmio;
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  128  			}
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  129  		}
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  130  		break;
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  131  	default:
> 00347e4ea8ca4c Colin Ian King                2018-11-16  132  		dev_err(&pci->dev, "Invalid ACP audio mode : %d\n", val);
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  133  		ret = -ENODEV;
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  134  		goto unmap_mmio;
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  135  	}
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  136  	return 0;
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  137
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  138  unmap_mmio:
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  139  	pci_disable_msi(pci);
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  140  	for (i = 0 ; i < ACP3x_DEVS ; i++)
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13  141  		platform_device_unregister(adata->pdev[i]);
> 79701559637a30 Ravulapati Vishnu vardhan rao 2019-11-13 @142  	kfree(adata->res);
> 7894a7e7ea3de6 Vijendar Mukunda              2018-11-12  143  	iounmap(adata->acp3x_base);
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  144  release_regions:
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  145  	pci_release_regions(pci);
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  146  disable_pci:
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  147  	pci_disable_device(pci);
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  148
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  149  	return ret;
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  150  }
> e30d9128def6ca Maruthi Srinivas Bayyavarapu  2018-11-12  151
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
> 

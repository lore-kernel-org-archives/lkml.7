Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF867C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B198F205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bbNUoZb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLCKb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:31:57 -0500
Received: from mail-eopbgr820083.outbound.protection.outlook.com ([40.107.82.83]:12292
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725997AbfLCKb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:31:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NM18GkKKHCGY8z9viZiwq2AZEkRbn3ynkwh+j9toVXDB5uyWx3LLmEWI7zz3YVTJBgrw4nAO4BucdAx3JJ4VJp+fLYSWHF1iWBx4hap0W07oIYu1k7NLtQmVFr0i9pbmi16liSiDppwDe/72+f/v0NVspbU9wDN6vMuNkmNd4QlGqlOJ+I/FSX6oQ44pv41f7sqotZwvzHvp7U0F//fM9gpTwy7YsuAWQOb3pzh97NaSWBs6WX7mmB0EoqlPOLrjq41H1yPnWlm8imk+l3iMJ5myk5q/qGaFFCdakTeL4mQRyDX8NvyYUAc8AX6S3upNVuFN0zrOtLFMxDudT09htg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbqo2Itu7FHm3Sds83bYUhjZm/pCw3/0AGD5vPeuKkc=;
 b=D7WnOi+2CEn0V27camWsHfYqDDxkpxzrWL+cVVRCL1z3t1u5MITcwi8L8ToGE2mqYzr2JukEeD1aZcIPVirBfHJWjqFXUYmJJP8Ul7tC2bY4/boVVF90D15XVQn3XHdLyw13a45QS20Yn6T6nS7yYjEoMPEIKNmf+4I91sOJMFYb8lGAQQyA5uYGq8+Y6REsvVJ7CGAuRans69kZfnNa3HLjQxygtKKGJSWqCXH0PpLk5f+U0cJYyKXIyIohldO1vF/K2XyY6boG60mr1Mq3zH9DMLDrEWEmkkpzeAe1yRzltrJyKrtHPEodEh9zdkZv4cRk92MV8P8CdRM5W3A40Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbqo2Itu7FHm3Sds83bYUhjZm/pCw3/0AGD5vPeuKkc=;
 b=bbNUoZb9xvXBicudguavUafrtZ94nBpTsOfQUdtj7/dfC+Z/ZesUvo3f36uWtwjeHyOGZBCFuCSg831C6Z1ec0SldrRFbuAMUJ/a0gPzM3fO9SNDD3Yr2ErgsMycYHRj7lP2q7Cvan/PmZmUhrHQ/YLjELfEGGoXR67fOoD13QI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from MN2PR12MB2878.namprd12.prod.outlook.com (20.179.80.143) by
 MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Tue, 3 Dec 2019 10:31:54 +0000
Received: from MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::305d:cfb0:baaf:7008]) by MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::305d:cfb0:baaf:7008%4]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 10:31:54 +0000
Subject: Re: [RESEND PATCH v12 4/6] ASoC: amd: add ACP3x TDM mode support
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, djkurtz@google.com,
        pierre-louis.bossart@linux.intel.com, Akshu.Agrawal@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1574415866-29715-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1574415866-29715-5-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
From:   "Agrawal, Akshu" <aagrawal2@amd.com>
Message-ID: <46263e01-fd7f-57c3-64f8-c48e01cdb79c@amd.com>
Date:   Tue, 3 Dec 2019 16:01:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <1574415866-29715-5-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MAXPR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::30) To MN2PR12MB2878.namprd12.prod.outlook.com
 (2603:10b6:208:aa::15)
MIME-Version: 1.0
X-Originating-IP: [165.204.157.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e69dde5-dc49-4079-e787-08d777dc0429
X-MS-TrafficTypeDiagnostic: MN2PR12MB3309:|MN2PR12MB3309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3309DA2CB2BAC34BB682BF21F8420@MN2PR12MB3309.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 02408926C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(25786009)(99286004)(6512007)(2616005)(5660300002)(7736002)(305945005)(81166006)(52116002)(11346002)(81156014)(6436002)(446003)(186003)(76176011)(66556008)(66476007)(66946007)(478600001)(316002)(4326008)(31696002)(31686004)(14454004)(6506007)(8936002)(6666004)(386003)(53546011)(8676002)(37006003)(58126008)(6636002)(6486002)(2486003)(23676004)(6862004)(6116002)(6246003)(50466002)(230700001)(36756003)(229853002)(3846002)(54906003)(65956001)(2906002)(26005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3309;H:MN2PR12MB2878.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1K0UlOu9u1c6aR6DLeMMkP+02q0m93ps7CsEt9SnV+z/LbKuQkuf+0lBCyvWOhrwW2Bl0AhWbp3WMEWsJa7hdYYGryitWJV4Kz527ubzY/W+/lhHV9G5YummmYtdHokL0ziO26/FqtchqIws2FUi0u1M4JLh0lN+Hkos409aOfKTWPzVbeA4AJ9x8NlIBJwkzRaxLP5p+ylFxT1PCG0ZOLNVnH/xTFY0MIm6CRqOe13rJDuycC1PHPsS8HXONX9yaMbsyT3HOH6AbYOJ9MR5o3SvYLfvkGFbkPYy3nrz5jm6x0j0x3Qa7Dz/rHWzLx/H00MmBiH4wJaZ7D9Wpu/r+l4zPFCm3JCed+Gpy0TowR4J2keJuJiYraeqFXnB65HYMhIalPyTMEmOnHPgVtGOmpNssUxuYEu0WwitxGOQOvKHAFuWyWjwDu6X4mPeLVzu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e69dde5-dc49-4079-e787-08d777dc0429
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 10:31:54.5028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUDnyVMyli3J0lMDt4ZubvXi8STg436u2mJokoZIB+Y5dPsoTVSxbPEKJ2Ca9K7BQZ0c2xiBJ2Fku95PXcwbQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3309
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/22/2019 3:14 PM, Ravulapati Vishnu vardhan rao wrote:
> ACP3x I2S (CPU DAI) can act in normal I2S and TDM modes. Added support
> for TDM mode. Desired mode can be selected from ASoC machine driver.
>
> Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
> ---
>   sound/soc/amd/raven/acp3x-i2s.c | 24 ++++++++++++++++++++----
>   sound/soc/amd/raven/acp3x.h     |  1 +
>   2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
> index 7f05782..cea7311 100644
> --- a/sound/soc/amd/raven/acp3x-i2s.c
> +++ b/sound/soc/amd/raven/acp3x-i2s.c
> @@ -70,11 +70,27 @@ static int acp3x_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai,
>   
>   	frm_len = FRM_LEN | (slots << 15) | (slot_len << 18);
>   	if (adata->substream_type == SNDRV_PCM_STREAM_PLAYBACK) {
> -		reg_val = mmACP_BTTDM_ITER;
> -		frmt_val = mmACP_BTTDM_TXFRMT;
> +		switch (adata->i2s_instance) {
> +		case I2S_BT_INSTANCE:
> +			reg_val = mmACP_BTTDM_ITER;
> +			frmt_reg = mmACP_BTTDM_TXFRMT;

Patch 2 of this series declares frmt_val, frmt_reg should cause build 
errors.

Thanks,

Akshu


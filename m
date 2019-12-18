Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9088CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 06:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5998920717
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 06:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YHW6uvi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfLRGbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 01:31:41 -0500
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:5792
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfLRGbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 01:31:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJo8Xv14UVhi7ASwT6AgVNScETf49rbnzs3s5ctZbyZyccAOCiL5uHgbJjr3IL82bL+E0A57jTY1YAjAwfrZT+vhrq95WZfHvI554FNJEZA2cMyT+nEQuWQRwx2OpxGwP9D/FSod0sUa5YVDVIf0Xm2O8XD/34Qt9feA95d/VvoOLUpKArmm6q5jfWP/LQdXE+lsw3hfpxnBeZp0xpr3Ob052n3bXlfl46nerhz0DRdvFtqCaW/TVzXvcSu8YA0eNNohSXkEFx13JXr/LhBazTxtTRD+TEUxeQl8yBbbs5ljgVEINMcLQapnwjzHK1AYZo71PODojOnFAhPRr5Wv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apHv+0GPRsLdUmX9eggFiu9bWaN5GuejZLELOFj/y7A=;
 b=kqIfCxLhyBplu/JHUAB3PuLGovhOJ0dTbtJlf5CkJDDzE7qLDqmKOhk8BrDURI121w30PT0F/lrPrGW4LLIQn4aZHyd2LXWSrT+NL1DOozgyAu4WNbTYu/uEUw/+Ikqo6xVv15ePKUqfXOKbimHZsLXMRcv+D2EnW4VNsYApRbocEnB3SJ4nZpK/EL3Lubdf6XUJPKWXUbIUhIxS6nmWutKlSArpwBCw+g2zizzegTondwJp3KZUAttD8GNtP+6KPLZIq2mtjnidoaFJbhHv5Ppz+hM5/HIK1gP2FmmArRdECOQIHE11eCnpD6CtpfgowwDbGp6F5/nwmYigujuH1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apHv+0GPRsLdUmX9eggFiu9bWaN5GuejZLELOFj/y7A=;
 b=YHW6uvi5bMWqGcWA3uV4s1NWxO/clxxhV/mpUQyk662bm3zqPSBckoOEy/3QnCrBOxk1nEsaxroRY6mn0KwmvqkRny7D1tNUsM0Kujw2rhee/DHhSJwudIhoT+WmFDE5thZHa/fUMLbLkvAv0eH77NAfMZZbBSBEcM0HqV/46TQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vishnuvardhanrao.Ravulapati@amd.com; 
Received: from DM6PR12MB3868.namprd12.prod.outlook.com (10.255.173.213) by
 DM6PR12MB3706.namprd12.prod.outlook.com (10.255.174.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 06:31:37 +0000
Received: from DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::cd29:4d84:9dbf:c632]) by DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::cd29:4d84:9dbf:c632%7]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 06:31:37 +0000
Subject: Re: [PATCH v14 7/7] ASoC: amd MMAP_INTERLEAVED Support
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, djkurtz@google.com,
        pierre-louis.bossart@linux.intel.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Tabian, Reza" <Reza.Tabian@amd.com>
References: <1575553053-18344-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1575553053-18344-8-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
From:   vishnu <vravulap@amd.com>
Message-ID: <3688990f-0ac3-08bf-20b8-93a4ab17441e@amd.com>
Date:   Wed, 18 Dec 2019 11:59:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <1575553053-18344-8-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::31) To DM6PR12MB3868.namprd12.prod.outlook.com
 (2603:10b6:5:1c8::21)
MIME-Version: 1.0
X-Originating-IP: [165.204.159.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 64aa55aa-6f76-4ace-a441-08d78383eee8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3706:|DM6PR12MB3706:|DM6PR12MB3706:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37060B16BB701138CDBA9003E7530@DM6PR12MB3706.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0255DF69B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(6862004)(6486002)(8936002)(2906002)(66476007)(316002)(2616005)(66556008)(81166006)(81156014)(52116002)(8676002)(5660300002)(66946007)(37006003)(36756003)(6512007)(4326008)(478600001)(31686004)(186003)(54906003)(26005)(6506007)(31696002)(6666004)(7416002)(53546011)(6636002)(43062003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3706;H:DM6PR12MB3868.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ug2t8DUNy0Rz4myfZpnIm8/iIKwgaCk6LkfHgvtwmNRLHJsMm/MlPfV6Krdz2vKK81PaW5lJzsPvhQuwsyOvilNyOSNdIChvqCC6ut2NB/b5T5AyRbUhaFya+jOZW/7BsPqFpzl2Vc1UI5jJJyuP4vMnvDWUO7aGqXyFrE07k1RByxlcwnk3PmxH38RG9cuR6QTL5CnVacG87ZzY/KXCe4r1cXhlbIQb/so3RjE2owbxsBQZH9a1GlvzhY16SyzVZsyLQxEq90Ntg7ShnuXf50P5ho0JfyUhzwk39lkiZZQs8lc+MnDbVs/SM0y+qAgd3l6MIU5hYcvEo4DcHjXtxlb/pKzJV3nck53ELUtgOml1G69Mhe5GabSrppinJKJZwhMuelDOCISYh61xn8gMXFWl4kBaYjlKGiqUvTjECZJtxpUSFQEkvSV4Vq4NNM25QViZ7+Mg/qaC8BcuJDir5UuBfuKAgO2bXQEDGGm8deg7RSNZpbYNejJ/TYs+6To+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64aa55aa-6f76-4ace-a441-08d78383eee8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2019 06:31:37.1301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyNWhT2QSKC+fyEHsLFKXaFF56uP6HvZeOTTDnVXtS396Uy8z7Y0HfP4Zf30/VA/ul+2xjjINKgPQ9DfMCcyrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3706
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Patches have been reviewed by Dan and pierre-louis.bossart@linux.intel.com

Please can you upstream these please.

Regards,
Vishnu

On 05/12/19 7:07 PM, Ravulapati Vishnu vardhan rao wrote:
> ACP-I2S device support MMAP_INTERLEAVED.
> Added support for the same.
> 
> Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
> ---
>   sound/soc/amd/raven/acp3x-pcm-dma.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
> index 916f0d8..28a3081 100644
> --- a/sound/soc/amd/raven/acp3x-pcm-dma.c
> +++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
> @@ -22,6 +22,7 @@ static const struct snd_pcm_hardware acp3x_pcm_hardware_playback = {
>   	.info = SNDRV_PCM_INFO_INTERLEAVED |
>   		SNDRV_PCM_INFO_BLOCK_TRANSFER |
>   		SNDRV_PCM_INFO_BATCH |
> +		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
>   		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
>   	.formats = SNDRV_PCM_FMTBIT_S16_LE |  SNDRV_PCM_FMTBIT_S8 |
>   		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S24_LE |
> @@ -42,7 +43,8 @@ static const struct snd_pcm_hardware acp3x_pcm_hardware_capture = {
>   	.info = SNDRV_PCM_INFO_INTERLEAVED |
>   		SNDRV_PCM_INFO_BLOCK_TRANSFER |
>   		SNDRV_PCM_INFO_BATCH |
> -	    SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
> +		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
> +		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
>   	.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
>   		   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S24_LE |
>   		   SNDRV_PCM_FMTBIT_S32_LE,
> 

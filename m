Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7CAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0C520863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OJlZWhTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfCDGcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 01:32:02 -0500
Received: from mail-eopbgr790083.outbound.protection.outlook.com ([40.107.79.83]:31136
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725550AbfCDGcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 01:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrQxZtPjhPkowum4D/KJgCY5/CNuNBsQW1RMcegMjDQ=;
 b=OJlZWhTMLQc9+yiNtlj4+h8PULPW9LcTU0NAVeJTfNhIfbg1dCcbGlF7QE1wS1ouwTlnIJO3ovk4BrQVMS9fmqKuJD56Iy9XX/ge+nep7MVYLoAWIy+gf1SQ6dAOMSTrXiheFnzi6Bebd96uIFWjYbDbIog5I9Zvx6CHqg/KdPI=
Received: from BN4PR12CA0003.namprd12.prod.outlook.com (2603:10b6:403:2::13)
 by BYAPR12MB2965.namprd12.prod.outlook.com (2603:10b6:a03:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1665.15; Mon, 4 Mar
 2019 06:31:57 +0000
Received: from CO1NAM03FT009.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::204) by BN4PR12CA0003.outlook.office365.com
 (2603:10b6:403:2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1665.15 via Frontend
 Transport; Mon, 4 Mar 2019 06:31:56 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT009.mail.protection.outlook.com (10.152.80.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1643.13 via Frontend Transport; Mon, 4 Mar 2019 06:31:55 +0000
Received: from hr-amur2 (10.34.1.3) by SATLEXCHOV01.amd.com (10.181.40.71)
 with Microsoft SMTP Server (TLS) id 14.3.389.1; Mon, 4 Mar 2019 00:31:53
 -0600
Date:   Mon, 4 Mar 2019 14:32:57 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S++/vW5pZw==?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu/powerplay: Fix missing break in switch
 statement
Message-ID: <20190304063256.GC10714@hr-amur2>
References: <20190301212943.GA21585@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190301212943.GA21585@embeddedor>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(2980300002)(428003)(189003)(199004)(6916009)(58126008)(54906003)(47776003)(105586002)(86362001)(33716001)(55016002)(1076003)(104016004)(5660300002)(2906002)(46406003)(68736007)(50466002)(356004)(9686003)(6306002)(76176011)(229853002)(16586007)(316002)(106466001)(23726003)(6246003)(426003)(97756001)(8936002)(4326008)(476003)(53936002)(126002)(478600001)(446003)(8676002)(81156014)(81166006)(14444005)(11346002)(26005)(77096007)(33656002)(305945005)(97736004)(486006)(186003)(336012)(966005)(72206003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2965;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c410957f-6d0b-400e-1a0b-08d6a06b18c4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060);SRVR:BYAPR12MB2965;
X-MS-TrafficTypeDiagnostic: BYAPR12MB2965:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2965;20:vlXrRnfMY1lRLm/O3Kaf3UPZx+GcaUW9TyqBsSbsKJx2IQ3s1AMTD80He4ZC4A098XoU2og2HhwOBA+hbTv7HS+KUhkY+WZEkGbEo5qkc4BI2b1LDrFe1aV/NRGgFvFud7IKtK9T+BFaMRS/hM8cER6k9CQwocGik696fkw2jUFLNvfCWaJZlcnJDm3ZUypkP5c7qdsDkfRxB9tuLMVqsZecmW9mMTWZPvULkedmrJqHAGoGBcFeq0HlQO3RUsO7ykC2VZCAQP/nRMEYrB/N2yAaDiEu2N79/fFBNeBvUo0GXoHpW6OzPlEtzASpE6muSwcsyCAgiJOeuQttwJZbKJSudD/9p5IvTPtOOEm/ZXKc6pn3EtMBRUMtPTQwGq1aWz6AoYGDrYnd1yb26PS2nvdlZH7M1Na/1X8wPHV5xs5qtGE95DlMEXuzC954IE8s5PUqNtWacziqDYTQq2XEqe4DDOlGizK1DOiWbIi7Z6wJn52evZOdU4hA7i+te7tB
X-Microsoft-Antispam-PRVS: <BYAPR12MB2965D4A79A7D370FF01363D2EC710@BYAPR12MB2965.namprd12.prod.outlook.com>
X-Forefront-PRVS: 09669DB681
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR12MB2965;23:vlE4Bbt4ZD1UWSx0J6uS5nNplWsGJ/OY5ljoW5Nzg?=
 =?us-ascii?Q?SXxtDeLWvX3+uIjxAbW/Fu0DTZDNX8Mp3rLOA110T6lU0GHO0kYiQh1/RkMZ?=
 =?us-ascii?Q?ofJJCvO5C+CuGHtmaJGhYZmHOz/HQ1EQPgBbkSp0raQ9kqImBNy3aMm5CtNg?=
 =?us-ascii?Q?z7XWxFpSKqQ9IMW1NeAZmZ/amV0mJ+FoMoFKVai+GqLgB8V7vY7vvm1xbv7L?=
 =?us-ascii?Q?hUsFdt2btYRHg5MRFVGeM41iEIxSQVfUEZcMKj5KnL7UNGMa9cVCYhg3WJdX?=
 =?us-ascii?Q?HCSZjKSL8rW+iZTDPOGQtAS3xB8ooDpHag0tZ1QjU83HHnNWCg3kPTI9KqOj?=
 =?us-ascii?Q?NR/V7XJZluFGbLXF+4ZWC3DSIU4tp3enoUIvXLSsDLxzT58N8iq98SzWXnaF?=
 =?us-ascii?Q?CMlSFDlESw+WSYE/UhOqxv9xpT6SKRoCHDcoj50m4hADMn5kyplzusNwUCMZ?=
 =?us-ascii?Q?/RLHwrRtWzyQ14NjT5+gU/VATVcmndJGSSLQzCroE7rEf9Bjky64NkhfXLzR?=
 =?us-ascii?Q?oRBr5PlAymq35rtClY+R1hjnrnPb85MNRjt7h/tMWCWIon22iJj43K8v8ULW?=
 =?us-ascii?Q?G6f4fvnDrXVz25FvY1xWHzwNX51ZbXMchqyXWNTMZkiuj030vQbV7mgTfkeA?=
 =?us-ascii?Q?QlOHKqysdMTimfiJi2ZNCA8/ajaU486Gz9oljjDrMpdU9B9EVwxWCPariPSN?=
 =?us-ascii?Q?/YPi4QHTqCsQxZ7qE4U4rQdKfoGcxAcI7U/6N1dhcjLsEn2vvFbR+TN5e6Ct?=
 =?us-ascii?Q?7uia/zi6Ue+oRG1MCQQWuv9dm3QXlcZq+WP7RY42ZmG5Ow/F24RAfmAzOr9n?=
 =?us-ascii?Q?XjfBG0YI7UZ2H6QAtAJ4aw5jajxPhtqqWNOtlDGV7ZpCgQj4NcbtEcJUxGLl?=
 =?us-ascii?Q?Frp3a6oi+NSRLu6Oqnne6QhiQIc4r47zzkmmEIVB17zhUgoMU38i42gjvZGe?=
 =?us-ascii?Q?SuTUOF1FfujRVIxOflFGteDY0Rh8GslJQYZuOYfgGTBaMpmhAFUfUf9gJMcl?=
 =?us-ascii?Q?Y63FOKLCNc/YE9QiGUxw3eZtJ//GXpteoBq1N8UVQQ0WNNRYsy+C702TSxWC?=
 =?us-ascii?Q?BROg/iUxL8ffbb9iRh+KqmbVQt1yEixGigmeaayMIZ5WQkLSoa3I8Yc6YHp3?=
 =?us-ascii?Q?p7vhS8K+btTaYvVj13oXLcm835QkzJfDfLsA1YafV1ziq8ClfquyYo6nBVPS?=
 =?us-ascii?Q?bWByr6i88vKOezE3WcOuTgEbz6zEfM9kVvqA2W4Kn0e1xH3ETv6p4szODnub?=
 =?us-ascii?Q?JK+Hl9dFdB2mrka3ThX4WgkggIWI6nfCJo0W0mi+8XUzanOhVjz61MNBZ4hK?=
 =?us-ascii?B?QT09?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: /v13Dz4AjU1kt+0AJlC2LdrwZJ6SGJTGTRVRGyWZ7HBkcmfmVq8mNBtgR9/fWlgFNAdeDYzdto3/cP/QYOrb1qsueQuzNYtciplK/2RqjuVL0w4T/U49MINgSJKjrMn0Qh4nuK98m0h1C9YnNta2LPfRxkUzLgJ1DIOzt9aRT07ik4bD+nFORa0bZqRdqe1ah5qVRuYLM6O6LHEV+r5iMkFsDdrKyzDfx3WYwQxWFGY2A1g/b+y9HK5repSNB9mZ8JDCJsou90+XgwDtgg9BD9QxqDKFB+vEnXEaEZHW1BzBH4dHQp73goqBQBJt7KMb2k3IGJM0w1PsEZR0tFU03Rx1egf7dLZetMf3bt3c+XaVnVaI1xBFvjvUkIMehgiQEjeXGapp8k28fVAwq4qFSaQtnMP5qz0JtuUZlzXAxj8=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2965;20:QPapkufpmjJmGrzEITwtmNCIGw5IEghON21EEmuBy1Z6pzXEu7kdbr3BRC+q99hv3FgNp7uXHDLEyhqc7P76+Z5BKDll6ZIGLSJqVAg2asqw/dEizp98PQ6wPKhpbq+hQxpJ90wQC7EnPBHRr1EAb4g0KdzQZq1xFQN2jPbrvyYsZDxtH5rDDSTyAM5VK6UV4h8WQzpd42ceRYvf416s4aK30J4mDYWsupL+xLcmFxAcx1yOSyOlBu/0DWiAYwjr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2019 06:31:55.4062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c410957f-6d0b-400e-1a0b-08d6a06b18c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2965
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 03:29:43PM -0600, Gustavo A. R. Silva wrote:
> Add missing break statement in order to prevent the code from falling
> through to case SMU_Discrete_DpmTable.
> 
> This bug was found thanks to the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Fixes: 34a564eaf528 ("drm/amd/powerplay: implement fw image related smum interface for Polaris.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> index 52abca065764..222fb79d319e 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> @@ -2330,6 +2330,7 @@ static uint32_t polaris10_get_offsetof(uint32_t type, uint32_t member)
>  		case DRAM_LOG_BUFF_SIZE:
>  			return offsetof(SMU74_SoftRegisters, DRAM_LOG_BUFF_SIZE);
>  		}
> +		break;
>  	case SMU_Discrete_DpmTable:
>  		switch (member) {
>  		case UvdBootLevel:
> -- 
> 2.21.0
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

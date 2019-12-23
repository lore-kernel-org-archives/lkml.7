Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D2BC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588B420715
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nYMEY3Zz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLWJie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 04:38:34 -0500
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:6152
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbfLWJid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 04:38:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMh7YmjJuJGHcNsb2UslqPsKpdmTVLn6xEY2mVM7ADmZOvVUKSOno0A7boGAIUIdHXDQnO2cslOq9pXgFArYm9zFnv97w0Mtw9i3T2bvQxsDLv+BI+p8yW869E5nQxmz5DLgNWfQNE1pc4iFMv9UEbaeRTwexMdqV4mQbQwPhP3huNPn+Vv5HVq8JJNuBwk3FSYBU1I+rLjP6eJ2P04Cx+pUf7l5FgkpULa3zRzwwEE7Gpg7hqhqQb0K974uZUzW2dwRKzRh+EeunZ3ASZH3uUvyOzHN6BXXpjKWur2K0DgLLDkY0UDyrFn5li55pi5VQR3hXKVbUZ2bgJ1/nOqFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1LSJHjfTePHXqnX7FZjQjWWgmFiXeod42eBEYMbvss=;
 b=E6zSW06dv9oqAlN+bz7LtkGX24atOMYb8aqY/a8m6ZbFyhK+UPQRPanW5iUGKeJa9VJ6WsPilwZvX8HO5XOuAAL0jHwy8y3F6s0qjzYlhYO5zHUZf563QawvWN9LTfI2VN/i9V7j+dlSZA/e7MSuVawaZA7ZmRfbFu2D3trppWjt8y4im2LQFS1WT+XEg7iLQGTXp8zrl37OEKDwAZirFwyTKul9fBAxmuzOw5MPAVjc1ujTuwytKB0E1K0BtJYo2wbt6w8DDgSx8BZWLwEsScVmeLYK7MHJJg7mJ3NHXK+uR2B8hk+Tg9/60YW+zchz+GtnZTNgWvBlRwmkSxsCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1LSJHjfTePHXqnX7FZjQjWWgmFiXeod42eBEYMbvss=;
 b=nYMEY3ZzMBTe1k0UGsrU+0yd5KdNY6EOIaldaCxGhk8WDc/JfZC6oesr6BKIwrSP7guj/AD3c13dVOz0CZ06tmLzBkxPwQmTzbeIzwfH0GjaYXtyW0w/e6Z32C2/mngcyqGFPbZ2UYMp6ig5DkhDPr8vNsV1uAAxmT/Kt7a2Xtg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from MN2PR12MB2878.namprd12.prod.outlook.com (20.179.80.143) by
 MN2PR12MB2925.namprd12.prod.outlook.com (20.179.81.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Mon, 23 Dec 2019 09:38:30 +0000
Received: from MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::c97e:d4c0:bfaf:5edf]) by MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::c97e:d4c0:bfaf:5edf%3]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 09:38:30 +0000
Subject: Re: [alsa-devel] [PATCH] ASoC: rt5682: Add option to select pulse IRQ
 in jack detect
To:     =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        "yuhsuan@chromium.org" <yuhsuan@chromium.org>,
        "Flove(HsinFu)" <flove@realtek.com>
References: <20191220061220.229679-1-akshu.agrawal@amd.com>
 <55cbcef1d09e43e0aac057b680c25e17@realtek.com>
From:   "Agrawal, Akshu" <aagrawal2@amd.com>
Message-ID: <21ae77ee-c0d1-838f-56e6-a931451b0f6e@amd.com>
Date:   Mon, 23 Dec 2019 15:08:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <55cbcef1d09e43e0aac057b680c25e17@realtek.com>
Content-Type: text/plain; charset=big5; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MAXPR0101CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::11) To MN2PR12MB2878.namprd12.prod.outlook.com
 (2603:10b6:208:aa::15)
MIME-Version: 1.0
Received: from [10.136.129.209] (165.204.157.251) by MAXPR0101CA0001.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::11) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 23 Dec 2019 09:38:27 +0000
X-Originating-IP: [165.204.157.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a5043dce-137c-4e00-44e1-08d7878bde64
X-MS-TrafficTypeDiagnostic: MN2PR12MB2925:|MN2PR12MB2925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2925D5194CA29D32DB2EF1C8F82E0@MN2PR12MB2925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0260457E99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(199004)(189003)(478600001)(4744005)(16576012)(31696002)(81156014)(81166006)(8676002)(5660300002)(31686004)(66476007)(66556008)(66946007)(110136005)(8936002)(2616005)(316002)(6636002)(6666004)(2906002)(5009610100001)(956004)(186003)(54906003)(36756003)(16526019)(53546011)(26005)(6486002)(4326008)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2925;H:MN2PR12MB2878.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5m3/GapROT+ve+w1aJSet1VTtTQ+pnZDTVPbQKUvtIhEWYwlHhKYUjZkKa8IoD+ytGokOw6zEhdA18up2DtMfoaBxN++TvsQcHHajiLAjDZzrTuL2WrkApFIiBscoNcG7TMtCWHyVtY2pNPIghVbYDdx1WPIs6+o0pSkLTOM+A+u6ViGrjT6OOAAkOyM0ZmpVN3Ledor2wGW4OaLNXPJ1Y2+VO2y3gQcl85NLSV6i0141mmuZm3ee3lhNy8Odacx+T+lFC96Ck1E+Z4gIjKx5hrQ4dp8YCCwRSR71aK4Kd+a2zZCri8ujOALGlKeBYMEsqYKYvoGu7FXgLoTrI8W39d1dmENCEzD0PL27L/CeRyqvEUragc67HHKFAu5Tb3raqzKfi+BCtoV8mSxagZRS0WjJtPitgc+J/3fVMUZ4Z49EfdNmSljj7A7kiFOtcGH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5043dce-137c-4e00-44e1-08d7878bde64
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 09:38:30.1909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Q3VjlKc7DKehM9FTBxmhXlWGYmkoiRRELIXeSD7gG89occTGKaEezDbr9GoKDuvN51svDoYYz1aoTgxgBKIAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/23/2019 1:28 PM, Shuming [­S®Ñ»Ê] wrote:
>> Subject: [alsa-devel] [PATCH] ASoC: rt5682: Add option to select pulse IRQ in
>> jack detect
>>
>> Some SoC need to set IRQ type as pulse along with other JD1 options.
> Could you configure GPIO IRQ by edge trigger(both rising/falling) and try again?
> BTW, the modification doesn't make sense to name JD2.

Thanks Shuming, was about to send a mail to abandon this patch request.

The GPIO connected to codec is not a traditional one, but a wake event. 
Hence, it took us time to figure out the way to set it active on both 
the edges.


Regards,

Akshu


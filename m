Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB87CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDE6214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gVTINuaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfKLUTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:19:09 -0500
Received: from mail-eopbgr740071.outbound.protection.outlook.com ([40.107.74.71]:15232
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfKLUTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:19:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SufSrIHXmkh6XvWn91aWKEoTTvU8gZLH4ruk4Cpb/QXPovGTs+CnCGOT0RSKVgTYqmY8h4SIAB9B8Cq5Kzkn7PZKG9W9COukeGnPFuZzRd+rB3T/jHJwwqGidy2lTUYIrfw0SP09lrLdixaptY7JqnpY1X7cTmLYTGMP6qi1K79pEsWCKGdZWioMd0cJafHbIGAu3n4Fojc10oFu4BPZqnrITEjXIE4Go5kPFu+EHJ5LGUAJDAg8+CnSJK2D62QsPQi2fLeTowjyVfQ1Yg5auvxUYMLw/I7LCm/6CEJ4D3pMS5CkkLoBFDFzj/QvGMoo64nRYIFrkGRG/zrfCjU/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC4MwTw1dU7ywaoMKx76Ec0g4sMCpZ88y3qeJZweO6w=;
 b=De+zXYI1nAgGo9Bh5Iwz8AJp9QWE3xDbjs54tJhzuaQuiyMwWzRSvMUpmAzlONVYknBeZrYH2DghZ7WSEy7KfDo2yFs1UDzgJoCcmu+LfEKDlHCMGXLDsWtp2rHlkgJDedU6daxT23v67nWj7I0x5hIFbpUHhalcrkFDeYqeaCZeGgFiKR8Gck1LgIx3RjCVsXHjLKQxLg80Vjybq4vtY7ZHKPSUK4AZcwrR1tLhRnz36kVeyXThNAbEx+s1qdUmkm/WnhAy4COYp9ZJT/Jvxu3yQ3A+D6fgUe5ltt+XftDXstLCYq1vW1MZa3yE0IcRonMcYZU4K1XoIVk+1mPRqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC4MwTw1dU7ywaoMKx76Ec0g4sMCpZ88y3qeJZweO6w=;
 b=gVTINuaE7Ncul+q3z68uMMM1rhuXu1YnvyVxS5dPPrS9XcNVnmXEsoX8lEsOqOoYtK9k7fC8IMe23GZUXeJz24TwMczGhgGqZp+lj9hMEk35R8YSrXUdUgNl7NkclaMyjGzLTvaPjbhCnsEv0Gnd7X2ld0SPMw39WFT8pJVbNuI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0216.namprd12.prod.outlook.com (10.172.76.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 20:19:05 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195%5]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 20:19:05 +0000
Subject: Re: [PATCH -next] drm/amd/display: Fix old-style declaration
To:     Yuehaibing <yuehaibing@huawei.com>, Joe Perches <joe@perches.com>,
        harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Bhawanpreet.Lakha@amd.com, Jun.Lei@amd.com, David.Francis@amd.com,
        Dmytro.Laktyushkin@amd.com, nicholas.kazlauskas@amd.com,
        martin.leung@amd.com, Chris.Park@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20191111122801.18584-1-yuehaibing@huawei.com>
 <01c630e6d4c58b3f6184603e158f53fb9aaeae7d.camel@perches.com>
 <3361b760-fe4f-87e8-b0a4-ebda390aa492@huawei.com>
From:   Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <e59cbdf4-ac9e-dda7-f1c3-fdd148ddeeea@amd.com>
Date:   Tue, 12 Nov 2019 15:19:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <3361b760-fe4f-87e8-b0a4-ebda390aa492@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::26) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 39a3da19-50f4-4315-c552-08d767ad9097
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0216:|CY4PR1201MB0216:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB021639A3B5399AC26F1A41A08C770@CY4PR1201MB0216.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(199004)(189003)(66556008)(81156014)(8676002)(66476007)(81166006)(8936002)(36756003)(99286004)(4001150100001)(110136005)(58126008)(316002)(5660300002)(52116002)(6666004)(31696002)(25786009)(14444005)(66946007)(6246003)(4326008)(6506007)(305945005)(53546011)(6512007)(23746002)(229853002)(230700001)(11346002)(50466002)(446003)(7736002)(26005)(3846002)(386003)(14454004)(478600001)(47776003)(31686004)(6636002)(6486002)(76176011)(2906002)(65806001)(65956001)(486006)(66066001)(2616005)(476003)(6116002)(6436002)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB0216;H:CY4PR1201MB0230.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6s6SqoUy3a0yh0ZO7+jOdEL8NFyHRJimhVSz31xXzEQu0mgn5vW346X/tE8LI2oe8gAgV2ATlWQGqJQKP7tK8DVfXUiHNlSEopyWu9Aw0YC/yjyiPge/0wZdDAfoKYNTfhW/s63K88uE1e7i4M+FFMo/Rwq9L/lagxgciReAjseAqEmZZSKpwBVNCCSEBLi6X7KRnpl4G59AeijH7HKE1Qs8yMQDOnc5lzTmo06j8//Zd6dHOl9d8ZksrMnV13oBWm0+9eKj/1g4H91bCOVXyudcLkS4JF8PWCJWcC28STYekUz8NOuEVAd1M+8PdPziz8kePI5CzaAh9dm+1aK71j1DdlPSVuEMMlcrEnYrvL6e6ZnIofFMn2XbgDMo3TkEZ/JfsGUR3/Fwl4cF8N3juVWw7oKvFAnGzrqnGH8I/VsP28FWAcBl0+nOkDeSMQmY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a3da19-50f4-4315-c552-08d767ad9097
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 20:19:05.1202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wvHVpGyrcfRGV9biyuUGoglhGBxkfj+EcrjBqYlFjVLLgMFrivn+vZD5w1aL6JdNx6mGOtpdjMSGbPt7L5mig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-12 2:51 a.m., Yuehaibing wrote:
> On 2019/11/12 10:39, Joe Perches wrote:
>> On Mon, 2019-11-11 at 20:28 +0800, YueHaibing wrote:
>>> Fix a build warning:
>>>
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:75:1:
>>>  warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
>> []
>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> []
>>> @@ -69,7 +69,7 @@
>>>  #define DC_LOGGER \
>>>  	dc->ctx->logger
>>>  
>>> -const static char DC_BUILD_ID[] = "production-build";
>>> +static const char DC_BUILD_ID[] = "production-build";
>>
>> DC_BUILD_ID is used exactly once.
>> Maybe just use it directly and remove DC_BUILD_ID instead?
> 
> commit be61df574256ae8c0dbd45ac148ca7260a0483c0
> Author: Jun Lei <Jun.Lei@amd.com>
> Date:   Thu Sep 13 09:32:26 2018 -0400
> 
>     drm/amd/display: Add DC build_id to determine build type
> 
>     [why]
>     Sometimes there are indications that the incorrect driver is being
>     loaded in automated tests. This change adds the ability for builds to
>     be tagged with a string, and picked up by the test infrastructure.
> 
>     [how]
>     dc.c will allocate const for build id, which is init-ed with default
>     value, indicating production build. For test builds, build server will
>     find/replace this value. The test machine will then verify this value.
> 
> It seems DC_BUILD_ID is used by the build server, so maybe we should keep it.

Thanks, Haibing. Yes, we'll want to keep it for build purposes.

Harry

> 
>>
>> ---
>>  drivers/gpu/drm/amd/display/dc/core/dc.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> index 1fdba13..803dc14 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> @@ -69,8 +69,6 @@
>>  #define DC_LOGGER \
>>  	dc->ctx->logger
>>  
>> -const static char DC_BUILD_ID[] = "production-build";
>> -
>>  /**
>>   * DOC: Overview
>>   *
>> @@ -815,7 +813,7 @@ struct dc *dc_create(const struct dc_init_data *init_params)
>>  	if (dc->res_pool->dmcu != NULL)
>>  		dc->versions.dmcu_version = dc->res_pool->dmcu->dmcu_version;
>>  
>> -	dc->build_id = DC_BUILD_ID;
>> +	dc->build_id = "production-build";
>>  
>>  	DC_LOG_DC("Display Core initialized\n");
>>  
>>
>>
>>
>> .
>>
> 

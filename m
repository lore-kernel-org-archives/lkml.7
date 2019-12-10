Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EFDC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F4A206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nIlvCVQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfLJU4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:56:08 -0500
Received: from mail-bn7nam10on2060.outbound.protection.outlook.com ([40.107.92.60]:6144
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbfLJU4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:56:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXjLAZSzPpu/SPyvxlL8wviWHX4DuoPjSfckzl5XjWK41U6WJhjS9mZT3Qn5PYAq32+B0yDZ8SIHo06XduTx5qEGb2yGxvzk0JCuEHywNCD2Rg8os0Z6nu9//OEZ8MseKktZq1iFOq6sMaFiM2laEx5mFUpTeqX9um9smVllWrqBoEtdoytjIrqrrm4goEHVqzcXEz1vByG6LZssC4CeBe/9xCfu+JSlKGR91xuU6Mu6ouIIlD1iJAyUW9XWxMSkhabVCwpYoh0F19SbIJLutXhKEEFfifmWRbqHc0axX9DulKWjK5MpGCAU5ZbcO+uyKEYuEL+a5ImfyDEkuBMXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9J9/GjwHWXVOk78M7BOCW77BqHoMYk4rboFHyrAYiWs=;
 b=DD+RN5Dnv2JzHTPpCwlHiI/UsNGi1B0M9D/ZNrxXZqUWRFfLZythSHvCke3xIOZ3p516B3JxqqZAZcJf9q25Jnr4T3zrvkGNzCLOnTp75+ywXdhiyhc9rD9qcgXc/SnH0JcnWVk2o8QehQZAWgTOdyBZx8eJsAXjtT1a5F/yyiFSzXXVvOGCugutIWDDXrhHvM4CNmxM+1qFMeYdsyzO3wFUQia6icq4iJ306UoaZDtt7SeMtps7YD2R39J05MUy/nvosXJ3uL9ycGzDwF/WTqSACOp4w6kG6RsghylHAaMrN15/tP6H9dsN4F9EuZvyr57a3xUSltnkgfIOjM0KQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9J9/GjwHWXVOk78M7BOCW77BqHoMYk4rboFHyrAYiWs=;
 b=nIlvCVQGMHOqbKsLgNb17p8CFYxnwMTki9HBu73Kb+tXtwNedyoFFqJgc0og4UuW48DRKoK6x17Sp2FZBbExmsi9ZMldPznh/OpN2nka1bMjowJMcfdk8uWtk9j7116/661hl1P0T+DImivAHbFjsfeOle1mwpqlkMk46m/xaeY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3559.namprd12.prod.outlook.com (20.178.53.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.18; Tue, 10 Dec 2019 20:56:02 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::81f8:ed8a:e30e:adb0]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::81f8:ed8a:e30e:adb0%7]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 20:56:01 +0000
Subject: Re: [PATCH] drm/amd/display: fix undefined struct member reference
To:     "Liu, Zhan" <Zhan.Liu@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     "Liu, Charlene" <Charlene.Liu@amd.com>,
        "Yang, Eric" <Eric.Yang2@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Cornij, Nikola" <Nikola.Cornij@amd.com>,
        "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Lei, Jun" <Jun.Lei@amd.com>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
References: <20191210203101.2663341-1-arnd@arndb.de>
 <DM6PR12MB34665D3A13E23D8AA7E2E7919E5B0@DM6PR12MB3466.namprd12.prod.outlook.com>
From:   "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <b552de20-dca5-b5d1-e5e8-4c09bc3fdcb5@amd.com>
Date:   Tue, 10 Dec 2019 15:55:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <DM6PR12MB34665D3A13E23D8AA7E2E7919E5B0@DM6PR12MB3466.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTOPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::19) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c54fd4f-af00-473a-31bc-08d77db35d4b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3559:|BYAPR12MB3559:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3559360A046387881D113FB0EC5B0@BYAPR12MB3559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02475B2A01
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(189003)(199004)(13464003)(4001150100001)(81156014)(66556008)(81166006)(36756003)(8676002)(5660300002)(26005)(186003)(52116002)(6666004)(31686004)(4326008)(2616005)(316002)(53546011)(86362001)(31696002)(966005)(66946007)(6506007)(8936002)(110136005)(66476007)(2906002)(6486002)(6512007)(54906003)(478600001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3559;H:BYAPR12MB3560.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHRgsuGIqCsqi7UiyBzkPD9HwozJ+QYHAnw0lKVG3xfqj8cabosKG0E8k4KiQ2iDnW9zbkzTaDnfq+GNvmK10K9QHm9d5tr95UuzJq/1rqPNczcZqLLyr78XQWE/WNGxfOM+7lRx4sjGwIMDdLvYXFW4lnzcFKxryCGgPtqyPIDKjVAzW3etCcITs3sqTe2XLt5RCi4kdFA9qkFQe7cG9uSrV+SumZ0nB0qBrhlB3ls+8uxkXJFO2RKpBcb49BDwpMzYHY+RCQRyTSB2sF58XFfaIiF7317GdK6VuVvx4C8r35pwfdjO2Wj+1f1wWIFTYzIteAHYmFsBAc2LjIew9wKmLn/UuInIe/CdJdgV9WU8ESuzGgFaJOUTB+jrdJBSSrpF2Ue1ntpRtCK0Z7xqrWx06Y/QnG5LJ8OvHz7Tf6Qe+60nGkLCcv7FaAh+5tnEDLlDl4J+wGUuxicbgiTzCkWQKkU81STPul5yV4YCh8gbTcNCWL8KUhyxkyb8YFWANWL4HkOyqn74uHzJ4f6hSPwubVKdBSl+TsPS2r+fYpl2qmuxOvTdwB/Yupk61YTp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c54fd4f-af00-473a-31bc-08d77db35d4b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 20:56:01.6819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxm+ZFsaAGyRPaI5IYYFxGqV+0nLzBH8KNDKP/TtLETdaaw9TaHqwLXyInlccetoVwcxiGppbXt7JIOIwSjR2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3559
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-10 3:54 p.m., Liu, Zhan wrote:
> 
> 
>> -----Original Message-----
>> From: Arnd Bergmann <arnd@arndb.de>
>> Sent: 2019/December/10, Tuesday 3:31 PM
>> To: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
>> <Sunpeng.Li@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
>> <David1.Zhou@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter
>> <daniel@ffwll.ch>; Liu, Zhan <Zhan.Liu@amd.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>; Laktyushkin, Dmytro
>> <Dmytro.Laktyushkin@amd.com>; Lakha, Bhawanpreet
>> <Bhawanpreet.Lakha@amd.com>; Lei, Jun <Jun.Lei@amd.com>; Liu,
>> Charlene <Charlene.Liu@amd.com>; Yang, Eric <Eric.Yang2@amd.com>;
>> Cornij, Nikola <Nikola.Cornij@amd.com>; amd-gfx@lists.freedesktop.org;
>> dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
>> Subject: [PATCH] drm/amd/display: fix undefined struct member reference
>>
>> An initialization was added for two optional struct members.  One of these is
>> always present in the dcn20_resource file, but the other one depends on
>> CONFIG_DRM_AMD_DC_DSC_SUPPORT and causes a build failure if that is
>> missing:
>>
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:926:1
>> 4: error: excess elements in struct initializer [-Werror]
>>     .num_dsc = 5,
>>
>> Add another #ifdef around the assignment.
>>
>> Fixes: c3d03c5a196f ("drm/amd/display: Include num_vmid and num_dsc
>> within NV14's resource caps")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thank you for catching that 😊 On my side I kept that flag enabled all the time, so I didn't realize there was a warning hidden here.
> 
> Reviewed-by: Zhan Liu <zhan.liu@amd.com>

What tree is this reported on?

We dropped this flag whenever building DCN. Sounds like we're missing a 
patch if you're getting this.

So this is a NAK from me for going into amd-staging-drm-next at least.

Nicholas Kazlauskas

> 
>> ---
>>   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
>> b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
>> index faab89d1e694..fdf93e6edf43 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
>> @@ -923,7 +923,9 @@ static const struct resource_caps res_cap_nv14 = {
>>   		.num_dwb = 1,
>>   		.num_ddc = 5,
>>   		.num_vmid = 16,
>> +#ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT
>>   		.num_dsc = 5,
>> +#endif
>>   };
>>
>>   static const struct dc_debug_options debug_defaults_drv = {
>> --
>> 2.20.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 


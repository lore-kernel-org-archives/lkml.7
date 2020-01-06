Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE56EC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B7120731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yhk/G0eQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgAFOIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:08:09 -0500
Received: from mail-bn7nam10on2081.outbound.protection.outlook.com ([40.107.92.81]:6059
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726307AbgAFOIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:08:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbu7kKGAT6oqo+07p1TNYGevPQSG3lCkJ/5oWr12afdGCxNbWR/KLOXvp9hywEC/mmcNo4xBbiKj+coMMsYKMPRK/OFIF3XTpiSbQqAuokWxbyFOy0YN+wDz7xS0rZcKrzkof3w+7S6lac7V+VuZT4JYtmPbPYj9O3445r4KRLP0o2A7K/ngxLuVT5cIad7SnFrCfsvbGn616YnGt/PXhrsDGgjzGk9fjYLfiznA55BBDVL4a78IDE7Zw95XTG/EHEEzx6c47SUADM4VfVsC9a/RinM6/uvqP1ccj8E9hLEthMI93HDtDd4A2u0L6e8Vf5YYvMrP05IaqOzyhvAXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXzMi4+r13IvuJ/ir8A+SMGm32tj96WDfpNY8If1LmM=;
 b=ike1NtZ6NU3NDHY5CxRQxWlBCX3bspcstDgkdY24KanJhDFqsGRasM/6XN5wLS5LuSMwxrAZ5V1QmBZ6ULZVV7QeyyO2PaYYHYvhRjvi+9eYX/ym1CBBI+1FFg6P88J9uSvkspCOwSGmjp49lDAWL/vIUNEY3CkAloVF4lNccpVHCFNPZLv0AS/cyssWIu0cgiqTi+9JuDT1P2diaHol4pdlL/FWWEcFJw9coI966blPB9l87AT2vdabc9dP2dwe33wEtwQw716+AlcKTQU7A6AOSVg5gOHfnhtprxwCjCmLTWVXQZUFYbs/FHJGG20KM4CuSMjyWkXGZfbetWr9+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXzMi4+r13IvuJ/ir8A+SMGm32tj96WDfpNY8If1LmM=;
 b=yhk/G0eQmifRWyMNM4gieClGPlbdmRArwA0oq1RUt79CxlOTmUuIFNHmDfy197RTI8c1Sj4YeyrG3cuqzIF95pFD0tEXLLUWjkkOWPm5nO+/G3ZudFqp33jaHddsffSIr+f+mOqH9hP/QAkdVmumOO9r5AR18mZw+ij+BGOi6kA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2455.namprd12.prod.outlook.com (52.132.142.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Mon, 6 Jan 2020 14:08:04 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 14:08:04 +0000
Subject: Re: Warning: check cp_fw_version and update it to realize GRBM
 requires 1-cycle delay in cp firmware
To:     =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Alex Deucher <alexdeucher@gmail.com>,
        Paul Menzel <pmenzel+amd-gfx@molgen.mpg.de>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Chang Zhu <Changfeng.Zhu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <745c5951-5304-9651-34f1-6b3f6a713ece@molgen.mpg.de>
 <CADnq5_PH=ww4nNzRmC6PkyfPNomH_1FXWeMTJpS2pt6CpuRZMA@mail.gmail.com>
 <3553af46-c9c5-cd33-e7f9-bf7a1a5f49a7@daenzer.net>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9e4d867b-cd30-eb2d-406b-d6a462bdb04c@amd.com>
Date:   Mon, 6 Jan 2020 15:07:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <3553af46-c9c5-cd33-e7f9-bf7a1a5f49a7@daenzer.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:205:1::33) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR07CA0020.eurprd07.prod.outlook.com (2603:10a6:205:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.4 via Frontend Transport; Mon, 6 Jan 2020 14:08:02 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d8f66ea-4912-4271-5e3d-08d792b1d8d3
X-MS-TrafficTypeDiagnostic: DM5PR12MB2455:|DM5PR12MB2455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB245582A61F2C5D9B12DB060F833C0@DM5PR12MB2455.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0274272F87
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(199004)(189003)(6666004)(5660300002)(6486002)(2616005)(66574012)(53546011)(2906002)(52116002)(86362001)(8936002)(8676002)(16526019)(186003)(81166006)(81156014)(31696002)(15650500001)(66556008)(66476007)(66946007)(4001150100001)(4326008)(36756003)(31686004)(316002)(54906003)(478600001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2455;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Z3gsyt4i6VMxY3C5DWoV/4UX5OwIel5jRGl9NN86BPVf8qiNoLqbRcgPxIjNPSw5bIB1JOIHlm1aSz2NB024Hn/IAy12pUg3CeiQ5f7oXuovfpwRFS20FkAe2g7++pa5/QRgutiXENjsxNm8IkZEKUUK65fMq0LdidFfmpv0ExYkOnmLriETrRQyaXtKAfseDwTbfFtE8r2FThWP9PLmj9tQVd5FcgUDt79ctPy9G2fEPWJ85l33S+qhMIdwLFnGeO2eNOKoWTiC7+poGIqA8+zqFJpJ3WsLYTknlSJQiRnhsPGCCqSo6mmC8mQ9i/c2q4Tp8fnEy+VY+r3jPcjPu+WWCGIqElEr6k5caOcwMDLrZmPS1QTEPYJCOwiV6LJ4cxeaXJg1SVLle+AK6gLAQW7lA40uFUvpHlyAxvoRc3ZH9xM9nBNeDNFYQ7YKZbx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8f66ea-4912-4271-5e3d-08d792b1d8d3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2020 14:08:04.8628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGCcmF3ZLPNKwNh3JJUv38o6LIo4cPn0j3lF4+bjaWmzp3HBXuDGg8qYA80OWfg/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.01.20 um 12:29 schrieb Michel Dänzer:
> On 2019-12-26 5:53 p.m., Alex Deucher wrote:
>> On Thu, Dec 26, 2019 at 5:11 AM Paul Menzel
>>>> [   13.446975] [drm] Warning: check cp_fw_version and update it to realize                          GRBM requires 1-cycle delay in cp firmware
>>> Chang, it looks like you added that warning in commit 11c6108934.
>>>
>>>> drm/amdgpu: add warning for GRBM 1-cycle delay issue in gfx9
>>>>
>>>> It needs to add warning to update firmware in gfx9
>>>> in case that firmware is too old to have function to
>>>> realize dummy read in cp firmware.
>>> Unfortunately, it looks like you did not even check how the warning is
>>> formatted (needless spaces), so I guess this was totally untested. Also,
>>> what is that warning about, and what is the user supposed to do? I am
>>> unable to find `cp_fw_version` in the source code at all.
>>>
>> The code looks fine.  Not sure why it's rendering funny in your log.
>>                 DRM_WARN_ONCE("Warning: check cp_fw_version and update
>> it to realize \
>>                               GRBM requires 1-cycle delay in cp firmware\n");
> Looks like the leading spaces after the backslash are included in the
> string. Something like this should be better:
>
>          DRM_WARN_ONCE("Warning: check cp_fw_version and update "
>                        "GRBM requires 1-cycle delay in cp firmware\n");

Warning and error messages in the kernel should be on a single line if 
possible to allow for searching the kernel code for the string of the 
message.

I suggest to just shorten the message. Especially it is irrelevant why 
the CP firmware is to old, that is debugging info at best. Additional to 
that the "Warning:" is superfluous.

Something like DRM_WARN_ONCE("CP firmware version to old, please 
update!") should perfectly do it.

Regards,
Christian.

>
> (or maybe the intention was to put the second sentence on a new line?)


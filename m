Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F996C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D89D21901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="11RgK0Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbfGVRoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:44:00 -0400
Received: from mail-eopbgr690046.outbound.protection.outlook.com ([40.107.69.46]:23365
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727510AbfGVRn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:43:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnPEaQUcJc7gT6Xtcrk3LB7gyrfoCXIqtoQ4Fcg5xtC3E2/kA7iUXgOd0e+e/7pFRRt4OAPDiOpta+LUOUP/DRdO/ac/E2Z39FeV9WIVM137xuUwm1RQRNGsCafOS3vZazsBFH+90OG9jxM21HmaCk5ZZ4eVIcdGID+QdJCc1HBTR/Uw8eaSXcN4FEyox1iQco3n2CXP3IZ5cWAHGgzDvzPzCQDaAgFbVjzrV8/BzZNsMeh1YWkGHzmQF4tTFSc3sQp4eXn8A6CqRs4FrprRxLzcnj1GhX0LPHNWh1qXC5+19DmZe/10nS2jO+/nwb8HYQ/0w1a2i8yVF224EkUXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wz9Oq3jHYUDrU+vzUuNEx/znkkzRCOVFQVbyvG59/U=;
 b=RsGbEnZoJJXlephHHcTU7pe5lXv6DoDNcOj7YbwK1sEoruHnHR2Nv8Rx4hvdZKtHeJfilx3GvT0LZzgut9bILeZ0aAh6zq0h/ggLXQNpGVe2wSJSxhky1z2YlXJrQEiqYUV/lXcqjUYT01GfyK2Qvixyxe3Q27+V9W5GLvWtu3vaNToyvRzFPIogQx100QaLbFXBZwmGsijrf/Ry6NbUfVoG696I4di9QOI/Nwzw1gNSWNZal5OZjz3hnd5uKlrJJmyQ9Ei7YtFPI0dO3P9rYZoPY1OC1uTo/2z4j4h1r1HCapdRV2HIMT3FmQ2/Rkbhb3cLs6p4EZlpz0KgQtfjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wz9Oq3jHYUDrU+vzUuNEx/znkkzRCOVFQVbyvG59/U=;
 b=11RgK0Fb3W7Pk0wzsO1BbzrUFLjeN7iMA/PtsTKX48hEXPEaHWNOXr1FL9U0mAx5ezaZoUhlpUCSOYvNQKM/g1oepbEO1fx0t3vF5IXjXk4oNiGs6f2btBEMdCHYqnk7S8yfU2rIe8Urv5tjaMq0yqnYrUxEo7VYYWoaqZ26Ja8=
Received: from DM6PR12MB3241.namprd12.prod.outlook.com (20.179.105.153) by
 DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Mon, 22 Jul 2019 17:43:56 +0000
Received: from DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::2532:fffd:e1e1:3bdc]) by DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::2532:fffd:e1e1:3bdc%6]) with mapi id 15.20.2094.017; Mon, 22 Jul 2019
 17:43:56 +0000
From:   "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Cox, Philip" <Philip.Cox@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdkfd/kfd_mqd_manager_v10: Fix missing break in
 switch statement
Thread-Topic: [PATCH] drm/amdkfd/kfd_mqd_manager_v10: Fix missing break in
 switch statement
Thread-Index: AQHVQFzD0k60V1DuYEWlKWHlkB78W6bWfGgAgABPVwCAAARmgIAAGTAA
Date:   Mon, 22 Jul 2019 17:43:56 +0000
Message-ID: <fd20d447-dde0-a24d-8d63-d846accb5cc9@amd.com>
References: <20190721225920.GA18099@embeddedor>
 <c735a1cc-a545-50fb-44e7-c0ad93ee8ee7@amd.com>
 <BN6PR12MB18098741A081711936563597F7C40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <b1feb7e5-bd52-ef1b-b72e-b98b2c954b89@embeddedor.com>
In-Reply-To: <b1feb7e5-bd52-ef1b-b72e-b98b2c954b89@embeddedor.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
x-clientproxiedby: YTBPR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::24) To DM6PR12MB3241.namprd12.prod.outlook.com
 (2603:10b6:5:186::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shaoyun.Liu@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45840885-27a7-461e-89e2-08d70ecc2bc2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3466;
x-ms-traffictypediagnostic: DM6PR12MB3466:
x-microsoft-antispam-prvs: <DM6PR12MB3466EB37A2A9080FD6CD3B83F4C40@DM6PR12MB3466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:305;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(8936002)(102836004)(186003)(14444005)(66066001)(65956001)(256004)(65806001)(2616005)(476003)(66556008)(11346002)(446003)(66446008)(66946007)(64756008)(66476007)(26005)(5660300002)(2906002)(36756003)(229853002)(71190400001)(71200400001)(53546011)(386003)(6506007)(76176011)(31686004)(52116002)(4326008)(486006)(68736007)(86362001)(6436002)(6512007)(3846002)(6116002)(6486002)(53936002)(110136005)(81166006)(81156014)(64126003)(65826007)(14454004)(25786009)(6246003)(305945005)(99286004)(7736002)(478600001)(31696002)(316002)(54906003)(8676002)(58126008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3466;H:DM6PR12MB3241.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Lv54kfGQJ/1EQ2o3x5vOG39u4qKSaSB9PhiipbRZbUPEJ1H0ZBYqxAu3GtmNY9zOIUMqc/tvR8HyzsYtTQp4TKyfFAFMqKEXnvW/OHCoKECDKs3KLPXQ/BP3Uf3Isug7jS5OTkSA3KPcxbHZxfbJEPiqi9XNtwrrfZe2VLlZgYhZReiQ6fOKNceyx6kw9ZnZobL44nDe36zrdO5Ky5VQYqSAsssok0nucQZxHIdrOPNKfCB9uHLCeBPQhn7oPNCRzMGai79gSFY9O6gRawARmfSMLpOB6EuqSSCjkZ7jOhO5jwV3gYosByJBxUujIC/iSv8dYsqgApeP1EFwdHH/YJNmM6m2NwpWgqNI6oBpQ7fy/FFKpzvY0V6ml7aotjdBlLcGWtnMwNBCkL3LgfmSi0XOr0vE/H5NGkpkCv/L/DQ=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <988882E2B639C74B889D4B8FD45F7B31@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45840885-27a7-461e-89e2-08d70ecc2bc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 17:43:56.9419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ShaoyunL@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That sounds good to me .

Regards

shaoyun.liu

On 2019-07-22 12:13 p.m., Gustavo A. R. Silva wrote:
>
> On 7/22/19 10:58 AM, Deucher, Alexander wrote:
>> We need to add a /*fall through */ comment then.
>>
> It might be better to remove the call to pr_debug() in KFD_MQD_TYPE_CP:
>
> 	case KFD_MQD_TYPE_CP:
>         	case KFD_MQD_TYPE_COMPUTE:
> 		pr_debug("%s@%i\n", __func__, __LINE__);
> 		mqd->allocate_mqd =3D allocate_mqd;
>
> Thanks
> --
> Gustavo
>
>
>> Alex
>> ________________________________
>> From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
>> Sent: Monday, July 22, 2019 11:14 AM
>> To: Gustavo A. R. Silva <gustavo@embeddedor.com>; Cox, Philip <Philip.Co=
x@amd.com>; Oded Gabbay <oded.gabbay@gmail.com>; Deucher, Alexander <Alexan=
der.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhou, D=
avid(ChunMing) <David1.Zhou@amd.com>; David Airlie <airlied@linux.ie>; Dani=
el Vetter <daniel@ffwll.ch>
>> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; dri-d=
evel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; linux-kernel@=
vger.kernel.org <linux-kernel@vger.kernel.org>
>> Subject: Re: [PATCH] drm/amdkfd/kfd_mqd_manager_v10: Fix missing break i=
n switch statement
>>
>> This one properly in purpose , The mqd init for CP and  COMPUTE will
>> have the same  routine .
>>
>> Regard
>>
>> sshaoyun.liu
>>
>> On 2019-07-21 6:59 p.m., Gustavo A. R. Silva wrote:
>>> Add missing break statement in order to prevent the code from falling
>>> through to case KFD_MQD_TYPE_COMPUTE.
>>>
>>> This bug was found thanks to the ongoing efforts to enable
>>> -Wimplicit-fallthrough.
>>>
>>> Fixes: 14328aa58ce5 ("drm/amdkfd: Add navi10 support to amdkfd. (v3)")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers=
/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
>>> index 4f8a6ffc5775..1d8b13ad46f9 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
>>> @@ -430,6 +430,7 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_M=
QD_TYPE type,
>>>         switch (type) {
>>>         case KFD_MQD_TYPE_CP:
>>>                 pr_debug("%s@%i\n", __func__, __LINE__);
>>> +             break;
>>>         case KFD_MQD_TYPE_COMPUTE:
>>>                 pr_debug("%s@%i\n", __func__, __LINE__);
>>>                 mqd->allocate_mqd =3D allocate_mqd;

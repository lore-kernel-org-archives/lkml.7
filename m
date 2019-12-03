Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF64C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB77206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uJAZO2E1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfLCJ6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:58:23 -0500
Received: from mail-eopbgr680057.outbound.protection.outlook.com ([40.107.68.57]:39688
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfLCJ6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:58:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1Utp1grA+a/D1iQ8zj0NAcgVN8u4xAZMFaStLJsoSeckggszGJEn+n1IRc5Cf/cWfqA9pI14fyrx8GkqhkOfJonULEYakL/+Sx54rUOHzvE6gGav9P3RvqLjlo1ooQIcY9p5sEFx4I+2oqMmkNicKLX/JjVVAG1FjO1DTb1vq3/qF8CrX4Eav8cUVAZJFmZyN3KNfM6KpENFSWI2y6wHe5ex4Gm0/FpSKcvD6whrF+qFiMFd0ixLoDPTpO7RCRMRzJLVm482W6/nz+xtH3d5ueeVjNJjTrA6o2VLpUYpXgfylB2sB5E4UgQwAKJdNFsw8nOd/gMXJ6YiV+6Gb3seQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOCf11jeNVYXEtc5bvdpGgBXHZ1TnDm7c+KlJM6MpKI=;
 b=hvnt1rMyqAlC1v8eoNTWidm2WioIJrzdeB20b/MiV8MZIGibbdxfe5tF/0ONRoHS9jSokcAjlBXCoC0QfRZVcXZ79wDtQTMi3NH3ql9SC+2WHhiuC1EIpsS4gAf4MsjYGyOp0qB2h9wTvhko5uN4fR328QnGYGw9r/JvG+vn68Ia6lfZQKCZQepi4JNeAD/QWJozxLWV+aT+pHt6ZIa672n5srGubRifH9xP+JsbWxNu8I8lS6n0TbR+Fy1az7DMrZ53b5mG2Wky708fJCj3CPrCA9Fe0ERpXVQeaqZrmUNpB6j5LqCI5/emPa7VW855RV0BI3TDrkNdVvjwSItmGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOCf11jeNVYXEtc5bvdpGgBXHZ1TnDm7c+KlJM6MpKI=;
 b=uJAZO2E1lm6CiAXAighvpBPOZ6gLnf3c9sVy8Oe8hL4QlyVZ7K1kO/VqNecMbN/QcNse7hBquSyFKPuBJbTJltSRK9TqCKmBzm8CxRIQIqEO3mgKi09pUewRKKktOY9XMg0pZDMjLujQWr1R8UsCt5o+rvgXOP5BwXRjSAzNo7U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1561.namprd12.prod.outlook.com (10.172.37.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Tue, 3 Dec 2019 09:58:17 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 09:58:17 +0000
Subject: Re: [PATCH 2/2] drm/ttm: Fix vm page protection handling
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@vmware.com, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20191203075446.60197-1-thomas_os@shipmail.org>
 <20191203075446.60197-3-thomas_os@shipmail.org>
 <20191203095502.hw3r33ioax2x4kvt@box>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c1f35529-6e3c-2ba5-bd86-e7cc04cbc1b1@amd.com>
Date:   Tue, 3 Dec 2019 10:58:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191203095502.hw3r33ioax2x4kvt@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0110.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::15) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dad1d722-6ccc-41db-8872-08d777d751ea
X-MS-TrafficTypeDiagnostic: DM5PR12MB1561:
X-Microsoft-Antispam-PRVS: <DM5PR12MB156141F43192DA5534D9A22C83420@DM5PR12MB1561.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 02408926C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(81166006)(58126008)(110136005)(54906003)(6666004)(2906002)(316002)(7736002)(305945005)(66574012)(81156014)(2870700001)(99286004)(46003)(8676002)(65956001)(2616005)(14444005)(6116002)(4326008)(11346002)(446003)(25786009)(31686004)(6486002)(14454004)(6246003)(186003)(86362001)(229853002)(6436002)(50466002)(478600001)(4744005)(66556008)(66476007)(52116002)(76176011)(66946007)(2486003)(6506007)(386003)(8936002)(36756003)(5660300002)(7416002)(6512007)(23676004)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1561;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vBhSrnjkZB/vYcanaNS6H/VutpcS0xEVepwaha+lXSAloAuXfYd6COYlX6e/H95rL9jnALS2Vp1Jd8i1HvEXQYX8t8CpCQkiHTa2YJNHrfQGepZ2zXIKkx4rdhtd92xo+Dd1Omju5Bt2vL+aTD7Xrsn2OY6J8SiR96Q7KmlxZpfkHMtjqYW1s28MV//RvBFZSKlA4QVzvSjNNHmIZdNL6XdMTASzDxlVbNWXm583lnd00sD5xCiglO9S6g1+gMfgmQ/5XZJk2CZBjytoX2/gd8juyhY4semBe/YahXD7XlcMENsQP9E5zJ7RS/VJJ8PEVCsMIBfsfL2xuGhGPYyx5/syKdx/cTMCf7nvDoMsgtH3QXoX0zF+X/ygSWddInZHIEfJet/Zd4L7sKGvi3LoGi+tGCYlE8ijOs8kICCcONXDBD6ECZBiMREVzDKELyri
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad1d722-6ccc-41db-8872-08d777d751ea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 09:58:17.6871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ca96OyC1Bhwfp/OsQSiWBT4OSDQ3PKEknhOAdolc1OYprE6c8HHqjm9Wwhs5RVeO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1561
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.12.19 um 10:55 schrieb Kirill A. Shutemov:
> On Tue, Dec 03, 2019 at 08:54:46AM +0100, Thomas Hellström (VMware) wrote:
>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>
>> We were using an ugly hack to set the page protection correctly.
>> Fix that and instead use vmf_insert_mixed_prot() and / or
>> vmf_insert_pfn_prot().
>> Also get the default page protection from
>> struct vm_area_struct::vm_page_prot rather than using vm_get_page_prot().
>> This way we catch modifications done by the vm system for drivers that
>> want write-notification.
> Hm. Why doesn't your VMA have the right prot flags in the first place? Why
> do you need to override them? More context, please.

TTM allows for graphics buffer to move between system and IO memory. So 
the prot flags can change on the fly for a VMA.

Regards,
Christian.

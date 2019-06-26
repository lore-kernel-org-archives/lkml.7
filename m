Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410FCC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BC0216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Aj/ZWMrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfFZVSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:18:44 -0400
Received: from mail-eopbgr680068.outbound.protection.outlook.com ([40.107.68.68]:42251
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726223AbfFZVSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zADyRKxG1rXeQLACDKl7XkRNXQhB7WYNfstazbgDZg=;
 b=Aj/ZWMrBpAFwC6f3rbwn/tzOuduuum2Ge8NSYVHJ0w9jsJnFobE2pBMy2xuQl6avCj8Sh/Ohk/0m/TezBI+UoRVGRRkypr+auSNi3gXwt/7u0qiECo/E00Fc1sQ/G6Wqpjfou3fM/ehpPqdYa9tg00qp2XTUDyc//88oxeto5Is=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3257.namprd12.prod.outlook.com (20.179.105.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Wed, 26 Jun 2019 21:18:01 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::9b0:ee82:ca4b:a4e7]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::9b0:ee82:ca4b:a4e7%6]) with mapi id 15.20.2008.018; Wed, 26 Jun 2019
 21:18:01 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] sched/topology: Improve load balancing on AMD EPYC
Thread-Topic: [PATCH] sched/topology: Improve load balancing on AMD EPYC
Thread-Index: AQHVG7eoxI4KuIDvfEiZt9H+t4SB36aNWbaAgAgVJQCAAU4pgIAKkNWAgAAeuwCAAimSgIAHY3AAgAOYOwA=
Date:   Wed, 26 Jun 2019 21:18:01 +0000
Message-ID: <989944bc-6c3a-43b5-4f95-0bdfcc6d6c29@amd.com>
References: <20190605155922.17153-1-matt@codeblueprint.co.uk>
 <20190605180035.GA3402@hirez.programming.kicks-ass.net>
 <20190610212620.GA4772@codeblueprint.co.uk>
 <18994abb-a2a8-47f4-9a35-515165c75942@amd.com>
 <20190618104319.GB4772@codeblueprint.co.uk>
 <20190618123318.GG3419@hirez.programming.kicks-ass.net>
 <20190619213437.GA6909@codeblueprint.co.uk>
 <20190624142420.GC2978@techsingularity.net>
In-Reply-To: <20190624142420.GC2978@techsingularity.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
x-originating-ip: [165.204.77.11]
x-clientproxiedby: SN4PR0701CA0016.namprd07.prod.outlook.com
 (2603:10b6:803:28::26) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51c536ed-a2da-4298-f10e-08d6fa7bc523
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR12MB3257;
x-ms-traffictypediagnostic: DM6PR12MB3257:
x-microsoft-antispam-prvs: <DM6PR12MB3257CD0FC320BF44FD981949F3E20@DM6PR12MB3257.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(39860400002)(346002)(396003)(376002)(366004)(189003)(199004)(8676002)(14444005)(81166006)(81156014)(72206003)(71200400001)(31696002)(476003)(71190400001)(11346002)(256004)(229853002)(6436002)(68736007)(486006)(31686004)(2906002)(446003)(2616005)(478600001)(25786009)(7736002)(305945005)(36756003)(4326008)(26005)(99286004)(110136005)(386003)(6246003)(76176011)(102836004)(65826007)(6506007)(64126003)(3846002)(14454004)(73956011)(54906003)(66446008)(53546011)(66476007)(66556008)(6116002)(8936002)(6512007)(186003)(65956001)(66066001)(65806001)(53936002)(6486002)(86362001)(316002)(66946007)(5660300002)(58126008)(64756008)(52116002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3257;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5w6h1en8e5WJDIR0l9+WVG/rV2NDrWZgAIJkxEkQPHSKV72dBmdXSml7J55kY3tWxGPHG1DzZaOfTQTJ+14YJ/kCdiI6zYX+6zqGX4yQ9YjuVrOtDyQTR605m22Ah0C/YF6buzmX9MC3dixd4FyuJnmvauLJ025BYevkc1h/0q7rslEXDOKy2apl2mLFkOVBYzKztcAF5kqmZXJO2Q3KUvyj2BBy0EdsYwO3jA4/iTz1sPsLIfA+GTczV0T3I02cIpRzWpzuReIllsVe7zhpF9x/wJBicO9VJaCJv6QaG3x2HH4cUqoxO8JuYQiF4cmtGBqI0DXPzYGAGbgdYAJyeGCjaAc9oc1i/VQMqeapCYv2VCMw2EDPpor9KAqnO73Xq0pu3drhdYQu4p9oof2K/gzweViB2HleizhYgWaYoa4=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <F09C500C804F564DA3E1CE086C6502D1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c536ed-a2da-4298-f10e-08d6fa7bc523
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 21:18:01.8090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssuthiku@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/19 9:24 AM, Mel Gorman wrote:
> On Wed, Jun 19, 2019 at 10:34:37PM +0100, Matt Fleming wrote:
>> On Tue, 18 Jun, at 02:33:18PM, Peter Zijlstra wrote:
>>> On Tue, Jun 18, 2019 at 11:43:19AM +0100, Matt Fleming wrote:
>>>> This works for me under all my tests. Thoughts?
>>>>
>>>> --->8---
>>>>
>>>> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
>>>> index 80a405c2048a..4db4e9e7654b 100644
>>>> --- a/arch/x86/kernel/cpu/amd.c
>>>> +++ b/arch/x86/kernel/cpu/amd.c
>>>> @@ -8,6 +8,7 @@
>>>>   #include <linux/sched.h>
>>>>   #include <linux/sched/clock.h>
>>>>   #include <linux/random.h>
>>>> +#include <linux/topology.h>
>>>>   #include <asm/processor.h>
>>>>   #include <asm/apic.h>
>>>>   #include <asm/cacheinfo.h>
>>>> @@ -824,6 +825,8 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
>>>>   {
>>>>   	set_cpu_cap(c, X86_FEATURE_ZEN);
>>>>  =20
>>>
>>> I'm thinking this deserves a comment. Traditionally the SLIT table held
>>> relative memory latency. So where the identity is 10, 16 would indicate
>>> 1.6 times local latency and 32 would be 3.2 times local.
>>>
>>> Now, even very early on BIOS monkeys went about their business and put
>>> in random values in an attempt to 'tune' the system based on how
>>> $random-os behaved, which is all sorts of fu^Wwrong.
>>>
>>> Now, I suppose my question is; is that 32 Zen puts in an actual relativ=
e
>>> memory latency metric, or a random value we somehow have to deal with.
>>> And can we pretty please describe the whole sordid story behind this
>>> 'tunable' somewhere?
>>
>> This is one for the AMD folks. I don't know if the memory latency
>> really is 3.2 times or not, only that that's the value in all the Zen
>> machines I have access to. Even this 2-socket one:
>>
>> node distances:
>> node   0   1
>>    0:  10  32
>>    1:  32  10
>>
>> Tom, Suravee?
>=20
> Do not consider this an authorative response but based on what I know
> of the physical topology, it is not unreasonable to use 32 in the SLIT
> table. There is a small latency when accessing another die on the same
> socket (details are generation specific). It's not quite a local access
> but it's not as much as a traditional remote access either (hence 16 bein=
g
> the base unit for another die to hint that it's not quite local but not
> quite remote either). 32 is based on accessing a die on a remote socket
> based on the expected performance and latency of the interconnect.
>=20
> To the best of my knowledge, the magic numbers are reflective of the real
> topology and not just a gamification of the numbers for a random OS. If
> anything, the fact that there is a load balancing issue on Linux would
> indicate that they were not picking random numbers for Linux at least :P
>=20

We use 16 to designate 1-hop latency (for different node within the same so=
cket).
For across-socket access, since the latency is greater, we set the latency =
to 32
(twice the latency of 1-hop) not aware of the RECLAIM_DISTANCE at the time.

At this point, it might not be possible to change the SLIT values on
existing platforms out in the field. So, introducing the AMD family17h
quirk as Matt suggested would be a more feasible approach.

Going forward, we will make sure that this would not exceed the standard
RECLAIM_DISTANCE (30).

Thanks,
Suravee

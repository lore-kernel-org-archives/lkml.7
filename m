Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400E4ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052572133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="IWlm4dFv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="8TaBfm8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbfJNPuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:50:32 -0400
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:9758
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730429AbfJNPub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gIoCbjfgqtqX+bf6NrJTLFtDvb/O9kJZlsrfNurJFY=;
 b=IWlm4dFvuW+eglH9+0khhh/Qr1HPbnqtR8NNHxs6OKF3oG/4v3gfjGN3qGeOdceNDHjdxgeKznqXdu0dqjhrtSXCSHgV53pFUIFG69oIBMwG8ths8kwBEZHWj86onJYCIbwIDV/dmwswH0hCmdEKDCnvDd1A0POdv/4+0tnKUJM=
Received: from VI1PR0802CA0019.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::29) by AM6PR08MB4740.eurprd08.prod.outlook.com
 (2603:10a6:20b:ca::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17; Mon, 14 Oct
 2019 15:50:25 +0000
Received: from VE1EUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by VI1PR0802CA0019.outlook.office365.com
 (2603:10a6:800:aa::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Mon, 14 Oct 2019 15:50:25 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT053.mail.protection.outlook.com (10.152.19.198) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 14 Oct 2019 15:50:23 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Mon, 14 Oct 2019 15:50:21 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8119e232b0fe8f23
X-CR-MTA-TID: 64aa7808
Received: from f04d66514384.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.13.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B68B8034-31D8-47AA-86D7-01A5309BBCBD.1;
        Mon, 14 Oct 2019 15:50:14 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f04d66514384.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 14 Oct 2019 15:50:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjRm4oIjgf/3UMpbtjiF5QoTwaxP+RuPM3aSRKC/J0GFkmxhVOdOQaiatDSJpqUtP4N1UKGOO0RiDN0yMFCmIBqjCghhFBrzHmac3Mfee/+s2gpJuhD7L4m7+TAg5gklbUwzkqVvu1WfjcnicS+4ZmU7k0zFZMcbpNedgYprQ7dW/06TJOi1t3kbdaEjvxJnQyhGnSuNJQknepN5OuDz8BSzbPuUaQq0FrAFyUHEqH4XYxJVHv3gM3f3hNTtV1fP51eJHf4ivWTNhBmZS0CfVcJRw1gE+3IhJdUWkfRkfYzhcmVZp125+90HCsj+YHa5xSrrmO9i3dfP590nQ1EvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ek5v3vIQfWWOoJ30aMK/1wdUl++wjXgDbrSO6LB123A=;
 b=Mr2FzGgcYk06yULthAlLZVZEFLqJ0wWujo2jyUlhNKE1aMF8UDwcpuemmPgngAp4a9dCS68hesh2ZvzVt6+c1UNb9lg5CUO7D5QghSJrhn/si86crHlUTBS/qyd3R06IWX4r9rHMPdYUlqjP1OAI1U8lFN3BUF0WrEoS4wc9CMB+feWmhz+qs8/kJcoPWFZpk1mubI074xAzWJvBsKKTzJ9hsoXySOZn/dDBkylts8nnPxa5WWCO9UdtO+HWOq7lBU6vx0Ek038EUldWlopS8ZaN8mb4FfFFi1kyyXaEspLj+N20L+ZWwsBbgal73MGDxXkgpkxTpvdR2a+3R48EKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ek5v3vIQfWWOoJ30aMK/1wdUl++wjXgDbrSO6LB123A=;
 b=8TaBfm8kOhbfvqcqpKlSYHyA6qcdk3yDmsWpZkwTe/bWqbXwpKsudxymsugfQd8nTV+JD2FqToH/mxFhM59LiXryRBwGt081SdB30/HuXvhyiKEXBHwsTn+AKprBUOGjBl7S93e1CtORK6MwHHgG3fchajFN2dTtWvHHMkWczgM=
Received: from AM4PR08MB2802.eurprd08.prod.outlook.com (10.171.188.27) by
 AM4SPR01MB269.eurprd08.prod.outlook.com (10.171.191.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Mon, 14 Oct 2019 15:50:12 +0000
Received: from AM4PR08MB2802.eurprd08.prod.outlook.com
 ([fe80::f888:998d:df8e:7445]) by AM4PR08MB2802.eurprd08.prod.outlook.com
 ([fe80::f888:998d:df8e:7445%7]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 15:50:12 +0000
From:   Dave P Martin <Dave.Martin@arm.com>
To:     Suzuki Poulose <Suzuki.Poulose@arm.com>
CC:     Mark Rutland <Mark.Rutland@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 1/3] arm64: cpufeature: Fix the type of no FP/SIMD
 capability
Thread-Topic: [PATCH 1/3] arm64: cpufeature: Fix the type of no FP/SIMD
 capability
Thread-Index: AQHVf45d3fyKFJDtg0OjKsHZE3QEVqdVYdoA///5kQCAADSdgIAAI4OAgASb/gD///42AIAAAUIA
Date:   Mon, 14 Oct 2019 15:50:11 +0000
Message-ID: <20191014155009.GM24047@e103592.cambridge.arm.com>
References: <20191010171517.28782-1-suzuki.poulose@arm.com>
 <20191010171517.28782-2-suzuki.poulose@arm.com>
 <20191011113620.GG27757@arm.com>
 <4ba5c423-4e2a-d810-cd36-32a16ad42c91@arm.com>
 <20191011142137.GH27757@arm.com>
 <418b0c4b-cbcd-4263-276d-1e9edc5eee0b@arm.com>
 <20191014145204.GS27757@arm.com>
 <12e002e7-42e8-c205-e42c-3348359d2f98@arm.com>
In-Reply-To: <12e002e7-42e8-c205-e42c-3348359d2f98@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.23 (2014-03-12)
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0277.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::25) To AM4PR08MB2802.eurprd08.prod.outlook.com
 (2603:10a6:205:7::27)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Dave.Martin@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 84d233e5-93f3-4055-5b23-08d750be39dd
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM4SPR01MB269:|AM4SPR01MB269:|AM6PR08MB4740:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB47406B60172DAD42C8CACF92FE900@AM6PR08MB4740.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 01901B3451
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(199004)(189003)(478694002)(81166006)(6486002)(8676002)(81156014)(8936002)(186003)(6512007)(6436002)(52116002)(7736002)(66476007)(66556008)(64756008)(53546011)(386003)(66446008)(66946007)(6506007)(66066001)(76176011)(6862004)(86362001)(6636002)(99286004)(11346002)(476003)(446003)(6246003)(229853002)(486006)(478600001)(25786009)(71190400001)(71200400001)(256004)(4326008)(14444005)(3846002)(1076003)(6116002)(316002)(14454004)(58126008)(102836004)(305945005)(26005)(54906003)(33656002)(2906002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4SPR01MB269;H:AM4PR08MB2802.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Y83Br3Jmc12ncqAFfysjY4O0c1V1x/SElCo4YIoRT1SpjBMaom7J/C+ZvJykCFZkRNlzZzfCXH7TZSCHdzTeYD7rl/PrtQKSxOrMl8GoNwqprfoftARukvUKGQ/UozZGZ6Y9cynZNHVdls1As4UHPUv+9mecyLWpwxzBo5srqWi0GSi3KKmltNj59Q5rIooiBNXcxepajWBiLIhjjhb8A6qBrax/y0czAMr8hQVqvLmqqwHwzk6M4W4w3Yib68CfFISqhhE3tBVHQZSK5z0wKl+HEWTAhmxh8uofRLGjwDiktNTs7E6UwOPoGnPdoIEuQ4Dfn8vxrINilRdGuUCgl4zrksyvp4vcR1TO80eEkZMpIvQeTk7nG6VqK3XXCJX4eh3Djnj/f2fCWT4kgAZQ2fATryHYEk82Gfe/krpnyrU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5A941A56EE2B9D47B90996BFD5A1EE55@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4SPR01MB269
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Dave.Martin@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(199004)(189003)(40434004)(478694002)(6862004)(305945005)(81166006)(3846002)(86362001)(4326008)(6636002)(356004)(33656002)(1076003)(46406003)(58126008)(7736002)(8936002)(76176011)(81156014)(8746002)(36906005)(6116002)(99286004)(6512007)(107886003)(6246003)(6486002)(229853002)(8676002)(316002)(23726003)(54906003)(186003)(26005)(6506007)(386003)(76130400001)(70586007)(22756006)(5024004)(14444005)(53546011)(70206006)(14454004)(446003)(97756001)(11346002)(336012)(26826003)(63350400001)(486006)(47776003)(476003)(126002)(2906002)(50466002)(5660300002)(25786009)(102836004)(66066001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4740;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: ebbc2d65-6d87-4666-2987-08d750be328c
X-Forefront-PRVS: 01901B3451
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2SunpzZo9MDk8qnI9Q4uvdTSSMRcx4bB+NjfMcT0q95U8Pq+1B+VSjy0+qYkRDRFpIRIXsHdUXdOte9UIPv5WdO/X6egjiwyDvXD9FpUsHeVQN1X3VfpUvPjtC9pqm1WTOl3Z7QO8JSvJF6fKCcvg7MHYAQJsf+0FENrPUwV8q7viVtXTO8jRZeGok7YwZyqfulJ5M9fTkTtJhUmDuObLOjLat89oEH5+Ld0IHOlqohB9pScrfsJNlLM7Aiid4NxCPv12V36ZlrFqLQfsxmGrXlVyw0RzFD0g1z4CFw2ZSSaap4z7HngWAlfPvEjRDK50Cx6ttyydmxKRtu1hjZtMZnWlFGVXH3sr20C5Lg/uwD0qxbz3yRwSd4grsUyiA650Z6/S0TIOXYEUcR4/WeizJmKv30NRaeQuIsDrgcnBc4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2019 15:50:23.9980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d233e5-93f3-4055-5b23-08d750be39dd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4740
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 04:45:40PM +0100, Suzuki K Poulose wrote:
>
>
> On 14/10/2019 15:52, Dave Martin wrote:
> > On Fri, Oct 11, 2019 at 06:28:43PM +0100, Suzuki K Poulose wrote:
> >>
> >>
> >> On 11/10/2019 15:21, Dave Martin wrote:
> >>> On Fri, Oct 11, 2019 at 01:13:18PM +0100, Suzuki K Poulose wrote: > H=
i Dave
> >>>>
> >>>> On 11/10/2019 12:36, Dave Martin wrote:
> >>>>> On Thu, Oct 10, 2019 at 06:15:15PM +0100, Suzuki K Poulose wrote:
> >>>>>> The NO_FPSIMD capability is defined with scope SYSTEM, which impli=
es
> >>>>>> that the "absence" of FP/SIMD on at least one CPU is detected only
> >>>>>> after all the SMP CPUs are brought up. However, we use the status
> >>>>>> of this capability for every context switch. So, let us change
> >>>>>> the scop to LOCAL_CPU to allow the detection of this capability
> >>>>>> as and when the first CPU without FP is brought up.
> >>>>>>
> >>>>>> Also, the current type allows hotplugged CPU to be brought up with=
out
> >>>>>> FP/SIMD when all the current CPUs have FP/SIMD and we have the use=
rspace
> >>>>>> up. Fix both of these issues by changing the capability to
> >>>>>> BOOT_RESTRICTED_LOCAL_CPU_FEATURE.
> >>>>>>
> >>>>>> Fixes: 82e0191a1aa11abf ("arm64: Support systems without FP/ASIMD"=
)
> >>>>>> Cc: Will Deacon <will@kernel.org>
> >>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
> >>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>>>>> ---
> >>>>>>   arch/arm64/kernel/cpufeature.c | 2 +-
> >>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cp=
ufeature.c
> >>>>>> index 9323bcc40a58..0f9eace6c64b 100644
> >>>>>> --- a/arch/arm64/kernel/cpufeature.c
> >>>>>> +++ b/arch/arm64/kernel/cpufeature.c
> >>>>>> @@ -1361,7 +1361,7 @@ static const struct arm64_cpu_capabilities a=
rm64_features[] =3D {
> >>>>>>        {
> >>>>>>                /* FP/SIMD is not implemented */
> >>>>>>                .capability =3D ARM64_HAS_NO_FPSIMD,
> >>>>>> -              .type =3D ARM64_CPUCAP_SYSTEM_FEATURE,
> >>>>>> +              .type =3D ARM64_CPUCAP_BOOT_RESTRICTED_CPU_LOCAL_FE=
ATURE,
> >>>>>
> >>>>> ARM64_HAS_NO_FPSIMD is really a disability, not a capability.
> >>>>>
> >>>>> Although we have other things that smell like this (CPU errata for
> >>>>> example), I wonder whether inverting the meaning in the case would
> >>>>> make the situation easier to understand.
> >>>>
> >>>> Yes, it is indeed a disability, more on that below.
> >>>>
> >>>>>
> >>>>> So, we'd have ARM64_HAS_FPSIMD, with a minimum (signed) feature fie=
ld
> >>>>> value of 0.  Then this just looks like an ARM64_CPUCAP_SYSTEM_FEATU=
RE
> >>>>> IIUC.  We'd just need to invert the sense of the check in
> >>>>> system_supports_fpsimd().
> >>>>
> >>>> This is particularly something we want to avoid with this patch. We =
want
> >>>> to make sure that we have the up-to-date status of the disability ri=
ght
> >>>> when it happens. i.e, a CPU without FP/SIMD is brought up. With SYST=
EM_FEATURE
> >>>> you have to wait until we bring all the CPUs up. Also, for HAS_FPSIM=
D,
> >>>> you must wait until all the CPUs are up, unlike the negated capabili=
ty.
> >>>
> >>> I don't see why waiting for the random defective early CPU to come up=
 is
> >>> better than waiting for all the early CPUs to come up and then decidi=
ng.
> >>>
> >>> Kernel-mode NEON aside, the status of this cap should not matter unti=
l
> >>> we enter userspace for the first time.
> >>>
> >>> The only issue is if e.g., crypto drivers that can use kernel-mode NE=
ON
> >>> probe for it before all early CPUs are up, and so cache the wrong
> >>> decision.  The current approach doesn't cope with that anyway AFAICT.
> >>
> >> This approach does in fact. With LOCAL_CPU scope, the moment a defecti=
ve
> >> CPU turns up, we mark the "capability" and thus the kernel cannot use
> >> the neon then onwards, unlike the existing case where we have time til=
l
> >> we boot all the CPUs (even when the boot CPU may be defective).
> >
> > I guess that makes sense.
> >
> > I'm now wondering what happens if anything tries to use kernel-mode NEO=
N
> > before SVE is initialised -- which doesn't happen until cpufeatures
> > configures the system features.
> >
> > I don't think your proposed change makes anything worse here, but it ma=
y
> > need looking into.
>
> We could throw in a WARN_ON() in kernel_neon() to make sure that the SVE
> is initialised ?

Could do, at least as an experiment.

Ard, do you have any thoughts on this?

Cheers
---Dave
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

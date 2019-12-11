Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67520C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F2A208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="o+/ASf+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfLKFZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 00:25:02 -0500
Received: from mail-eopbgr760040.outbound.protection.outlook.com ([40.107.76.40]:2326
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbfLKFZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 00:25:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npaeydtLWPECzF0Lz8wQQ21Qt8pnGzGmfzcRRee+nfiTVZmt9JB20zdYf7/yMIgdqtsOS4gbpluszPdPPE7kM1d/ndD5ozsGyAndJcEZ1+c04w8ujXhTsolZg0TK50qLw5ErNpXKS0UgB32RT/Au7YYm8QfkYM5wXwp4ZiP1RXRw3hdAYqBEea9q78cYCAXghATWhisDC9hkK0OGju+WS89r/WvAvJrLC5xOML31bhNDTwPgO1Cuaixyg18rR5IbbVi7h6wEkro1IBFutrOohxXWlW7mzRhb0i69CkjSIX57jb+HCLICtr6fvOXxhLgrAyb7B21039sdY9Ecl/TzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9nVuvmEHgKw9QnSUut2Jb27U2Nhe+2pVKZYgEO3c8s=;
 b=Kn66H4wq6joQz/j3QkAgeuyJ5sEP4kLUHuj7KG40OPTi4QCr+InBB3daJQUnkmzk3IF4oWboD4nrLVVkpjOIimkQqyyf1N7OIBt25uIJyYXSoASLxKCSSeGwxoALwCVV6Sx27JZEb3AD2J9Z/im+goXS8M1HIWCw+mHZTf8O+BIdGfPBtgWXTYfAE7FNnafZQXbqqPGFkd2irHX1vzcblHjUQi9GSyyySMVPNF5sDuqwaxZUbalrnB2dAqgEup+GTaPnDSZ0QbY0+N0GOu6ZCYX/R3gt3xL6AVkjLeDZHlGK9cDkI6fhKCbfpXLVMFWdkLEEd0dSe01A/evzLu1IaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9nVuvmEHgKw9QnSUut2Jb27U2Nhe+2pVKZYgEO3c8s=;
 b=o+/ASf+S9bCraexFt04M5ULVPsZDjAX12Ng2ygVqSCtW431yWGpcwang9aueRRnw8qFwAnyQSHz+467If6FeqKNaQVgjTOYw56NHSA4xDQgvMbxF0AAWoDLoVrMurIFG25dQErI6G8PvSnU7O+zi70CegYMvk6kn6o+YWVEU848=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from MN2PR12MB3870.namprd12.prod.outlook.com (10.255.237.93) by
 MN2PR12MB3214.namprd12.prod.outlook.com (20.179.83.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 11 Dec 2019 05:24:55 +0000
Received: from MN2PR12MB3870.namprd12.prod.outlook.com
 ([fe80::354e:13c8:116b:1261]) by MN2PR12MB3870.namprd12.prod.outlook.com
 ([fe80::354e:13c8:116b:1261%7]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 05:24:55 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] x86/fpu: Warn only when CPU-provided sizes less than
 struct declaration
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        jon.grimm@amd.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
References: <1575363688-36727-1-git-send-email-suravee.suthikulpanit@amd.com>
 <b63e2111-b0c6-a716-3d99-88f91ad64e1d@intel.com>
 <68bdd6f0-a229-433a-9234-303a3b02b092@amd.com>
 <4b20cff5-6e16-3599-4fc1-4f51d7c18d1d@intel.com>
Message-ID: <7a8fe748-2c57-295a-e6ed-8969c41462aa@amd.com>
Date:   Wed, 11 Dec 2019 12:24:42 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <4b20cff5-6e16-3599-4fc1-4f51d7c18d1d@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU1PR03CA0017.apcprd03.prod.outlook.com
 (2603:1096:802:18::29) To MN2PR12MB3870.namprd12.prod.outlook.com
 (2603:10b6:208:166::29)
MIME-Version: 1.0
X-Originating-IP: [165.204.80.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10211dec-e980-4942-70eb-08d77dfa74e1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3214:|MN2PR12MB3214:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB32142A876C8C728753F0922EF35A0@MN2PR12MB3214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(199004)(189003)(53546011)(31686004)(31696002)(6512007)(186003)(26005)(6506007)(54906003)(81156014)(316002)(2906002)(6486002)(66946007)(5660300002)(36756003)(66556008)(66476007)(81166006)(4326008)(6666004)(44832011)(2616005)(8936002)(478600001)(86362001)(8676002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3214;H:MN2PR12MB3870.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCLqPPZ8ddVfClCW7h/I0t9OB1cGbregWRSoVS6ujAhIsTbhFZhfGpbKyWpbOtyMur7ueZOR1/JNTZRCg/qPzFUFDVdd+GZy1wg5IgDP3qrYAluvfRQad32wyk4W3Y0Whu8CDTc1peBs9z5vyaq1JnB0Cwra1KodPSse4leuflYyKYxcxu6Fx+bW8guYCdgGmAyLoOuZ7Rd0hc7wVfD6iHkygRDsko3J3mHhoLypkp6ME+4VODNxfoyU8HlDUPHj77aiJaj9yUQXhTTQq6X+HSfU62jbpnlwEeWwS0VQOuRt1SRpE4YMIyIzqDoj/osEnp7ivPncFNrQDEEhePMHo+RyXBI95GQLRTh1NqciJEYUnjEbVY62efolrddvY6BfdnzdgCxwhREZFeag1HwGGyJGwoAfXVTq1KBYQiBruvv9/r1FNrCtwLE6vbeLJkct
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10211dec-e980-4942-70eb-08d77dfa74e1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 05:24:55.4670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nx7xSxgHkwKC+XpgSq4uqXS1Ewq0ok6hyiDLTMbG2O7ma2X+uNouG1/f5TYaWbxD5UUDC98Jtkcm+rax0wy1bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave

On 12/6/19 10:28 PM, Dave Hansen wrote:
> On 12/6/19 12:14 AM, Suravee Suthikulpanit wrote:
>> On 12/4/19 12:27 AM, Dave Hansen wrote:
>>> On 12/3/19 1:01 AM, Suravee Suthikulpanit wrote:
>>>> The current XCHECK_SZ macro warns if the XFEATURE size reported
>>>> by CPUID does not match the size of kernel structure. However, depending
>>>> on the hardware implementation, CPUID can report the XSAVE state size
>>>> larger than the size of C structures defined for each of the XSAVE state
>>>> due to padding.
>>>
>>> We have existing architecture for padding.  See xfeature_is_aligned(),
>>> for instance.  Are you saying that there are implementations out there
>>> that do padding which is not otherwise enumerated and that they do it
>>> within the size of the enumerated stat
>> Yes, the implementation includes the padding size within the size of
>> the enumerated state. This results in the reported size larger than
>> the amount needed by the feature.

Actually, please allow me clarify my understanding for this part.

When you referred to "the existing architecture for padding", IIUC,
that's the XSAVE state size, offset, and alignment of each extended
feature reported by the CPUID Fn 0Dh E[A|B|C]X. By "padding", do you
mean the additional area included as part of alignment?

> I don't think we've ever had XSAVE state that differed in size between
> implementations.  This kind of thing ensures that we can't have any
> statically-defined inspection into the XSAVE state.
>
> It also increases the amount of blind trust that we have in the CPU
> implementations.  However, those warnings were specifically added at
> Ingo's behest (IIRC) to reduce our blind trust in the CPU.
> 

I am not quite sure what you meant by "statically-defined inspection" and
"blind trust".

>>>> Such case should be safe and should not need to generate warning
>>>> message.
>>>
>>> I've seen these error messages trip before, but only on pre-production
>>> processors with goofy microcode.  I'd be really suspicious that this is
>>> just papering over a processor issue.  Or, that perhaps the compacted
>>> form works but the standard form is broken somehow.
>>
>> I have verified with the HW folks and the have confirmed that this is
>> to be expected.
> 
>  From a review perspective, I'd really appreciate being able to have a
> concrete discussion about exactly which state this is and exactly how
> much padding we are talking about and *why* the existing padding
> architecture can't be used.  I'd also want guarantees about this state
> not getting used for any real state, *ever*.

Here is the warning message:

     ------------[ cut here ]------------
     XFEATURE_PKRU: struct is 8 bytes, cpu state 32 bytes
     WARNING: CPU: 0 PID: 0 at arch/x86/kernel/fpu/xstate.c:558 fpu__init_system_xstate+0x2b5/0x8ea
     .......

In this case, the feature is PKRU (feature enum 9), and CPUID 0Dh instruction reports
eax:0x20 (size), ebx:0x340 (offset), ecx:0(aligned). The warning is due to the 32-byte size
is more than the 8 bytes required for struct pkru_state.

What I have been told (by HW folks) is that the hardware reports 32 bytes for PKRU feature
to account for additional padding (24 bytes) required to maintain offset for the XSAVE data
in compact form where:

     offset of the next component = offset of current component +
                                    size of current component

In this case, the hardware adds the padding needed before the offset of the subsequent
feature into the PKRU xsave state size.

Please correct me if I am wrong, but I believe this is similar to the case
mentioned in the commit ef78f2a4bf84 ('x86/fpu: Check CPU-provided sizes against struct declarations'),
where it mentions inconsistency b/w the MPX 'bndcsr' state and the C structures.

However, my point is that it should not need to warn if the xsave size is greater than
the size of the C structure.

Thanks,
Suravee

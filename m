Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F106BC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 06:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA36F2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 06:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h956Ds3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfLLGxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 01:53:01 -0500
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com ([40.107.92.68]:33268
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726825AbfLLGxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 01:53:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOVPuU0vUh3I4fOMzo1FRkOTHzo3uLDInMlPVZOA6oefKFbTfuxSQlahej7zkAHn/DpSlvQyPo+FnNq/Vs6v56584+Abxw+yka6j9dRDsWmiNciFH6Orzt9Gsh6t8cZGChYl0/DnX8v2JoUh8ZFZZEuIdFQU00zziGucWMKEzpc2lvI+mPKWIUinCIEN5UQZpCLvC99fXvnOpB2D/KafLDL5KVBFxHML4X07wdgLtMgubOc9c6J51+sN/8yuLX1TPqWO4LRLIfsrCYjcrQDLfC8k+fDM42iZjHNp4oxsHW81p5hv4MSxnauK05OdbEKSb17wEr4JIa4UAHShGupKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NKtTpcVyjF3Xhcgy3O5InqdH/NZMKo9f/VtTqn0RSA=;
 b=QkE3TKjuQdsnuLwblXG2Tnp8miX9/C4JmeS4XsXzRBDnChDpCMt6ac1Q45T0uS1O5dro539f311iUr5QeZcAVttPfxAtSrB79PDWsLr16BkD+SxAKoQSzAfbehIuTDwjOQirMmGiYYpfqvJEP2PDyQwvEHA/TJGRuwP/ymmbZZssPHr32QfenFqYebXns6MnCj0+OnQXW+2tP3kjdPKiS3J7owVlhlFjtE+4ryphJUsfcwHZvBLrV0Hhu6rS9JhgLpYq5HZ2C3kN0Hvn9jp9alueQaTBOlBTjuuIdi5IIP22gzemYsmaOER86a0oFQD2jbI9ci1fnPR4sCA5lx5jXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NKtTpcVyjF3Xhcgy3O5InqdH/NZMKo9f/VtTqn0RSA=;
 b=h956Ds3gexme4fFxmKlzIi/t2DakycAY0IUntw9oXWgh4eABV48Njr4Xt2V6PhCK8MIDyZ1/3aWCGRztDbKK66UEtm6fVdjiUWvQPVcWI+AscPBqZzhDBzLem8LwXGXfYS7Sv0gCpuiUL6ahCqJoj5dEcSiyeXbPMHxre+ef/wU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from MN2PR12MB3870.namprd12.prod.outlook.com (10.255.237.93) by
 MN2PR12MB4141.namprd12.prod.outlook.com (52.135.49.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Thu, 12 Dec 2019 06:52:57 +0000
Received: from MN2PR12MB3870.namprd12.prod.outlook.com
 ([fe80::354e:13c8:116b:1261]) by MN2PR12MB3870.namprd12.prod.outlook.com
 ([fe80::354e:13c8:116b:1261%7]) with mapi id 15.20.2516.020; Thu, 12 Dec 2019
 06:52:57 +0000
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
 <7a8fe748-2c57-295a-e6ed-8969c41462aa@amd.com>
 <d092bae0-69ea-0a57-4db5-6de074956564@intel.com>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <bac4b1ee-de8c-5e50-dc11-ab432ca0f6af@amd.com>
Date:   Thu, 12 Dec 2019 13:52:44 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <d092bae0-69ea-0a57-4db5-6de074956564@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::15) To MN2PR12MB3870.namprd12.prod.outlook.com
 (2603:10b6:208:166::29)
MIME-Version: 1.0
X-Originating-IP: [165.204.80.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 819aa540-1d8e-43ef-249f-08d77ecfebd9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4141:|MN2PR12MB4141:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4141C221CBEDAA98A114E2BBF3550@MN2PR12MB4141.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0249EFCB0B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(6666004)(31686004)(8936002)(2616005)(54906003)(86362001)(316002)(186003)(6512007)(4326008)(31696002)(26005)(2906002)(6486002)(6506007)(53546011)(44832011)(36756003)(52116002)(66476007)(478600001)(8676002)(5660300002)(81156014)(81166006)(66556008)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4141;H:MN2PR12MB3870.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F4xPenSkeooxCN8VxO2ba/AoQeifMY9Z8uwHIfra3M5Zb6Kb9OA21ySua+/Sp5/m5NRLPvIjrMl7DnTr9rFwXJ/BVkWZm+dISw9XB8zZPtDETYn6FE+1mQsR1C7RiBgJ3Bwm9nL1m12gQzHNokkrBTnEJSSe49vMcM264UPnJYHQTE87j7FZBEiF9NNcVYt24yNnh49EB4NGL1fJn7BAWiEnJUwVLdrxKeU7SD+22D+aCsccwk9+VMN1NeTF9ZS1Mew/tQTN2lZhjf2BMq0a3kgiFmYlre6gAPZyPB997kqZ7gf1SFF/BExMGGdXOAEfbUxBk15lVnoJFEaD88Cz/ZJWxLE4ZFqn85kckkPNbZT3A9E6LT90wM1GVyaWAgtS7fwuyqm+63bqizofg1TORzgRziy/tDESM8iYgwZOZfXK4mnjMYzw0aSBTI+s1xIk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819aa540-1d8e-43ef-249f-08d77ecfebd9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 06:52:57.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0fW2VWfaEW8ad3jJb0ruzOxp+Gax/JjldcEVSnQFZbbCDuHE+GZxwAe8KKmbBv4jd8I6d8kG9OkAptZ77rcVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

On 12/11/2019 9:13 PM, Dave Hansen wrote:
> On 12/10/19 9:24 PM, Suravee Suthikulpanit wrote:
>> The value returned by ECX[1] indicates the alignment of state
>> component i when the compacted format of the extended region of an
>> XSAVE area is used (see Section 13.4.3). If ECX[1] returns 0, state
>> component i is located immediately following the preceding state
>> component; if ECX[1] returns 1, state component i is located on the
>> next 64-byte boundary following the preceding state component.
> 
> Essentially, if an implementation needs state alignment or (up to) 64
> bytes of padding, it could use this existing architecture for it.

Let me check with the HW folks and get back to you on this.

>> Please correct me if I am wrong, but I believe this is similar to the
>> case mentioned in the commit ef78f2a4bf84 ('x86/fpu: Check
>> CPU-provided sizes against struct declarations'), where it mentions
>> inconsistency b/w the MPX 'bndcsr' state and the C structures.
> 
> Yep, but I fixed that by padding the C structure, not silencing the
> warning.  Also *ALL* MPX implementations have had the same size for that
> state.

Ah I see. But that solution works because the MPX feature is only on Intel.
In case of PKRU, it seems that two hardware implementations have different
padding size for PKRU state. IIUC, Intel has padding of 4 bytes based on
the following struct.

/*
  * State component 9: 32-bit PKRU register.  The state is
  * 8 bytes long but only 4 bytes is used currently.
  */
struct pkru_state {
         u32                             pkru;
         u32                             pad;
} __packed;

Therefore, I agree with you that we might need to use the ECX[1].
Let me confirm this and get back to you.

Thanks,
Suravee

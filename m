Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBDBC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23B52467A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vPRvqqlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfLFIOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:14:32 -0500
Received: from mail-eopbgr680078.outbound.protection.outlook.com ([40.107.68.78]:22562
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfLFIOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:14:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdJOj2dF3nBFZ0bp3y+n5IliajlFgH60JTfMzWGKI+Dl9tkmK+4LfnVjJ/XYB00uzjU467brgcHMf6vsLJOHfZ6Gor2SPhCcaraNWidSfbnA8Mbc2n8KdeUMafhI3vOxyj5Sdyl2aOML2/o4Vb6/oE/FyNtnk4jkTV4xwtV2YFhbOaoOYt+5jlCoe8Anrr8EX+wDAyxrhO7oyCGS4sUF96p18ZVruokw3E9BAq59W4WibO/cqE/shUWa11z7CQRSoAOHi6Z9cZ30mm0peNgkqo0jTDsgaJmAbhwUZnGRtghC/d9rqWBN41wC1KiMSJdJKWSOR5tOsEW6We0W1oAlfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NGTAL/SCrviSYKBEcHwHPUIyuFLi6s4QPQHPBrUJBc=;
 b=icMnAF/WhLpiWLMxngYkL4UqhIy5+RmEp+RCFl/W0Mmim4tBkMMLM6Ub+3r77eb9XpSnKzSOGg1bC7rhL7UfPiNE5K4OpCUoC3J3PlUkdzobKKRx5MKO5o27ZbDI1DEZAaPm4pvtkcsWovqHVgIdEaaVTvNXOJeExMD822qog9lmYpeMsRzrnQ+MLk0XAip2aslkS83zsgl3+nRAewkfM4RKNzZmDU3dhM91IeeKBJgM/J4Qu52YW5RqpkfwJS1fYRXpC0LuirDWH6fifxE392Pl47MuDqKQ/SmqRw+gTveylRbvAgtJqWm3BH5GqfVrzl+z/koAciMwfjHI3gXvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NGTAL/SCrviSYKBEcHwHPUIyuFLi6s4QPQHPBrUJBc=;
 b=vPRvqqlWyUHBdnAHSMxZCVj0KSicUnhcuJkoeQjgzuF9cHIUp+GWtR+7q4t2Hm1iLEAxap4Gpw6RDcD+nRyOXiokQN935hwhAF3hEwrcjaTFAOBVS+04URBadg9iUge9VKTqv/3ID5FUzXnYlWnnqxNFfhvmjzLDvdfMK73Xqlw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from DM6PR12MB3865.namprd12.prod.outlook.com (10.255.172.206) by
 DM6PR12MB3324.namprd12.prod.outlook.com (20.178.31.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Fri, 6 Dec 2019 08:14:28 +0000
Received: from DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::39cc:b3a4:6c0a:14f6]) by DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::39cc:b3a4:6c0a:14f6%7]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 08:14:27 +0000
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
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <68bdd6f0-a229-433a-9234-303a3b02b092@amd.com>
Date:   Fri, 6 Dec 2019 15:14:13 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
In-Reply-To: <b63e2111-b0c6-a716-3d99-88f91ad64e1d@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::34)
 To DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14)
MIME-Version: 1.0
X-Originating-IP: [223.24.188.36]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 960911e4-9b0f-4d6c-b3e3-08d77a244fcd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3324:|DM6PR12MB3324:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3324F8105D023ABC731D532DF35F0@DM6PR12MB3324.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0243E5FD68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(189003)(199004)(66946007)(50466002)(66556008)(66476007)(8936002)(81156014)(2906002)(26005)(86362001)(8676002)(65956001)(31686004)(31696002)(5660300002)(6486002)(229853002)(6512007)(81166006)(4326008)(305945005)(53546011)(52116002)(76176011)(25786009)(2616005)(23676004)(99286004)(11346002)(58126008)(186003)(44832011)(316002)(54906003)(6506007)(36756003)(14444005)(230700001)(478600001)(14454004)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3324;H:DM6PR12MB3865.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYUSPwEsNj/mXW69/yhhYQbZHroUWyP8KMRWy891k03g7bCg4gI8lchr47gsmqmw6HkDo8xI2T8jJ2ziwW4byjiOdxVv9aEx9CtDjLKbSLnIciF6w230cex6ZqVTPAdXxeWwsbufDACwsHYMz9YPTQAKAw9urLy5mP8n15RV8UcjxH5NEJOCQlDhREVzpIFDfaT2F/MDUFHGd/V6gdk5c6rhMN0LsPmtVGxlP3slYJ/PF3xi1NuV4bYfQM3zRlaex/JgbM70gY3SljLalABUJX0qmL4jfZssYifeppUid9rAztWtP+K+52nvyn0XUxFqqSPLPKxQQUgApM9kqdwaOrqp4REWi70Dkb2fMk7ReDvkBUzL/ecy/984RLkT522GIgp2l7kZZHQ3xIGBQV7HgrdX4KWiXkKy2KzKDiQseJ51l5pYrYSn1oVtCMVZGqJj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960911e4-9b0f-4d6c-b3e3-08d77a244fcd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 08:14:27.6724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUdB09LFjQU8KOVxLoFaieINI5Whcs9QhOsEIQQqp910gGDEGsSFe6v8aPifhNZ6hlJFaZWyv35EwdkquKlo9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

On 12/4/19 12:27 AM, Dave Hansen wrote:
> On 12/3/19 1:01 AM, Suravee Suthikulpanit wrote:
>> The current XCHECK_SZ macro warns if the XFEATURE size reported
>> by CPUID does not match the size of kernel structure. However, depending
>> on the hardware implementation, CPUID can report the XSAVE state size
>> larger than the size of C structures defined for each of the XSAVE state
>> due to padding.
> 
> We have existing architecture for padding.  See xfeature_is_aligned(),
> for instance.  Are you saying that there are implementations out there
> that do padding which is not otherwise enumerated and that they do it
> within the size of the enumerated stat
Yes, the implementation includes the padding size within the size of
the enumerated state. This results in the reported size larger than
the amount needed by the feature.

>> Such case should be safe and should not need to generate warning
>> message.
> 
> I've seen these error messages trip before, but only on pre-production
> processors with goofy microcode.  I'd be really suspicious that this is
> just papering over a processor issue.  Or, that perhaps the compacted
> form works but the standard form is broken somehow.

I have verified with the HW folks and the have confirmed that this is
to be expected.

Thanks,
Suravee

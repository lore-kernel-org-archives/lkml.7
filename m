Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECF4C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC4624685
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="I43dxz9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfLFIOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:14:35 -0500
Received: from mail-eopbgr680078.outbound.protection.outlook.com ([40.107.68.78]:22562
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbfLFIOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:14:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRiuSQ24xDiYuvgsiXy2tvkHJKS91l0tWSAMgj+HXYmn7+x8qh6j2QD75wlJ6LuhrJykWiQhJvn9oATdub+diTaGqDTXPhkOQC0Wih4Gw133TiafrL5h8zrP3rQnsePH2lDf6ZLhuItO65qisj84nWbUuxnYjrK5SO0AUDmmp8GJqj+55tVw6iDiNRJbbS435ZBJvyKzojcIgwh8hhvF5Tek+N/7ZBDQFWLu+yTW5m9bbYac+/qz5scHLb2a2p3gBWVzS+ZXHvj9xftlNVlKTfsaYfv2COZ/ZzrQbOdCpZPx4SDVZGJtHd6cJZ6T4ZRLvWLHPMzTKP2tG2YmXvBnXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d60s4dJWKNcPqeQgmpEIz8oiGs3JCx4zdpxbqnmbhnw=;
 b=n1QJm1/vPTXjKjG7NSxXfmWz2CtYBOITQ3VuTEatXyf37PFuBDktMvJX0ShembtrS/1Mu6CgY/ra4M2irK6XfFbKp8XD3ApGZy7XFj7IE6wIC2QnKhndf0csBCYbV70y7Mjls6Ql2el4glVBgOKC53wkEY6cGFmJv9s3WeQ0oRuznyiTfuPy/sTlFYSs0sacF4xF86jtJUKu2JXpgBmmBTiVrb2eTXTrncxBvg++YZ4XChtm6FybpQmCpH0dUF/ew3+Kc2uATxrxx1nX1kpL8q6AZ9vlaospzVIOD02CT+KPwiwhffQfX859lPMSFwDbPipaGmhqkA0VlTUMhBHSlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d60s4dJWKNcPqeQgmpEIz8oiGs3JCx4zdpxbqnmbhnw=;
 b=I43dxz9/72eq6DsRRTkiqaQalJKVJaZZvG7Lh46BMx6DE/Fn37U8g7zlLue5l+ZjXf9dnH1KRZDOSTdazgXEU3U5AheZdXUECeYFEuDs16xAT5wGvbfeD6K4NkOxkcDOfqpFJGyu6r5Ann2IxapKz4YTbHOL3lbVmLI+Q2vS79E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from DM6PR12MB3865.namprd12.prod.outlook.com (10.255.172.206) by
 DM6PR12MB3324.namprd12.prod.outlook.com (20.178.31.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Fri, 6 Dec 2019 08:14:29 +0000
Received: from DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::39cc:b3a4:6c0a:14f6]) by DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::39cc:b3a4:6c0a:14f6%7]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 08:14:29 +0000
Subject: Re: [PATCH] x86/fpu: Warn only when CPU-provided sizes less than
 struct declaration
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, jon.grimm@amd.com,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
References: <1575363688-36727-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20191203103455.pvm5jrwkksygmhd7@linutronix.de>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <ccee3768-c160-25b6-362f-de6cdd2b78c2@amd.com>
Date:   Fri, 6 Dec 2019 15:14:17 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
In-Reply-To: <20191203103455.pvm5jrwkksygmhd7@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::19)
 To DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14)
MIME-Version: 1.0
X-Originating-IP: [223.24.188.36]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb50d5a3-b3f3-45af-b2a6-08d77a245110
X-MS-TrafficTypeDiagnostic: DM6PR12MB3324:|DM6PR12MB3324:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3324C4F0278F1CDB4745BE09F35F0@DM6PR12MB3324.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0243E5FD68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(189003)(199004)(66946007)(50466002)(66556008)(66476007)(8936002)(81156014)(2906002)(26005)(86362001)(8676002)(65956001)(6916009)(31686004)(31696002)(5660300002)(6486002)(229853002)(6512007)(81166006)(4326008)(305945005)(53546011)(52116002)(76176011)(25786009)(2616005)(23676004)(99286004)(11346002)(58126008)(186003)(44832011)(316002)(54906003)(6506007)(36756003)(14444005)(230700001)(478600001)(14454004)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3324;H:DM6PR12MB3865.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R/sLk1uHOsHKzCtPehz8dxKvD5mWdmkPClpJtq/5Y62nhKQPvW5KFV5vAArKrLufbcVA0FsOf42S83Q5DGisqoSZKYqgGUfCLX11GcbhZ/AVYk6dMRJcyKa9I5nzHRVqgAHeYGCyKq8uV4dvZYhwSPRv8xDC4gOTpLAzJichcSS5+mBm8OMHtLKp1eVip8khUZ/lzHBZVi4G1TI5yh3SADXm5VEtGBA7iezW68DhVDhYZ6giIbSrUdBeGtASPrE3W4GikyHaefPWPg1p4izwZjqarR1E/O0m8pjtvGuIcUtMLbVOk5bR8XwMBecHGp97coGsfYPqzWeI4LVt2rnFaTpbFteAbNbO9i7UFz9Jo9oIysV0CCQ4qHpyYniHHze+Xghxd4qr69G+EJRJbpWUq+aSblXTiEX5SDYdlEbIcEy8k3POdTMZWCH715QCua/0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb50d5a3-b3f3-45af-b2a6-08d77a245110
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 08:14:29.5623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75sa22azAB0nEvJwvUjGcZH42e0H+AtcPwqJ+ugZGtgLoHFlJrW909cjBxF6tpNCS7nJzb0xXNe9YzM8UB6MHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian,

On 12/3/19 5:34 PM, Sebastian Andrzej Siewior wrote:
> On 2019-12-03 04:01:28 [-0500], Suravee Suthikulpanit wrote:
>> The current XCHECK_SZ macro warns if the XFEATURE size reported
>> by CPUID does not match the size of kernel structure. However, depending
>> on the hardware implementation, CPUID can report the XSAVE state size
>> larger than the size of C structures defined for each of the XSAVE state
>> due to padding. Such case should be safe and should not need to generate
>> warning message.
> Do you have an example which CPU generation and which feature?

This is observed with one of the newly supported features in the upcoming product.

> We don't use this these structs in the kernel and the xsave layout is
> dynamic based on the memory requirements reported by the CPU.
> But we have a warning which complains about different sizes. Now you
> change the warning that it is okay if the CPU reports that more memory
> is needed than we expect. This looks wrong. The other way around would
> be "okay" but this just renders the warning useless.

My point is it should be safe for the hardware to save data more than or equal
to the size used by the kernel. However, it is not okay if the hardware
saves data less than the amount used by kernel because that means the data
would lost at the time of restore.

However, in this case the hardware reported size contains data + padding.

Thanks,
Suravee


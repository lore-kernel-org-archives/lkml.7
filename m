Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA8EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F132071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PD4jtv6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfKZNK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:10:26 -0500
Received: from mail-eopbgr750043.outbound.protection.outlook.com ([40.107.75.43]:20195
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbfKZNKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:10:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+eDdpsVd+DznZu3GSTtMDGkhQQJdD9nD8EbLZuEmCrnG5wv1jYRVYiDC6U+gOOifi9BOgCrPWTCHZAT/LuyWRpgozDCjbFlK7BxAxZlfcSmMywNTBySLM7Kzib2FVEOcr1Eh+xhvKmWCepgBv4ZLdnd/kPgEwtZQMy0Rr0XuvUOTCSRKpfwvadf7SPmFqZIOpDPyChV7Q4vJb4muoCQpvURa2okNw1EGC6Wq3f8M6epQQ7SNsDrcY8PTp8ELAe17nTJKzegdeXjc6EGWU8Hfveci8lmx2C2q6rUb3xE74W5wye7JZDFxxZewYnAgQ+ex0lnBys4WRNE8M2Lc1iOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrWLzrJbyculD6NkQ/GQeEyeu0Pf96Mh2AuC0rC48h4=;
 b=leabm+Fd6VhtMa9TpimwJRf1XLPrvvQvhKqWX3fdXhfZYrm+3WtFebQ41yJP3XJXpqa021Bcq4mBYioPKDlyIcskFBZRCqh8yIR2zCBcnqENIH+c0JKsH1v6tsBlRaYyCRJmsKTQYtFznHMmrF6Ca4j9Qck6F5phwwbXwF+4OY3CS/7VVFZk8s58mmeyyBx9uFWuXRlnMO5aQ5majbk7ghaahAkCtdSa73v3b13yulw3KNn8XkDXKGoAa2mUX9WJS5W/xpGoEY5OBiyeF9OZ+Z/jtuyOyyydW42H9kItImnZNCYs+qx5TNaSTV/UIyto4OE3a72g5H7WL0+PwhPI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrWLzrJbyculD6NkQ/GQeEyeu0Pf96Mh2AuC0rC48h4=;
 b=PD4jtv6G34JLq3IxwSQ4f4UZecA8PxW6RlzvzIZgVaDQx5KK4YJbqooKwDp7DTe8brMGIlgH0cgtAz8nNMWGICa/ghvdtQxaYHArKoyy8DgcNEDuaT91SG25Y2Hosm1Z1aztJYErPG77A3dYxZSXutzUOglt7a8ygqJ5gY0R0pU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3485.namprd12.prod.outlook.com (20.178.242.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Tue, 26 Nov 2019 13:10:20 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::b927:9d83:f11:941b]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::b927:9d83:f11:941b%6]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:10:20 +0000
Subject: Re: Fwd: [PATCH] NTB: Fix an error in get link status
To:     Jiasen Lin <linjiasen@hygon.cn>
Cc:     "S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com> Dave Jiang" 
        <dave.jiang@intel.com>, Arindam Nath <arindam.nath@amd.com>,
        Allen Hubbe <allenbh@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-ntb <linux-ntb@googlegroups.com>, linjiasen007@gmail.com
References: <1573119336-107732-1-git-send-email-linjiasen@hygon.cn>
 <CAPoiz9wAJz=Hqb6Os=9AHHv_NGpZ8uCaAuOC=aUTkASKdfs9WQ@mail.gmail.com>
 <933f74c7-7249-618c-13dc-9e4e47ad75d7@hygon.cn>
 <11b355a8-0fe0-f256-c510-ddf106017703@hygon.cn>
 <CAADLhr7bpb-F0eF1UFXy7AcN=z061mno_QsqGE8z-mvWKvUyCQ@mail.gmail.com>
 <04b4d1ed-ea47-819e-a7e4-b729fa463506@amd.com>
 <5c3155b5-6eed-d955-b18b-59b0cb1c513b@hygon.cn>
 <740bb924-b258-8dda-6469-bc1bee90291f@hygon.cn>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <c5adca66-024f-8d37-3187-ffba73102ac4@amd.com>
Date:   Tue, 26 Nov 2019 18:40:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <740bb924-b258-8dda-6469-bc1bee90291f@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MAXPR0101CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::22) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
X-Originating-IP: [165.204.157.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3ce53380-5afc-459b-e90f-08d77271fd0d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:|MN2PR12MB3485:|MN2PR12MB3485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3485D39F41B4DB77D95F875AE5450@MN2PR12MB3485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0233768B38
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(2616005)(31686004)(11346002)(446003)(6116002)(3846002)(50466002)(25786009)(36756003)(66946007)(186003)(4326008)(6512007)(8676002)(6666004)(305945005)(7736002)(6862004)(66476007)(66556008)(81156014)(81166006)(23676004)(2486003)(66066001)(52116002)(6506007)(6246003)(8936002)(386003)(76176011)(6436002)(31696002)(316002)(2906002)(47776003)(58126008)(2870700001)(478600001)(14454004)(26005)(99286004)(65956001)(65806001)(229853002)(5660300002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3485;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJZBS0upws9jJneNjNyucXyEqMgwzo7VXUTYGS9RX7u4tSWqUxNObxa6m3Wm4WKHAQyUFJoiiecgjOmToRW/2164nscausnd5L67YwbAhT9RSIGEk7UQMuC86zWWPaBUQcKMFKv7mz7O1XM427xA05JjDn5zPRSnpvVzJlpU6OH9tSbFbxQcfH6jXjmXijCMMwv+ZGSBui6VF+gsQe2wJcMlZGTPgbGVZjZ/1F8GpCitwHx52sWQi89qi/+lwKgXyvO7NAAgglj02zbyhOx+pfkUGP0QyMPXE/n8wdNc1WFiM9h2Nk/5v9HowNMmBygQF7qRgiZoxVzqPMfIIbXePz1bvMC7AFJTd4H/kf7MQEnHF90tMf+U0dqO8yqEHqPPfYuWUUUTMZtbbADE6SfeVQi7p8KMudo6/jDl5IA0eRY9UJbFfIolKzRW0gkspx9Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce53380-5afc-459b-e90f-08d77271fd0d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:10:20.2900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItIRLWATrP9tJa9+u/LAue+DDceLmc1Y5Pjsc0XjP/w9n+E8u+bCVMR7Xrey9VRNi/zWTVc7cei2ehO1GvYR2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3485
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi Sanjay R Mehta
>
> In more complex topology, read the Link Status and Control register of
> RP is also wrong. Suppose that a PCIe switch bridge to the Secondary RP,
> and Secondary internal SW.ds is a child device for switch's downstream
> port as illustrated in the following topology.
>
> In secondary PCI domain:
> Secondary RP--Switch UP--Switch DP--Secondary internal SW.us--Secondary
> internal SW.ds--Secondary NTB
>
> pci_rp = pci_find_pcie_root_port(ndev->ntb.pdev) will return the
> Secondary RP, and pcie_capability_read_dword(pci_rp,
> PCI_EXP_LNKCTL,&stat) will get the link status between Secondary RP and
> Switch UP. Maybe, read the Link Status and control register of Secondary
> internal SW.us is appropriate.
>
Hi Jiansen Lin,

I modified the code as per your suggestion and is working fine.
Adding Arindam for comments who was the co-author of the patch I was about to send for upstream review.

Thanks,
Sanjay Mehta
> struct pci_dev *pci_up = NULL;
> struct pci_dev *pci_dp = NULL;
>
> if (ndev->ntb.topo == NTB_TOPO_SEC) {
>     /* Locate the pointer to Secondary up for this device */
>     pci_dp = pci_upstream_bridge(ndev->ntb.pdev);
>     /* Read the PCIe Link Control and Status register */
>     if (pci_dp) {
>        pci_up = pci_upstream_bridge(pci_dp);
>        if (pci_up) {
>                rc = pcie_capability_read_dword(pci_up, PCI_EXP_LNKCTL,
>                         &stat);
>                if (rc)
>                        return 0;
>                }
>        }
> }
>
> Thanks,
> Jiansen Lin
>
>> I have modified the code according to your suggestion and tested it
>> on Dhyana platform, it works well, expect to receice your patch.
>>
>> Before modify the code, read the Link Status and control register of the
>> secondary NTB device to get link status.
>>
>> cat /sys/kernel/debug/ntb_hw_amd/0000\:43\:00.1/info
>> NTB Device Information:
>> Connection Topology -   NTB_TOPO_SEC
>> LNK STA -               0x11030042
>> Link Status -           Up
>> Link Speed -            PCI-E Gen 3
>> Link Width -            x16
>>
>> After modify the code, read the Link Status and control register of the
>> secondary RP to get link status.
>>
>> cat /sys/kernel/debug/ntb_hw_amd/0000\:43\:00.1/info
>> NTB Device Information:
>> Connection Topology -   NTB_TOPO_SEC
>> LNK STA -               0x70830042
>> Link Status -           Up
>> Link Speed -            PCI-E Gen 3
>> Link Width -            x8
>>
>> Thanks,
>> Jiasen Lin
>>
>>> ---
>>>   drivers/ntb/hw/amd/ntb_hw_amd.c | 27 +++++++++++++++++++++++----
>>>   drivers/ntb/hw/amd/ntb_hw_amd.h |  1 -
>>>   2 files changed, 23 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c
>>> b/drivers/ntb/hw/amd/ntb_hw_amd.c
>>> index 14ad69c..91e1966 100644
>>> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
>>> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
>>> @@ -842,6 +842,8 @@ static inline void ndev_init_struct(struct
>>> amd_ntb_dev *ndev,
>>>   static int amd_poll_link(struct amd_ntb_dev *ndev)
>>>   {
>>>       void __iomem *mmio = ndev->peer_mmio;
>>> +    struct pci_dev *pci_rp = NULL;
>>> +    struct pci_dev *pdev = NULL;
>>>       u32 reg, stat;
>>>       int rc;
>>> @@ -855,10 +857,27 @@ static int amd_poll_link(struct amd_ntb_dev *ndev)
>>>       ndev->cntl_sta = reg;
>>> -    rc = pci_read_config_dword(ndev->ntb.pdev,
>>> -                   AMD_LINK_STATUS_OFFSET, &stat);
>>> -    if (rc)
>>> -        return 0;
>>> +    if (ndev->ntb.topo == NTB_TOPO_SEC) {
>>> +        /* Locate the pointer to PCIe Root Port for this device */
>>> +        pci_rp = pci_find_pcie_root_port(ndev->ntb.pdev);
>>> +        /* Read the PCIe Link Control and Status register */
>>> +        if (pci_rp) {
>>> +            rc = pcie_capability_read_dword(pci_rp, PCI_EXP_LNKCTL,
>>> +                            &stat);
>>> +            if (rc)
>>> +                return 0;
>>> +        }
>>> +    } else if (ndev->ntb.topo == NTB_TOPO_PRI) {
>>> +        /*
>>> +         * For NTB primary, we simply read the Link Status and control
>>> +         * register of the NTB device itself.
>>> +         */
>>> +        pdev = ndev->ntb.pdev;
>>> +        rc = pcie_capability_read_dword(pdev, PCI_EXP_LNKCTL, &stat);
>>> +        if (rc)
>>> +            return 0;
>>> +    }
>>> +
>>>       ndev->lnk_sta = stat;
>>>       return 1;
>>> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h
>>> b/drivers/ntb/hw/amd/ntb_hw_amd.h
>>> index 139a307..39e5d18 100644
>>> --- a/drivers/ntb/hw/amd/ntb_hw_amd.h
>>> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
>>> @@ -53,7 +53,6 @@
>>>   #include <linux/pci.h>
>>>   #define AMD_LINK_HB_TIMEOUT    msecs_to_jiffies(1000)
>>> -#define AMD_LINK_STATUS_OFFSET    0x68
>>>   #define NTB_LIN_STA_ACTIVE_BIT    0x00000002
>>>   #define NTB_LNK_STA_SPEED_MASK    0x000F0000
>>>   #define NTB_LNK_STA_WIDTH_MASK    0x03F00000
>>>

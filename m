Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2756C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8132B2230F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vr8kWfiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbfKTOOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:14:14 -0500
Received: from mail-eopbgr800074.outbound.protection.outlook.com ([40.107.80.74]:18592
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727791AbfKTOOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:14:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDADVazm5402/tObaJ1yuS2lZj20VU0IQJZYZgUQ/gFhT7jw+DTzlRn6E9mP7revcJ30Azdp103oUiZV0wIvkgFg5gfzVfvn94mh6hxkXg2XqN7W5L1dXNfCF+jePvVGJpJ49WO+EWoknw9wzM2A4w9m+EhPkYWGDveDJkm+QWbAMTEF63QXpSJo1PzH3Lh3OzOn6SIbe1w1lyRV6nEnZ8G1OPXI1WZcDMExdXwdRdZLI7FMGd/tst6pPXH7wl9yvnyC2GxO+ohmIV1YaWInIBLKXXVk0G+o8NO/FE1asFtcd8rsIq8poJkmKyT0wHO3KE1Rllf5IRXPSwdtOiYb7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frxBKfp14rXQvS9lqrGdzI2iWgh6yqJfwOX1JJkSd6Y=;
 b=LgNi1pqUQaQzpN0mjzhvSduwpHgCidPLZr1D1ZVMxefROfenowhao7E+O47K81JnRuWhxY4Hpf2tRIAnDLuByRX6HW2E2ooH3vaL30uzw3mJyPr/F0oJ0lXoBeGCfB9LiAYH24+1pNCAP3YINInWjSkGjPCpZ6r5YJ7udAGsXyyLuon2MFLkrd5FIMzkjKSdTFwFIOzUuByfXgxUrL84nwqsdMHYbh6eg+g6+MKA363VjHFqZQWMQkpDBS9O4NJta5fQ2o6V8kbZeUOu61RjHMawM2H0jgcGP47TYqA2R+19k+Yks+LQ3jsfYw3kF0wG4yDD2snt+bjA1ZWvBAglMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frxBKfp14rXQvS9lqrGdzI2iWgh6yqJfwOX1JJkSd6Y=;
 b=vr8kWfiDJkMw1A5cpB+CQ5l7iOjtBzOPpyve3UNVC6UXSuSseuo1pCYTw8eYxbIsJX4U0MXPULbj60LA62Sq/jtR/z4x0VDA8YqaFLnFxEiubJg+xjSgdra3v60bXJgnJZrRByTGG+IxU7tvd/JorAITM3c9X4DsZTLjGokcWFQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3101.namprd12.prod.outlook.com (20.178.241.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 14:14:06 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::b927:9d83:f11:941b]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::b927:9d83:f11:941b%6]) with mapi id 15.20.2474.015; Wed, 20 Nov 2019
 14:14:05 +0000
Subject: Re: Fwd: [PATCH] NTB: Fix an error in get link status
To:     Jiasen Lin <linjiasen@hygon.cn>
References: <1573119336-107732-1-git-send-email-linjiasen@hygon.cn>
 <CAPoiz9wAJz=Hqb6Os=9AHHv_NGpZ8uCaAuOC=aUTkASKdfs9WQ@mail.gmail.com>
 <933f74c7-7249-618c-13dc-9e4e47ad75d7@hygon.cn>
 <11b355a8-0fe0-f256-c510-ddf106017703@hygon.cn>
 <CAADLhr7bpb-F0eF1UFXy7AcN=z061mno_QsqGE8z-mvWKvUyCQ@mail.gmail.com>
Cc:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-ntb <linux-ntb@googlegroups.com>, linjiasen007@gmail.com
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <04b4d1ed-ea47-819e-a7e4-b729fa463506@amd.com>
Date:   Wed, 20 Nov 2019 19:43:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <CAADLhr7bpb-F0eF1UFXy7AcN=z061mno_QsqGE8z-mvWKvUyCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MAXPR0101CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::28) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
X-Originating-IP: [165.204.157.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81ff98d5-d8dd-4224-f1ff-08d76dc3e6e9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3101:|MN2PR12MB3101:
X-MS-Exchange-PUrlCount: 3
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB31014B635D1DA353AFD65B4CE54F0@MN2PR12MB3101.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(189003)(199004)(229853002)(76176011)(36756003)(2616005)(316002)(2870700001)(58126008)(446003)(305945005)(47776003)(23676004)(5660300002)(11346002)(4326008)(52116002)(2486003)(6512007)(6306002)(6246003)(6862004)(478600001)(65956001)(6486002)(66066001)(65806001)(476003)(8936002)(99286004)(6666004)(3846002)(6116002)(6506007)(53546011)(54906003)(81166006)(386003)(81156014)(8676002)(31686004)(186003)(486006)(50466002)(26005)(66946007)(66476007)(66556008)(14444005)(14454004)(7736002)(966005)(25786009)(6436002)(2906002)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3101;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hczpjcLckyFBdD/y0nZIZXTN0u6TyYhBNl6ONCi94l+0kRGSSCrhea9ktT0Ju+zhK4lnrj6ibwq3vIA5NHemafO2ZSPt8kFEuSJi8FXOXmRqv4VlAfC+OKjjW5OzCe2qS3Lwqo+VzZ0veB+ng3QMWMudy3cu9D7jES7xX24jIwRLv9DEt4zJdd5asYrFMQHFJGo6UEfJAVAGsRJrtoA9kBUVCJLjgrpMrb3mU7qKmGYqxUMGUvngk9YjLZWJct+XU3zheDwCwuYJVOBULkp9jrfOGnGpu0pzNvRJIZnBcruJhx+SgXLoaryeaaMtXGPvEWaxTbmYhm40MqqjxO4dfXH+4z3hN0qrUqGTNiSwV8dy9kYwT/FJad5mdCb3j917r4c7aB+z9kLAY88NxX75Yor2VQccvQKvgafNvM7+Z8QvFtjyL18c/PH2OIV4enNLM7TidE82eWJzC6nqCVN+Ih48Qwv63Z2lRYfhV4fx38Y=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ff98d5-d8dd-4224-f1ff-08d76dc3e6e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 14:14:05.7995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drWl+hjKFQ+WBVOa+/aISvaqB+edwF5i4QEfoPmHwf5F4vT+RDSVD16HJrdoLtn4SP7r7JWz/0+TYDuLCse+GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: *Jiasen Lin* <linjiasen@hygon.cn <mailto:linjiasen@hygon.cn>>
> Date: Wed, Nov 20, 2019 at 3:25 PM
> Subject: Re: [PATCH] NTB: Fix an error in get link status
> To: Jon Mason <jdmason@kudzu.us <mailto:jdmason@kudzu.us>>
> Cc: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com <mailto:Shyam-sundar.S-k@amd.com>>, Dave Jiang <dave.jiang@intel.com <mailto:dave.jiang@intel.com>>, Allen Hubbe <allenbh@gmail.com
> <mailto:allenbh@gmail.com>>, linux-kernel <linux-kernel@vger.kernel.org <mailto:linux-kernel@vger.kernel.org>>, linux-ntb <linux-ntb@googlegroups.com <mailto:linux-ntb@googlegroups.com>>,
> <linjiasen007@gmail.com <mailto:linjiasen007@gmail.com>>, Jiasen Lin <linjiasen@hygon.cn <mailto:linjiasen@hygon.cn>>
>
>
>
>
> On 2019/11/18 18:17, Jiasen Lin wrote:
> >
> >
> > On 2019/11/18 7:00, Jon Mason wrote:
> >> On Thu, Nov 7, 2019 at 4:37 AM Jiasen Lin <linjiasen@hygon.cn <mailto:linjiasen@hygon.cn>> wrote:
> >>>
> >>> The offset of PCIe Capability Header for AMD and HYGON NTB is 0x64,
> >>> but the macro which named "AMD_LINK_STATUS_OFFSET" is defined as 0x68.
> >>> It is offset of Device Capabilities Reg rather than Link Control Reg.
> >>>
> >>> This code trigger an error in get link statsus:
> >>>
> >>>          cat /sys/kernel/debug/ntb_hw_amd/0000:43:00.1/info
> >>>                  LNK STA -               0x8fa1
> >>>                  Link Status -           Up
> >>>                  Link Speed -            PCI-E Gen 0
> >>>                  Link Width -            x0
> >>>
> >>> This patch use pcie_capability_read_dword to get link status.
> >>> After fix this issue, we can get link status accurately:
> >>>
> >>>          cat /sys/kernel/debug/ntb_hw_amd/0000:43:00.1/info
> >>>                  LNK STA -               0x11030042
> >>>                  Link Status -           Up
> >>>                  Link Speed -            PCI-E Gen 3
> >>>                  Link Width -            x16
> >>
> >> No response from AMD maintainers, but it looks like you are correct.
> >>
> >> This needs a "Fixes:" line here.  I took the liberty of adding one to
> >> this patch.
> >>
> >
> > Thank you for your suggestions. Yes, this patch fix the commit id:
> > a1b3695 ("NTB: Add support for AMD PCI-Express Non-Transparent Bridge").
> >
> >>> Signed-off-by: Jiasen Lin <linjiasen@hygon.cn <mailto:linjiasen@hygon.cn>>
> >>> ---
> >>>   drivers/ntb/hw/amd/ntb_hw_amd.c | 5 +++--
> >>>   drivers/ntb/hw/amd/ntb_hw_amd.h | 1 -
> >>>   2 files changed, 3 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c
> >>> b/drivers/ntb/hw/amd/ntb_hw_amd.c
> >>> index 156c2a1..ae91105 100644
> >>> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> >>> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> >>> @@ -855,8 +855,8 @@ static int amd_poll_link(struct amd_ntb_dev *ndev)
> >>>
> >>>          ndev->cntl_sta = reg;
> >>>
> >>> -       rc = pci_read_config_dword(ndev->ntb.pdev,
> >>> -                                  AMD_LINK_STATUS_OFFSET, &stat);
> >>> +       rc = pcie_capability_read_dword(ndev->ntb.pdev,
> >>> +                                  PCI_EXP_LNKCTL, &stat);
> >>>          if (rc)
> >>>                  return 0;
> >>>          ndev->lnk_sta = stat;
> >>> @@ -1139,6 +1139,7 @@ static const struct ntb_dev_data dev_data[] = {
> >>>   static const struct pci_device_id amd_ntb_pci_tbl[] = {
> >>>          { PCI_VDEVICE(AMD, 0x145b), (kernel_ulong_t)&dev_data[0] },
> >>>          { PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
> >>> +       { PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
> >>
> >> This should be a separate patch.  I took the liberty of splitting it
> >> off into a unique patch and attributing it to you.  I've pushed them
> >> to the ntb-next branch on
> >> https://github.com/jonmason/ntb
> >>
> > Thank you for your comment. We appreciate the time and effort you have
> > spent to split it off, I will test it ASAP.
> >
> >> Please verify everything looks acceptable to you (given the changes I
> >> did above that are attributed to you).  Also, testing of the latest
> >> code is always appreciated.
> >>
> >> Thanks,
> >> Jon
> >>
>
> I have tested these patches that are pushed to ntb-next branch, they
> work well on HYGON platforms.
>
> Thanks,
> Jiasen Lin

Hi Jiasen Lin,

Apologies for my delayed response. I was on vacation.

Your patch is a correct fix, but that would work only for primary system.

The design of AMD NTB implementation is such that NTB primary acts as an endpoint device and NTB secondary is a PCIe Root Port (RP). Considering that,
the link status and control register needs to be accessed differently based on the NTB topology.

So in the case of NTB secondary, we read the link status and control register of the PCIe RP capabilities structure and in the case of NTB primary, we read the
link status and control register from NTB device capabilities structure.

The code below is the proper fix for AMD platform. I will be sending incremental change above your patch.

would appreciate if you could test my patch and let me know whether that works for you.

---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 27 +++++++++++++++++++++++----
 drivers/ntb/hw/amd/ntb_hw_amd.h |  1 -
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 14ad69c..91e1966 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -842,6 +842,8 @@ static inline void ndev_init_struct(struct amd_ntb_dev *ndev,
 static int amd_poll_link(struct amd_ntb_dev *ndev)
 {
     void __iomem *mmio = ndev->peer_mmio;
+    struct pci_dev *pci_rp = NULL;
+    struct pci_dev *pdev = NULL;
     u32 reg, stat;
     int rc;
 
@@ -855,10 +857,27 @@ static int amd_poll_link(struct amd_ntb_dev *ndev)
 
     ndev->cntl_sta = reg;
 
-    rc = pci_read_config_dword(ndev->ntb.pdev,
-                   AMD_LINK_STATUS_OFFSET, &stat);
-    if (rc)
-        return 0;
+    if (ndev->ntb.topo == NTB_TOPO_SEC) {
+        /* Locate the pointer to PCIe Root Port for this device */
+        pci_rp = pci_find_pcie_root_port(ndev->ntb.pdev);
+        /* Read the PCIe Link Control and Status register */
+        if (pci_rp) {
+            rc = pcie_capability_read_dword(pci_rp, PCI_EXP_LNKCTL,
+                            &stat);
+            if (rc)
+                return 0;
+        }
+    } else if (ndev->ntb.topo == NTB_TOPO_PRI) {
+        /*
+         * For NTB primary, we simply read the Link Status and control
+         * register of the NTB device itself.
+         */
+        pdev = ndev->ntb.pdev;
+        rc = pcie_capability_read_dword(pdev, PCI_EXP_LNKCTL, &stat);
+        if (rc)
+            return 0;
+    }
+
     ndev->lnk_sta = stat;
 
     return 1;
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
index 139a307..39e5d18 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -53,7 +53,6 @@
 #include <linux/pci.h>
 
 #define AMD_LINK_HB_TIMEOUT    msecs_to_jiffies(1000)
-#define AMD_LINK_STATUS_OFFSET    0x68
 #define NTB_LIN_STA_ACTIVE_BIT    0x00000002
 #define NTB_LNK_STA_SPEED_MASK    0x000F0000
 #define NTB_LNK_STA_WIDTH_MASK    0x03F00000
-- 
2.7.4

Thanks & Regards
Sanjay Mehta

>
> >>
> >>>          { 0, }
> >>>   };
> >>>   MODULE_DEVICE_TABLE(pci, amd_ntb_pci_tbl);
> >>> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h
> >>> b/drivers/ntb/hw/amd/ntb_hw_amd.h
> >>> index 139a307..39e5d18 100644
> >>> --- a/drivers/ntb/hw/amd/ntb_hw_amd.h
> >>> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
> >>> @@ -53,7 +53,6 @@
> >>>   #include <linux/pci.h>
> >>>
> >>>   #define AMD_LINK_HB_TIMEOUT    msecs_to_jiffies(1000)
> >>> -#define AMD_LINK_STATUS_OFFSET 0x68
> >>>   #define NTB_LIN_STA_ACTIVE_BIT 0x00000002
> >>>   #define NTB_LNK_STA_SPEED_MASK 0x000F0000
> >>>   #define NTB_LNK_STA_WIDTH_MASK 0x03F00000
> >>> --
> >>> 2.7.4
> >>>
> >>> --
> >>> You received this message because you are subscribed to the Google
> >>> Groups "linux-ntb" group.
> >>> To unsubscribe from this group and stop receiving emails from it,
> >>> send an email to linux-ntb+unsubscribe@googlegroups.com <mailto:linux-ntb%2Bunsubscribe@googlegroups.com>.
> >>> To view this discussion on the web visit
> >>> https://groups.google.com/d/msgid/linux-ntb/1573119336-107732-1-git-send-email-linjiasen%40hygon.cn.
> >>>
> >
> > Thanks,
> >
> > Jiasen Lin
>
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com <mailto:linux-ntb%2Bunsubscribe@googlegroups.com>.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/11b355a8-0fe0-f256-c510-ddf106017703%40hygon.cn.

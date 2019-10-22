Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53AFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A032086D
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f9+XYyjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbfJVCsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:48:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46480 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJVCsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:48:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9M2d2nI042130;
        Tue, 22 Oct 2019 02:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=Q9utWKWJocLz9Lmse484kL5IWf93HtVEVrbRVjLwMEE=;
 b=f9+XYyjcB27fvE3Tbk8CuJQ3cZTRRAoD3uWHlQemMWaqopET+4Oy+rRFL2R36fs4rgnM
 CVkD/CfQ57JhYEPlaRJho9VshTPzC/S/yoZx8BV8yRBIjBqDv8GGYEHjfctSnIWTn8KU
 KMnIXhm0TJ1km/GF9rCLPo4nxPu5mRvil5gbLhCE7WzuGg0L+VEJxRwnh66C2SitxiyJ
 9uy4MQn/RpkStD9ShAfn2QupHkbINLOkUk1SJbSbTjHrmg4QSZzO4lMC1E+6sE+F6Zn6
 lo8JbSnAlS4+Kxqdp5U7Qq6VC//NjXkuAu8WxrvkVDPh+9GTHjZwHP3cX0JUC+kRrSKk Wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vqu4qkbgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 02:48:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9M2m6hB024977;
        Tue, 22 Oct 2019 02:48:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vsp3x1fa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 02:48:12 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9M2mB3P023757;
        Tue, 22 Oct 2019 02:48:11 GMT
Received: from [192.168.1.126] (/47.220.71.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 19:48:10 -0700
To:     linux-kernel@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        John Donnelly <john.p.donnelly@Oracle.com>
From:   John Donnelly <John.P.Donnelly@Oracle.com>
Subject: [PATCH v3 ] iommu/vt-d: Fix panic after kexec -p for kdump
Message-ID: <f856dfd6-0483-fb97-033c-1cda83ead79f@Oracle.com>
Date:   Mon, 21 Oct 2019 21:48:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=984
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910220026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910220025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



This cures a panic on restart after a kexec operation on 5.3 and 5.4 
kernels.

The underlying state of the iommu registers (iommu->flags &
VTD_FLAG_TRANS_PRE_ENABLED) on a restart results in a domain being marked as
"DEFER_DEVICE_DOMAIN_INFO" that produces an Oops in identity_mapping().

[   43.654737] BUG: kernel NULL pointer dereference, address:
0000000000000056
[   43.655720] #PF: supervisor read access in kernel mode
[   43.655720] #PF: error_code(0x0000) - not-present page
[   43.655720] PGD 0 P4D 0
[   43.655720] Oops: 0000 [#1] SMP PTI
[   43.655720] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.3.2-1940.el8uek.x86_64 #1
[   43.655720] Hardware name: Oracle Corporation ORACLE SERVER
X5-2/ASM,MOTHERBOARD,1U, BIOS 30140300 09/20/2018
[   43.655720] RIP: 0010:iommu_need_mapping+0x29/0xd0
[   43.655720] Code: 00 0f 1f 44 00 00 48 8b 97 70 02 00 00 48 83 fa ff
74 53 48 8d 4a ff b8 01 00 00 00 48 83 f9 fd 76 01 c3 48 8b 35 7f 58 e0
01 <48> 39 72 58 75 f2 55 48 89 e5 41 54 53 48 8b 87 28 02 00 00 4c 8b
[   43.655720] RSP: 0018:ffffc9000001b9b0 EFLAGS: 00010246
[   43.655720] RAX: 0000000000000001 RBX: 0000000000001000 RCX:
fffffffffffffffd
[   43.655720] RDX: fffffffffffffffe RSI: ffff8880719b8000 RDI:
ffff8880477460b0
[   43.655720] RBP: ffffc9000001b9e8 R08: 0000000000000000 R09:
ffff888047c01700
[   43.655720] R10: 00002194036fc692 R11: 0000000000000000 R12:
0000000000000000
[   43.655720] R13: ffff8880477460b0 R14: 0000000000000cc0 R15:
ffff888072d2b558
[   43.655720] FS:  0000000000000000(0000) GS:ffff888071c00000(0000)
knlGS:0000000000000000
[   43.655720] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.655720] CR2: 0000000000000056 CR3: 000000007440a002 CR4:
00000000001606b0
[   43.655720] Call Trace:
[   43.655720]  ? intel_alloc_coherent+0x2a/0x180
[   43.655720]  ? __schedule+0x2c2/0x650
[   43.655720]  dma_alloc_attrs+0x8c/0xd0
[   43.655720]  dma_pool_alloc+0xdf/0x200
[   43.655720]  ehci_qh_alloc+0x58/0x130
[   43.655720]  ehci_setup+0x287/0x7ba
[   43.655720]  ? _dev_info+0x6c/0x83
[   43.655720]  ehci_pci_setup+0x91/0x436
[   43.655720]  usb_add_hcd.cold.48+0x1d4/0x754
[   43.655720]  usb_hcd_pci_probe+0x2bc/0x3f0
[   43.655720]  ehci_pci_probe+0x39/0x40
[   43.655720]  local_pci_probe+0x47/0x80
[   43.655720]  pci_device_probe+0xff/0x1b0
[   43.655720]  really_probe+0xf5/0x3a0
[   43.655720]  driver_probe_device+0xbb/0x100
[   43.655720]  device_driver_attach+0x58/0x60
[   43.655720]  __driver_attach+0x8f/0x150
[   43.655720]  ? device_driver_attach+0x60/0x60
[   43.655720]  bus_for_each_dev+0x74/0xb0
[   43.655720]  driver_attach+0x1e/0x20
[   43.655720]  bus_add_driver+0x151/0x1f0
[   43.655720]  ? ehci_hcd_init+0xb2/0xb2
[   43.655720]  ? do_early_param+0x95/0x95
[   43.655720]  driver_register+0x70/0xc0
[   43.655720]  ? ehci_hcd_init+0xb2/0xb2
[   43.655720]  __pci_register_driver+0x57/0x60
[   43.655720]  ehci_pci_init+0x6a/0x6c
[   43.655720]  do_one_initcall+0x4a/0x1fa
[   43.655720]  ? do_early_param+0x95/0x95
[   43.655720]  kernel_init_freeable+0x1bd/0x262
[   43.655720]  ? rest_init+0xb0/0xb0
[   43.655720]  kernel_init+0xe/0x110
[   43.655720]  ret_from_fork+0x24/0x50


Fixes: 8af46c784ecfe ("iommu/vt-d: Implement is_attach_deferred iommu 
ops entry")
Cc: stable@vger.kernel.org # v5.3+

Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>


---
  drivers/iommu/intel-iommu.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c4e0e4a9ee9e..f83a9a302f8e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2783,7 +2783,7 @@ static int identity_mapping(struct device *dev)
  	struct device_domain_info *info;

  	info = dev->archdata.iommu;
-	if (info && info != DUMMY_DEVICE_DOMAIN_INFO)
+	if (info && info != DUMMY_DEVICE_DOMAIN_INFO && info != 
DEFER_DEVICE_DOMAIN_INFO)
  		return (info->domain == si_domain);

  	return 0;
-- 
2.20.1


-- 
Thank You,
John

Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F86CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4232089C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cggYGqec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410018AbfJROSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:18:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48644 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732676AbfJROSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:18:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9IEEZK7112162;
        Fri, 18 Oct 2019 14:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : date : subject : message-id :
 to; s=corp-2019-08-05; bh=hBAKAUIK63rJcT7dO4ageGdosxnTtI2CaSQBixHJS1A=;
 b=cggYGqecYhiKNii2UAtMfjNNwn/ZxAtnbmaLmSmDq5ILU+MyxbDGvGKdNdXSEZHWBjx4
 tEx7EDDfCwj+fTNIC3AcDObybFspm3KLsOvmhbG98ZerhCGHsEDFeaTGpGZEd7lesSim
 avQO1pDPSbmjNjXsk9gP/+2OwDDDASBE3ntPhDWlrbDVOrUtlRCPIDi9xHmeYTJMo2A5
 DdKBYGVcw1bmNEopXbyu+VElEPkldHNlEBpC6cGyKywoaItLAOi4ZgY/f1uqqwoVU8wa
 Gq6kFZ5thJ7V68YFjUdtkIb0qz9EGoCBZfdbGHi7xs3NP0PfhRhBpyKB4fYPKiuQK7Z0 Wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vq0q447r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 14:18:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9IEHq3T193932;
        Fri, 18 Oct 2019 14:18:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vq0dxwv4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 14:17:59 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9IEHwZt026820;
        Fri, 18 Oct 2019 14:17:58 GMT
Received: from dhcp-10-154-168-69.vpn.oracle.com (/10.154.168.69)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Oct 2019 14:17:58 +0000
From:   John Donnelly <john.p.donnelly@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Date:   Fri, 18 Oct 2019 09:17:57 -0500
Subject: [PATCH] iommu/vt-d: Fix panic after kexec -p for kdump
Message-Id: <4E962E33-4B15-4407-9FF0-3705229D8881@oracle.com>
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=5 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=744
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910180134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=821 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910180133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cures a panic on restart after a kexec -p  operation on 5.3 and 5.4 =
kernels.

The underlying state of the iommu registers (iommu->flags &
VTD_FLAG_TRANS_PRE_ENABLED) on a restart results in a domain being =
marked as
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

Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
---
drivers/iommu/intel-iommu.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c4e0e4a9ee9e..f83a9a302f8e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2783,7 +2783,7 @@ static int identity_mapping(struct device *dev)
	struct device_domain_info *info;

	info =3D dev->archdata.iommu;
-	if (info && info !=3D DUMMY_DEVICE_DOMAIN_INFO)
+	if (info && info !=3D DUMMY_DEVICE_DOMAIN_INFO && info !=3D =
DEFER_DEVICE_DOMAIN_INFO)
		return (info->domain =3D=3D si_domain);

	return 0;
--=20
2.20.1=

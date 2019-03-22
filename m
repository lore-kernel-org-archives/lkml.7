Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D44C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44E72054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257691;
	bh=Dae9HaDyfCdwPRp0Laj5457iJ/QhJFhztZVSOjsuJ6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xMlVAgr/OIY09FPYhCQ1b3txJnzYxGEDpsQSyOMS+vWR4V7MIL34Aw8lvDgX83nMU
	 5y9as/+JHxiPT49mgptjKOyYRQJyHL+l+aSu1KKTOeMrUQu4qHVPGAzJKKUK8jJVyl
	 TFSl6pJS5G6p3uWLpgljinIvZVTcibiWXrvMVHFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390801AbfCVMVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:21:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390064AbfCVMU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:20:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C4B0218A1;
        Fri, 22 Mar 2019 12:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257256;
        bh=Dae9HaDyfCdwPRp0Laj5457iJ/QhJFhztZVSOjsuJ6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mo6MxPYOrj0e5z4ZXom7pRgmJR/aaUawwfW2nUWmi+MbJ1uJk919kQhGg+V0gYk36
         cqdhdbqcabmatEJM9tUqr7e81JjozK1dWb/lpm/44/y6F3yX2QVJrbfJ6g7fxgBzPE
         YBl4uDtfJKUUER64SlkOc3yevqdnx212lkAAMBmM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NuoHan Qiao <qiaonuohan@huawei.com>,
        Corey Minyard <cminyard@mvista.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 5.0 177/238] ipmi_si: fix use-after-free of resource->name
Date:   Fri, 22 Mar 2019 12:16:36 +0100
Message-Id: <20190322111308.722008882@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Yingliang <yangyingliang@huawei.com>

commit 401e7e88d4ef80188ffa07095ac00456f901b8c4 upstream.

When we excute the following commands, we got oops
rmmod ipmi_si
cat /proc/ioports

[ 1623.482380] Unable to handle kernel paging request at virtual address ffff00000901d478
[ 1623.482382] Mem abort info:
[ 1623.482383]   ESR = 0x96000007
[ 1623.482385]   Exception class = DABT (current EL), IL = 32 bits
[ 1623.482386]   SET = 0, FnV = 0
[ 1623.482387]   EA = 0, S1PTW = 0
[ 1623.482388] Data abort info:
[ 1623.482389]   ISV = 0, ISS = 0x00000007
[ 1623.482390]   CM = 0, WnR = 0
[ 1623.482393] swapper pgtable: 4k pages, 48-bit VAs, pgdp = 00000000d7d94a66
[ 1623.482395] [ffff00000901d478] pgd=000000dffbfff003, pud=000000dffbffe003, pmd=0000003f5d06e003, pte=0000000000000000
[ 1623.482399] Internal error: Oops: 96000007 [#1] SMP
[ 1623.487407] Modules linked in: ipmi_si(E) nls_utf8 isofs rpcrdma ib_iser ib_srpt target_core_mod ib_srp scsi_transport_srp ib_ipoib rdma_ucm ib_umad rdma_cm ib_cm dm_mirror dm_region_hash dm_log iw_cm dm_mod aes_ce_blk crypto_simd cryptd aes_ce_cipher ses ghash_ce sha2_ce enclosure sha256_arm64 sg sha1_ce hisi_sas_v2_hw hibmc_drm sbsa_gwdt hisi_sas_main ip_tables mlx5_ib ib_uverbs marvell ib_core mlx5_core ixgbe mdio hns_dsaf ipmi_devintf hns_enet_drv ipmi_msghandler hns_mdio [last unloaded: ipmi_si]
[ 1623.532410] CPU: 30 PID: 11438 Comm: cat Kdump: loaded Tainted: G            E     5.0.0-rc3+ #168
[ 1623.541498] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.37 11/21/2017
[ 1623.548822] pstate: a0000005 (NzCv daif -PAN -UAO)
[ 1623.553684] pc : string+0x28/0x98
[ 1623.557040] lr : vsnprintf+0x368/0x5e8
[ 1623.560837] sp : ffff000013213a80
[ 1623.564191] x29: ffff000013213a80 x28: ffff00001138abb5
[ 1623.569577] x27: ffff000013213c18 x26: ffff805f67d06049
[ 1623.574963] x25: 0000000000000000 x24: ffff00001138abb5
[ 1623.580349] x23: 0000000000000fb7 x22: ffff0000117ed000
[ 1623.585734] x21: ffff000011188fd8 x20: ffff805f67d07000
[ 1623.591119] x19: ffff805f67d06061 x18: ffffffffffffffff
[ 1623.596505] x17: 0000000000000200 x16: 0000000000000000
[ 1623.601890] x15: ffff0000117ed748 x14: ffff805f67d07000
[ 1623.607276] x13: ffff805f67d0605e x12: 0000000000000000
[ 1623.612661] x11: 0000000000000000 x10: 0000000000000000
[ 1623.618046] x9 : 0000000000000000 x8 : 000000000000000f
[ 1623.623432] x7 : ffff805f67d06061 x6 : fffffffffffffffe
[ 1623.628817] x5 : 0000000000000012 x4 : ffff00000901d478
[ 1623.634203] x3 : ffff0a00ffffff04 x2 : ffff805f67d07000
[ 1623.639588] x1 : ffff805f67d07000 x0 : ffffffffffffffff
[ 1623.644974] Process cat (pid: 11438, stack limit = 0x000000008d4cbc10)
[ 1623.651592] Call trace:
[ 1623.654068]  string+0x28/0x98
[ 1623.657071]  vsnprintf+0x368/0x5e8
[ 1623.660517]  seq_vprintf+0x70/0x98
[ 1623.668009]  seq_printf+0x7c/0xa0
[ 1623.675530]  r_show+0xc8/0xf8
[ 1623.682558]  seq_read+0x330/0x440
[ 1623.689877]  proc_reg_read+0x78/0xd0
[ 1623.697346]  __vfs_read+0x60/0x1a0
[ 1623.704564]  vfs_read+0x94/0x150
[ 1623.711339]  ksys_read+0x6c/0xd8
[ 1623.717939]  __arm64_sys_read+0x24/0x30
[ 1623.725077]  el0_svc_common+0x120/0x148
[ 1623.732035]  el0_svc_handler+0x30/0x40
[ 1623.738757]  el0_svc+0x8/0xc
[ 1623.744520] Code: d1000406 aa0103e2 54000149 b4000080 (39400085)
[ 1623.753441] ---[ end trace f91b6a4937de9835 ]---
[ 1623.760871] Kernel panic - not syncing: Fatal exception
[ 1623.768935] SMP: stopping secondary CPUs
[ 1623.775718] Kernel Offset: disabled
[ 1623.781998] CPU features: 0x002,21006008
[ 1623.788777] Memory Limit: none
[ 1623.798329] Starting crashdump kernel...
[ 1623.805202] Bye!

If io_setup is called successful in try_smi_init() but try_smi_init()
goes out_err before calling ipmi_register_smi(), so ipmi_unregister_smi()
will not be called while removing module. It leads to the resource that
allocated in io_setup() can not be freed, but the name(DEVICE_NAME) of
resource is freed while removing the module. It causes use-after-free
when cat /proc/ioports.

Fix this by calling io_cleanup() while try_smi_init() goes to out_err.
and don't call io_cleanup() until io_setup() returns successful to avoid
warning prints.

Fixes: 93c303d2045b ("ipmi_si: Clean up shutdown a bit")
Cc: stable@vger.kernel.org
Reported-by: NuoHan Qiao <qiaonuohan@huawei.com>
Suggested-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ipmi/ipmi_si_intf.c    |    5 +++++
 drivers/char/ipmi/ipmi_si_mem_io.c  |    5 +++--
 drivers/char/ipmi/ipmi_si_port_io.c |    5 +++--
 3 files changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2097,6 +2097,11 @@ static int try_smi_init(struct smi_info
 	WARN_ON(new_smi->io.dev->init_name != NULL);
 
  out_err:
+	if (rv && new_smi->io.io_cleanup) {
+		new_smi->io.io_cleanup(&new_smi->io);
+		new_smi->io.io_cleanup = NULL;
+	}
+
 	kfree(init_name);
 	return rv;
 }
--- a/drivers/char/ipmi/ipmi_si_mem_io.c
+++ b/drivers/char/ipmi/ipmi_si_mem_io.c
@@ -81,8 +81,6 @@ int ipmi_si_mem_setup(struct si_sm_io *i
 	if (!addr)
 		return -ENODEV;
 
-	io->io_cleanup = mem_cleanup;
-
 	/*
 	 * Figure out the actual readb/readw/readl/etc routine to use based
 	 * upon the register size.
@@ -141,5 +139,8 @@ int ipmi_si_mem_setup(struct si_sm_io *i
 		mem_region_cleanup(io, io->io_size);
 		return -EIO;
 	}
+
+	io->io_cleanup = mem_cleanup;
+
 	return 0;
 }
--- a/drivers/char/ipmi/ipmi_si_port_io.c
+++ b/drivers/char/ipmi/ipmi_si_port_io.c
@@ -68,8 +68,6 @@ int ipmi_si_port_setup(struct si_sm_io *
 	if (!addr)
 		return -ENODEV;
 
-	io->io_cleanup = port_cleanup;
-
 	/*
 	 * Figure out the actual inb/inw/inl/etc routine to use based
 	 * upon the register size.
@@ -109,5 +107,8 @@ int ipmi_si_port_setup(struct si_sm_io *
 			return -EIO;
 		}
 	}
+
+	io->io_cleanup = port_cleanup;
+
 	return 0;
 }



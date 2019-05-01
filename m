Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3F6C46460
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 00:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05C921743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 00:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ouhDZAWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfEAAaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 20:30:06 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:33841 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfEAAaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 20:30:05 -0400
Received: by mail-vk1-f202.google.com with SMTP id y82so7129462vkd.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 17:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rvnnbDmsOgJ3xr/PffPc0gbHg8YSZc9QHWS8F5/zrz0=;
        b=ouhDZAWcHKtKyngvM68oiibCChzMbcqbVGPz4YuQdwYUPFM4ynjce1cPHtBKp+HrJh
         SHEg0bopCTTpmijYzKAlX8Hcvt4WTS9mmBRQwZ7OrOC4nW18Hc8PgqA88LbKdWg67BtN
         22pvwxMyiNDPQkTaWYwf3FnpZXnWVlDML2Inls7H2lUgAccqN5vm2Ya7DA8PVn9h21Ui
         zEvGZzs13JPe3YwreavZZvdN4kH5gkrMGNsTmYTqYOKpf1gFMDSlKxTfZvtf/bwAXEBG
         lGz9Vp/KNDxebfL8M2UvekoKUhgIq86pq8LiZF629VUUGzYosazpZdvAB0/NWRarQ9aI
         QFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rvnnbDmsOgJ3xr/PffPc0gbHg8YSZc9QHWS8F5/zrz0=;
        b=G7Eax5aVhq7yju7LhLqQ7Zq5TzOu/2xqx2mulEGXqQXasO8DKOLLIrmOArMawBRLWj
         kzb8+EZ6BcMGWrnBi8vjCOSw6Q0/lBbwICLIvTpdsGBm8UXLwMVUUC9Q84rF/ZJbDrnR
         N4lOGz/aR9pyM4tmRn5xdPVl7y99uoeSj2O+3vCuJccAXNXXs5WZHv3O8k3BHbQg27lP
         jthchpKYlu0HNaZ/2zqoCE9EtDCzAh2A/mVe9HK5hVFJ85uKT/49Nac6pJ+KWiitv5oB
         ysW/yeY4GG/INW5sCDlOdN7xeo32rfMhMzIFg3+0Uu69rXI8+b2qIspf7IwPdmKQxWJV
         lXDw==
X-Gm-Message-State: APjAAAVk/9UOllRQNV6OYfAqJhRZTbI0MP0rbMQSswa6dHJgT1/LiRX7
        NAVHCnScbbTXihTIMPvQc3+JywXIJ05zUNu/+EF8Fp4pe8KrDT4DPTS2+O+IfUlyxJz2QwKczD1
        9yfdm1pC26FXy69NYfkCGI3G4l6LQDH4KYCX/xWUBhwO7GouW/nBghLh0VWJkthD6y9k7V8L3V1
        WxyA==
X-Google-Smtp-Source: APXvYqxS/RD69FJkWFky/f1r4LGDC/KcN/ZgqbnWKDp6CV3L9ulYeepm2htYaXuH9V02y1lY6qy0VpnQ+LgxkHE=
X-Received: by 2002:a67:f695:: with SMTP id n21mr2835367vso.19.1556670604001;
 Tue, 30 Apr 2019 17:30:04 -0700 (PDT)
Date:   Tue, 30 Apr 2019 17:30:01 -0700
Message-Id: <20190501003001.186239-1-jemoreira@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH] vsock/virtio: Initialize core virtio vsock before registering
 the driver
From:   "Jorge E. Moreira" <jemoreira@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a race in which static variables in net/vmw_vsock/af_vsock.c are
accessed (while handling interrupts) before they are initialized.

[    4.201410] BUG: unable to handle kernel paging request at ffffffffffffffe8
[    4.207829] IP: vsock_addr_equals_addr+0x3/0x20
[    4.211379] PGD 28210067 P4D 28210067 PUD 28212067 PMD 0
[    4.211379] Oops: 0000 [#1] PREEMPT SMP PTI
[    4.211379] Modules linked in:
[    4.211379] CPU: 1 PID: 30 Comm: kworker/1:1 Not tainted 4.14.106-419297-gd7e28cc1f241 #1
[    4.211379] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    4.211379] Workqueue: virtio_vsock virtio_transport_rx_work
[    4.211379] task: ffffa3273d175280 task.stack: ffffaea1800e8000
[    4.211379] RIP: 0010:vsock_addr_equals_addr+0x3/0x20
[    4.211379] RSP: 0000:ffffaea1800ebd28 EFLAGS: 00010286
[    4.211379] RAX: 0000000000000002 RBX: 0000000000000000 RCX: ffffffffb94e42f0
[    4.211379] RDX: 0000000000000400 RSI: ffffffffffffffe0 RDI: ffffaea1800ebdd0
[    4.211379] RBP: ffffaea1800ebd58 R08: 0000000000000001 R09: 0000000000000001
[    4.211379] R10: 0000000000000000 R11: ffffffffb89d5d60 R12: ffffaea1800ebdd0
[    4.211379] R13: 00000000828cbfbf R14: 0000000000000000 R15: ffffaea1800ebdc0
[    4.211379] FS:  0000000000000000(0000) GS:ffffa3273fd00000(0000) knlGS:0000000000000000
[    4.211379] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.211379] CR2: ffffffffffffffe8 CR3: 000000002820e001 CR4: 00000000001606e0
[    4.211379] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    4.211379] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    4.211379] Call Trace:
[    4.211379]  ? vsock_find_connected_socket+0x6c/0xe0
[    4.211379]  virtio_transport_recv_pkt+0x15f/0x740
[    4.211379]  ? detach_buf+0x1b5/0x210
[    4.211379]  virtio_transport_rx_work+0xb7/0x140
[    4.211379]  process_one_work+0x1ef/0x480
[    4.211379]  worker_thread+0x312/0x460
[    4.211379]  kthread+0x132/0x140
[    4.211379]  ? process_one_work+0x480/0x480
[    4.211379]  ? kthread_destroy_worker+0xd0/0xd0
[    4.211379]  ret_from_fork+0x35/0x40
[    4.211379] Code: c7 47 08 00 00 00 00 66 c7 07 28 00 c7 47 08 ff ff ff ff c7 47 04 ff ff ff ff c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 8b 47 08 <3b> 46 08 75 0a 8b 47 04 3b 46 04 0f 94 c0 c3 31 c0 c3 90 66 2e
[    4.211379] RIP: vsock_addr_equals_addr+0x3/0x20 RSP: ffffaea1800ebd28
[    4.211379] CR2: ffffffffffffffe8
[    4.211379] ---[ end trace f31cc4a2e6df3689 ]---
[    4.211379] Kernel panic - not syncing: Fatal exception in interrupt
[    4.211379] Kernel Offset: 0x37000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    4.211379] Rebooting in 5 seconds..

Fixes: 22b5c0b63f32 ("vsock/virtio: fix kernel panic after device hot-unplug")
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: netdev@vger.kernel.org
Cc: kernel-team@android.com
Cc: stable@vger.kernel.org [4.9+]
Signed-off-by: Jorge E. Moreira <jemoreira@google.com>
---
 net/vmw_vsock/virtio_transport.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 15eb5d3d4750..96ab344f17bb 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -702,28 +702,27 @@ static int __init virtio_vsock_init(void)
 	if (!virtio_vsock_workqueue)
 		return -ENOMEM;
 
-	ret = register_virtio_driver(&virtio_vsock_driver);
+	ret = vsock_core_init(&virtio_transport.transport);
 	if (ret)
 		goto out_wq;
 
-	ret = vsock_core_init(&virtio_transport.transport);
+	ret = register_virtio_driver(&virtio_vsock_driver);
 	if (ret)
-		goto out_vdr;
+		goto out_vci;
 
 	return 0;
 
-out_vdr:
-	unregister_virtio_driver(&virtio_vsock_driver);
+out_vci:
+	vsock_core_exit();
 out_wq:
 	destroy_workqueue(virtio_vsock_workqueue);
 	return ret;
-
 }
 
 static void __exit virtio_vsock_exit(void)
 {
-	vsock_core_exit();
 	unregister_virtio_driver(&virtio_vsock_driver);
+	vsock_core_exit();
 	destroy_workqueue(virtio_vsock_workqueue);
 }
 
-- 
2.21.0.593.g511ec345e18-goog


Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421B6C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E536F2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=eikelenboom.it header.i=@eikelenboom.it header.b="ADokSp/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732095AbfHHJOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:14:18 -0400
Received: from server.eikelenboom.it ([91.121.65.215]:47744 "EHLO
        server.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbfHHJOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:14:17 -0400
X-Greylist: delayed 756 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Aug 2019 05:14:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eikelenboom.it; s=20180706; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q4t05Hs2cQCUotCtn7fTqSBa+P2LJrH574M0w2wbHtE=; b=ADokSp/R6afsIgIwth6F1DDmUR
        PVYhiNqbukN8QGmzssxOfawyGiMHfksGow2B1ZVxN9SYNKkiOK9ahjpKtXOt5tLN5K/iDNsP8cczk
        PmVoM3TXdP8Hz77mOGm1nybU+4d43On5/YbRLINOlACFbhHt713tisK3HtWJsrMBNKNs=;
Received: from ip4da85049.direct-adsl.nl ([77.168.80.73]:48140 helo=[172.16.1.50])
        by server.eikelenboom.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <linux@eikelenboom.it>)
        id 1hveIq-0000ub-7C; Thu, 08 Aug 2019 11:01:44 +0200
To:     Jens Axboe <axboe@kernel.dk>,
        Douglas Anderson <dianders@chromium.org>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
From:   Sander Eikelenboom <linux@eikelenboom.it>
Subject: RIP: e030:bfq_exit_icq_bfqq+0x147/0x1c0
Message-ID: <6cfd07de-f5a8-78ea-405a-0243061cb620@eikelenboom.it>
Date:   Thu, 8 Aug 2019 11:05:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L.S.,

While testing a linux 5.3-rc3 kernel on my Xen server I come across the splat below when trying to shutdown all the VM's.
This is after the server has ran for a few days without any problem. It seems to happen consistently.

It seems it's in the same area as dbc3117d4ca9e17819ac73501e914b8422686750, but already rc3 incorporates that patch.

Any ideas ?

--
Sander


[80915.716048] BUG: unable to handle page fault for address: 0000100000000008
[80915.724188] #PF: supervisor write access in kernel mode
[80915.733182] #PF: error_code(0x0002) - not-present page
[80915.741455] PGD 0 P4D 0 
[80915.750538] Oops: 0002 [#1] SMP NOPTI
[80915.758425] CPU: 4 PID: 11407 Comm: 17.hda-2 Tainted: G        W         5.3.0-rc3-20190807-doflr+ #1
[80915.766137] Hardware name: MSI MS-7640/890FXA-GD70 (MS-7640)  , BIOS V1.8B1 09/13/2010
[80915.773737] RIP: e030:bfq_exit_icq_bfqq+0x147/0x1c0
[80915.781294] Code: 00 00 00 00 00 00 48 0f ba b0 20 01 00 00 0c 48 8b 88 f0 01 00 00 48 85 c9 74 29 48 8b b0 e8 01 00 00 48 89 31 48 85 f6 74 04 <48> 89 4e 08 48 c7 80 e8 01 00 00 00 00 00 00 48 c7 80 f0 01 00 00
[80915.796792] RSP: e02b:ffffc9000473be28 EFLAGS: 00010006
[80915.804419] RAX: ffff888070393200 RBX: ffff888076c4a800 RCX: ffff888076c4a9f8
[80915.810254] device vif17.0 left promiscuous mode
[80915.811906] RDX: 0000100000000000 RSI: 0000100000000000 RDI: 0000000000000000
[80915.811908] RBP: ffff888077efc398 R08: 0000000000000004 R09: ffffffff81106800
[80915.811909] R10: ffff88807804ca40 R11: ffffc9000473be31 R12: ffff888005256bf0
[80915.811909] R13: 0000000000000000 R14: ffff888005256800 R15: ffffffff82a6a3c0
[80915.811919] FS:  00007f1c30a8dbc0(0000) GS:ffff88807d500000(0000) knlGS:0000000000000000
[80915.819456] xen_bridge: port 18(vif17.0) entered disabled state
[80915.826569] CS:  10000e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[80915.826571] CR2: 0000100000000008 CR3: 000000005d9d0000 CR4: 0000000000000660
[80915.826575] Call Trace:
[80915.826592]  bfq_exit_icq+0xe/0x20
[80915.826595]  put_io_context_active+0x52/0x80
[80915.826599]  do_exit+0x774/0xac0
[80915.906037]  ? xen_blkif_be_int+0x30/0x30
[80915.913311]  kthread+0xda/0x130
[80915.920398]  ? kthread_park+0x80/0x80
[80915.927524]  ret_from_fork+0x22/0x40
[80915.934512] Modules linked in:
[80915.941412] CR2: 0000100000000008
[80915.948221] ---[ end trace 61315493e0f8ef40 ]---
[80915.954984] RIP: e030:bfq_exit_icq_bfqq+0x147/0x1c0
[80915.961850] Code: 00 00 00 00 00 00 48 0f ba b0 20 01 00 00 0c 48 8b 88 f0 01 00 00 48 85 c9 74 29 48 8b b0 e8 01 00 00 48 89 31 48 85 f6 74 04 <48> 89 4e 08 48 c7 80 e8 01 00 00 00 00 00 00 48 c7 80 f0 01 00 00
[80915.976124] RSP: e02b:ffffc9000473be28 EFLAGS: 00010006
[80915.983205] RAX: ffff888070393200 RBX: ffff888076c4a800 RCX: ffff888076c4a9f8
[80915.990321] RDX: 0000100000000000 RSI: 0000100000000000 RDI: 0000000000000000
[80915.997319] RBP: ffff888077efc398 R08: 0000000000000004 R09: ffffffff81106800
[80916.004427] R10: ffff88807804ca40 R11: ffffc9000473be31 R12: ffff888005256bf0
[80916.011525] R13: 0000000000000000 R14: ffff888005256800 R15: ffffffff82a6a3c0
[80916.018679] FS:  00007f1c30a8dbc0(0000) GS:ffff88807d500000(0000) knlGS:0000000000000000
[80916.025897] CS:  10000e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[80916.033116] CR2: 0000100000000008 CR3: 000000005d9d0000 CR4: 0000000000000660
[80916.040348] Fixing recursive fault but reboot is needed!

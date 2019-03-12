Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D99C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68479214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413568;
	bh=UnOB25eJ+t8VptOGRxIYV1YIQ1maq8d6IOTPXLkilJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0aqO4h9Qbx7nyQ4WhiN3YpdXMYYH4kaF0c0qabz642FCGsJ7/w9bsC9hqGnJ54CWI
	 Rydceh+SSJW3GFjvaT7RzFyDFt47c5Z1Ks1O3To2vLPAlH0lGt/r98k85cKMMYOxnR
	 FSs+0eimILQg28STB6FrLq3yTVu9O6ypnFx57r/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfCLR71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbfCLRNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:33 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 353D421852;
        Tue, 12 Mar 2019 17:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410812;
        bh=UnOB25eJ+t8VptOGRxIYV1YIQ1maq8d6IOTPXLkilJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bCvjVCXsqaSmqoOQ8xoIT2qz4o+H/O/NclVtYax6/WoTXHOnxtV0CASTnYVOHdpB5
         FOcs/XpHl3naIXadh4mOJ2YAINgvwllrov32EYPHCbIg57adg1BL2iBuU1g6JM/+fw
         jqTA1P1b+E4pKpPOXb/xavOOUG87OtAKP2eIHC6I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <rong.a.chen@intel.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.20 164/171] bpf: Stop the psock parser before canceling its work
Date:   Tue, 12 Mar 2019 10:09:04 -0700
Message-Id: <20190312170401.502067554@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Sitnicki <jakub@cloudflare.com>

commit e8e3437762ad938880dd48a3c52d702e7cf3c124 upstream.

We might have never enabled (started) the psock's parser, in which case it
will not get stopped when destroying the psock. This leads to a warning
when trying to cancel parser's work from psock's deferred destructor:

[  405.325769] WARNING: CPU: 1 PID: 3216 at net/strparser/strparser.c:526 strp_done+0x3c/0x40
[  405.326712] Modules linked in: [last unloaded: test_bpf]
[  405.327359] CPU: 1 PID: 3216 Comm: kworker/1:164 Tainted: G        W         5.0.0 #42
[  405.328294] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180531_142017-buildhw-08.phx2.fedoraproject.org-1.fc28 04/01/2014
[  405.329712] Workqueue: events sk_psock_destroy_deferred
[  405.330254] RIP: 0010:strp_done+0x3c/0x40
[  405.330706] Code: 28 e8 b8 d5 6b ff 48 8d bb 80 00 00 00 e8 9c d5 6b ff 48 8b 7b 18 48 85 ff 74 0d e8 1e a5 e8 ff 48 c7 43 18 00 00 00 00 5b c3 <0f> 0b eb cf 66 66 66 66 90 55 89 f5 53 48 89 fb 48 83 c7 28 e8 0b
[  405.332862] RSP: 0018:ffffc900026bbe50 EFLAGS: 00010246
[  405.333482] RAX: ffffffff819323e0 RBX: ffff88812cb83640 RCX: ffff88812cb829e8
[  405.334228] RDX: 0000000000000001 RSI: ffff88812cb837e8 RDI: ffff88812cb83640
[  405.335366] RBP: ffff88813fd22680 R08: 0000000000000000 R09: 000073746e657665
[  405.336472] R10: 8080808080808080 R11: 0000000000000001 R12: ffff88812cb83600
[  405.337760] R13: 0000000000000000 R14: ffff88811f401780 R15: ffff88812cb837e8
[  405.338777] FS:  0000000000000000(0000) GS:ffff88813fd00000(0000) knlGS:0000000000000000
[  405.339903] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  405.340821] CR2: 00007fb11489a6b8 CR3: 000000012d4d6000 CR4: 00000000000406e0
[  405.341981] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  405.343131] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  405.344415] Call Trace:
[  405.344821]  sk_psock_destroy_deferred+0x23/0x1b0
[  405.345585]  process_one_work+0x1ae/0x3e0
[  405.346110]  worker_thread+0x3c/0x3b0
[  405.346576]  ? pwq_unbound_release_workfn+0xd0/0xd0
[  405.347187]  kthread+0x11d/0x140
[  405.347601]  ? __kthread_parkme+0x80/0x80
[  405.348108]  ret_from_fork+0x35/0x40
[  405.348566] ---[ end trace a4a3af4026a327d4 ]---

Stop psock's parser just before canceling its work.

Fixes: 1d79895aef18 ("sk_msg: Always cancel strp work before freeing the psock")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/skmsg.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -545,6 +545,7 @@ static void sk_psock_destroy_deferred(st
 	struct sk_psock *psock = container_of(gc, struct sk_psock, gc);
 
 	/* No sk_callback_lock since already detached. */
+	strp_stop(&psock->parser.strp);
 	strp_done(&psock->parser.strp);
 
 	cancel_work_sync(&psock->work);



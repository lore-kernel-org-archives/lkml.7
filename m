Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A2AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6915B20716
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="Rk4PUTEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfLSMNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:13:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34346 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfLSMNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:13:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id r11so3042587pgf.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 04:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xF/0eg1mKjbOu46bWm6AvTJ4OsSRBLEmdwbGkyHb8Bk=;
        b=Rk4PUTEA2K/8XbN9jcFMgI0Hv+1gCRpWq1cbOD3jHiCa8uxFeJ2uPrMc2ArJlqD/B9
         3ghwSn6ebHp2vDW9Qe3Gmd0B6UQqOcUy8iHHr5Lf95/poXGNx/vhXC6fl1xs0Y9bVZIr
         VV0zZYlScMMSL0Uw/H+ugg/KxtwmBmerF8c/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xF/0eg1mKjbOu46bWm6AvTJ4OsSRBLEmdwbGkyHb8Bk=;
        b=LfVj1wYHihMPDf4Zyke2pVz5UfGwHMp9qzHo7zxLqXVmARopvz1eysauglEdDvmaqB
         JhgLMY4+UBRNSx29ao3eymZxaaiM/KwRImffF3zy8INIGVTmUK7Q45JsUey9gKpoCaK6
         npZS41PewAttGur08pqlM+biUtHsS0WkicOhSMKvaqjZ1bAdJcwwHxdVK7KzO3dzJJLL
         pu/piGnYFNDmnETmB+arQxTyGrudMeWsiZpTsrnC9EiP/kPiHL+fx8Q66LrfXGaT9LdC
         UUe3vG2aGKwm/2odl/TAtkWgwhiFtpIEGvimFUDP4PV1nZGjCFsnQSO3M8T9Wno2uVBU
         COfQ==
X-Gm-Message-State: APjAAAV8uuaI+F2YRyykm2rZxHBkr0viGqWgPFfhMl2fz58fFKOfyzAF
        3rQNO3akd042M0Quk2aBc0ljLtm/H4Y=
X-Google-Smtp-Source: APXvYqxmzWgC+ooAh65J1KbMCQBICOAT3BLbu/7+uz3lKkd0tgrKGigRRvRxfuVIQptzW5/6HE8Spw==
X-Received: by 2002:a62:7541:: with SMTP id q62mr9239419pfc.256.1576757580691;
        Thu, 19 Dec 2019 04:13:00 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-b05d-cbfe-b2ee-de17.static.ipv6.internode.on.net. [2001:44b8:1113:6700:b05d:cbfe:b2ee:de17])
        by smtp.gmail.com with ESMTPSA id z19sm7660119pfn.49.2019.12.19.04.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 04:12:59 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     ajd@linux.ibm.com, mpe@ellerman.id.au,
        Daniel Axtens <dja@axtens.net>,
        syzbot+1e925b4b836afe85a1c6@syzkaller-ppc64.appspotmail.com,
        syzbot+587b2421926808309d21@syzkaller-ppc64.appspotmail.com,
        syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com,
        syzbot+d6074fb08bdb2e010520@syzkaller.appspotmail.com
Subject: [PATCH v2] relay: handle alloc_percpu returning NULL in relay_open
Date:   Thu, 19 Dec 2019 23:12:56 +1100
Message-Id: <20191219121256.26480-1-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_percpu() may return NULL, which means chan->buf may be set to
NULL. In that case, when we do *per_cpu_ptr(chan->buf, ...), we
dereference an invalid pointer:

BUG: Unable to handle kernel data access at 0x7dae0000
Faulting instruction address: 0xc0000000003f3fec
...
NIP [c0000000003f3fec] relay_open+0x29c/0x600
LR [c0000000003f3fc0] relay_open+0x270/0x600
Call Trace:
[c000000054353a70] [c0000000003f3fb4] relay_open+0x264/0x600 (unreliable)
[c000000054353b00] [c000000000451764] __blk_trace_setup+0x254/0x600
[c000000054353bb0] [c000000000451b78] blk_trace_setup+0x68/0xa0
[c000000054353c10] [c0000000010da77c] sg_ioctl+0x7bc/0x2e80
[c000000054353cd0] [c000000000758cbc] do_vfs_ioctl+0x13c/0x1300
[c000000054353d90] [c000000000759f14] ksys_ioctl+0x94/0x130
[c000000054353de0] [c000000000759ff8] sys_ioctl+0x48/0xb0
[c000000054353e20] [c00000000000bcd0] system_call+0x5c/0x68

Check if alloc_percpu returns NULL.

This was found by syzkaller both on x86 and powerpc, and the reproducer
it found on powerpc is capable of hitting the issue as an unprivileged
user.

Fixes: 017c59c042d0 ("relay: Use per CPU constructs for the relay channel buffer pointers")
Reported-by: syzbot+1e925b4b836afe85a1c6@syzkaller-ppc64.appspotmail.com
Reported-by: syzbot+587b2421926808309d21@syzkaller-ppc64.appspotmail.com
Reported-by: syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com
Reported-by: syzbot+d6074fb08bdb2e010520@syzkaller.appspotmail.com
Cc: Akash Goel <akash.goel@intel.com>
Cc: Andrew Donnellan <ajd@linux.ibm.com> # syzkaller-ppc64
Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
Cc: stable@vger.kernel.org # v4.10+
Signed-off-by: Daniel Axtens <dja@axtens.net>

--

v2: drop the NOWARN.

There's a syz reproducer on the powerpc syzbot that eventually hits
the bug, but it can take up to an hour or so before it keels over on a
kernel with all the syzkaller debugging on, and even longer on a
production kernel. I have been able to reproduce it once on a stock
Ubuntu 5.0 ppc64le kernel.

CVE-2019-19462 has been assigned. While only the process doing the syscall
gets killed, it gets killed while holding the relay_channels_mutex,
so it blocks all future relay activity.
---
 kernel/relay.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/relay.c b/kernel/relay.c
index ade14fb7ce2e..4b760ec16342 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -581,6 +581,11 @@ struct rchan *relay_open(const char *base_filename,
 		return NULL;
 
 	chan->buf = alloc_percpu(struct rchan_buf *);
+	if (!chan->buf) {
+		kfree(chan);
+		return NULL;
+	}
+
 	chan->version = RELAYFS_CHANNEL_VERSION;
 	chan->n_subbufs = n_subbufs;
 	chan->subbuf_size = subbuf_size;
-- 
2.20.1


Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAC4C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E66F20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="dQJ7OlZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgAHIv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:51:57 -0500
Received: from sender4-pp-o98.zoho.com ([136.143.188.98]:25823 "EHLO
        sender4-pp-o98.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgAHIv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:51:56 -0500
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jan 2020 03:51:55 EST
ARC-Seal: i=1; a=rsa-sha256; t=1578472590; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=OB3SCILpr4Z2HkfDFFNE7HNxkHVQnwJOQ6XqUxbNHgMJQ3EbZQt6OLYMYH2YeAHEZnY8NtdSkjAp+gbKoSZ0lgljPnMLd50NzfOmEY6ua+ZajK13YW8xVaLP9WxwPRYvjNhCgOitLY5HRIEMh2Qz6M9R87Mv9H0/7o/HfZb3IzA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1578472590; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=+kgrggsSsoG7yMscyxbbsc5njPglpoR+TUgwY4n/iFU=; 
        b=GROFp6ndAUnwUaz7LEKpc9ijGoTdVCRGhvRqI5WYOzX/Mvy+KrjEEhHzf5uLOB1FrCaXW97SGJ/zxjB60YEC3wcShnKZfSgAPD+xnU0hz2uH/elES5loaY5nWA3bJjI7o56QgQyxpJdwMFEy5uk8TZWBG25kJ+CbbUT1CFxUxNM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=VXa2XQTPmANlI8AMq7s0PCO5iDy7edtCqbRh9NptyUVBTC2PJzSkOzybjPnSbJ3TPSn/r7HnpNF0
    OwUN0a6mZgeqt/TtkJg14OKh0FIA3ASXIC/0aykOAkux9vOgn7BE  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1578472590;
        s=zm2020; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=+kgrggsSsoG7yMscyxbbsc5njPglpoR+TUgwY4n/iFU=;
        b=dQJ7OlZnyg7AdlMRnO3dxz+qikvEwOIQVif0SrF1AiHhNgS5rfSyUEcZiDeFRL+/
        Y8f71GLTgLETcqfO9+7ij0W4HKok2EJyl3EdKwiwUBzCPntktNCSk2QeaPxLp/HkSBr
        qPObOdvCAlIEkM2BLzNp7uyk/jqlswZu9pogwml4=
Received: from YEHS1XPF1D05WL.lenovo.com (123.120.78.162 [123.120.78.162]) by mx.zohomail.com
        with SMTPS id 1578472511306306.39115541972785; Wed, 8 Jan 2020 00:35:11 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     keescook@chromium.org, casey@schaufler-ca.com
Cc:     jmorris@namei.org, efremov@ispras.ru, paul@paul-moore.com,
        omosnace@redhat.com, dhowells@redhat.com, joel@joelfernandes.org,
        tyu1@lenovo.com, linux-kernel@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH] LSM: Delete hooks in reverse order for avoiding race
Date:   Wed,  8 Jan 2020 16:34:30 +0800
Message-Id: <20200108083430.57412-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

There is small possibility as race condition when selinux_disable
has been triggered. security_delete_hooks deletes all selinux hooks
from security_hook_heads, but there are some selinux functions which
are being called at the same time.

Here is a panic accident scene from 4.18 based kernel,

[   26.654494] SELinux:  Disabled at runtime.
[   26.654507] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000020
[   26.654508] PGD 0 P4D 0
[   26.654510] Oops: 0002 [#1] SMP NOPTI
[   26.654512] CPU: 53 PID: 2614 Comm: systemd-cgroups Tainted: G
     OE    --------- -  - 4.18.0-80.el8.x86_64 #1
[   26.654512] Hardware name: Lenovo ThinkSystem SR850P
 -[7D2H]-/-[7D2H]-, BIOS -[TEE145P-1.10]- 12/06/2019
[   26.654519] RIP: 0010:selinux_socket_post_create+0x80/0x390
[   26.654520] Code: e9 95 6a 89 00 bd 16 00 00 00 c7 44 24 04 01
 00 00 00 45 85 c0 0f 85 f6 00 00 00 8b 56 14 85 d2 0f 84 26 01 00
 00 89 54 24 04 <66> 41 89 6c 24 20 31 c0 41 89 54 24 1c 41 c6 44
 24 22 01 49 8b 4d
[   26.654521] RSP: 0018:ffffbf515cc63e48 EFLAGS: 00010246
[   26.654522] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000019
[   26.654522] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffffffab46f680
[   26.654523] RBP: 0000000000000019 R08: 0000000000000000 R09: ffffbf515cc63e4c
[   26.654523] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   26.654524] R13: ffff97d7bb6cbc80 R14: 0000000000000001 R15: ffff97d7bb6cbc80
[   26.654525] FS:  00007f5c608ea380(0000) GS:ffff97d7bf140000(0000) knlGS:0000000000000000
[   26.654525] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.654526] CR2: 0000000000000020 CR3: 0000011ebc934004 CR4: 00000000007606e0
[   26.654527] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   26.654528] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   26.654528] PKRU: 55555554
[   26.654528] Call Trace:
[   26.654535]  security_socket_post_create+0x42/0x60
[   26.654537] SELinux:  Unregistering netfilter hooks
[   26.654542]  __sock_create+0x106/0x1a0
[   26.654545]  __sys_socket+0x57/0xe0
[   26.654547]  __x64_sys_socket+0x16/0x20
[   26.654551]  do_syscall_64+0x5b/0x1b0
[   26.654554]  entry_SYSCALL_64_after_hwframe+0x65/0xca

The root cause is that, selinux_inode_alloc_security has been deleted
firstly from security_hook_heads, so security_inode_alloc directly 
return 0, that means the value of pointer inode->i_security equalling
to NULL.

But selinux_socket_post_create hasn't been deleted at that moment, so
which would involked by mistake. Inside the function, pointer isec
needs to point to inode->i_security, then a NULL pointer defect happens.

For current upstream kernel, because of commit
afb1cbe37440c7f38b9cf46fc331cc9dfd5cce21
the inode security has been moved out to LSM infrastructure from
individual security modules like selinux.

But this patch still can be applied for solving similar issue when
security_delete_hooks has been used. Also for stable branch v4.19,
the inode security still need to be created in individual modules.

The patch has been verified by Lenovo SR850P server through overnight
reboot cycles.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 include/linux/lsm_hooks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 20d8cf1..57cb2ac 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2164,7 +2164,7 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 	int i;
 
 	for (i = 0; i < count; i++)
-		hlist_del_rcu(&hooks[i].list);
+		hlist_del_rcu(&hooks[count - 1 - i].list);
 }
 #endif /* CONFIG_SECURITY_SELINUX_DISABLE */
 
-- 
1.8.3.1



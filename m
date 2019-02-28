Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC95C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0452133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551368083;
	bh=fJK6iMzVu0kVdh0LvvygSDe9BB+1XB4OIFTMCsjXWH8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=TwKkf/k5TBTNL6XpgQP5MLHi4M9RGNVSDQ5EwRrYOcpRGtg6CxVBZ3pbeFe6v3I3O
	 OBpclqbinPq+ULif96HX0Wj9dTEVjGK7KTtJHcTmAcODiBStftB+6ldYXWG6/dScU+
	 0y6bS0bH2ROY9LVy2giKLN64c+Ayp+DsOuj/jemE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387761AbfB1Pem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:34:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:35766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732065AbfB1Pek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:34:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3B59206DD;
        Thu, 28 Feb 2019 15:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551368080;
        bh=fJK6iMzVu0kVdh0LvvygSDe9BB+1XB4OIFTMCsjXWH8=;
        h=Date:From:To:Cc:Subject:From;
        b=MrnjIUGhQYCBUFZqVBISbCFt65iTZqGIvbTw3c1L4+4MNWQ/HRV/cMgRORfqfU5I+
         iOuBiWw3zVaPVKBp/q+bGN5EgQj2XvjbRlN/fILpHE78hr3Uv0Z/Y50jqNR68wFV+O
         2y8KUMiFis5q+NpiIJsGfP6smlGrxo38yMniKptw=
Date:   Thu, 28 Feb 2019 16:34:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>, kvm@vger.kernel.org,
        syzbot <syzbot+7857962b4d45e602b8ad@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: [PATCH] kvm: properly check debugfs dentry before using it
Message-ID: <20190228153437.GI8481@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs can now report an error code if something went wrong instead of
just NULL.  So if the return value is to be used as a "real" dentry, it
needs to be checked if it is an error before dereferencing it.

This is now happening because of ff9fb72bc077 ("debugfs: return error
values, not NULL").  syzbot has found a way to trigger multiple debugfs
files attempting to be created, which fails, and then the error code
gets passed to dentry_path_raw() which obviously does not like it.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Reported-and-tested-by: syzbot+7857962b4d45e602b8ad@syzkaller.appspotmail.com
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

Linus, this should go in before 5.0-final is out, as it resolves a
problem found by syzbot.  Paolo has given his ack for me to send this
directly to you.  If you want this in [GIT PULL] format, I can do that
as well.

 virt/kvm/kvm_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4044,7 +4044,7 @@ static void kvm_uevent_notify_change(uns
 	}
 	add_uevent_var(env, "PID=%d", kvm->userspace_pid);
 
-	if (kvm->debugfs_dentry) {
+	if (!IS_ERR_OR_NULL(kvm->debugfs_dentry)) {
 		char *tmp, *p = kmalloc(PATH_MAX, GFP_KERNEL);
 
 		if (p) {

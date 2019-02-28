Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF20C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7086218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366490;
	bh=07NQ6vyXCGuZ0OvIFh9Yt/v+WOUhGCBfJqAF9Qw3iz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LFC45Nng+CyhSJvY1ZUF/2VEObXwU5zz6Z3Mbm57NOW9lOC4tY0cCZfoP9LXUPU9X
	 koZKBiX8qxWvakgn7iwu5lsUpaRIPP4naGqGXWVusBXFCNueTNs8KKGnz3iMH0Ytvb
	 bwPx1GSd4lXdOE6YvhaC+PgxWw+gofx4CSIFwtYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbfB1PIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:08:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:40150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbfB1PIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93A8F2184A;
        Thu, 28 Feb 2019 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366488;
        bh=07NQ6vyXCGuZ0OvIFh9Yt/v+WOUhGCBfJqAF9Qw3iz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0jdkYgHZ2xC+2+zeKiF2SPlkASIdpVrvMpQDcd8pL9mJvTEQOl7nJdM6J4byaN7kl
         DnC7CsYR+8UEf2bR6WlqF1Sfh/COvKdpDicvlN0QvDNnCQ7uWKfOrOMXhx4MWK0iZ2
         LqmEbmZLUIavdwD/XO9yyAhJlg2+QQCu/iyI7KNM=
Date:   Thu, 28 Feb 2019 16:08:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     kvm@vger.kernel.org,
        syzbot <syzbot+7857962b4d45e602b8ad@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: [PATCH] kvm: properly check debugfs dentry before using it
Message-ID: <20190228150805.GA31904@kroah.com>
References: <0000000000007e10c50580aa7684@google.com>
 <0000000000006164d205825fb497@google.com>
 <20190226191932.GB218103@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190226191932.GB218103@gmail.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---

Paolo, this should be merged into 5.0-final, and if not there, then
5.1-rc1 and then backported to 5.0 through the stable tree.  If you
want me to send this to Linus, I will be glad to do so.


diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 585845203db8..076bc38963bf 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4044,7 +4044,7 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
 	}
 	add_uevent_var(env, "PID=%d", kvm->userspace_pid);
 
-	if (kvm->debugfs_dentry) {
+	if (!IS_ERR_OR_NULL(kvm->debugfs_dentry)) {
 		char *tmp, *p = kmalloc(PATH_MAX, GFP_KERNEL);
 
 		if (p) {

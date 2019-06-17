Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5E2C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4C020657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560807467;
	bh=jqenDNII4IoZDFoDx7mrOY3SY6QUqRovuDdceGkE0zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WKlv8L9T1BHmrB51varTHnj/b99dorqP1k4tvWegoB0TJcwsBtBr3yaeRs/OLzwip
	 7rIeHD56KfxeU3jFB+w3SHkkLkR59Qpk3MwuD97WDzhBQfWZmvO6exaburx6km3N3a
	 NikPrvfvOM9vyb9/JoyrvXhgti0zGv/7WpcfLFCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfFQVhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbfFQVTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:19:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2C42208CB;
        Mon, 17 Jun 2019 21:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806372;
        bh=jqenDNII4IoZDFoDx7mrOY3SY6QUqRovuDdceGkE0zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYpHR+BbBJ/WkQUvHB6WeAL5Wd/yEsTqE4nAewBoYA0/1aCt51j1rUVGVNVWLrRE6
         PGHjJ3j5Kss9zz6PFpq7D/YOaU/ZSlyjlnOUAuNHbIGcY4pwV66I7r90cPdZoY5OD4
         fAoJU1lCi2iGdStnQQW8VtIBI+/1LSz37Rehj0S4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Bollo <jose.bollo@iot.bzh>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.1 029/115] Smack: Restore the smackfsdef mount option and add missing prefixes
Date:   Mon, 17 Jun 2019 23:08:49 +0200
Message-Id: <20190617210801.421402542@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Casey Schaufler <casey@schaufler-ca.com>

commit 6e7739fc938c1ec58d321f70ea41d9548a4cca0f upstream.

The 5.1 mount system rework changed the smackfsdef mount option to
smackfsdefault.  This fixes the regression by making smackfsdef treated
the same way as smackfsdefault.

Also fix the smack_param_specs[] to have "smack" prefixes on all the
names.  This isn't visible to a user unless they either:

 (a) Try to mount a filesystem that's converted to the internal mount API
     and that implements the ->parse_monolithic() context operation - and
     only then if they call security_fs_context_parse_param() rather than
     security_sb_eat_lsm_opts().

     There are no examples of this upstream yet, but nfs will probably want
     to do this for nfs2 or nfs3.

 (b) Use fsconfig() to configure the filesystem - in which case
     security_fs_context_parse_param() will be called.

This issue is that smack_sb_eat_lsm_opts() checks for the "smack" prefix
on the options, but smack_fs_context_parse_param() does not.

Fixes: c3300aaf95fb ("smack: get rid of match_token()")
Fixes: 2febd254adc4 ("smack: Implement filesystem context security hooks")
Cc: stable@vger.kernel.org
Reported-by: Jose Bollo <jose.bollo@iot.bzh>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/smack/smack_lsm.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -67,6 +67,7 @@ static struct {
 	int len;
 	int opt;
 } smk_mount_opts[] = {
+	{"smackfsdef", sizeof("smackfsdef") - 1, Opt_fsdefault},
 	A(fsdefault), A(fsfloor), A(fshat), A(fsroot), A(fstransmute)
 };
 #undef A
@@ -681,11 +682,12 @@ static int smack_fs_context_dup(struct f
 }
 
 static const struct fs_parameter_spec smack_param_specs[] = {
-	fsparam_string("fsdefault",	Opt_fsdefault),
-	fsparam_string("fsfloor",	Opt_fsfloor),
-	fsparam_string("fshat",		Opt_fshat),
-	fsparam_string("fsroot",	Opt_fsroot),
-	fsparam_string("fstransmute",	Opt_fstransmute),
+	fsparam_string("smackfsdef",		Opt_fsdefault),
+	fsparam_string("smackfsdefault",	Opt_fsdefault),
+	fsparam_string("smackfsfloor",		Opt_fsfloor),
+	fsparam_string("smackfshat",		Opt_fshat),
+	fsparam_string("smackfsroot",		Opt_fsroot),
+	fsparam_string("smackfstransmute",	Opt_fstransmute),
 	{}
 };
 



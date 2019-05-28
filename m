Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC61C46470
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C6121670
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfE1Urn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 16:47:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfE1Urm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 16:47:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C8317FDCA;
        Tue, 28 May 2019 20:47:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57DB3600C1;
        Tue, 28 May 2019 20:47:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] Smack: Restore the smackfsdef mount option and add missing
 prefixes
From:   David Howells <dhowells@redhat.com>
To:     casey@schaufler-ca.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, jmorris@namei.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 May 2019 21:47:40 +0100
Message-ID: <155907646050.25083.16573974978890009010.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 28 May 2019 20:47:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Casey Schaufler <casey@schaufler-ca.com>

The 5.1 mount system rework changed the smackfsdef mount option
to smackfsdefault. This fixes the regression by making smackfsdef
treated the same way as smackfsdefault.

Also fix the smack_param_specs[] to have "smack" prefixes on all the names.
This isn't visible to a user unless they either:

 (a) Try to mount a filesystem that's converted to the internal mount API
     and that implements the ->parse_monolithic() context operation - and
     only then if they call security_fs_context_parse_param() rather than
     security_sb_eat_lsm_opts().

     There are no examples of this upstream yet, but nfs will probably want
     to do this for nfs2 or nfs3.

 (b) Use fsconfig() to configure the filesystem - in which case
     security_fs_context_parse_param() will be called.

This issue is that smack_sb_eat_lsm_opts() checks for the "smack" prefix on
the options, but smack_fs_context_parse_param() does not.

Fixes: c3300aaf95fb ("smack: get rid of match_token()")
Fixes: 2febd254adc4 ("smack: Implement filesystem context security hooks")
Cc: stable@vger.kernel.org
Reported-by: Jose Bollo <jose.bollo@iot.bzh>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/smack/smack_lsm.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0de725f88bed..d99450b4f511 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -68,6 +68,7 @@ static struct {
 	int len;
 	int opt;
 } smk_mount_opts[] = {
+	{"smackfsdef", sizeof("smackfsdef") - 1, Opt_fsdefault},
 	A(fsdefault), A(fsfloor), A(fshat), A(fsroot), A(fstransmute)
 };
 #undef A
@@ -682,11 +683,12 @@ static int smack_fs_context_dup(struct fs_context *fc,
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
 


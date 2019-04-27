Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE67C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC4E206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfD0P32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:29:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:32892 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727273AbfD0PPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:18 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2p-000144-Vx; Sat, 27 Apr 2019 16:15:16 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2n-0004cx-5Y; Sat, 27 Apr 2019 16:15:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "James Morris" <james.morris@microsoft.com>,
        "David Howells" <dhowells@redhat.com>,
        "Eric Biggers" <ebiggers@google.com>,
        syzbot+ec24e95ea483de0a24da@syzkaller.appspotmail.com
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.671177784@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 171/202] KEYS: always initialize keyring_index_key::desc_len
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit ede0fa98a900e657d1fcd80b50920efc896c1a4c upstream.

syzbot hit the 'BUG_ON(index_key->desc_len == 0);' in __key_link_begin()
called from construct_alloc_key() during sys_request_key(), because the
length of the key description was never calculated.

The problem is that we rely on ->desc_len being initialized by
search_process_keyrings(), specifically by search_nested_keyrings().
But, if the process isn't subscribed to any keyrings that never happens.

Fix it by always initializing keyring_index_key::desc_len as soon as the
description is set, like we already do in some places.

The following program reproduces the BUG_ON() when it's run as root and
no session keyring has been installed.  If it doesn't work, try removing
pam_keyinit.so from /etc/pam.d/login and rebooting.

    #include <stdlib.h>
    #include <unistd.h>
    #include <keyutils.h>

    int main(void)
    {
            int id = add_key("keyring", "syz", NULL, 0, KEY_SPEC_USER_KEYRING);

            keyctl_setperm(id, KEY_OTH_WRITE);
            setreuid(5000, 5000);
            request_key("user", "desc", "", id);
    }

Reported-by: syzbot+ec24e95ea483de0a24da@syzkaller.appspotmail.com
Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 security/keys/keyring.c          | 4 +---
 security/keys/proc.c             | 3 +--
 security/keys/request_key.c      | 1 +
 security/keys/request_key_auth.c | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -604,9 +604,6 @@ static bool search_nested_keyrings(struc
 	       ctx->index_key.type->name,
 	       ctx->index_key.description);
 
-	if (ctx->index_key.description)
-		ctx->index_key.desc_len = strlen(ctx->index_key.description);
-
 	/* Check to see if this top-level keyring is what we are looking for
 	 * and whether it is valid or not.
 	 */
@@ -870,6 +867,7 @@ key_ref_t keyring_search(key_ref_t keyri
 	struct keyring_search_context ctx = {
 		.index_key.type		= type,
 		.index_key.description	= description,
+		.index_key.desc_len	= strlen(description),
 		.cred			= current_cred(),
 		.match			= type->match,
 		.match_data		= description,
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -191,8 +191,7 @@ static int proc_keys_show(struct seq_fil
 	int rc;
 
 	struct keyring_search_context ctx = {
-		.index_key.type		= key->type,
-		.index_key.description	= key->description,
+		.index_key		= key->index_key,
 		.cred			= m->file->f_cred,
 		.match			= lookup_user_key_possessed,
 		.match_data		= key,
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -561,6 +561,7 @@ struct key *request_key_and_link(struct
 	struct keyring_search_context ctx = {
 		.index_key.type		= type,
 		.index_key.description	= description,
+		.index_key.desc_len	= strlen(description),
 		.cred			= current_cred(),
 		.match			= type->match,
 		.match_data		= description,
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -233,7 +233,7 @@ struct key *key_get_instantiation_authke
 	struct key *authkey;
 	key_ref_t authkey_ref;
 
-	sprintf(description, "%x", target_id);
+	ctx.index_key.desc_len = sprintf(description, "%x", target_id);
 
 	authkey_ref = search_process_keyrings(&ctx);
 


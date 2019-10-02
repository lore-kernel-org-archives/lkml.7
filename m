Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D219DC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65532133F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfJBTK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:10:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35882 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729315AbfJBTIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:08:16 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1iFjyx-00035r-HB; Wed, 02 Oct 2019 20:08:15 +0100
Received: from ben by deadeye with local (Exim 4.92.1)
        (envelope-from <ben@decadent.org.uk>)
        id 1iFjyp-0003fK-I4; Wed, 02 Oct 2019 20:08:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "John Johansen" <john.johansen@canonical.com>,
        "Jann Horn" <jannh@google.com>
Date:   Wed, 02 Oct 2019 20:06:51 +0100
Message-ID: <lsq.1570043211.513144298@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 68/87] apparmor: enforce nullbyte at end of tag string
In-Reply-To: <lsq.1570043210.379046399@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.75-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 8404d7a674c49278607d19726e0acc0cae299357 upstream.

A packed AppArmor policy contains null-terminated tag strings that are read
by unpack_nameX(). However, unpack_nameX() uses string functions on them
without ensuring that they are actually null-terminated, potentially
leading to out-of-bounds accesses.

Make sure that the tag string is null-terminated before passing it to
strcmp().

Fixes: 736ec752d95e ("AppArmor: policy routines for loading and unpacking policy")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 security/apparmor/policy_unpack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -177,7 +177,7 @@ static bool unpack_nameX(struct aa_ext *
 		char *tag = NULL;
 		size_t size = unpack_u16_chunk(e, &tag);
 		/* if a name is specified it must match. otherwise skip tag */
-		if (name && (!size || strcmp(name, tag)))
+		if (name && (!size || tag[size-1] != '\0' || strcmp(name, tag)))
 			goto fail;
 	} else if (name) {
 		/* if a name is specified and there is no name tag fail */


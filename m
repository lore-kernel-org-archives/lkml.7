Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FF4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E991620811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553663936;
	bh=vMaM1cF0JhIv9VYOQ0sWkkbVGKEVNZ+cYUuys5vv7J8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hH5I5ThMszbnQ5GmuxHHgAK7LYg3HDktQlOC9oca+kAcJ8oo1lLXYtk0q+0cL2B8b
	 95z/qcByW/MVSrYc0kQn98KrPMzfP71lJMXQ0HfRbGaAhtRJmjQA7PhRrs3TlV3F3W
	 L+AICTv+LMbT55+4XjTWjKb6ImIu9l3rDaUnZcG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732931AbfC0FSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:18:54 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58289 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbfC0FSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:18:53 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AE288221A6;
        Wed, 27 Mar 2019 01:18:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=LkBxDEwxK//pbnzUp1eCPuq5rRkpN350XpuuORksqBQ=; b=l4jC4z7F
        DpzUVRJKal7eiOgn/4LoHoWYUYE+EfKyrbx7OG0puXmTBoEc6NVwGhk0h68Fwk4m
        94KcUwS7+wCEPhxDHK4L+TCS55inmGcaBz7NSSZLrpDU8JEaVhQr1r0JaMrdj4ql
        e40ceB6uYUbW09DLEkVkeftaLdwQg3N1CDpOFs8IhqivIoDddy6BtfO19Op4PUQE
        F97OmqNLkhots0YhRNqyZvRHedAb+E8nccPjPvydffothqFmwrVFWirEPOCSfyrA
        JFdCKptvDbvCR5XHPNYPKcxGFAnOy335L4uta0oFp3gYTVS/ADmqm916yUqlMkME
        vkyUDig0b5O2EQ==
X-ME-Sender: <xms:vAebXEh1GaN-0sTsdDKWbE5j7m7EYO_YW_CaizoDbDG-jJ6Pgo-0_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudefledrudelvdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepie
X-ME-Proxy: <xmx:vAebXEBgxEJypLXXjdKu0CMH7jcbcmYuDZr-9Mggh4SBriLll_kbZA>
    <xmx:vAebXBGJAIX1RcE2LFRdaouY0pX7ylIk1d91sHY3rHRiPTT7__sDJg>
    <xmx:vAebXEKwKw9jW6rU4lrmWUBXisEpFYAuSy-nW62JO4YkBz5W8qaEPg>
    <xmx:vAebXLArfwAW_1V_rfsoZcKOqqV9kgn8zkUQMi8r4t5LperaAnnWAw>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2249DE4210;
        Wed, 27 Mar 2019 01:18:48 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/24] fs: Fix function docstring for posix_acl_update_mode()
Date:   Wed, 27 Mar 2019 16:17:00 +1100
Message-Id: <20190327051717.23225-8-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327051717.23225-1-tobin@kernel.org>
References: <20190327051717.23225-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx emits a bunch of warnings due to undocumented function parameters
for posix_acl_update_mode().  We should document all the parameters.

Docstring is currently stale in places, it references a non-existent
function, inode_change_ok().  As noted in the documentation file
Documentation/filesystems/Porting this function is now called
setattr_prepare().

Currently docstring includes 'setgit bit', meaning is not totally
clear (to me), setattr_prepare() uses term 'SGID bit', let's use this
too.

Fix function docstring for posix_acl_update_mode():

 - Document function parameters.
 - Reference setattr_prepare() instead of inode_change_ok().
 - Use 'SGID bit' instead of 'setgit bit'.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/posix_acl.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 2fd0fde16fe1..07394510c3d6 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -629,14 +629,18 @@ posix_acl_create(struct inode *dir, umode_t *mode,
 EXPORT_SYMBOL_GPL(posix_acl_create);
 
 /**
- * posix_acl_update_mode  -  update mode in set_acl
+ * posix_acl_update_mode() - Update mode in set_acl.
+ * @inode: The inode we are working on.
+ * @mode_p: New mode to use when updating.
+ * @acl: ACL we are operating on.
  *
- * Update the file mode when setting an ACL: compute the new file permission
- * bits based on the ACL.  In addition, if the ACL is equivalent to the new
- * file mode, set *acl to NULL to indicate that no ACL should be set.
+ * Update the file mode when setting an ACL, compute the new file
+ * permission bits based on the ACL.  In addition, if the ACL is
+ * equivalent to the new file mode, set ``*acl`` to %NULL to indicate
+ * that no ACL should be set.
  *
- * As with chmod, clear the setgit bit if the caller is not in the owning group
- * or capable of CAP_FSETID (see inode_change_ok).
+ * As with chmod, clear the SGID bit if the caller is not in the owning
+ * group or capable of CAP_FSETID (see setattr_prepare()).
  *
  * Called from set_acl inode operations.
  */
-- 
2.21.0


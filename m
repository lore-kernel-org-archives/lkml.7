Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3C5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85DC20811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553663932;
	bh=00obCVu+lf1h98x3XeRpV+l+TQkzpZyxI54dxH/XHzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XE82ZyQUGkC4o3lf3uRSYWBzYPf77m1OPz07FtiMCuDhRqQXDwDQ+0IKEDoCZDN9w
	 6OXaylYXZq3B6Nv6cQz32YKU28u8QvLwxHcOePupbJG0hkmGCFzN0QX/QU5N8/i3sZ
	 UEnw1t3r6P7dlIJK10gnZlFQGPZnRTwRZGVs+Cfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732883AbfC0FSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:18:51 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59071 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbfC0FSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:18:49 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5537622125;
        Wed, 27 Mar 2019 01:18:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Iz22Myouv8iQMYGK0rTnTeswOBYDThi/TC7bfTdyCxs=; b=PnF40OmR
        fRI+VmRi6ki9Vgee37u/fxh8YzD1IbxyYEcFHl8hj0T1zTmerTGBoA8/qVsBgYWO
        hrylaGz207Luw5WcjZJsMlRLN1848/yQ55cMQwb+pqh1tdfb/PhDAA2A0reWlGRu
        ROlYhOW4mNRBTeEvbxIPSUkiq5Wt5LC5BNYc76YaqG2xbuCuqyQNah/2OlpeQilt
        dJFI4XzONWhCZBrU0z2kesN9IBKKdllxAqgJ0g4ssCT0TjnYGQBS3YNuhCJoE6Rg
        MjzT2O+jrZ1Ds2nulymO8+TssqI+OSXaNe3XF8/xYbZyckEKeQlViFkbp+raBBhk
        GRinhcyCM5G+cg==
X-ME-Sender: <xms:uAebXNfstZ_PaOeEwXnH7hARwK5kRdywCWVlYzlcPS4Vc6dguMxmNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudefledrudelvdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgephe
X-ME-Proxy: <xmx:uAebXBOhBhQ9NfFFGzTTfmHevJwWWoDtYoOV_4H0ZigmHDqyRwhgcw>
    <xmx:uAebXEKdVqfqPHrZp8uBL6lYqFJv8pE2Pz7u1K9JXnMII99fIbZk2w>
    <xmx:uAebXCGK3G0X2OOi4J0MEZMrYVmAoAJYfQlzvAs8_hEqbdquXXgmgw>
    <xmx:uAebXHIEOukPqv6E8rdKtzMMB2BQ1VWs_0wv728ANkSPhngaB2RCOg>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id BA09EE40FF;
        Wed, 27 Mar 2019 01:18:44 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/24] fs: Update function docstring for simple_write_end()
Date:   Wed, 27 Mar 2019 16:16:59 +1100
Message-Id: <20190327051717.23225-7-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327051717.23225-1-tobin@kernel.org>
References: <20190327051717.23225-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shinx emits a warning due to an extra function parameter in the current
function docstring for simple_write_end().  While we are fixing this
warning we might as well clean up the whole function docstring for this
function.

The current member descriptions are readable in text and also ok in
HTML.  When vfs.txt is converted to use RST format these member
descriptions could be improved with a reference to struct
address_space_operations docs in that file.

Update and cleanup docstring for simple_write_end()

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/libfs.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 0fb590d79f30..36af25b9b2a3 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -448,9 +448,8 @@ int simple_write_begin(struct file *file, struct address_space *mapping,
 EXPORT_SYMBOL(simple_write_begin);
 
 /**
- * simple_write_end - .write_end helper for non-block-device FSes
- * @available: See .write_end of address_space_operations
- * @file: 		"
+ * simple_write_end() - .write_end helper for non-block-device FSes
+ * @file: See .write_end of &struct address_space_operations
  * @mapping: 		"
  * @pos: 		"
  * @len: 		"
@@ -458,17 +457,21 @@ EXPORT_SYMBOL(simple_write_begin);
  * @page: 		"
  * @fsdata: 		"
  *
- * simple_write_end does the minimum needed for updating a page after writing is
- * done. It has the same API signature as the .write_end of
- * address_space_operations vector. So it can just be set onto .write_end for
- * FSes that don't need any other processing. i_mutex is assumed to be held.
- * Block based filesystems should use generic_write_end().
- * NOTE: Even though i_size might get updated by this function, mark_inode_dirty
- * is not called, so a filesystem that actually does store data in .write_inode
- * should extend on what's done here with a call to mark_inode_dirty() in the
- * case that i_size has changed.
+ * Does the minimum needed for updating a page after writing is done.
+ * It has the same API signature as the .write_end member of &struct
+ * address_space_operations vector.  So it can just be set onto
+ * .write_end for FSes that don't need any other processing.  Block
+ * based filesystems should use generic_write_end().
+ *
+ * NOTE: Even though i_size might get updated by this function,
+ * mark_inode_dirty() is not called, so a filesystem that actually does
+ * store data in .write_inode should extend on what's done here with a
+ * call to mark_inode_dirty() in the case that i_size has changed.
  *
  * Use *ONLY* with simple_readpage()
+ *
+ * Context: Caller must hold i_mutex
+ * Return: @copied argument unmodified.
  */
 int simple_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
-- 
2.21.0


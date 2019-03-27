Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F88CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0DD20811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553663927;
	bh=i01FY9ejvuzDdNjuKXf+u5oXhMi3pjbUfQbWi6fQEfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rdRqvJ6K33joJV5jadel69BOp/FPCVD2j7uG2savFu2EXQOVxkzHkZAIKhlijLA6M
	 PZUSF7WLCPY3X5Mu5Ycdk/34pnnI3C3sHs+wQQE9IIe0lSMo66EzaziQUvB1eJKh3E
	 ZwjjA9KvbiS7YCSos3KLXrrGR6eo54NpuUxrmRjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbfC0FSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:18:46 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50913 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbfC0FSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:18:45 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E6135220A4;
        Wed, 27 Mar 2019 01:18:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=MkHDjnuhQa7s6Nb5SWdLKYFJ84x4dIRVbvit8loBXBQ=; b=08M1pU/1
        4POsaDnoDOopBtt408XVAK8R0nfhzbOqHfhuvHOvRXH+VWZy79GuVtSR+41yQVi9
        bLrGLFS95qZ35OL3q0x8kaXEJ5KxG1IYtNZiEqDshmmbR0eoXa3YV9bnZhKCrPfB
        nS3d3z+WZ+Ew7qa9iqIuIxTg7knq0cVKA+vTLhvnsWYkc3EV0IrKUNPYRov8yq64
        LpjoKVqKNHLOtNaSxcvlgM6uq09NOZo86BFEQmLofp4OvfPNdyyHvyF6rE+6KETV
        NYgHxpMtFJ/3q5Z7WSkkbOQSvsor/dceUSUdm42I4QO1GM5wjtpKiegh6eGCY42m
        a45p/XYaBRp/XQ==
X-ME-Sender: <xms:swebXE38PRvKEnhj6LoXB9h0TifKspBA17WRkLi9mQIXAXVzd3jwAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudefledrudelvdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepfe
X-ME-Proxy: <xmx:swebXOKVdjW75WbHRiHvaqYOQNAXj4T3_3aA9dSLCWFuJPs2dIJ9tw>
    <xmx:swebXDGbCwouEJnz_US7BvPf50yI29gCcX8OtshtMhkkae5Kr-IfAQ>
    <xmx:swebXKU3dLiZOaEIC7CFn4qFvEjFa9ayJm4zkhvwK7V9yaolrdlj8g>
    <xmx:swebXEXEGD8oAT9I64PEogbcTnRsHX73gu_Ru3cLjgLgoCn-WGMm8g>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id 82D07E40FF;
        Wed, 27 Mar 2019 01:18:40 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/24] fs: Guard unusual text with backticks
Date:   Wed, 27 Mar 2019 16:16:58 +1100
Message-Id: <20190327051717.23225-6-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327051717.23225-1-tobin@kernel.org>
References: <20190327051717.23225-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have unusual text which in context is clear

	@flags: O_... flags with which the new file will be opened

Currently this docstring is _not_ included in any documentation file but
if it is in future this will cause Sphinx to emit a warning (as
discovered while documenting alloc_file_pseudo()).  Let's fix it now to
save our future selves the hassle.

Guard unusual text with backticks.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/file_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index e3c6966c2d53..89875f1a1195 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -180,7 +180,7 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
 /**
  * alloc_file() - Allocate and initialize a &struct file.
  * @path: the (dentry, vfsmount) pair for the new file
- * @flags: O_... flags with which the new file will be opened
+ * @flags: ``O_...`` flags with which the new file will be opened
  * @fop: the 'struct file_operations' for the new file
  */
 static struct file *alloc_file(const struct path *path, int flags,
-- 
2.21.0


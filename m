Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6120FC48BE7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311F820679
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561224741;
	bh=B9ECSyjqEV3fCGpekeGcVNstXskCYsMQ+ki9bvF3lUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mrV906QSD2pOlAAR9Xn7IHyAv/gL3pLFa201octSA6aKb5R3whkoHfrDd4pM2h5tG
	 PZIUvL10zvGjlPIr85t9ALvM/P3b5QbpBDyyqTUcc7H1ayCD6WyvxnAcaLsmrAb+pO
	 QBWX2WDbWC8goumavQolKvMZD31qU6VkEg8VQXqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfFVRcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 13:32:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45136 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfFVRcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 13:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Zb/SASuRPcGdt/bTBUbecQLsS4IPsWmL3XCBWFftiQ0=; b=Mm3JfBuikBs/yWj+iqqVmPLcc9
        AMdbFdn3zaEGTe6f7Q4hfaF3Zqb5RzczrHmM+EP/AiY4TsS0MQwsegAoT+uKIxRa5omj+wu5/ygkR
        u99lqJDZtVAqnWmwbhnbb8ddz4aoh5v5N5HvL7qt+t+URRX1ahJ4Fi6OuwjBu+SUpIIwu6dXXKajd
        nujVZdJnqXaqjaHGo3x/grCcKKtfSkG0J/R2DFEf+ty0jKt/qnrVFyc3rMEjVV0E60wyEkV6L/923
        mWtgYfa4FX8d2N6IcsSthrE0bkO6UD/ndjz38JeqBzGkCF4cihQ8/jXptZyle8Y2c86Dx0i1b9FZf
        2zZK3L+g==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejrs-00076i-CA; Sat, 22 Jun 2019 17:32:00 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejrq-0001HN-8M; Sat, 22 Jun 2019 14:31:58 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [RFC v2 4/8] docs: ABI: make it parse ABI/stable as ReST-compatible files
Date:   Sat, 22 Jun 2019 14:31:52 -0300
Message-Id: <1dab0a50592d4f0a91028438e58f7df9533cb305.1561224093.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561224093.git.mchehab+samsung@kernel.org>
References: <cover.1561224093.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the stable ABI files are compatible with ReST,
parse them without converting complex descriptions as literal
blocks nor escaping special characters.

Please notice that escaping special characters will probably
be needed at descriptions, at least for the asterisk character.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/abi-stable.rst | 1 +
 Documentation/sphinx/kernel_abi.py       | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/abi-stable.rst b/Documentation/admin-guide/abi-stable.rst
index 7495d7a35048..70490736e0d3 100644
--- a/Documentation/admin-guide/abi-stable.rst
+++ b/Documentation/admin-guide/abi-stable.rst
@@ -11,3 +11,4 @@ Most interfaces (like syscalls) are expected to never change and always
 be available.
 
 .. kernel-abi:: $srctree/Documentation/ABI/stable
+   :rst:
diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index a417026ed690..a00eccfbafea 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -72,12 +72,13 @@ class KernelCmd(Directive):
     u"""KernelABI (``kernel-abi``) directive"""
 
     required_arguments = 1
-    optional_arguments = 0
+    optional_arguments = 2
     has_content = False
     final_argument_whitespace = True
 
     option_spec = {
-        "debug"     : directives.flag
+        "debug"     : directives.flag,
+        "rst"       : directives.unchanged
     }
 
     def run(self):
@@ -91,6 +92,9 @@ class KernelCmd(Directive):
         cmd = "get_abi.pl rest --enable-lineno --dir "
         cmd += self.arguments[0]
 
+        if 'rst' in self.options:
+            cmd += " --rst-source"
+
         srctree = path.abspath(os.environ["srctree"])
 
         fname = cmd
-- 
2.21.0


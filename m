Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3555BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01012173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414035;
	bh=GJ6XayUpeMpEkHSnxWVk9oBsJs7zIftirT4wQlnNT04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GiUoTu0i/tZwTK4YoykQ/uTjrocuTTCbmera7kc1AwmAjR0SQbAG1gr2v7Bon49de
	 a5N/il1RaK8PF7vVv8WyhE1QtN5qek6KRwpsvlNg9fwoBdgVyNGcojWZKkgjBkRiDp
	 GVou3LxC3dMjvI5GuysStPSxZ7PdC8bam239Ibuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfCLSHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727425AbfCLRMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:23 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC5C52171F;
        Tue, 12 Mar 2019 17:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410743;
        bh=GJ6XayUpeMpEkHSnxWVk9oBsJs7zIftirT4wQlnNT04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kr0UGpSHw7s8hfWQPBaj7sRWbnt0kUXBLNTIIHVtfAh1IO3uwvZ8cLtSBBECUhBfu
         Yf7fyQDl71XsaOXOT98p6obuqy9W41sljqL6bQaUAuwx5dt4ln4HSpNcE0AGRh9ySu
         LrmWpmjI3NdfA7hmvO7HLMlcUYgseNEmgAQUuyH8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Ian Kent <raven@themaw.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 068/171] autofs: drop dentry reference only when it is never used
Date:   Tue, 12 Mar 2019 10:07:28 -0700
Message-Id: <20190312170354.026391964@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 63ce5f552beb9bdb41546b3a26c4374758b21815 ]

autofs_expire_run() calls dput(dentry) to drop the reference count of
dentry.  However, dentry is read via autofs_dentry_ino(dentry) after
that.  This may result in a use-free-bug.  The patch drops the reference
count of dentry only when it is never used.

Link: http://lkml.kernel.org/r/154725122396.11260.16053424107144453867.stgit@pluto-themaw-net
Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/autofs/expire.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index d441244b79df..28d9c2b1b3bb 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -596,7 +596,6 @@ int autofs_expire_run(struct super_block *sb,
 	pkt.len = dentry->d_name.len;
 	memcpy(pkt.name, dentry->d_name.name, pkt.len);
 	pkt.name[pkt.len] = '\0';
-	dput(dentry);
 
 	if (copy_to_user(pkt_p, &pkt, sizeof(struct autofs_packet_expire)))
 		ret = -EFAULT;
@@ -609,6 +608,8 @@ int autofs_expire_run(struct super_block *sb,
 	complete_all(&ino->expire_complete);
 	spin_unlock(&sbi->fs_lock);
 
+	dput(dentry);
+
 	return ret;
 }
 
-- 
2.19.1




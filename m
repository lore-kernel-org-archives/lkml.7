Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853ECC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 05:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8FC260D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 05:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559192452;
	bh=c6uPQz3VJz5ElZSEEv1iizI9Mnw05qTF0Ocdffmw2Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zBZgN6TVzolekyG2ueYlG9y1SeEpqRN1ws8RF2ruiN7D9Zi5nFzZKPAOVYZ02IyRO
	 zu8erI3oNZBRrqxFJPL2nMczhnCLs9XHKP74bo+o+Xxl9WT52tDUxdJNu1nm4AY7n/
	 OFGzP2FR+LY4LtWvGxJDeULp0anWV6mmbkE25KgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfE3FAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 01:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbfE3DJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:09:29 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3487124484;
        Thu, 30 May 2019 03:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185769;
        bh=c6uPQz3VJz5ElZSEEv1iizI9Mnw05qTF0Ocdffmw2Qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1csmcwTv03ufX91Lyxy2EpaL/T14f5CSmhm+xpj0tE0OGQIzb3/5/dIcJUzzYANRj
         u8AdiHA3ZvAm4cTCfaPcU+cZWhZxo7txk87ViStUBpxqvyeFCGSQgLwaEttcg3v6Zv
         7y/GbwVpsLQX8w1Tw7sTtvMsNPOndwvoXnxN7L08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 5.1 002/405] ext4: do not delete unlinked inode from orphan list on failed truncate
Date:   Wed, 29 May 2019 20:00:00 -0700
Message-Id: <20190530030540.446674006@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit ee0ed02ca93ef1ecf8963ad96638795d55af2c14 upstream.

It is possible that unlinked inode enters ext4_setattr() (e.g. if
somebody calls ftruncate(2) on unlinked but still open file). In such
case we should not delete the inode from the orphan list if truncate
fails. Note that this is mostly a theoretical concern as filesystem is
corrupted if we reach this path anyway but let's be consistent in our
orphan handling.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5619,7 +5619,7 @@ int ext4_setattr(struct dentry *dentry,
 			up_write(&EXT4_I(inode)->i_data_sem);
 			ext4_journal_stop(handle);
 			if (error) {
-				if (orphan)
+				if (orphan && inode->i_nlink)
 					ext4_orphan_del(NULL, inode);
 				goto err_out;
 			}



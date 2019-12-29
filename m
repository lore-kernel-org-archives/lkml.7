Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E98C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4953621744
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642404;
	bh=kInf8AiDuC57fCDS/s235eRuwT5V2lXhyqwTypBgl4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LLrBMJaW8r17FZ9cfPlnYDRxIwEnkO51xQS7HTyBHVlZXkCVO3Yy6herinIuKIDNU
	 sygxsrCiX334SBsC7UUHmQPQGYIk4YeQRGslosulsXLCeM0mLaIGrl0JB3uNtPmorm
	 HAWG5bE2/QBSCZXeqMuQOuVJM1mmiUXmlBMJ7bwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbfL2R54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:57:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387412AbfL2R5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:57:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CC06206DB;
        Sun, 29 Dec 2019 17:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642270;
        bh=kInf8AiDuC57fCDS/s235eRuwT5V2lXhyqwTypBgl4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UcJ+0od+kN77uCK1Z0NqBggIv3TOJFlJvTx1tt148rUlQ+yvKcx4Irl1GeM37asnv
         cIGM3odQ871KoRhUPKUPJhHQUqmL6VOmlhP/ybcxxpWrDTs3/9eSHIBNSEC4TTyVzR
         9+bmYzB68t7RSc9th+2BDpH5B4hzaWBXXkOtvHd8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.4 411/434] ext4: check for directory entries too close to block end
Date:   Sun, 29 Dec 2019 18:27:44 +0100
Message-Id: <20191229172730.048079366@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit 109ba779d6cca2d519c5dd624a3276d03e21948e upstream.

ext4_check_dir_entry() currently does not catch a case when a directory
entry ends so close to the block end that the header of the next
directory entry would not fit in the remaining space. This can lead to
directory iteration code trying to access address beyond end of current
buffer head leading to oops.

CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20191202170213.4761-3-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/dir.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -81,6 +81,11 @@ int __ext4_check_dir_entry(const char *f
 		error_msg = "rec_len is too small for name_len";
 	else if (unlikely(((char *) de - buf) + rlen > size))
 		error_msg = "directory entry overrun";
+	else if (unlikely(((char *) de - buf) + rlen >
+			  size - EXT4_DIR_REC_LEN(1) &&
+			  ((char *) de - buf) + rlen != size)) {
+		error_msg = "directory entry too close to block end";
+	}
 	else if (unlikely(le32_to_cpu(de->inode) >
 			le32_to_cpu(EXT4_SB(dir->i_sb)->s_es->s_inodes_count)))
 		error_msg = "inode out of bounds";



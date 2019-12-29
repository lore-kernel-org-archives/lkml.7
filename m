Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CB0C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC9720748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577643211;
	bh=lZfQ73VqQQtjsTM7v6sL6jXQFcPPf+p/jvKrLBnmzhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xw3xuoa15BTLjY+ggEHL18CmmKP6quZRKPtEDyJ4m5EXAQJtHH69wyL/cfI8OBXAi
	 MaLZSvEqfYEX6lMBUwVnjcaZ8DBGtavDAcWVNGtBYCHhlOn6CEL8pbEbiTHYJAvI9Y
	 yE4l3DQot1ceKPvRs2KpwDJUZPf1BuYik92TjNUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbfL2SNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 13:13:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:51504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728224AbfL2R2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:28:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42FC320409;
        Sun, 29 Dec 2019 17:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640495;
        bh=lZfQ73VqQQtjsTM7v6sL6jXQFcPPf+p/jvKrLBnmzhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mtEyVHnL6J6RHqpjIwDsZGmZHDY7npoVi8FdfLa+HSalI0AMHiEn5YMwnib3eurBh
         k+DkfXOr+N1GmDgZfKBii/BCDMArJWsmo1uxUXL3WZFT3+xzDQxCkoyzP1aGZVhZNA
         D7UnHmDO59nuAP/ROmQ0iNUZXdmA9K59P4uQKpDo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 020/219] btrfs: do not leak reloc root if we fail to read the fs root
Date:   Sun, 29 Dec 2019 18:17:02 +0100
Message-Id: <20191229162512.034950201@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit ca1aa2818a53875cfdd175fb5e9a2984e997cce9 upstream.

If we fail to read the fs root corresponding with a reloc root we'll
just break out and free the reloc roots.  But we remove our current
reloc_root from this list higher up, which means we'll leak this
reloc_root.  Fix this by adding ourselves back to the reloc_roots list
so we are properly cleaned up.

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/relocation.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4474,6 +4474,7 @@ int btrfs_recover_relocation(struct btrf
 		fs_root = read_fs_root(fs_info, reloc_root->root_key.offset);
 		if (IS_ERR(fs_root)) {
 			err = PTR_ERR(fs_root);
+			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			goto out_free;
 		}
 



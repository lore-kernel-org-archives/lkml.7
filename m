Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C182C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E45E208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139780;
	bh=gfryAOKXKIdjJ9GJP8hqZmpvoTTZXizvBcA4A7Vn42w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l8oBW7qqWNiIvQFJ8tiv5qhpkkEUpiPLywu3vvOEv+997kao32I0kVZP1sTC5Iqpp
	 Fx/GNfFmNo2121pfA/r0B+ZgnOg47VucxK1gnDwpM4EwOGB5mzt1N6nllXYwjNR9VF
	 akfJLUaotRXDYiOuTovGima5gdeK0El3P4xnp654=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbfDAR3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:29:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732415AbfDAR3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:29:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E1FC20856;
        Mon,  1 Apr 2019 17:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139775;
        bh=gfryAOKXKIdjJ9GJP8hqZmpvoTTZXizvBcA4A7Vn42w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AxRFxv8Nk2IbAUhQee8ny5YjhmEALbNkZh5yDMmSu0HtQ+/qWPN8tRgTTuLziu4Rt
         pIdbn18U6u/PX8BQShPMlGlPEQOAgOHNgip4xOz4XqX22kEB1itOrb7WPMqbxh3gvE
         QOFv3RK8WPL9yBMd16v+3vgeT0dsax057vMslMCo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, jean-luc malet <jeanluc.malet@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4.4 003/131] udf: Fix crash on IO error during truncate
Date:   Mon,  1 Apr 2019 19:01:13 +0200
Message-Id: <20190401170051.966433764@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit d3ca4651d05c0ff7259d087d8c949bcf3e14fb46 upstream.

When truncate(2) hits IO error when reading indirect extent block the
code just bugs with:

kernel BUG at linux-4.15.0/fs/udf/truncate.c:249!
...

Fix the problem by bailing out cleanly in case of IO error.

CC: stable@vger.kernel.org
Reported-by: jean-luc malet <jeanluc.malet@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/udf/truncate.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -260,6 +260,9 @@ void udf_truncate_extents(struct inode *
 			epos.block = eloc;
 			epos.bh = udf_tread(sb,
 					udf_get_lb_pblock(sb, &eloc, 0));
+			/* Error reading indirect block? */
+			if (!epos.bh)
+				return;
 			if (elen)
 				indirect_ext_len =
 					(elen + sb->s_blocksize - 1) >>



Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3235BC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A31D2467F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780654;
	bh=BH8qikRBDt42ngMKoPw5Pib1vwe/elbNsYhbcf3y2MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l+86XltDwK3Mgjr75Scf/dYZAqQ92BmZ3n8R0vIzFli9GbFQ6Zr06q0MTTXFvwHNw
	 A94AoE2BvkefsmCJIRslwGf5Hdo8Zdv92znfWZREzDpOSmNS1TMNVLdy2hFRDIDCxM
	 QPpC7O3bCQmhPQj9zR1qn2xOUfkDm3HcreijqSSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfLSShd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:37:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbfLSSh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:37:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0765D24679;
        Thu, 19 Dec 2019 18:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780649;
        bh=BH8qikRBDt42ngMKoPw5Pib1vwe/elbNsYhbcf3y2MA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cFhzklpTP+HnOT2JnJkwGIwP3uxwvHj6HNNTTnRuVcqRQmZn71/ZNGDJQoysHYbQ4
         tgJOj9LU6lXhQJK+wDHxOcdbzXmEBmNs4Du+0dHVAbhbeIp31tdETeZ2nvJ+T5Rr8h
         aQhl0HU3VTfKqznCtctJ2OwQ7vKzxU2dFzXz/SKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.4 059/162] CIFS: Fix SMB2 oplock break processing
Date:   Thu, 19 Dec 2019 19:32:47 +0100
Message-Id: <20191219183211.467075228@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Shilovsky <pshilov@microsoft.com>

commit fa9c2362497fbd64788063288dc4e74daf977ebb upstream.

Even when mounting modern protocol version the server may be
configured without supporting SMB2.1 leases and the client
uses SMB2 oplock to optimize IO performance through local caching.

However there is a problem in oplock break handling that leads
to missing a break notification on the client who has a file
opened. It latter causes big latencies to other clients that
are trying to open the same file.

The problem reproduces when there are multiple shares from the
same server mounted on the client. The processing code tries to
match persistent and volatile file ids from the break notification
with an open file but it skips all share besides the first one.
Fix this by looking up in all shares belonging to the server that
issued the oplock break.

Cc: Stable <stable@vger.kernel.org>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2misc.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -582,10 +582,10 @@ smb2_is_valid_oplock_break(char *buffer,
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each(tmp, &server->smb_ses_list) {
 		ses = list_entry(tmp, struct cifs_ses, smb_ses_list);
+
 		list_for_each(tmp1, &ses->tcon_list) {
 			tcon = list_entry(tmp1, struct cifs_tcon, tcon_list);
 
-			cifs_stats_inc(&tcon->stats.cifs_stats.num_oplock_brks);
 			spin_lock(&tcon->open_file_lock);
 			list_for_each(tmp2, &tcon->openFileList) {
 				cfile = list_entry(tmp2, struct cifsFileInfo,
@@ -597,6 +597,8 @@ smb2_is_valid_oplock_break(char *buffer,
 					continue;
 
 				cifs_dbg(FYI, "file id match, oplock break\n");
+				cifs_stats_inc(
+				    &tcon->stats.cifs_stats.num_oplock_brks);
 				cinode = CIFS_I(d_inode(cfile->dentry));
 				spin_lock(&cfile->file_info_lock);
 				if (!CIFS_CACHE_WRITE(cinode) &&
@@ -628,9 +630,6 @@ smb2_is_valid_oplock_break(char *buffer,
 				return true;
 			}
 			spin_unlock(&tcon->open_file_lock);
-			spin_unlock(&cifs_tcp_ses_lock);
-			cifs_dbg(FYI, "No matching file for oplock break\n");
-			return true;
 		}
 	}
 	spin_unlock(&cifs_tcp_ses_lock);



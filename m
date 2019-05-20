Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB8DC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08159216C4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355779;
	bh=ekJd2Q1d/UpW8siTLHEETVBkSt/8+dxoZ1rgaPCogCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vrvCyMAdecuhcJ3M6kHFaPEBPx/p2uLSYkarqyqV5jNkD9J1FGW6457AJ35nFwkyT
	 hBy97w7IkeQX//EhM7hVcaug9MmCLAIHrUwv5PZGOy6B7qg/VPo1/SoHebzbAwdkz6
	 Z3t0EPlj5ry0eEkV3G0+gpHdqAvwF8xLDssUPdAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391252AbfETMgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391236AbfETMgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:36:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E84C21726;
        Mon, 20 May 2019 12:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355773;
        bh=ekJd2Q1d/UpW8siTLHEETVBkSt/8+dxoZ1rgaPCogCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BfZctMvXt6Lnb80j18TMRodFL7kohfqL//FvL8eReFO8x2vIK6uhykQsvdI4ecIB4
         66M3G0NTlikoW4lSMz6HclKgj+t+MxAza02ff3n3NBeSjHdh5sAaXEZ76czzPYMJRd
         03UkWF/1zCsAmXPFdlkxnGznwQT3ZUJqOSAyq75w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 5.1 119/128] smb3: display session id in debug data
Date:   Mon, 20 May 2019 14:15:06 +0200
Message-Id: <20190520115256.755226302@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115249.449077487@linuxfoundation.org>
References: <20190520115249.449077487@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

commit b63a9de02d64ecd5ff0749e90253f5b30ba5b9c0 upstream.

Displaying the session id in /proc/fs/cifs/DebugData
is needed in order to correlate Linux client information
with network and server traces for many common support
scenarios.  Turned out to be very important for debugging.

Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifs_debug.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -376,6 +376,8 @@ skip_rdma:
 				atomic_read(&server->in_send),
 				atomic_read(&server->num_waiters));
 #endif
+			/* dump session id helpful for use with network trace */
+			seq_printf(m, " SessionId: 0x%llx", ses->Suid);
 			if (ses->session_flags & SMB2_SESSION_FLAG_ENCRYPT_DATA)
 				seq_puts(m, " encrypted");
 			if (ses->sign)



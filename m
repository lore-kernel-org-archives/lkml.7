Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDA1C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88056229F9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149296;
	bh=/EHkBTPJ0LG/YwBarAjxnw94cxUW332nLrdZvvLt+1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cwqm+vGx/ufE9wSyt6958ynTBbGLTTrQhf3ZoHb8FDberTSq2ImkXMORru+F74j2U
	 1TQbztrPb7Xtqni0kHMB8QknL8t94KQbRDK2m1M2UI5J8Mfz+21NNoxUmu+x1TigtX
	 jtcepMg91Q55YiyZajNyX/WSjE1ib1dvJurN1kuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfGZNyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388005AbfGZNml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:42:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F378222CBB;
        Fri, 26 Jul 2019 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148560;
        bh=/EHkBTPJ0LG/YwBarAjxnw94cxUW332nLrdZvvLt+1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r0hbRxaxUU6DnCZSIbBGChCUcFcMJwDFRrmyqXNBb7N+ADY3e5j5vL8DUqz8dtUQ/
         lL4raZOU6PbYoWHW2tsHlxW+JxvhhPp9mbt2Ytrmw8/Ao8yjvlNJo3WeSkmKSuIWDu
         bDqiCehN2CUfqgZ1L3YzPYrZFoJIVQwRTs/Z3n9I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 17/47] cifs: Fix a race condition with cifs_echo_request
Date:   Fri, 26 Jul 2019 09:41:40 -0400
Message-Id: <20190726134210.12156-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134210.12156-1-sashal@kernel.org>
References: <20190726134210.12156-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronnie Sahlberg <lsahlber@redhat.com>

[ Upstream commit f2caf901c1b7ce65f9e6aef4217e3241039db768 ]

There is a race condition with how we send (or supress and don't send)
smb echos that will cause the client to incorrectly think the
server is unresponsive and thus needs to be reconnected.

Summary of the race condition:
 1) Daisy chaining scheduling creates a gap.
 2) If traffic comes unfortunate shortly after
    the last echo, the planned echo is suppressed.
 3) Due to the gap, the next echo transmission is delayed
    until after the timeout, which is set hard to twice
    the echo interval.

This is fixed by changing the timeouts from 2 to three times the echo interval.

Detailed description of the bug: https://lutz.donnerhacke.de/eng/Blog/Groundhog-Day-with-SMB-remount

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index f31339db45fd..c53a2e86ed54 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -563,10 +563,10 @@ static bool
 server_unresponsive(struct TCP_Server_Info *server)
 {
 	/*
-	 * We need to wait 2 echo intervals to make sure we handle such
+	 * We need to wait 3 echo intervals to make sure we handle such
 	 * situations right:
 	 * 1s  client sends a normal SMB request
-	 * 2s  client gets a response
+	 * 3s  client gets a response
 	 * 30s echo workqueue job pops, and decides we got a response recently
 	 *     and don't need to send another
 	 * ...
@@ -575,9 +575,9 @@ server_unresponsive(struct TCP_Server_Info *server)
 	 */
 	if ((server->tcpStatus == CifsGood ||
 	    server->tcpStatus == CifsNeedNegotiate) &&
-	    time_after(jiffies, server->lstrp + 2 * server->echo_interval)) {
+	    time_after(jiffies, server->lstrp + 3 * server->echo_interval)) {
 		cifs_dbg(VFS, "Server %s has not responded in %lu seconds. Reconnecting...\n",
-			 server->hostname, (2 * server->echo_interval) / HZ);
+			 server->hostname, (3 * server->echo_interval) / HZ);
 		cifs_reconnect(server);
 		wake_up(&server->response_q);
 		return true;
-- 
2.20.1


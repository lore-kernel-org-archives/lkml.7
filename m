Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29683C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC6C20835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625928;
	bh=yNF5fBcZBeHofcbFX4RGA8qq7oiAsCqYqoSBSysuYh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PU7lGlI6WLNs/MtEcRMLLggB++dseSXxDfdzJqlnAE/9If2Mgxq1a5kXVU//GNoeH
	 133i1UnBspfDFjWuEwNrC+4SPnu1FvsGGLEIhTJELKalUujQFXAnWBMIHE3CqVVAOh
	 2ja0m+sWGrKQhOsw3Zrl+louMQNUXV9if5KJVgkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfD3MF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:05:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729187AbfD3LmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:42:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E68D421743;
        Tue, 30 Apr 2019 11:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624528;
        bh=yNF5fBcZBeHofcbFX4RGA8qq7oiAsCqYqoSBSysuYh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYC+f2YtB/dvMjO3W9lsg2u2qWzCLH3ymlPcIHEH8c2L6hhrGr//FFXxcr/H4jPAx
         Zp48pQ+Gnrk95JHG6nioHL4XdjktRy9BzCRgVI1r/le525rmdS7Fk2w48HqVJ7mDJV
         3kN55pS0KDzTx0yXXQuEEhk93c2PvfrjpYbOKGvw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+3ce8520484b0d4e260a5@syzkaller.appspotmail.com,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 27/53] tipc: handle the err returned from cmd header function
Date:   Tue, 30 Apr 2019 13:38:34 +0200
Message-Id: <20190430113556.049274931@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113549.400132183@linuxfoundation.org>
References: <20190430113549.400132183@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

commit 2ac695d1d602ce00b12170242f58c3d3a8e36d04 upstream.

Syzbot found a crash:

  BUG: KMSAN: uninit-value in tipc_nl_compat_name_table_dump+0x54f/0xcd0 net/tipc/netlink_compat.c:872
  Call Trace:
    tipc_nl_compat_name_table_dump+0x54f/0xcd0 net/tipc/netlink_compat.c:872
    __tipc_nl_compat_dumpit+0x59e/0xda0 net/tipc/netlink_compat.c:215
    tipc_nl_compat_dumpit+0x63a/0x820 net/tipc/netlink_compat.c:280
    tipc_nl_compat_handle net/tipc/netlink_compat.c:1226 [inline]
    tipc_nl_compat_recv+0x1b5f/0x2750 net/tipc/netlink_compat.c:1265
    genl_family_rcv_msg net/netlink/genetlink.c:601 [inline]
    genl_rcv_msg+0x185f/0x1a60 net/netlink/genetlink.c:626
    netlink_rcv_skb+0x431/0x620 net/netlink/af_netlink.c:2477
    genl_rcv+0x63/0x80 net/netlink/genetlink.c:637
    netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
    netlink_unicast+0xf3e/0x1020 net/netlink/af_netlink.c:1336
    netlink_sendmsg+0x127f/0x1300 net/netlink/af_netlink.c:1917
    sock_sendmsg_nosec net/socket.c:622 [inline]
    sock_sendmsg net/socket.c:632 [inline]

  Uninit was created at:
    __alloc_skb+0x309/0xa20 net/core/skbuff.c:208
    alloc_skb include/linux/skbuff.h:1012 [inline]
    netlink_alloc_large_skb net/netlink/af_netlink.c:1182 [inline]
    netlink_sendmsg+0xb82/0x1300 net/netlink/af_netlink.c:1892
    sock_sendmsg_nosec net/socket.c:622 [inline]
    sock_sendmsg net/socket.c:632 [inline]

It was supposed to be fixed on commit 974cb0e3e7c9 ("tipc: fix uninit-value
in tipc_nl_compat_name_table_dump") by checking TLV_GET_DATA_LEN(msg->req)
in cmd->header()/tipc_nl_compat_name_table_dump_header(), which is called
ahead of tipc_nl_compat_name_table_dump().

However, tipc_nl_compat_dumpit() doesn't handle the error returned from cmd
header function. It means even when the check added in that fix fails, it
won't stop calling tipc_nl_compat_name_table_dump(), and the issue will be
triggered again.

So this patch is to add the process for the err returned from cmd header
function in tipc_nl_compat_dumpit().

Reported-by: syzbot+3ce8520484b0d4e260a5@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/tipc/netlink_compat.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -262,8 +262,14 @@ static int tipc_nl_compat_dumpit(struct
 	if (msg->rep_type)
 		tipc_tlv_init(msg->rep, msg->rep_type);
 
-	if (cmd->header)
-		(*cmd->header)(msg);
+	if (cmd->header) {
+		err = (*cmd->header)(msg);
+		if (err) {
+			kfree_skb(msg->rep);
+			msg->rep = NULL;
+			return err;
+		}
+	}
 
 	arg = nlmsg_new(0, GFP_KERNEL);
 	if (!arg) {



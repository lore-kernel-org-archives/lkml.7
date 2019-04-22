Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA72C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C2620881
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555939887;
	bh=SffF734I/Q3vHgoUOQS2OGepZyMDzBbDsWyUu9SYurQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XTlwVEvz2YZP6/CV16PAKuH8YuQiZj7yzixbqR9W2HNiytAp273CPIm50knABF0lJ
	 tyxDQLwhJ8q+vDuIIWXalyjI4wGrCu2XepG/a40gqrTMSaKoKzWAcgg4CiRl1km8xJ
	 nGBBzupkzwHb25Lcle/hyiQJaVUDv+Q/7Uaa+GEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfDVNbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:31:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37912 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfDVN2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4774MrSqWzL5rj9lXOE+oHgFu/4h7OgE51S7mqczGXY=; b=thuHH4uixemVufoaySc2KJkYBy
        dFELi1K0m67tsIKiuH/JXAcRl5xjA4horR+NCp82zySIUDw1nCfdSejrdHAZwyjlryAn4mVAOy8D8
        ahXkqPkp7y9CRByqqvwVL6TRCnrtKWj6uIibRs3hfvtOewZkNJpfzx9Es+Mf5rk/0UMycEmwjM42c
        D5y/zoJJM8dYFPPlQtkSY1szste7/hEgX7TuyX9H+oOtAXfWHOD3Phup7jUgecP+JDvVZJLgq/xd3
        S9dJ9B1ZdxilvnxS7/naMel2IbGNsAPP8AsMF89j3XMqdFW3xtJP09kvLrlPDZhDM3tZ4JHhGvTGZ
        AG0J7anA==;
Received: from 179.176.125.229.dynamic.adsl.gvt.net.br ([179.176.125.229] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIYzc-0005Hx-VF; Mon, 22 Apr 2019 13:28:21 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hIYzT-0005mh-F4; Mon, 22 Apr 2019 10:28:11 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Evgeniy Polyakov <zbr@ioremap.net>
Subject: [PATCH v2 40/79] convert docs to ReST and rename to *.rst
Date:   Mon, 22 Apr 2019 10:27:29 -0300
Message-Id: <cb452fd60de6f4b1460c0b2b3406be73dc98497d.1555938376.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555938375.git.mchehab+samsung@kernel.org>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it has some function definitions, move them to connector.h.

The remaining conversion is actually:
  - add blank lines and identation in order to identify paragraphs;
  - fix tables markups;
  - add some lists markups;
  - mark literal blocks;
  - adjust title markups.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../{connector.txt => connector.rst}          | 130 ++++++------------
 drivers/w1/Kconfig                            |   2 +-
 include/linux/connector.h                     |  63 ++++++++-
 samples/Kconfig                               |   2 +-
 4 files changed, 109 insertions(+), 88 deletions(-)
 rename Documentation/connector/{connector.txt => connector.rst} (57%)

diff --git a/Documentation/connector/connector.txt b/Documentation/connector/connector.rst
similarity index 57%
rename from Documentation/connector/connector.txt
rename to Documentation/connector/connector.rst
index ab7ca897fab7..24e26dc22dbf 100644
--- a/Documentation/connector/connector.txt
+++ b/Documentation/connector/connector.rst
@@ -1,6 +1,8 @@
-/*****************************************/
-Kernel Connector.
-/*****************************************/
+:orphan:
+
+================
+Kernel Connector
+================
 
 Kernel connector - new netlink based userspace <-> kernel space easy
 to use communication module.
@@ -12,94 +14,55 @@ identifier, the appropriate callback will be called.
 
 From the userspace point of view it's quite straightforward:
 
-	socket();
-	bind();
-	send();
-	recv();
+	- socket();
+	- bind();
+	- send();
+	- recv();
 
 But if kernelspace wants to use the full power of such connections, the
 driver writer must create special sockets, must know about struct sk_buff
 handling, etc...  The Connector driver allows any kernelspace agents to use
 netlink based networking for inter-process communication in a significantly
-easier way:
+easier way::
 
-int cn_add_callback(struct cb_id *id, char *name, void (*callback) (struct cn_msg *, struct netlink_skb_parms *));
-void cn_netlink_send_multi(struct cn_msg *msg, u16 len, u32 portid, u32 __group, int gfp_mask);
-void cn_netlink_send(struct cn_msg *msg, u32 portid, u32 __group, int gfp_mask);
+  int cn_add_callback(struct cb_id *id, char *name, void (*callback) (struct cn_msg *, struct netlink_skb_parms *));
+  void cn_netlink_send_multi(struct cn_msg *msg, u16 len, u32 portid, u32 __group, int gfp_mask);
+  void cn_netlink_send(struct cn_msg *msg, u32 portid, u32 __group, int gfp_mask);
 
-struct cb_id
-{
+  struct cb_id
+  {
 	__u32			idx;
 	__u32			val;
-};
+  };
 
 idx and val are unique identifiers which must be registered in the
-connector.h header for in-kernel usage.  void (*callback) (void *) is a
+connector.h header for in-kernel usage.  `void (*callback) (void *)` is a
 callback function which will be called when a message with above idx.val
 is received by the connector core.  The argument for that function must
-be dereferenced to struct cn_msg *.
+be dereferenced to `struct cn_msg *`::
 
-struct cn_msg
-{
+  struct cn_msg
+  {
 	struct cb_id		id;
 
 	__u32			seq;
 	__u32			ack;
 
-	__u32			len;		/* Length of the following data */
+	__u32			len;	/* Length of the following data */
 	__u8			data[0];
-};
+  };
 
-/*****************************************/
-Connector interfaces.
-/*****************************************/
+Connector interfaces
+====================
 
-int cn_add_callback(struct cb_id *id, char *name, void (*callback) (struct cn_msg *, struct netlink_skb_parms *));
+ .. kernel-doc:: include/linux/connector.h
 
- Registers new callback with connector core.
+ Note:
+   When registering new callback user, connector core assigns
+   netlink group to the user which is equal to its id.idx.
 
- struct cb_id *id		- unique connector's user identifier.
-				  It must be registered in connector.h for legal in-kernel users.
- char *name			- connector's callback symbolic name.
- void (*callback) (struct cn..)	- connector's callback.
-				  cn_msg and the sender's credentials
-
-
-void cn_del_callback(struct cb_id *id);
-
- Unregisters new callback with connector core.
-
- struct cb_id *id		- unique connector's user identifier.
-
-
-int cn_netlink_send_multi(struct cn_msg *msg, u16 len, u32 portid, u32 __groups, int gfp_mask);
-int cn_netlink_send(struct cn_msg *msg, u32 portid, u32 __groups, int gfp_mask);
-
- Sends message to the specified groups.  It can be safely called from
- softirq context, but may silently fail under strong memory pressure.
- If there are no listeners for given group -ESRCH can be returned.
-
- struct cn_msg *		- message header(with attached data).
- u16 len			- for *_multi multiple cn_msg messages can be sent
- u32 port			- destination port.
- 				  If non-zero the message will be sent to the
-				  given port, which should be set to the
-				  original sender.
- u32 __group			- destination group.
-				  If port and __group is zero, then appropriate group will
-				  be searched through all registered connector users,
-				  and message will be delivered to the group which was
-				  created for user with the same ID as in msg.
-				  If __group is not zero, then message will be delivered
-				  to the specified group.
- int gfp_mask			- GFP mask.
-
- Note: When registering new callback user, connector core assigns
- netlink group to the user which is equal to its id.idx.
-
-/*****************************************/
-Protocol description.
-/*****************************************/
+Protocol description
+====================
 
 The current framework offers a transport layer with fixed headers.  The
 recommended protocol which uses such a header is as following:
@@ -132,9 +95,8 @@ driver (it also registers itself with id={-1, -1}).
 As example of this usage can be found in the cn_test.c module which
 uses the connector to request notification and to send messages.
 
-/*****************************************/
-Reliability.
-/*****************************************/
+Reliability
+===========
 
 Netlink itself is not a reliable protocol.  That means that messages can
 be lost due to memory pressure or process' receiving queue overflowed,
@@ -142,32 +104,31 @@ so caller is warned that it must be prepared.  That is why the struct
 cn_msg [main connector's message header] contains u32 seq and u32 ack
 fields.
 
-/*****************************************/
-Userspace usage.
-/*****************************************/
+Userspace usage
+===============
 
 2.6.14 has a new netlink socket implementation, which by default does not
 allow people to send data to netlink groups other than 1.
 So, if you wish to use a netlink socket (for example using connector)
 with a different group number, the userspace application must subscribe to
-that group first.  It can be achieved by the following pseudocode:
+that group first.  It can be achieved by the following pseudocode::
 
-s = socket(PF_NETLINK, SOCK_DGRAM, NETLINK_CONNECTOR);
+  s = socket(PF_NETLINK, SOCK_DGRAM, NETLINK_CONNECTOR);
 
-l_local.nl_family = AF_NETLINK;
-l_local.nl_groups = 12345;
-l_local.nl_pid = 0;
+  l_local.nl_family = AF_NETLINK;
+  l_local.nl_groups = 12345;
+  l_local.nl_pid = 0;
 
-if (bind(s, (struct sockaddr *)&l_local, sizeof(struct sockaddr_nl)) == -1) {
+  if (bind(s, (struct sockaddr *)&l_local, sizeof(struct sockaddr_nl)) == -1) {
 	perror("bind");
 	close(s);
 	return -1;
-}
+  }
 
-{
+  {
 	int on = l_local.nl_groups;
 	setsockopt(s, 270, 1, &on, sizeof(on));
-}
+  }
 
 Where 270 above is SOL_NETLINK, and 1 is a NETLINK_ADD_MEMBERSHIP socket
 option.  To drop a multicast subscription, one should call the above socket
@@ -180,16 +141,15 @@ group number 12345, you must increment CN_NETLINK_USERS to that number.
 Additional 0xf numbers are allocated to be used by non-in-kernel users.
 
 Due to this limitation, group 0xffffffff does not work now, so one can
-not use add/remove connector's group notifications, but as far as I know, 
+not use add/remove connector's group notifications, but as far as I know,
 only cn_test.c test module used it.
 
 Some work in netlink area is still being done, so things can be changed in
 2.6.15 timeframe, if it will happen, documentation will be updated for that
 kernel.
 
-/*****************************************/
 Code samples
-/*****************************************/
+============
 
 Sample code for a connector test module and user space can be found
 in samples/connector/. To build this code, enable CONFIG_CONNECTOR
diff --git a/drivers/w1/Kconfig b/drivers/w1/Kconfig
index dbb41f45af8a..c670bb247f21 100644
--- a/drivers/w1/Kconfig
+++ b/drivers/w1/Kconfig
@@ -18,7 +18,7 @@ config W1_CON
 	default y
 	---help---
 	  This allows to communicate with userspace using connector. For more
-	  information see <file:Documentation/connector/connector.txt>.
+	  information see <file:Documentation/connector/connector.rst>.
 	  There are three types of messages between w1 core and userspace:
 	  1. Events. They are generated each time new master or slave device found
 		either due to automatic or requested search.
diff --git a/include/linux/connector.h b/include/linux/connector.h
index 032102b19645..5aeb15f71b3a 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -68,10 +68,71 @@ struct cn_dev {
 	struct cn_queue_dev *cbdev;
 };
 
+/**
+ * cn_add_callback() - Registers new callback with connector core.
+ *
+ * @id:		unique connector's user identifier.
+ *		It must be registered in connector.h for legal
+ *		in-kernel users.
+ * @name:	connector's callback symbolic name.
+ * @callback:	connector's callback.
+ * 		parameters are %cn_msg and the sender's credentials
+ */
 int cn_add_callback(struct cb_id *id, const char *name,
 		    void (*callback)(struct cn_msg *, struct netlink_skb_parms *));
-void cn_del_callback(struct cb_id *);
+/**
+ * cn_del_callback() - Unregisters new callback with connector core.
+ *
+ * @id:		unique connector's user identifier.
+ */
+void cn_del_callback(struct cb_id *id);
+
+
+/**
+ * cn_netlink_send_mult - Sends message to the specified groups.
+ *
+ * @msg: 	message header(with attached data).
+ * @len:	Number of @msg to be sent.
+ * @portid:	destination port.
+ *		If non-zero the message will be sent to the given port,
+ *		which should be set to the original sender.
+ * @group:	destination group.
+ * 		If @portid and @group is zero, then appropriate group will
+ *		be searched through all registered connector users, and
+ *		message will be delivered to the group which was created
+ *		for user with the same ID as in @msg.
+ *		If @group is not zero, then message will be delivered
+ *		to the specified group.
+ * @gfp_mask:	GFP mask.
+ *
+ * It can be safely called from softirq context, but may silently
+ * fail under strong memory pressure.
+ *
+ * If there are no listeners for given group %-ESRCH can be returned.
+ */
 int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid, u32 group, gfp_t gfp_mask);
+
+/**
+ * cn_netlink_send_mult - Sends message to the specified groups.
+ *
+ * @msg:	message header(with attached data).
+ * @portid:	destination port.
+ *		If non-zero the message will be sent to the given port,
+ *		which should be set to the original sender.
+ * @group:	destination group.
+ * 		If @portid and @group is zero, then appropriate group will
+ *		be searched through all registered connector users, and
+ *		message will be delivered to the group which was created
+ *		for user with the same ID as in @msg.
+ *		If @group is not zero, then message will be delivered
+ *		to the specified group.
+ * @gfp_mask:	GFP mask.
+ *
+ * It can be safely called from softirq context, but may silently
+ * fail under strong memory pressure.
+ *
+ * If there are no listeners for given group %-ESRCH can be returned.
+ */
 int cn_netlink_send(struct cn_msg *msg, u32 portid, u32 group, gfp_t gfp_mask);
 
 int cn_queue_add_callback(struct cn_queue_dev *dev, const char *name,
diff --git a/samples/Kconfig b/samples/Kconfig
index d19754ccad08..12009247f482 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -100,7 +100,7 @@ config SAMPLE_CONNECTOR
 	  When enabled, this builds both a sample kernel module for
 	  the connector interface and a user space tool to communicate
 	  with it.
-	  See also Documentation/connector/connector.txt
+	  See also Documentation/connector/connector.rst
 
 config SAMPLE_SECCOMP
 	tristate "Build seccomp sample code -- loadable modules only"
-- 
2.20.1


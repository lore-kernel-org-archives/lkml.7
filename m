Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82EDC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7EA206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560364828;
	bh=yK3qj7qV8sIVRY3SXjmSdfEhKMToJI53eH5xc8xP2j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rUA2aSTRboNxqo8QZG2rxHsgyk7qpLeExRRO2fdf6m4PAPpS7IXL79cPByXnCzhxR
	 K95Ej5xywJ9uyQ9Rwqm0UdzSSvnh46GZ/oQCDzFmtEgc+VLgUCx7xmlEdtzwkmzxU+
	 SSlq2U9qmbtmlXlRRkLk014EGW2kZqvcwI0YStrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfFLSk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:40:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbfFLSil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v3+cKJjC8UE1x5KiXPrKT3zWPQnNrEMtVSn8hS0HGug=; b=cQs2Kg5rhEwyqBIBjqZeCz+o0Z
        PM51N/Fkku+1hVgndWce6qUuEkhoHsww4pRQQ6ABVCNHRKnZvoQ4C8dxllBmbVjClfLeev1gU+09O
        gYDcpjepGdOzvBmAolCItbX/Iul8S1h+00ao0Om0S42U381lFf+VJ8+84HlWgaEaXz2nUmRWHTNUk
        iqhf8gF4XFQvcAO/VtuoI8gFazmpIDMTaqQWXHYacg6Rj7V2PRXJpuSygWWehQz7jpmAIiF9dDSDo
        6g0WuR6n59h5cH7NuOjMkgZqAnLZoZLFwn+oFpuPF8Fek5zHR941IjgtSLTwHovciTm0sk9dyL9Gj
        wvS0qX/g==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb88s-0006YO-Sk; Wed, 12 Jun 2019 18:38:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb88p-0002AJ-Pb; Wed, 12 Jun 2019 15:38:35 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Evgeniy Polyakov <zbr@ioremap.net>
Subject: [PATCH v1 01/31] docs: connector: convert to ReST and rename to connector.rst
Date:   Wed, 12 Jun 2019 15:38:04 -0300
Message-Id: <b70b642c7fc05d72c6f4e5b1b2ee1fd336fddcb0.1560364494.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560364493.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
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
index 03dd57581df7..160053c0baea 100644
--- a/drivers/w1/Kconfig
+++ b/drivers/w1/Kconfig
@@ -19,7 +19,7 @@ config W1_CON
 	default y
 	---help---
 	  This allows to communicate with userspace using connector. For more
-	  information see <file:Documentation/connector/connector.txt>.
+	  information see <file:Documentation/connector/connector.rst>.
 	  There are three types of messages between w1 core and userspace:
 	  1. Events. They are generated each time new master or slave device found
 		either due to automatic or requested search.
diff --git a/include/linux/connector.h b/include/linux/connector.h
index 1d72ef76f24f..6b6c7396a584 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -55,10 +55,71 @@ struct cn_dev {
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
index d63cc8a3e0df..9ec524b2e003 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -100,7 +100,7 @@ config SAMPLE_CONNECTOR
 	  When enabled, this builds both a sample kernel module for
 	  the connector interface and a user space tool to communicate
 	  with it.
-	  See also Documentation/connector/connector.txt
+	  See also Documentation/connector/connector.rst
 
 config SAMPLE_SECCOMP
 	bool "Build seccomp sample code"
-- 
2.21.0


Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3F0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0572075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901879;
	bh=OZJ5IHnoXbgwtayRjLqWOSDr/fkquP7Z016tsh7le5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=whrQXhe1NukhaCec9rWE5K8PnwYXm6sdGwEOMPlR77lexzgs3uLoSuvZtDMUkhnkL
	 jN+NrzRjP6nyaUnUGD70WdDva8Wewpij6ALzRLnclimCIVtoheMtIhjYCrL1Jmf4Mu
	 +xW0Fs+5aEbS3zPJ2ZVF+8Z8ITXC5rWb9Wp89cWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387947AbfCRJhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387936AbfCRJho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:37:44 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88F322087C;
        Mon, 18 Mar 2019 09:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901864;
        bh=OZJ5IHnoXbgwtayRjLqWOSDr/fkquP7Z016tsh7le5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hHjbjGu/WlaQgjRTVgJleAl09IAV1wh4ldNkrzzbwMFh7uk0oZpNLbOGDVlep7yWc
         qhfsizPTZ6GbwTmKFVnuQPNWrMsLZCDvLEBwHPmoX4y35Mq57nYNXM7deQnp2W+jpN
         2wRWMT9IURwxnDhoYksbhBVhuPNnMNYIwfIipTyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Rob Herring <robh@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 30/31] of: Support const and non-const use for to_of_node()
Date:   Mon, 18 Mar 2019 10:26:05 +0100
Message-Id: <20190318084211.641869720@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084210.397476003@linuxfoundation.org>
References: <20190318084210.397476003@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit d20dc1493db438fbbfb7733adc82f472dd8a0789 upstream.

Turn to_of_node() into a macro in order to support both const and
non-const use. Additionally make the fwnode argument to is_of_node() const
as well.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/of.h |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -148,16 +148,20 @@ extern raw_spinlock_t devtree_lock;
 #ifdef CONFIG_OF
 void of_core_init(void);
 
-static inline bool is_of_node(struct fwnode_handle *fwnode)
+static inline bool is_of_node(const struct fwnode_handle *fwnode)
 {
 	return !IS_ERR_OR_NULL(fwnode) && fwnode->type == FWNODE_OF;
 }
 
-static inline struct device_node *to_of_node(struct fwnode_handle *fwnode)
-{
-	return is_of_node(fwnode) ?
-		container_of(fwnode, struct device_node, fwnode) : NULL;
-}
+#define to_of_node(__fwnode)						\
+	({								\
+		typeof(__fwnode) __to_of_node_fwnode = (__fwnode);	\
+									\
+		is_of_node(__to_of_node_fwnode) ?			\
+			container_of(__to_of_node_fwnode,		\
+				     struct device_node, fwnode) :	\
+			NULL;						\
+	})
 
 static inline bool of_have_populated_dt(void)
 {
@@ -529,12 +533,12 @@ static inline void of_core_init(void)
 {
 }
 
-static inline bool is_of_node(struct fwnode_handle *fwnode)
+static inline bool is_of_node(const struct fwnode_handle *fwnode)
 {
 	return false;
 }
 
-static inline struct device_node *to_of_node(struct fwnode_handle *fwnode)
+static inline struct device_node *to_of_node(const struct fwnode_handle *fwnode)
 {
 	return NULL;
 }



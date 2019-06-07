Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F50C468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD10212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfFGKae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 06:30:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:46377 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfFGKae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 06:30:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 03:30:32 -0700
X-ExtLoop1: 1
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 07 Jun 2019 03:30:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 07 Jun 2019 13:30:26 +0300
Date:   Fri, 7 Jun 2019 13:30:26 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yu Chen <chenyu56@huawei.com>
Subject: Re: [PATCH v6 06/10] device connection: Add
 fwnode_connection_find_match()
Message-ID: <20190607103026.GE10298@kuha.fi.intel.com>
References: <1559115828-19146-1-git-send-email-chunfeng.yun@mediatek.com>
 <1559115828-19146-7-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <1559115828-19146-7-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, May 29, 2019 at 03:43:44PM +0800, Chunfeng Yun wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> The fwnode_connection_find_match() function is exactly the
> same as device_connection_find_match(), except it takes
> struct fwnode_handle as parameter instead of struct device.
> That allows locating device connections before the device
> entries have been created.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

This one is also missing your SoB.

There are now some other changes to the devcon API in Rafael's tree
[1] that will conflict with this one. I'm attaching a modified version
of the patch that is rebased on top of today's linux-next. If you use
it, you should make a note (probable in the cover letter) that the
series now depends on Rafael's tree.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=linux-next


thanks,

-- 
heikki

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-device-connection-Add-fwnode_connection_find_match.patch"

From ea4ebbfd00e6ddc7bb7ad32e2f921bfc67f2ff8f Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Wed, 22 May 2019 17:06:54 +0300
Subject: [PATCH] device connection: Add fwnode_connection_find_match()

The fwnode_connection_find_match() function is exactly the
same as device_connection_find_match(), except it takes
struct fwnode_handle as parameter instead of struct device.
That allows locating device connections before the device
entries have been created.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/devcon.c  | 43 ++++++++++++++++++++++++++++++------------
 include/linux/device.h | 10 +++++++---
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index f7035fc12b92..5bf9537bd738 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -12,9 +12,6 @@
 static DEFINE_MUTEX(devcon_lock);
 static LIST_HEAD(devcon_list);
 
-typedef void *(*devcon_match_fn_t)(struct device_connection *con, int ep,
-				   void *data);
-
 static void *
 fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 			  void *data, devcon_match_fn_t match)
@@ -60,6 +57,34 @@ fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 	return NULL;
 }
 
+/**
+ * fwnode_connection_find_match - Find connection from a device node
+ * @fwnode: Device node with the connection
+ * @con_id: Identifier for the connection
+ * @data: Data for the match function
+ * @match: Function to check and convert the connection description
+ *
+ * Find a connection with unique identifier @con_id between @fwnode and another
+ * device node. @match will be used to convert the connection description to
+ * data the caller is expecting to be returned.
+ */
+void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
+				   const char *con_id, void *data,
+				   devcon_match_fn_t match)
+{
+	void *ret;
+
+	if (!fwnode || !match)
+		return NULL;
+
+	ret = fwnode_graph_devcon_match(fwnode, con_id, data, match);
+	if (ret)
+		return ret;
+
+	return fwnode_devcon_match(fwnode, con_id, data, match);
+}
+EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
+
 /**
  * device_connection_find_match - Find physical connection to a device
  * @dev: Device with the connection
@@ -83,15 +108,9 @@ void *device_connection_find_match(struct device *dev, const char *con_id,
 	if (!match)
 		return NULL;
 
-	if (fwnode) {
-		ret = fwnode_graph_devcon_match(fwnode, con_id, data, match);
-		if (ret)
-			return ret;
-
-		ret = fwnode_devcon_match(fwnode, con_id, data, match);
-		if (ret)
-			return ret;
-	}
+	ret = fwnode_connection_find_match(fwnode, con_id, data, match);
+	if (ret)
+		return ret;
 
 	mutex_lock(&devcon_lock);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index e0649f6adf2e..fd06d75da206 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -773,10 +773,14 @@ struct device_connection {
 	struct list_head	list;
 };
 
+typedef void *(*devcon_match_fn_t)(struct device_connection *con, int ep,
+				   void *data);
+
+void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
+				   const char *con_id, void *data,
+				   devcon_match_fn_t match);
 void *device_connection_find_match(struct device *dev, const char *con_id,
-				void *data,
-				void *(*match)(struct device_connection *con,
-					       int ep, void *data));
+				   void *data, devcon_match_fn_t match);
 
 struct device *device_connection_find(struct device *dev, const char *con_id);
 
-- 
2.20.1


--bg08WKrSYDhXBjb5--

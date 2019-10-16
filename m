Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F44ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3B22168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264586;
	bh=h9SQcFept3pB+xkQBM+FRgICSsNP72okiwEZoRRoA3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nlu0/9DkGX5S2l/iAufzFBL41rVGpwAf/CJ9vyb59Uz4ECndDRtjVsl/eH9t5F7lu
	 kIowYwtx5pVSXyyhEIcOgV0x9HsWAYoGRUZnhRr19fjAMweCt4nXcdqczXJ6XHlQwj
	 7Om0P3tgpB/aWMHqtOxxP3WWYKQpZiHVb+WM4tPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439406AbfJPWXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:23:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394810AbfJPVxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:53:04 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2310621925;
        Wed, 16 Oct 2019 21:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262784;
        bh=h9SQcFept3pB+xkQBM+FRgICSsNP72okiwEZoRRoA3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RoSyf2cHOhskonkMEpQp0CBmYEbYJ93PRTFprwGFeRu2Z4cr1Lcd//s+4lSsDS5zY
         G5wHUuGNq6C+7xlDBDzaAgj9JefqvW+iTlb+2FbK+78YheTkh/OM1mHx9FZCSsTRv9
         Kmhueb5L2wvdZh1NSyPHjgLL5XSIT9BxdeOqJHNE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jouni Malinen <j@w1.fi>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.4 25/79] cfg80211: Use const more consistently in for_each_element macros
Date:   Wed, 16 Oct 2019 14:50:00 -0700
Message-Id: <20191016214753.108991885@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214729.758892904@linuxfoundation.org>
References: <20191016214729.758892904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jouni Malinen <j@w1.fi>

commit 7388afe09143210f555bdd6c75035e9acc1fab96 upstream.

Enforce the first argument to be a correct type of a pointer to struct
element and avoid unnecessary typecasts from const to non-const pointers
(the change in validate_ie_attr() is needed to make this part work). In
addition, avoid signed/unsigned comparison within for_each_element() and
mark struct element packed just in case.

Signed-off-by: Jouni Malinen <j@w1.fi>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/ieee80211.h |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2554,16 +2554,16 @@ struct element {
 	u8 id;
 	u8 datalen;
 	u8 data[];
-};
+} __packed;
 
 /* element iteration helpers */
-#define for_each_element(element, _data, _datalen)			\
-	for (element = (void *)(_data);					\
-	     (u8 *)(_data) + (_datalen) - (u8 *)element >=		\
-		sizeof(*element) &&					\
-	     (u8 *)(_data) + (_datalen) - (u8 *)element >=		\
-		sizeof(*element) + element->datalen;			\
-	     element = (void *)(element->data + element->datalen))
+#define for_each_element(_elem, _data, _datalen)			\
+	for (_elem = (const struct element *)(_data);			\
+	     (const u8 *)(_data) + (_datalen) - (const u8 *)_elem >=	\
+		(int)sizeof(*_elem) &&					\
+	     (const u8 *)(_data) + (_datalen) - (const u8 *)_elem >=	\
+		(int)sizeof(*_elem) + _elem->datalen;			\
+	     _elem = (const struct element *)(_elem->data + _elem->datalen))
 
 #define for_each_element_id(element, _id, data, datalen)		\
 	for_each_element(element, data, datalen)			\
@@ -2600,7 +2600,7 @@ struct element {
 static inline bool for_each_element_completed(const struct element *element,
 					      const void *data, size_t datalen)
 {
-	return (u8 *)element == (u8 *)data + datalen;
+	return (const u8 *)element == (const u8 *)data + datalen;
 }
 
 #endif /* LINUX_IEEE80211_H */



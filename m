Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13048C47E49
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F6B21924
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WAfl1XmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390700AbfJ1WAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 18:00:46 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:54747 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390632AbfJ1WAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:00:45 -0400
Received: by mail-vk1-f201.google.com with SMTP id i207so4185063vke.21
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 15:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=p1q/Pw/wuy9bjo/DrQQAdF+Yb7XQb+VfuKZvKfT16cM=;
        b=WAfl1XmPbwo+7VE/CZN0905b+HEiYar7/NvUthq601HPXxT94eCGYY2F4WfuKln4W7
         +SfqttoOOX9bXAFCz8ORqsda1Ic2Uh3Ud+PYGT6xFRU4sjsX8FxhctSmhYGWjuK2/dMW
         LHMMJUos6oA87dNWQjCZ1EcxcjqfBavBeCcLKRO/W91UmWen/BnwZhnKmCsTTpXml3ho
         DduqFtcrLux5Npe9TmskCDaZBmz6ho7fI1oGF2ZSxPAddumrBpli4aTCIVo5rDh+5hnZ
         e/DiPNdXDAbp0iWTPlfNBmMt/jewBkIKimoHqF6EbT/oggxlma0OCQPTQc/K3+BotBRD
         oXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p1q/Pw/wuy9bjo/DrQQAdF+Yb7XQb+VfuKZvKfT16cM=;
        b=AiQWU7LXBtCVlrOHVPnTueRobm2d1RZhQ5q6vDzoSa5JlOrRVI3t1KNpa+PAOdxo3p
         DOvtUoLO/WGVsoakt65MuLc9TuuHmn7VtFiC0BsmLh3YwqlxZRksatToGU8QrAfR3kqj
         u+gJj2BZb21RzmwkkKc+mKlCIJt7PWT4qERXKJffUwfOjuVTr3Hkn+dVezmKNhmBdMyx
         F5Kx797ZlichldauS3bC090EOiH9Ws9aJ1OOz+cU6/dRpm4OJW9kUsz4DJeGQAnfvZAf
         5c/8+/e23XgOTYwKNI4MQluui/iJ7ijYrv+Wa7ZsULkpzy5NNr0yIuHsDBYnMB2DkynE
         BWsQ==
X-Gm-Message-State: APjAAAWioHMx2i81ec9Kdq4CXhxInfaE8F/ciYrj3KIwvv/TpT7R4duu
        JNJRpW8igrPuxOAdCVbeoD7R1ROOODNTpfg=
X-Google-Smtp-Source: APXvYqyedBmeKcCmUfQlI/6WF0HNof2bWz1MwtqdnVskuaQNyPZRJ7ILHAIvQWm0quDgwRzmEACcOOkgvrFUk10=
X-Received: by 2002:a05:6102:835:: with SMTP id k21mr10123988vsb.11.1572300043709;
 Mon, 28 Oct 2019 15:00:43 -0700 (PDT)
Date:   Mon, 28 Oct 2019 15:00:25 -0700
In-Reply-To: <20191028220027.251605-1-saravanak@google.com>
Message-Id: <20191028220027.251605-5-saravanak@google.com>
Mime-Version: 1.0
References: <20191028220027.251605-1-saravanak@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v1 4/5] of: property: Make sure child dependencies don't block
 probing of parent
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating device links to proxy the sync_state() needs of child
dependencies, create SYNC_STATE_ONLY device links so that children
dependencies don't block probing of the parent.

Also, differentiate between missing suppliers of parent device vs
missing suppliers of child devices so that driver core doesn't block
parent device probing when only child supplier dependencies are missing.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 2808832b2e86..f16f85597ccc 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1032,10 +1032,10 @@ static bool of_is_ancestor_of(struct device_node *test_ancestor,
  * - -EINVAL if the supplier link is invalid and should not be created
  * - -ENODEV if there is no device that corresponds to the supplier phandle
  */
-static int of_link_to_phandle(struct device *dev, struct device_node *sup_np)
+static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
+			      u32 dl_flags)
 {
 	struct device *sup_dev;
-	u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
 	int ret = 0;
 	struct device_node *tmp_np = sup_np;
 
@@ -1195,13 +1195,20 @@ static int of_link_property(struct device *dev, struct device_node *con_np,
 	unsigned int i = 0;
 	bool matched = false;
 	int ret = 0;
+	u32 dl_flags;
+
+	if (dev->of_node == con_np)
+		dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
+	else
+		dl_flags = DL_FLAG_SYNC_STATE_ONLY;
 
 	/* Do not stop at first failed link, link all available suppliers. */
 	while (!matched && s->parse_prop) {
 		while ((phandle = s->parse_prop(con_np, prop_name, i))) {
 			matched = true;
 			i++;
-			if (of_link_to_phandle(dev, phandle) == -EAGAIN)
+			if (of_link_to_phandle(dev, phandle, dl_flags)
+								== -EAGAIN)
 				ret = -EAGAIN;
 			of_node_put(phandle);
 		}
@@ -1219,10 +1226,10 @@ static int of_link_to_suppliers(struct device *dev,
 
 	for_each_property_of_node(con_np, p)
 		if (of_link_property(dev, con_np, p->name))
-			ret = -EAGAIN;
+			ret = -ENODEV;
 
 	for_each_child_of_node(con_np, child)
-		if (of_link_to_suppliers(dev, child))
+		if (of_link_to_suppliers(dev, child) && !ret)
 			ret = -EAGAIN;
 
 	return ret;
-- 
2.24.0.rc0.303.g954a862665-goog


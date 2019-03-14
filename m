Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE2FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE972184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="KRHG+Xem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfCNHFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:05:43 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:51664 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCNHFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:05:42 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 39890B10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:05:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bUWjlC_oB5Dp for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 02:05:41 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 07971AF7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 02:05:41 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id 9so3760256ita.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 00:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=geyknCHJBN9QzuUmxBhzQkvAPR4fFq898CG938LPR8E=;
        b=KRHG+Xem/qWECXN0PlkxHB7LqNeTZCApusewf7DczDTtaeO/W9Rw8oArue3ATqquM9
         j1ZfNnP0CPPFqPIHAlAGK8ikQ672BMkGD4LolmCm1eu+NcBs0BadSX0czpQGbhd3bR7w
         jp21/ofjvt/aPZYl6DDankWzGkMieHfRQhqSavbsMTjDsA+pz4yiD1GPoVzDBJpY/z/g
         mABSV9LwQxqy/h9O1itdbaquw6RJpKbo2pRFjf8YYWLIOKBv+U+LG0BfftxPmGDOunMq
         ChqFLksNAm8yB3O9uqGMxkR7ZU3PSaXQDUDux3dJsNgIG/MmepPbnXsMyFjfwnUqeuPn
         +5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=geyknCHJBN9QzuUmxBhzQkvAPR4fFq898CG938LPR8E=;
        b=Y5CNPFeiG4kZ9cxPJiCpQQFZBD7MfkN2mP8UaDVKscZyNO40zbhp5HZdJV3QKeAquM
         GHXNGa4/8XjlsH/Xh7SUB+wBbR2Ks2tcw/6FaIWMyvzybx60nkH5JfLzaKHHdu/NQVQt
         MSoCDkSZSFzRmgOXck+vE15nOoMFhCXNgxAGs3G/8y7LnJEKhv9sCiUydf8QRePtHd5Q
         nRHS9QbDx8QSd6usXhCWCJIWzMwhjydrZJQCb6r9M17bHr3/ZOvH+heN6wmcX6Sbz0Hj
         aphz8I9bblnVUeRaO6k3Smxwpllf45QqF6NboVfagmr6aQPtBDWo0fhONFLvPDs/4Fpc
         iAug==
X-Gm-Message-State: APjAAAWY1T2uMNYTpGCBSDiYx+AYPPftoqDBiFg73fBqh+v5YSwxkU50
        KAXvBQ1QteZeRgUYhmYmW0deHVpXmXTPgGqXWpN3kp7ViZR9T0iACFp72WnURO6TdRE2k0oMHvD
        JsoKhvYNxEEkmLfEKnALfMHI0t0J2
X-Received: by 2002:a5e:db48:: with SMTP id r8mr11155761iop.220.1552547140628;
        Thu, 14 Mar 2019 00:05:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqypDjJma3wZ5K/YwGFldO9WEouPyKn33YkVS0jxN/HQ7NG4JiNv5fkdO9qQqWO9/3m7DKgBHQ==
X-Received: by 2002:a5e:db48:: with SMTP id r8mr11155747iop.220.1552547140388;
        Thu, 14 Mar 2019 00:05:40 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id a8sm4685101iol.35.2019.03.14.00.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 00:05:39 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: ipwireless: fix missing checks for ioremap
Date:   Thu, 14 Mar 2019 02:05:32 -0500
Message-Id: <20190314070534.17819-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipw->attr_memory and ipw->common_memory are assigned with the
 return value of ioremap. ioremap may fail, but not checks
are enforced. The fix insertss the checks.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/tty/ipwireless/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/ipwireless/main.c b/drivers/tty/ipwireless/main.c
index 3475e841ef5c..4c18bbfe1a92 100644
--- a/drivers/tty/ipwireless/main.c
+++ b/drivers/tty/ipwireless/main.c
@@ -114,6 +114,10 @@ static int ipwireless_probe(struct pcmcia_device *p_dev, void *priv_data)
 
 	ipw->common_memory = ioremap(p_dev->resource[2]->start,
 				resource_size(p_dev->resource[2]));
+	if (!ipw->common_memory) {
+		ret = -ENOMEM;
+		goto exit1;
+	}
 	if (!request_mem_region(p_dev->resource[2]->start,
 				resource_size(p_dev->resource[2]),
 				IPWIRELESS_PCCARD_NAME)) {
@@ -134,6 +138,10 @@ static int ipwireless_probe(struct pcmcia_device *p_dev, void *priv_data)
 
 	ipw->attr_memory = ioremap(p_dev->resource[3]->start,
 				resource_size(p_dev->resource[3]));
+	if (!ipw->attr_memory) {
+		ret = -ENOMEM;
+		goto exit3;
+	}
 	if (!request_mem_region(p_dev->resource[3]->start,
 				resource_size(p_dev->resource[3]),
 				IPWIRELESS_PCCARD_NAME)) {
-- 
2.17.1


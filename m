Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD3EC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D84E21783
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738312;
	bh=6QaYj1hwO9X8cYBYVzsZl8PDnGSMIwF31I8yblWNh2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EUyfzRPuIzvlf+7xA+es6GzcYNUdzE/kdp95IcYcVkkJChe44l05E9J8CwHhRNT5m
	 wGnI/5IHFhZ6dPsGvFzAko1CQL+tW+PeSV2mSJf92OjJkR1/KcObi5ghnHa6IaEfO8
	 jImArZ00f/320PYFgIPAyKXzp081EyuNrKr8XumM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391103AbfHBJbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:31:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404743AbfHBJbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:31:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 138B821783;
        Fri,  2 Aug 2019 09:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738305;
        bh=6QaYj1hwO9X8cYBYVzsZl8PDnGSMIwF31I8yblWNh2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E4jn3+rEv8de0zJoZckzkAm/jQnpXmvKFs+yI8+QXThd0KuaS0xmTdr08eCGq+tEo
         tX9Jr/duAZQL10vr2sihL48opsPltAsjrgl67NpSV0RO8mmdeZ9tiI6Qb/QU2/fYP7
         ayPgNrnusbqpm1fAulysec/V57zUn3D0xxrivLqo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Borislav Petkov <bp@suse.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 035/158] EDAC/sysfs: Fix memory leak when creating a csrow object
Date:   Fri,  2 Aug 2019 11:27:36 +0200
Message-Id: <20190802092210.979107422@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 585fb3d93d32dbe89e718b85009f9c322cc554cd ]

In edac_create_csrow_object(), the reference to the object is not
released when adding the device to the device hierarchy fails
(device_add()). This may result in a memory leak.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: https://lkml.kernel.org/r/1555554438-103953-1-git-send-email-bianpan2016@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/edac_mc_sysfs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 3c8f19f5ac81..0c53f2d54765 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -426,6 +426,8 @@ static inline int nr_pages_per_csrow(struct csrow_info *csrow)
 static int edac_create_csrow_object(struct mem_ctl_info *mci,
 				    struct csrow_info *csrow, int index)
 {
+	int err;
+
 	csrow->dev.type = &csrow_attr_type;
 	csrow->dev.bus = mci->bus;
 	csrow->dev.groups = csrow_dev_groups;
@@ -438,7 +440,11 @@ static int edac_create_csrow_object(struct mem_ctl_info *mci,
 	edac_dbg(0, "creating (virtual) csrow node %s\n",
 		 dev_name(&csrow->dev));
 
-	return device_add(&csrow->dev);
+	err = device_add(&csrow->dev);
+	if (err)
+		put_device(&csrow->dev);
+
+	return err;
 }
 
 /* Create a CSROW object under specifed edac_mc_device */
-- 
2.20.1




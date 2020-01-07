Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A82C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF3A2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578430917;
	bh=61OKNzx1XwzEIQUxdZ0/+Y5LSE0f+dEE/8TrPh6VX2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TcEX0b22YNt/zcK47JBHerdpXZR55fAKju5eNGQAsChXAJJCyM++02Ev7JqR7oKBL
	 CD6pIJM9EACN4VqDYF5W64Z/SSahE3iTeDL9FLBbWwpqADBz+mKXseV/nIvsmmlyb5
	 rU/5tOvvbSqRyMJg1OdWMqwcOmdvOR0Q9P1ElKMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgAGVB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:01:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728639AbgAGVBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:01:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA015214D8;
        Tue,  7 Jan 2020 21:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430911;
        bh=61OKNzx1XwzEIQUxdZ0/+Y5LSE0f+dEE/8TrPh6VX2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZUGTwZbk7lw+jdovCOsHu3FlfzH8N94ehSIpGKwKkqe6tMHxtsBMNKPUQ3/gwByoD
         dmBjZT7VohpNyDXEznOkHcPvkTgZqa4lSjF1a+oyYo0EJrpTJW1f78h0lBxtrst38T
         /RL/CCwRXzvYkxHVoj+lkdmjBWGrXWxZpaTrdljk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wenyang@linux.alibaba.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 5.4 147/191] firmware: arm_scmi: Avoid double free in error flow
Date:   Tue,  7 Jan 2020 21:54:27 +0100
Message-Id: <20200107205340.839413251@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wenyang@linux.alibaba.com>

commit 8305e90a894f82c278c17e51a28459deee78b263 upstream.

If device_register() fails, both put_device() and kfree() are called,
ending with a double free of the scmi_dev.

Calling kfree() is needed only when a failure happens between the
allocation of the scmi_dev and its registration, so move it to there
and remove it from the error flow.

Fixes: 46edb8d1322c ("firmware: arm_scmi: provide the mandatory device release callback")
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/arm_scmi/bus.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -135,8 +135,10 @@ scmi_device_create(struct device_node *n
 		return NULL;
 
 	id = ida_simple_get(&scmi_bus_id, 1, 0, GFP_KERNEL);
-	if (id < 0)
-		goto free_mem;
+	if (id < 0) {
+		kfree(scmi_dev);
+		return NULL;
+	}
 
 	scmi_dev->id = id;
 	scmi_dev->protocol_id = protocol;
@@ -154,8 +156,6 @@ scmi_device_create(struct device_node *n
 put_dev:
 	put_device(&scmi_dev->dev);
 	ida_simple_remove(&scmi_bus_id, id);
-free_mem:
-	kfree(scmi_dev);
 	return NULL;
 }
 



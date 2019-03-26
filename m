Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ADBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC20C20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553581941;
	bh=7daqbbtkWfmInTArg8gSIKW6YSqqD57S5aM6bKnEz3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NBfku0UFZHmFdlL+jeVGgWvjmNEdbaZpf6CJk0b35w0+H/LkmF3yDmItRMQNNZekh
	 JEN/3TL1fMY+Mnm4FSdTwhziilhAjycJVyUmbeSPAiI3R2tjYSetdN9IOQihQ7Y7kD
	 Ejspk02wIYuVjysPNPCY+gkbQta+9ghu/y0jV9zA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfCZGcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:32:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731389AbfCZGcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:32:17 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACE9420823;
        Tue, 26 Mar 2019 06:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553581936;
        bh=7daqbbtkWfmInTArg8gSIKW6YSqqD57S5aM6bKnEz3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ogGevcsjBQ5J9mhK+w9k0VpfRAzakyhGq99SVrKtgNuhS6EhvpOFFL0eZfj/PhFJE
         F8BFGCBVJGqtmzWfwRXez2O0wpigBe8LF7uHRiXv/4AnBpjuVczADUKI9BaZ8mfJtN
         TA+eZA5fegTTtE6NK0dSdXDuqY7pLPVzoPr1NSdg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 4.9 29/30] power: supply: charger-manager: Fix incorrect return value
Date:   Tue, 26 Mar 2019 15:30:08 +0900
Message-Id: <20190326042608.539968138@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042607.558087893@linuxfoundation.org>
References: <20190326042607.558087893@linuxfoundation.org>
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

From: Baolin Wang <baolin.wang@linaro.org>

commit f25a646fbe2051527ad9721853e892d13a99199e upstream.

Fix incorrect return value.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/supply/charger-manager.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1212,7 +1212,6 @@ static int charger_extcon_init(struct ch
 	if (ret < 0) {
 		pr_info("Cannot register extcon_dev for %s(cable: %s)\n",
 			cable->extcon_name, cable->name);
-		ret = -EINVAL;
 	}
 
 	return ret;
@@ -1634,7 +1633,7 @@ static int charger_manager_probe(struct
 
 	if (IS_ERR(desc)) {
 		dev_err(&pdev->dev, "No platform data (desc) found\n");
-		return -ENODEV;
+		return PTR_ERR(desc);
 	}
 
 	cm = devm_kzalloc(&pdev->dev,



Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CA8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449D12192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255736;
	bh=YyeSrcj+lHAmQdOXozIn9Jnig5T7EGLGXtmtf20z0RA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qcR23VS6c8wtQ+ZcA7IOSH8kRYl78Ncl7zagklOoWSrGTEXjgXzGUbPVnPIoFncpH
	 89rmko/lQyBWJa2ekkZpPuz5/WoQyzaFGscrt+TCuqGmZZZY8JeKJUHuLtZCwUuBJf
	 LX0QeJ6roJWTG1L0hhk5rHtrvHIlvHKE7LuyZXGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbfCVLze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732762AbfCVLzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:55:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1396520850;
        Fri, 22 Mar 2019 11:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255731;
        bh=YyeSrcj+lHAmQdOXozIn9Jnig5T7EGLGXtmtf20z0RA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FCidiJUqmPQwjTdSTqdMUXWMLqIp6PK9IL1i0d9ZhG5mxeWHHKzjjF8w3sXhDAO3U
         UQMCIlG2W1aZ9U/EH8lIFkvl2NkPjcAvuKSSPsoyhfvbGJK33GItT6Bp/KUOrImIeu
         W1myiyuNgLbtkucSxFc7d8b7X5MbB+bNWf8mr0DA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 4.14 153/183] cpcap-charger: generate events for userspace
Date:   Fri, 22 Mar 2019 12:16:21 +0100
Message-Id: <20190322111252.970440782@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Machek <pavel@ucw.cz>

commit fd10606f93a149a9f3d37574e5385b083b4a7b32 upstream.

The driver doesn't generate uevents on charger connect/disconnect.
This leads to UPower not detecting when AC is on or off... and that is
bad.

Reported by Arthur D. on github (
https://github.com/maemo-leste/bugtracker/issues/206 ), thanks to
Merlijn Wajer for suggesting a fix.

Cc: stable@kernel.org
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/supply/cpcap-charger.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -458,6 +458,7 @@ static void cpcap_usb_detect(struct work
 			goto out_err;
 	}
 
+	power_supply_changed(ddata->usb);
 	return;
 
 out_err:



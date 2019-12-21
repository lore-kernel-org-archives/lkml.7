Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86327C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 07:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A884206EC
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 07:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfLUHAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 02:00:14 -0500
Received: from [167.172.186.51] ([167.172.186.51]:39708 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbfLUHAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 02:00:14 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id CB4B7DFCCE;
        Sat, 21 Dec 2019 07:00:15 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id AnN0fj76A62i; Sat, 21 Dec 2019 07:00:14 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7A9E0DFCCF;
        Sat, 21 Dec 2019 07:00:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lDODhx9dnsaf; Sat, 21 Dec 2019 07:00:14 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id E149BDFCCE;
        Sat, 21 Dec 2019 07:00:13 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Maciej Purski <m.purski@samsung.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [RESEND PATCH] component: do not dereference opaque pointer in debugfs
Date:   Sat, 21 Dec 2019 08:00:06 +0100
Message-Id: <20191221070006.267667-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The match data does not have to be a struct device pointer, and indeed
very often is not. Attempt to treat it as such easily results in a
crash.

For the components that are not registered, we don't know which device
is missing. Once it it is there, we can use the struct component to get
the device and whether it's bound or not.

Fixes: 59e73854b5fd ('component: add debugfs support')
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/base/component.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 532a3a5d8f633..1fdbd6ff20580 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -102,11 +102,11 @@ static int component_devices_show(struct seq_file *=
s, void *data)
 	seq_printf(s, "%-40s %20s\n", "device name", "status");
 	seq_puts(s, "----------------------------------------------------------=
---\n");
 	for (i =3D 0; i < match->num; i++) {
-		struct device *d =3D (struct device *)match->compare[i].data;
+		struct component *component =3D match->compare[i].component;
=20
-		seq_printf(s, "%-40s %20s\n", dev_name(d),
-			   match->compare[i].component ?
-			   "registered" : "not registered");
+		seq_printf(s, "%-40s %20s\n",
+			   component ? dev_name(component->dev) : "(unknown)",
+			   component ? (component->bound ? "bound" : "not bound") : "not regi=
stered");
 	}
 	mutex_unlock(&component_mutex);
=20
--=20
2.24.1


Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F075C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3575B20748
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKRLyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:54:45 -0500
Received: from shell.v3.sk ([90.176.6.54]:34678 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfKRLyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:54:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A3BD241C7A;
        Mon, 18 Nov 2019 12:54:40 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vlzYCjQ6L5VO; Mon, 18 Nov 2019 12:54:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 801EB41C7B;
        Mon, 18 Nov 2019 12:54:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fLPI3kAqcZ3N; Mon, 18 Nov 2019 12:54:35 +0100 (CET)
Received: from belphegor.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 20A7241C7A;
        Mon, 18 Nov 2019 12:54:35 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Maciej Purski <m.purski@samsung.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] component: do not dereference opaque pointer in debugfs
Date:   Mon, 18 Nov 2019 12:54:31 +0100
Message-Id: <20191118115431.63626-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.23.0
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
2.23.0


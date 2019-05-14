Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BB2C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826202147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITLwBme+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfENKOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:14:37 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34430 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfENKOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:14:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id v18so11436358lfi.1;
        Tue, 14 May 2019 03:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bermH+qcfg6fxNhcwx32poEW88kaY2/q9KQrNfCSlPQ=;
        b=ITLwBme+PtJxOfZZImLP0AGD5O0DJgJDl6GEXaqokIabNzw0oG/E0wkgzxUOD626fD
         j/yzxYWSeV4VfnIRCvf9UU4Vxy4MT4fgygTci2srIlKGU4SXmqtKarBe+7lgW0/dbCfk
         kn2tKgU3pSQIA06191F1Bylb3AVK0681anW6PxSviKkUT0nlU9r/Jb1OUtAjWYZS4vvW
         /4Ojg9wzcYtz0RVg2UQZThKrexIbl5NF25KttxqzL9LjmwISVxrmFHdPubYJgvFSXxzt
         cXdZuFaKCBzuSCa1k8hyrwO8tfee1Fl7kBEDsnscgb8sUtbrADJI9xK4mQJ94k6VIKNf
         Xefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bermH+qcfg6fxNhcwx32poEW88kaY2/q9KQrNfCSlPQ=;
        b=FMwN7B+XTR+D/5B/8YKk67D1X8wqUpcLmH1xnXeS6gZShRDaJ+5dPuS15kG7fMc2fn
         RE/7ffakjDGBVURc1cy4XuNwuRDaBhW/PRx1zsh5rwYm4LNCxXsRRTN9nZfUmExpnTZt
         mUc9YEypUXsUW9pPY3aGshOPsFZlm7XbXuXD9f+A6jWQh2nW0GP6DqlEELVT5aH5MgqZ
         CxuduFfiFjT66scHbz24f/6LSXTXaph99aOY1LYQ4W7Art8nC721E7+K6/oD4W5g+yST
         5RiF2TWVjgIbePE83z3ok/wX0nQ4DFdvoIDs3SD+UKoenZfRNc8goQoAAk1VpxAjXi7W
         pFPw==
X-Gm-Message-State: APjAAAUR8UNTedTWpEMQFkXV5wtID7RTmoHEwJRrClTEu6W1kcqXnbok
        h0QXyTjtMiyiaS+TLB3LAsw=
X-Google-Smtp-Source: APXvYqzT8zGzHXXA2zK0OdewB9tDHNRgs+9RlodpqnK/TSztmza/lZ0n/fjUBX9GRLr9RiaQeH0TWw==
X-Received: by 2002:a19:e20e:: with SMTP id z14mr16843748lfg.43.1557828872162;
        Tue, 14 May 2019 03:14:32 -0700 (PDT)
Received: from localhost.localdomain ([5.164.217.122])
        by smtp.gmail.com with ESMTPSA id v2sm3126359ljg.6.2019.05.14.03.14.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 03:14:31 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] tty: max310x: Introduce max310x_one port macro-wrapper
Date:   Tue, 14 May 2019 13:14:10 +0300
Message-Id: <20190514101415.26754-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514101415.26754-1-fancer.lancer@gmail.com>
References: <20190514101415.26754-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uart_port structure instance is embedded into the max310x_one
super-structure, which is accessed by some of the uart-port callback
methods. In order to improve the callback's code readability lets
define the to_max310x_port() wrapper which just translates the passed
uart_port pointer to the max310x_one one. It is also going to be
handy in future commits.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/tty/serial/max310x.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 4ee805862b68..527f1476c24a 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -259,6 +259,8 @@ struct max310x_one {
 	struct work_struct	md_work;
 	struct work_struct	rs_work;
 };
+#define to_max310x_port(_port) \
+	container_of(_port, struct max310x_one, port)
 
 struct max310x_port {
 	struct max310x_devtype	*devtype;
@@ -765,7 +767,7 @@ static void max310x_handle_tx(struct uart_port *port)
 
 static void max310x_start_tx(struct uart_port *port)
 {
-	struct max310x_one *one = container_of(port, struct max310x_one, port);
+	struct max310x_one *one = to_max310x_port(port);
 
 	schedule_work(&one->tx_work);
 }
@@ -858,7 +860,7 @@ static void max310x_md_proc(struct work_struct *ws)
 
 static void max310x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	struct max310x_one *one = container_of(port, struct max310x_one, port);
+	struct max310x_one *one = to_max310x_port(port);
 
 	schedule_work(&one->md_work);
 }
@@ -981,7 +983,7 @@ static void max310x_rs_proc(struct work_struct *ws)
 static int max310x_rs485_config(struct uart_port *port,
 				struct serial_rs485 *rs485)
 {
-	struct max310x_one *one = container_of(port, struct max310x_one, port);
+	struct max310x_one *one = to_max310x_port(port);
 
 	if ((rs485->delay_rts_before_send > 0x0f) ||
 	    (rs485->delay_rts_after_send > 0x0f))
-- 
2.21.0


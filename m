Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12365C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 17:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2F92467A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 17:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ndUwWqTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfLORwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 12:52:14 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:44340 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfLORvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 12:51:39 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 47bX5k2RC7z9vKZ5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 17:51:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HGqvoaOhvsiO for <linux-kernel@vger.kernel.org>;
        Sun, 15 Dec 2019 11:51:38 -0600 (CST)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 47bX5k1KLsz9vJbS
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 11:51:38 -0600 (CST)
Received: by mail-yb1-f200.google.com with SMTP id x18so4724080ybr.15
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 09:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2rmODKEIc4MD7niBVNAG3srAMkULqKzaTtL5GsTPKr4=;
        b=ndUwWqTOV8eJgWkt3A+zimBNrqZgOkk4mx82UHJiTFnfV5SPWHQQ/3mOwqM+X/lEcD
         wHihFytVBZVKo/KzHSkPWexBwaXWsEElfLMoJlUxL5qOFl/BgxyPAZckxakspyZFRKAy
         QNJinof2FUVltCN4q1Ozd4YV28BwwPHedse8GA1De8GQgA0zCG94iA4bj9Lap8qylAfC
         6/68JxtNZ/oxCXTc0ddGKRUhrqI5Nh5DyEsqJd9+OZZ6HxvR9R72wY6yqCuPWVXfze6Q
         1fTKElcBSqHUBAWzDe7F31mkJv4FO757xdIJ4cQWKeAV977SVLjQnQAyKcLfUDVwrbuq
         TaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2rmODKEIc4MD7niBVNAG3srAMkULqKzaTtL5GsTPKr4=;
        b=tqE0js+/6CjMDUCDPsgIId37HGXKF3n1pA2Hp3/OP6sCfTQA2QRKGifuwrbXd/Bmou
         K3ObkSy/pu9u/gxO0rh1/iBOqmS/xltV9jbDQvwkg32PNwgCooSfjesBVB5i9eRD/iCR
         7UelrfVVYAYwMN80feSoM5tIEOd/j6DoRUaOlnCjT2G5VH+PD/KCSbbZtL8Kgv9SoVK6
         OPsjLZnpcTrSAmAok8iuHCLvjTlgG+4Sb3ixfHEoVFmHb1Xiojxuf3YLYK1OaP+bVxnM
         3Bd5VxvTcA93YM+Na7znghJd104zY6tVz6ppALlP4M79JmUdEItAqDpKL77zmvlO7V2N
         4pvA==
X-Gm-Message-State: APjAAAXtoftvR9OqO/cZBYBfC32qQxs7I19Gd9MqDFS2lCb3zcno9vD3
        wf9j6aSyEbj9HzdGc/Uo8psHMgKn8sYxzhO0E6osnREeZ12J3tSFKi7POmkw2czeGWRZYoR+rDs
        MOJfkOmo5F94MtMvB2tIyGgMo51SU
X-Received: by 2002:a25:4290:: with SMTP id p138mr13981237yba.112.1576432297513;
        Sun, 15 Dec 2019 09:51:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqw0HHeIjcH7OnOW2tenzQrKmWXlYm720LYOj55jH+SMODNilD9yyzR9CazJpICeyA4QsooJTQ==
X-Received: by 2002:a25:4290:: with SMTP id p138mr13981225yba.112.1576432297273;
        Sun, 15 Dec 2019 09:51:37 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id g5sm6210011ywk.46.2019.12.15.09.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 09:51:36 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yang Wei <yang.wei9@zte.com.cn>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: caif: replace BUG_ON with recovery code
Date:   Sun, 15 Dec 2019 11:51:30 -0600
Message-Id: <20191215175132.30139-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In caif_xmit, there is a crash if the ptr dev is NULL. However, by
returning the error to the callers, the error can be handled. The
patch fixes this issue.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/net/caif/caif_serial.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index bd40b114d6cd..d737ceb61203 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -270,7 +270,9 @@ static int caif_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ser_device *ser;
 
-	BUG_ON(dev == NULL);
+	if (WARN_ON(!dev))
+		return -EINVAL;
+
 	ser = netdev_priv(dev);
 
 	/* Send flow off once, on high water mark */
-- 
2.20.1


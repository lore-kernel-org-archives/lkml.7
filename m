Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E44C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 00:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D696222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 00:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BG1oNkKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfKTAHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:07:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41037 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKTAHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 19:07:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id b18so24586878wrj.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 16:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7u0vuDrO1PbhdaGTzNJSFWi+UDVK44G/M8ptTaBTUJY=;
        b=BG1oNkKOsdGxpHa+T5K+FowoOxps2wPnyI4wb7xyvV2j9bB71Nk6I6g0fcSfn4uS2U
         WKqlYyTJOUF3jGHQq0en/UuqiiSdcknpOURglq/HmQHThjPPY0I81XYN1SgRa+K350k9
         K7ceBV5CTkyJU3hV1y9SMYaYU6Z5jJ8WDVuOUgpYIwR1do2nu/aOCYGWUA20+ak61qHg
         kdwDQ1VFHVoy2xW+Hnc+gQLGfdLYzhzh1Y+mL4UCzRWnX0v91OHpUCMvoGr0XT4yEoQB
         YdpHHs6fHZhvH/kA9wSUM4Nwe3YAQilB3FPo2UWGbZtuEKhcu8ar6dG9ua7l0eiLjMXp
         7yTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7u0vuDrO1PbhdaGTzNJSFWi+UDVK44G/M8ptTaBTUJY=;
        b=s17ovONhknY9G1F9wiXDPvdPn0QoJAQj1iHUfCr9Hony6+KT8RtcAscrAxG65W2W+4
         jwR3b1kIQpTeczCl2DjSnRXqPQUZoTfhsYae3nYjqRXyuS7AlgE/eTBzBHXoeWIA9pWo
         jFAIN53ttRklTg3kEDO1kING9ZD/AntJpAow380KeYvSnMdASMLy3r/qzpfKr9ha/IUh
         tPkrVTRhGL807Z3/10hHNZcu/KXWKCRIYeMI2qzG4/Pa+216mJt82CD6RN4Pdpy20QH7
         2Z6Ou4df44ADiZuzqCu/egjxFtIe2FEZtSteC6OhhMtofHUU/LnjQYQ167RIk1d8Qgz9
         0oWQ==
X-Gm-Message-State: APjAAAU/baB+zF1z1Vf1qkTLFe1+cwKVRqWZWAQgQwsQNBzXqESSXERK
        ChipXdIyB7j6KvcoI+orQ12+xbF6
X-Google-Smtp-Source: APXvYqynXZV5DmNKwcF41YMQI+zkMN2y+tT+EDVTDe/ER3FhFgZXekgKmDf/npYjX2nka84iVuLfLw==
X-Received: by 2002:a5d:574d:: with SMTP id q13mr94016wrw.263.1574208426257;
        Tue, 19 Nov 2019 16:07:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:40e1:9900:5dce:1599:e3b5:7d61])
        by smtp.gmail.com with ESMTPSA id c11sm15073776wrv.92.2019.11.19.16.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 16:07:05 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] aspeed: fix snoop_file_poll()'s return type
Date:   Wed, 20 Nov 2019 01:06:47 +0100
Message-Id: <20191120000647.30551-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snoop_file_poll() is defined as returning 'unsigned int' but the
.poll method is declared as returning '__poll_t', a bitwise type.

Fix this by using the proper return type and using the EPOLL
constants instead of the POLL ones, as required for __poll_t.

CC: Joel Stanley <joel@jms.id.au>
CC: Andrew Jeffery <andrew@aj.id.au>
CC: linux-aspeed@lists.ozlabs.org
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 48f7ac238861..f3d8d53ab84d 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -97,13 +97,13 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
 	return ret ? ret : copied;
 }
 
-static unsigned int snoop_file_poll(struct file *file,
+static __poll_t snoop_file_poll(struct file *file,
 				    struct poll_table_struct *pt)
 {
 	struct aspeed_lpc_snoop_channel *chan = snoop_file_to_chan(file);
 
 	poll_wait(file, &chan->wq, pt);
-	return !kfifo_is_empty(&chan->fifo) ? POLLIN : 0;
+	return !kfifo_is_empty(&chan->fifo) ? EPOLLIN : 0;
 }
 
 static const struct file_operations snoop_fops = {
-- 
2.24.0


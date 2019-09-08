Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83BFC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88455216C8
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946641;
	bh=mqnRnbDGslsvYo8EJuwu7K/kmlaG/SNDh43N8rER6D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iNery+Fmsw293RaeJLVfwHdohjkflgceLI0WPkhcm0wyR+Ti9mBWbqPhC8x+UnWGc
	 Ongkv7JtiIJ3sbPaUAsFJU9yetVRSSkz6fHy6QXDy+6n8CToZi5tSUw71L8RXMxWih
	 ronAoGqH7hwGuz0nHMjtV5Q2GfVIuS1K1Zz17WgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfIHMoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbfIHMn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:43:56 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CDA121927;
        Sun,  8 Sep 2019 12:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946636;
        bh=mqnRnbDGslsvYo8EJuwu7K/kmlaG/SNDh43N8rER6D4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KCPiUKcdvF2vQcUQXRBXtl2FKI5JOIcR/px25JrGneie+khx4hzAm98d+jJJR7i/L
         uoOR4RVvAY0koMbEnW1uemmglzoFMV5TqWHv4Ooe7eboHgXFFV/RSP0QAE9N/2Afxh
         pqcCaHhf3Vqf+3j0JFvfcYqdg+u0QaGJiFLHJJUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 10/26] wimax/i2400m: fix a memory leak bug
Date:   Sun,  8 Sep 2019 13:41:49 +0100
Message-Id: <20190908121100.927195462@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121057.216802689@linuxfoundation.org>
References: <20190908121057.216802689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 44ef3a03252844a8753479b0cea7f29e4a804bdc ]

In i2400m_barker_db_init(), 'options_orig' is allocated through kstrdup()
to hold the original command line options. Then, the options are parsed.
However, if an error occurs during the parsing process, 'options_orig' is
not deallocated, leading to a memory leak bug. To fix this issue, free
'options_orig' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wimax/i2400m/fw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wimax/i2400m/fw.c b/drivers/net/wimax/i2400m/fw.c
index c9c711dcd0e6b..0e6c665a4de82 100644
--- a/drivers/net/wimax/i2400m/fw.c
+++ b/drivers/net/wimax/i2400m/fw.c
@@ -351,13 +351,15 @@ int i2400m_barker_db_init(const char *_options)
 			}
 			result = i2400m_barker_db_add(barker);
 			if (result < 0)
-				goto error_add;
+				goto error_parse_add;
 		}
 		kfree(options_orig);
 	}
 	return 0;
 
+error_parse_add:
 error_parse:
+	kfree(options_orig);
 error_add:
 	kfree(i2400m_barker_db);
 	return result;
-- 
2.20.1




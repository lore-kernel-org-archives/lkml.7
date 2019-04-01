Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A656C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C93B20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139493;
	bh=qWusleb1uBZSJIpwMbpvYnOvvfg8rIi5ifQWj1ezM0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Aw9QtQDTMM1ymoXyTKBxHS2ecNLcqB/AmTlbsFkzvgHAZfVgudCYTwFGNElj5cNvc
	 cUu2X14UzV4Ae7Az5XtSaA6fUKI3JdzIrypZU/L4HQ9aepqVa0xPx+h6DoMWlHF/O4
	 PgqHUlljQjc6QSFP7xCrsX4Fzr1G0FcEYrtswvBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbfDARYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731889AbfDARYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:24:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D26C2063F;
        Mon,  1 Apr 2019 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139487;
        bh=qWusleb1uBZSJIpwMbpvYnOvvfg8rIi5ifQWj1ezM0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kfnXMTUMhDtqM+2FrlvFjyobqJ9XkGOCOzvKFYyBn93yXUDD8+/eiTm8IAj/u3U1j
         C1poyG5P+Xg+Mz8S8fqcCaB1fTPVP28TgMXwyQX4zg7GrcboIFkw2sGB/ML2zfquPB
         DLSgKqpNet5Qbau5K6EZuaZnM/a9lwxZhSuXLOP8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4.14 091/107] gpio: exar: add a check for the return value of ida_simple_get fails
Date:   Mon,  1 Apr 2019 19:02:46 +0200
Message-Id: <20190401170053.961895928@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

From: Kangjie Lu <kjlu@umn.edu>

commit 7ecced0934e574b528a1ba6c237731e682216a74 upstream.

ida_simple_get may fail and return a negative error number.
The fix checks its return value; if it fails, go to err_destroy.

Cc: <stable@vger.kernel.org>
Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-exar.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -148,6 +148,8 @@ static int gpio_exar_probe(struct platfo
 	mutex_init(&exar_gpio->lock);
 
 	index = ida_simple_get(&ida_index, 0, 0, GFP_KERNEL);
+	if (index < 0)
+		goto err_destroy;
 
 	sprintf(exar_gpio->name, "exar_gpio%d", index);
 	exar_gpio->gpio_chip.label = exar_gpio->name;



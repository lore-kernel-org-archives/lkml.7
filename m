Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AFDC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0179C206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igxoj6e4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbfDWGZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:25:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44392 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDWGZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 02:25:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id z16so2437112pgv.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 23:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RaaGcTzhI0SDxCVukGPZqJTxviymuimG+0pW1Zook1E=;
        b=igxoj6e4d71VSplvzcgfh/aXS5Wto6zRfIlI4XOE5i8Bnx/GEe9uRgV03C3nI74NJN
         gFdXkhYgHOjTCoGgA3oU8xYt1T7p8+ZsOcrTQFMY7o4odCLvaV/9mj81539a9DjXOuIG
         bGGc9WTC/dxH/BorS7ZcGgpGpEVuKBxxIBR41yms2fHLREMT+2dKVl89Lfnzms2TUosr
         UtEFeeWyV1+CPNa2hOdRzuLrwo8zZbXydw5UErHsL0FfPpgmWcJkUuOsL8es3gEaR3eB
         a+v0rQnBFLfVg/WLW9qOpzWRQffTtSuNPI1WofXymJiZfoqSpF2hGDg2s/9wjqEU7z1e
         vDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RaaGcTzhI0SDxCVukGPZqJTxviymuimG+0pW1Zook1E=;
        b=D+DDQUt2P7cXILWuKUTrkVqByKHvhV4C3tAC3OskYb9kjzT0D4maDlpKLXLqx99m3Q
         nRvRm1HFSN6L4sLoxn+Qlv6q9nJvjjzXoH6WK74k59S5KwRR8EtjVo1dZ+idFW70VVuI
         Vv/KVNKXGBhCVJ+uLE/eA7VgHqVHOCSsogmMv2/+5ulyoT1HdDg5pk+EhQ+h6aXBL6eh
         ih6yQpjdMYO/+oorqbyG6IVWJXTzlEG9LOM8HtHpQ2tgXoywpdqKpWUS4VpjM6mdkuzd
         wyIlob49+4fvKH9FIIqDUgD1LI97qfDF3FyYhB7f7oAsF5kmBubx0lGnuWkvYfm66JsP
         rPiA==
X-Gm-Message-State: APjAAAV6WaTs2U6X/fnexTZMxxfc043p5e1LlSl3csJ25NhNEFQnInSx
        oOoz467HVOPqhLHv42WDkpRtuw4A
X-Google-Smtp-Source: APXvYqwzarnB9xzUvmDFbCaK6QbmtaL/b+1tiKSulvpSp5SthU6MKKBTjfMfITjKnKNT9Qx4hfZs6w==
X-Received: by 2002:aa7:9a99:: with SMTP id w25mr2567796pfi.240.1556000719974;
        Mon, 22 Apr 2019 23:25:19 -0700 (PDT)
Received: from localhost.localdomain ([175.223.38.143])
        by smtp.gmail.com with ESMTPSA id p3sm19490287pfn.167.2019.04.22.23.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 23:25:19 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCH 0/2] Access console drivers list under console_sem
Date:   Tue, 23 Apr 2019 15:25:09 +0900
Message-Id: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr, Steven,

	RFC

	Normally, we grab console_sem lock before we iterate consoles
list, which is necessary if we want to be race free. The only exception
to this rule is console_flush_on_panic(). However, it seems that we are
not fully race free - register_console() iterates console drivers list
in unsafe manner in several places. E.g. the following scenarion:

	CPU0					CPU1
	register_console()			unregister_console()
						 console_lock()
	  for_each_console()			  // modify console_drivers
	    con->foo				    kfree(con)

So I have two quick-n-dirty patches, which remove unsafe console list
access.

What do you think?

Sergey Senozhatsky (2):
  printk: lock console_sem before we unregister boot consoles
  printk: take console_sem when accessing console drivers list

 kernel/printk/printk.c | 117 ++++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 48 deletions(-)

-- 
2.21.0


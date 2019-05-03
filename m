Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B133C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BF5206E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E1kHCtY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfECXfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 19:35:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40080 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfECXfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 19:35:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so3633965pfn.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 16:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SHEjHfO9A5bRiMAqWYWHqc/8OGhvcUxNJFwk8XrvHsE=;
        b=E1kHCtY3StjY2jL6mVYyFBDOHkYOyxkDZHKrjgcQsUNJy8dDwNhCXMPstgxWlAWDVu
         N6/tKl0/5fSaSVUZeI/AswN2edBTfVnN7rBh5z5LP395vsJXAlfWtuvsqNrYQVbSP7/9
         hwBMR6j63Xx/mEajgFYbn6QXfKqogcl8pxheQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SHEjHfO9A5bRiMAqWYWHqc/8OGhvcUxNJFwk8XrvHsE=;
        b=DwWl7Kr5aUZlsXFWOUCWcCPlxE0wcJQk+7eIwiPWEovnFhxO9TRbXXVeaj/WXSKQp0
         eiq+caAWnYyXPA2sDRpEB0hDkt9rt+oHezb74oCWYvRWLYYrrUM6IH43b+9jPFqTBycP
         eRohTIYYO8zqkj421gRiNrT7pw8POuEo+Hb9KEZpVi+fo1ixkbQ+Z3+zJo0aUrOW6L+7
         afTeMQIYdw/zUbnSpYYya+8TGeFFTZ/pACMUcK7gDHL23zoPF4JX+X8CiS0zJydqeQEQ
         TeVHYmg14V7AhqxVNu1a0IJpc+4FKeJVmk4swd36pJ6oxBYb3GwWabNG1zXDewEH4SWi
         nK0w==
X-Gm-Message-State: APjAAAVpgAhxbMxTwAwOdkz6E8sekqUQNL4yL2fSiQ0OPFVb294IzIQi
        kJeY7CFaRbmaDPkHUOizv8EW3w==
X-Google-Smtp-Source: APXvYqxSl2kbX2wBpR+4fMn6q0ci7jtMz8uiaw/Pxs3UtU6+iNJMRtgXKO7o7X0k+XZwbkDsvK4mwA==
X-Received: by 2002:a65:62d2:: with SMTP id m18mr14209583pgv.122.1556926540856;
        Fri, 03 May 2019 16:35:40 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id l184sm7763304pfc.98.2019.05.03.16.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 16:35:39 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-rockchip@lists.infradead.org, groeck@chromium.org,
        mka@chromium.org, drinkcat@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Ming Lei <ming.lei@redhat.com>, linux-mmc@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
Subject: [PATCH] mmc: block: Fix memory leak in blk-mq when cleaning up
Date:   Fri,  3 May 2019 16:35:26 -0700
Message-Id: <20190503233526.226272-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If I run the following on rk3288-veyron-minnie (a 2GB machine)

  cd /sys/bus/platform/drivers/dwmmc_rockchip
  for i in $(seq 1 3000); do
    echo "========================" $i
    echo ff0f0000.dwmmc > unbind
    sleep .5
    echo ff0f0000.dwmmc > bind
    while true; do
      if [ -e /dev/mmcblk2 ]; then
        break;
      fi
      sleep .1
    done
  done

Then I start OOMing somewhere between iteration 200 and 250.  Using
kmemleak, I see reports like:

unreferenced object 0xe39c5580 (size 64):
  comm "kworker/1:0", pid 17, jiffies 4294821091 (age 96.952s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ad19d10a>] __kmalloc+0x1ec/0x2dc
    [<a28614c3>] blk_mq_alloc_tag_set+0x27c/0x2bc
    [<0955ae01>] mmc_init_queue+0xa8/0x2a8
    [<5102b986>] mmc_blk_alloc_req+0xf8/0x2d4
    [<f1c2214f>] mmc_blk_probe+0x4a8/0x6c0
    [<0dfdd9d5>] mmc_bus_probe+0x24/0x28

It's pretty clear that we're missing a call to blk_mq_free_tag_set().
Let's add it.

Fixes: 81196976ed94 ("mmc: block: Add blk-mq support")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mmc/core/queue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 7c364a9c4eeb..09071e13282e 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -480,6 +480,8 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	 */
 	flush_work(&mq->complete_work);
 
+	blk_mq_free_tag_set(&mq->tag_set);
+
 	mq->card = NULL;
 }
 
-- 
2.21.0.1020.gf2820cf01a-goog


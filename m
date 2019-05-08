Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AACC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38C021019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfEHMo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 08:44:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43470 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfEHMo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 08:44:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 29F3D283978
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: Re: [REGRESSION] usb: gadget: f_fs: Allow scatter-gather buffers
To:     John Stultz <john.stultz@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     "Yang, Fei" <fei.yang@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chen Yu <chenyu56@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "kernel@collabora.com" <kernel@collabora.com>
References: <CALAqxLUMRaNxwTUi9QS7-Cy-Ve4+vteBm8-jW4yzZg_QTJVChA@mail.gmail.com>
Message-ID: <3b57eb64-4c25-4582-7b0d-59143060b5a5@collabora.com>
Date:   Wed, 8 May 2019 14:44:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLUMRaNxwTUi9QS7-Cy-Ve4+vteBm8-jW4yzZg_QTJVChA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

W dniu 08.05.2019 o 04:18, John Stultz pisze:
> Since commit 772a7a724f69 ("usb: gadget: f_fs: Allow scatter-gather
> buffers"), I've been seeing trouble with adb transfers in Android on
> HiKey960, HiKey and now Dragonboard 845c.
> 
> Sometimes things crash, but often the transfers just stop w/o any
> obvious error messages.
> 

<snip>

> 
> Andrzej: Do you have any ideas or suggestions on this? I'm happy to
> test or run any debug patches, if it would help narrow the issue down.
> 

Can you please try the below patch?

One more thing to consider is "functionfs read size 512 > requested size 24,
splitting request into multiple reads." in your original report, but let's
try this first:

 From f2b8f27cfa42cafe1f56d8abbe2c76fa0072e368 Mon Sep 17 00:00:00 2001
From: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Date: Wed, 8 May 2019 13:52:40 +0200
Subject: [PATCH] usb: gadget: Zero ffs_io_data

In some cases the "Allocate & copy" block in ffs_epfile_io() is not
executed. Consequently, in such a case ffs_alloc_buffer() is never called
and struct ffs_io_data is not initialized properly. This in turn leads to
problems when ffs_free_buffer() is called at the end of ffs_epfile_io().

This patch uses kzalloc() instead of kmalloc() in the aio case and memset()
in non-aio case to properly initialize struct ffs_io_data.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
  drivers/usb/gadget/function/f_fs.c | 6 ++++--
  1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 47be961f1bf3..41d57ae8bc15 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1182,11 +1182,12 @@ static ssize_t ffs_epfile_write_iter(struct kiocb 
*kiocb, struct iov_iter *from)
  	ENTER();

  	if (!is_sync_kiocb(kiocb)) {
-		p = kmalloc(sizeof(io_data), GFP_KERNEL);
+		p = kzalloc(sizeof(io_data), GFP_KERNEL);
  		if (unlikely(!p))
  			return -ENOMEM;
  		p->aio = true;
  	} else {
+		memset(p, 0, sizeof(*p));
  		p->aio = false;
  	}

@@ -1218,11 +1219,12 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, 
struct iov_iter *to)
  	ENTER();

  	if (!is_sync_kiocb(kiocb)) {
-		p = kmalloc(sizeof(io_data), GFP_KERNEL);
+		p = kzalloc(sizeof(io_data), GFP_KERNEL);
  		if (unlikely(!p))
  			return -ENOMEM;
  		p->aio = true;
  	} else {
+		memset(p, 0, sizeof(*p));
  		p->aio = false;
  	}

-- 
2.17.1

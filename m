Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49385C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162DD20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9fshGZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfCJS6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:58:46 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40951 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfCJS6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:58:36 -0400
Received: by mail-it1-f195.google.com with SMTP id l139so3931834ita.5;
        Sun, 10 Mar 2019 11:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fxgFiCRKgpoCxt3b7qAJzupwn0XavxwiX5uUbpM/OII=;
        b=a9fshGZZ7i/tLOZepomjCBDfixyvFGzizvaDmgosBgbXN7+q1UJ/ZsN5OMR7TXZO3s
         OZsLl6fn5MRTxgtWXvRFdonnegXiOaRpFUqi+BHCHk4QjwpF+oxN+I5uNuEo4aOxZ7bZ
         r3fpKQHgmXCmSfjPDLwXnbs4/ueXM4Q9UrvmuK57Ao1e8UzEoS6wTrrZRp7cJJfs+zJq
         KtTwS33zSuk6UDDDspaMdOJHuUwGaDrS1JU04+N5oLT71uISpVnTdm0I4ZRxnBW7Qa4q
         bc2JXN+ybhDqk23+9lFgSLQBqaT+oyXxRhLcNPTVLQlQWMtEy1zu1v6pAlY60w5GoBuV
         a6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fxgFiCRKgpoCxt3b7qAJzupwn0XavxwiX5uUbpM/OII=;
        b=DgPWsdN8enq2zyHdghRBATd7/CMSLa+akuRkozoClIr1xMi3m/qbNVvc8ZUe3tEHGc
         /VznLSeGbf1n1YgPPVwoQdc3po4s34BUVzWNPHg+zaR8bxl7j9DL/WEDPmE9iaai1hUR
         NW+ILDj/jPMHIdZ8CwJz1ZXLiD1bXhcCefZ47yIPg4Umr+VsdRvaIKAmU1tvpwOesvOU
         w14jSLS0qDy+dZuT34ArOO74SlNBWvOOusWxNoNixpCFUHC6FOgLBO0u23Ce1gQVZAJl
         ATA1eVOCcI/X/KOjTLIILtVsKzcuM9cUOLbGIAssbqUMEFnQTDEir4FwGT24VDlorosf
         fBiw==
X-Gm-Message-State: APjAAAUyAJp3ywVIwh+8gOduqA/fGtnZHItTZvey4TXSZXYa8xgTjCLE
        15HG41w9fn5tFs2JYMP/tT0=
X-Google-Smtp-Source: APXvYqyGASuFsKMDYrVtGpg9O7HRaj1RL78fLP+QSyIZRt5Ha5mt6iBOlsy3QMRJjIlQs682yv+8YA==
X-Received: by 2002:a24:1cc6:: with SMTP id c189mr12881577itc.74.1552244315449;
        Sun, 10 Mar 2019 11:58:35 -0700 (PDT)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id y18sm1359270ioa.56.2019.03.10.11.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:58:35 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: adc: xilinx: fix potential use-after-free on probe
Date:   Sun, 10 Mar 2019 14:58:25 -0400
Message-Id: <20190310185826.25916-2-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190310185826.25916-1-TheSven73@gmail.com>
References: <20190310185826.25916-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If probe errors out after request_irq(), its error path
does not explicitly cancel the delayed work, which may
have been scheduled by the interrupt handler.

This means the delayed work may still be running when
the core frees the private structure (struct xadc).
This is a potential use-after-free.

Fix by inserting cancel_delayed_work_sync() in the probe
error path.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 1960694e8007..15e1a103f37d 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1290,6 +1290,7 @@ static int xadc_probe(struct platform_device *pdev)
 
 err_free_irq:
 	free_irq(xadc->irq, indio_dev);
+	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
 err_clk_disable_unprepare:
 	clk_disable_unprepare(xadc->clk);
 err_free_samplerate_trigger:
-- 
2.17.1


Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2A0C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CA4206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vRQFT89w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfKNJdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:33:31 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:37257 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfKNJda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:33:30 -0500
Received: by mail-wr1-f44.google.com with SMTP id t1so5621935wrv.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 01:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EOgfq2BPgwHks2knL2d8OExj9QUX1YIgf8uJJjgKXdc=;
        b=vRQFT89wvdDqZwisq7/offwKGfwyWniNkpZIiDsHJfvxsQ1UbchI2DPpLn9lLAXRW/
         IFrc0SFhH9crtlUVQhLmvt9pwQbGARfBxuPjyMCFsyQKVmQIn+LfT7RgqRPpVyeK9rtF
         qd57I3IWoRGBlNfRNbG/9Z8X8v92PEjp24F35zd1AkaTfxUox8SfhqQXG4wNe/J1CnlW
         d/D4bM8spOpZ6gr8QnbUFjSFlozkfKlw/Wqme6hPJmZnAlcoIE81dAOrd/h4QCzH7uIA
         IdwUdTA7XprwXhyt7iuIzaAS5mwmRduXhWLuh9V9i1siyK33wm8fQ2svQ9T0Bs+5OIMJ
         rI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EOgfq2BPgwHks2knL2d8OExj9QUX1YIgf8uJJjgKXdc=;
        b=WOb0ChASrD/zzprJ3GTsta8Cj9/BEf0o+5AEPUjMW8MJFelB0rBQlXCcjQEj9rhEli
         8ypYZVAcJQVzBiqDfRM5Zaw1KN+bRB91WEmgIGd59qvAmd3eB04V6coYRsXf0qSZahnS
         2bE2B67cqzwwWpiYc9VjRqU1CyD32fQL4GhIu5f20WINGyl2swDgXciih94Bz0fAUY5C
         sqdxnqVrFx6WhWU6H4OG3S5u7zBjE/pWp1uWzm9tQf7ntcuf66Wme3BJHTLzg/YuQFgV
         5P9iVQxWmc9fvgZHYqveMH2Sk2WM+46V2TlIh6xHZJWgw9jAfY7heR8q4Qz2ptKlVKCN
         sPrQ==
X-Gm-Message-State: APjAAAVDKYKF2bBiZb4h43g/w5rN/1HiAXsXyhww1jVyBS5C0M9jE96+
        jDI1OZrb8Clxb8wqiVMsxp4Kaw==
X-Google-Smtp-Source: APXvYqy3krbp6mthMNl4YSw918Ql+MakUswnHylyA3IVbydYKB9uj45ZzlRyWYZGgm2E6r3pnOfv5w==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr4194906wrm.106.1573724007087;
        Thu, 14 Nov 2019 01:33:27 -0800 (PST)
Received: from localhost.localdomain (hipert-gw1.mat.unimo.it. [155.185.5.1])
        by smtp.gmail.com with ESMTPSA id j22sm7523409wrd.41.2019.11.14.01.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 01:33:26 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        tschubert@bafh.org, patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX V2 0/1] block, bfq: deschedule empty bfq_queues not referred by any process
Date:   Thu, 14 Nov 2019 10:33:10 +0100
Message-Id: <20191114093311.47877-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
change from V1: added check to correctly work only on bfq-queues
scheduled for service, and not on in-service bfq-queues (it makes no
sense, and it creates inconsistencies, to deschedule an in-service
bfq-queue).

Differently from V1, which was still under test when I submitted it,
this version has already been tested, by those who reported V1's
failures.

Thanks,
Paolo

Paolo Valente (1):
  block, bfq: deschedule empty bfq_queues not referred by any process

 block/bfq-iosched.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

--
2.20.1

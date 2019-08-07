Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BC3C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A542721E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtISrsFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388294AbfHGOSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:18:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35864 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729887AbfHGOSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:18:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so235774wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 07:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mc2ZlcblJhTCc+59eGdVPsvblxllT8VyGaJItyjpB/U=;
        b=gtISrsFZCjjXtWqiQNCjpzLIWGuM/+IhT7JFDnhj4FBJVznjoG0Is51Mmg7bMKRuwS
         7P623IAy53MkhCtdn95Pe1EnLV2dFZM14VG8dWPOHT6cgY4IHbS00vx44K6/GMIt5XyG
         PiCc+ZLpZ7yr1VX455Vx9gxFNpuF6yCEvU0FvyeFnpy85m9nOInvipRC6BaAwQK0sfDl
         WngxOlh8MvEdYCrLXGhwUCcKs9tnLUlGDJTpAxSSrZHDImTfQqbN29U8m7d3EAQAnKpE
         D/SUjGmqxFVyAutxLzHrOLDFNlU7QwAsRLSQixa5pNkgKymPgHXYo9tt9m0+LBnjLmMb
         i+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mc2ZlcblJhTCc+59eGdVPsvblxllT8VyGaJItyjpB/U=;
        b=WhwT+tlNooWncogQD/8LtyENRnTnPs4DfFVmsEbdFeSk7q9nkV4viAlAdhoQLAOk/9
         7N+h2n74MZd18GOXaLPqsauZjDFLm9R3+5+yNkmUEtANDuCyuyPgSZinaPeNUBrthKiD
         UBt/jPOUz1cwAQGmpDJVqZf3pxBS5tMs/1sVV21pz222/TRUHqXZJStGC7urasur1WfU
         dkX/M2Ruk90xXZaYHEvGIF+6sgiNdo5MUw4rfyumIDPSd35l4Q/8MaiPKc5cfj4iLOxr
         PAWE3j6N97Jj2XHycQ7t6+tgC1WAoEk35JGDMSWO0w8XcC5Nf/q8tblZtfLCg8Q5uxOH
         w2BQ==
X-Gm-Message-State: APjAAAWdLce1k2rXa79hwSJ6K77TMsrO3gmBd3ySFyJCJL699sdwvtXH
        Sc9j017dpHA33mSjqpieNJ+dvg==
X-Google-Smtp-Source: APXvYqzYG4CIe1Bwnxo9d1jeqnUkHMU8b8dTEy2YSl2PeEsHYLWqmOdJv6c80SkEm7W9JOgag1f1mg==
X-Received: by 2002:a7b:c40c:: with SMTP id k12mr211035wmi.122.1565187486831;
        Wed, 07 Aug 2019 07:18:06 -0700 (PDT)
Received: from localhost.localdomain (88-147-66-140.dyn.eolo.it. [88.147.66.140])
        by smtp.gmail.com with ESMTPSA id o7sm83472wmc.36.2019.08.07.07.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 07:18:05 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        pavel@denx.de, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 0/2] block, bfq: fix user after free
Date:   Wed,  7 Aug 2019 16:17:52 +0200
Message-Id: <20190807141754.3567-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
this series contains a pair of fixes for the UAF reported in
[1]. These patches are the result of the testing described in this
Chrome OS issue [2] since Comment 57.

Thanks,
Paolo

[1] https://lkml.org/lkml/2019/7/27/254
[2] https://bugs.chromium.org/p/chromium/issues/detail?id=931295#c57


Paolo Valente (2):
  block, bfq: reset last_completed_rq_bfqq if the pointed queue is freed
  block, bfq: move update of waker and woken list to queue freeing

 block/bfq-iosched.c | 54 ++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 18 deletions(-)

--
2.20.1

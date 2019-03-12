Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7EEC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC202171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="CbkznmpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfCLRd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:33:57 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39052 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbfCLRdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:33:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id m13so2730643lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X6N5zivr7b9gV8h5d34MOFPVTMuRPmnipcPRFxSXQug=;
        b=CbkznmpHO9VH3IoEYzc2KVudPHFJ4bUScT313B+pCUFJ3EiIUanjbd3NvMrdaMIkpO
         QfmPu4/OcYuh4CJarONkw1yrIYmVamTAeb4z7by5l/6cumtPZAs2BCrRSh9KQz+wtdjX
         JgMnxY+JjfaamSzyflk2S6242YV+xfozJDqnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X6N5zivr7b9gV8h5d34MOFPVTMuRPmnipcPRFxSXQug=;
        b=HzIX3VOOTnRhsqrZEJxbZ0HMeefg9RswRY/jMtQ0Kqz1aTL8/aP8FhispuFOPLc7pY
         Wz8sPW3f23FO06K+Smz8YgOJLUTxxTOUJTNNYEg3NHzmOSreOLabYsFzSSBgj3MJR0PR
         77W60C1KCVKiNiqrKyl0iVTLbRMEXF8pDaiIWAwfTF7r+8WIT7t6AK2bamoY+Djjqiqh
         rmfeAsZ2ubyh/8solPkPQwXZhcIbEn2y8CLn6KCeITBZDsxlhuKv+VKj97oDbEv07V1o
         3e69rva0Ts6RHpviidYbofzxfDdNDG/yQxXGVoZfLlnf/vdJmKIaYtTu50SaLUi0O6p5
         Rq1A==
X-Gm-Message-State: APjAAAUXIy3Mi/YxBqkDpKj/bsZqeYzNlOR45z539pyRGprNe9gnYxFr
        6c/yGiYXTpnadk20ksMiJ9LbFw==
X-Google-Smtp-Source: APXvYqxPfAVZ/Np68EkaPppOejTRM1pP5AodAEQSgcshG35ziO25LVRTsJczbsKW1HvPziOG1NTXKw==
X-Received: by 2002:a19:4f06:: with SMTP id d6mr9792039lfb.125.1552412032748;
        Tue, 12 Mar 2019 10:33:52 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id j5sm1473609ljg.47.2019.03.12.10.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 10:33:51 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>, stable@vger.kernel.org
Subject: [PATCH 0/4] irqchip/gic-v3-its: free_lpi_range tweaks
Date:   Tue, 12 Mar 2019 18:33:45 +0100
Message-Id: <20190312173350.4025-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that the O(n log n) behaviour of free_lpi_range could easily
be made O(n) (patch 4), though I don't suppose n is ever large enough
to actually matter. While there, I also stumbled on two other
micro-optimizations (2 and 3).

Then while writing the commit log for the last patch, I noticed that
the cmp callback I was removing was actually buggy, so I went back and
added a patch in front suitable for -stable. I'll leave it to others
to decide if it's important enough for that.

Please note that this is only compile-tested.

Rasmus Villemoes (4):
  irqchip/gic-v3-its: fix comparison logic in lpi_range_cmp
  irqchip/gic-v3-its: move allocation outside mutex
  irqchip/gic-v3-its: drop redundant initialization in mk_lpi_range
  irqchip/gic-v3-its: make free_lpi_range a little cheaper

 drivers/irqchip/irq-gic-v3-its.c | 75 +++++++++++++++-----------------
 1 file changed, 36 insertions(+), 39 deletions(-)

-- 
2.20.1


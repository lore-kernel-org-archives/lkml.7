Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D349BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE912171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+PVTRlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfCMOzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:55:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36326 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfCMOzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:55:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id g18so2361254wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xq5xuArj+nE91z6fZSGSl2NseziKxs7lUXJaedIKnjw=;
        b=U+PVTRlfD3oyZ31XbiERHHoJqGtGX/r6lkXNXkBTpj/JxvJGaVlITg2X3yu2Vc5yIU
         dIgP7XbQPShsvpVa/pSdlyBWAcZDLLBTdKPlhuxPzF83SNsUQkLDZO3TN7LbFozkq4BF
         Kxis6ubqgJSxYIeqLSlgdit3pMbtUElK/XZ7jXAFGbxU7tKpDhajmtiPvXi6TgMKGXf1
         4d0GK8s+RFHQbdfuRGIW4h0+yVEYuX5rlnWt5VOru9H240qRTYryFamhmI3Xz3bnYAsy
         rEoD8G15skRrtjX9qp92mA6YDJya4IGXlrchejl9cV8h7uhgMXnAnD3qfL9pjLgs6uOv
         0stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xq5xuArj+nE91z6fZSGSl2NseziKxs7lUXJaedIKnjw=;
        b=Gm2bp2Cj40N6qjCkRCGMz/mQDsWh8JW40VzAgELPi0oA6pA/OuqzJSUrkDNz6YyiHB
         q41xCNpxYImgRjASqFhSL2bLcPc9565E3hY43Qc7EL2PJ57FGR4wRtwiQoKYp6sHQ3Qv
         GgnjGkaT+0iCrI5cpSyOSmGg6c9o2+47zwn3tcy5sH7mevoZjx1iod+oXMz1yNpS1CfE
         /YBKhUnV8z270krJESnW+/EIbpeTEIOXaWVR9GubzoeaG0alhL8rm0agNRqO3OZUAMkV
         iI0ZoqEurP86D81tX4fwoFLnaCSTxy9sH+jd6eta6q55TKE4RgwfjDoW/kKtiO2MLg8x
         GOdg==
X-Gm-Message-State: APjAAAV4TDqXb3HNqhSbr5Y3xX3k5OWEjPjAWhU/V2z9gf/eeY0JENx1
        btz5QetcKlonGSdK87OysA==
X-Google-Smtp-Source: APXvYqyGPPnYKGM7rK1VJOHHzoGSWpmOGKkQ2drs2DHC74YiBptoe17VFeaBYpfMArKTMcIh/i3qNQ==
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr8015241wrq.189.1552488943213;
        Wed, 13 Mar 2019 07:55:43 -0700 (PDT)
Received: from localhost.localdomain (cpc102034-bagu16-2-0-cust471.1-3.cable.virginm.net. [81.97.71.216])
        by smtp.gmail.com with ESMTPSA id p68sm1329218wme.45.2019.03.13.07.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 07:55:42 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH v3 0/2] SPDX Cleanups 
Date:   Wed, 13 Mar 2019 14:53:18 +0000
Message-Id: <20190313145320.26782-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This v3 corrects grammar and ensures it is ccied to the right
maintainer

Jules Irenge (2):
  staging: rtl8192e: add SPDX GPL-2.0 license identifier
  staging: rtl8192e: remove boilerplate license text

 drivers/staging/rtl8192e/dot11d.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

-- 
2.20.1


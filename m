Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A040AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FDE205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="E6SvlpoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfCOD6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 23:58:50 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:39930 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfCOD6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 23:58:49 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 3E4A7D2E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 03:58:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q5_HsMLEF-_A for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 22:58:48 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 0E4DED43
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 22:58:48 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id a9so5981764iol.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 20:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iLUkp8oVLq+kPOC38MJgOVEnJVsUq0i1VhMkxALVLd0=;
        b=E6SvlpoEwPWeiJXvJnhaDGPXNWHFg5Ns2SIKUPqI6Fiy01XUyf0+cYYnyrZLMpScOm
         +jKQPH08Qi53FthfV3vceJ7LekOzZ1X8J63f+PwlRXVSeKYXGDXpHx7j5LTF3lP0ahcU
         RFjyuhlKRxZZj4yRFi8qWNjDK9EwNgPqPENRfJxtk8pBUN4sTIIbB6hfGFFxJCX2d6C7
         OQjmwkMvbl0z8x0FTEUq9NIDKwvO66X/c2zB1lZ2fOR1i06ysUnoSohKqDqS/G5/U3Rw
         119KWA8FJmAlJuAnk6iz7w22CmwqJQvm5X+Bw3VODMZhFCEX60GgCypk++HioMNoqAvN
         ne2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iLUkp8oVLq+kPOC38MJgOVEnJVsUq0i1VhMkxALVLd0=;
        b=NVAHY0bonCcv/iHIGUylCBJ8Y/uaYX++x6zI2/AjqMAsa9WnXcPrE08AoeIjra3Qi/
         qxo+X4S5qIAGYl1f/nWQ/jtTAg2W2VkG2bTo2TVlwZ1oeaEhv0WXcxxXEHrr1w74Tf81
         t/dKj0JYvtEjANi6S+0LV8SPTfUrxv5YxK/BjE2Q9ZhhsFrRxZAlO6PIJ1W+FWZWMjSq
         6MKt80GznSMnMErxyukmkVfQKCjMiDu3Mt22qgdfMxVPub1UHrsPq5eqyMnVjh9NEXQk
         33bX6eOtEoNqwQA15fF72BkRZ2+utwzGAk1fot4d1wNYjMp8/vPUftqgGUcHuagwZUqi
         dpYA==
X-Gm-Message-State: APjAAAUMFRp/qLDXdKqTFWdq0oGg+desqfBefTL1io5D+0SHn+b7UvKl
        hRw9qE+FNrZu76FW0+AtvkTytahfL2e+2wbopXuB4I8Wq0icOyk1zg+VsPig10atk7FXPsP+6MK
        qpvnSgwSqiuvAOkSjDVwsp8sLFov7
X-Received: by 2002:a5e:c604:: with SMTP id f4mr865495iok.263.1552622326624;
        Thu, 14 Mar 2019 20:58:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwgUYeDx9rAeox18Vo0FsSk0JDVjFOsteVA7vc7GpjHVd+B8wqpiSbzaPVaqMHEGIuTx1mJ/Q==
X-Received: by 2002:a5e:c604:: with SMTP id f4mr865481iok.263.1552622326390;
        Thu, 14 Mar 2019 20:58:46 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id x191sm552885itb.8.2019.03.14.20.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 20:58:45 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: echoaudio: add a check for ioremap_nocache
Date:   Thu, 14 Mar 2019 22:58:29 -0500
Message-Id: <20190315035830.29557-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case ioremap_nocache fails, the fix releases chip and returns
an error code upstream to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/pci/echoaudio/echoaudio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index ea876b0b02b9..dc0084dc8550 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -1952,6 +1952,11 @@ static int snd_echo_create(struct snd_card *card,
 	}
 	chip->dsp_registers = (volatile u32 __iomem *)
 		ioremap_nocache(chip->dsp_registers_phys, sz);
+	if (!chip->dsp_registers) {
+		dev_err(chip->card->dev, "ioremap failed\n");
+		snd_echo_free(chip);
+		return -ENOMEM;
+	}
 
 	if (request_irq(pci->irq, snd_echo_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
-- 
2.17.1


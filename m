Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E861BC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9FD2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tro/ceew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfLPOm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:42:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46206 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfLPOm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:42:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so7509505wrl.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 06:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DQCUryrlcbtadK45KrrkF2pluF/TOFteIcdhbUBJX/s=;
        b=Tro/ceewTNY07xjTotVqEjJLmzGaXFL9gl3Z6HZQGLPOsOluG7cOuziBswSSQ89P3c
         fOOmNdiFkFqfjPMpzsakcodL/tFwlMcfvd/cb04NHA6O0vhTmnJERWr/OxpasG2eCaOq
         +1Sv5C21fEvKb6ql5qt0LIWGyuhyK/yMXoUVJxDfhz3aQzAUnifjLzhiBa6deBUvpkEU
         mHmSMQOJ+ARp2LrW5927k5PvANojD9NbFI6mAZLIWtW75YtWp5yumdUVgzCrI1R8xare
         EzXPYSSpar6cyw2qfmwAFSSc0G8a6ksZFVxIIa2egp4a4vAvsX8jgoySuMA2Kquj1HkJ
         eJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DQCUryrlcbtadK45KrrkF2pluF/TOFteIcdhbUBJX/s=;
        b=E09+f68ioZyoRDV2yAFosWjCXG22F9i5kK0MueOela3o5MkDxDShCPFzO97Sq30YRV
         rOZhG0w74CYSjZg7js05qZmjS+peaB7tr1nXpe2+G3PP7L/yaYObyZWNKmHNtCIG71Ws
         XaeU60a+DN355v223u063L/QWT06WHOtx6qcm7k++nbmMQq9Qay08aiUKmQXs62GZPn6
         63HMOx6AzMJzPaUBfHXLzRG9BmDD9lLMk/b9iebbxkIgYv1yjLh4KiVBoA3Vt/7x2OR6
         t/10/ru6yIAyryBX2TvjUiOnacMShROXbL9Gqib+YPBg8JgBmXSY3LJmce9BEAFg+15u
         fuSA==
X-Gm-Message-State: APjAAAVzyM5tPnmy1r110PNx2KUZSv6fNNPSAnEz6PjGiOh0Gc6SCRVr
        Tx4rHY5Rjsak2AQBd2I6aXgyzWYomao9
X-Google-Smtp-Source: APXvYqz15v0MnYrVwuo5Su0Mx8HsuguT+qX8Lt7suDDnCT6zoLaMtmHEN6FhjRGjT1X1PtIUuBo5Cw==
X-Received: by 2002:adf:f448:: with SMTP id f8mr32276511wrp.263.1576507346982;
        Mon, 16 Dec 2019 06:42:26 -0800 (PST)
Received: from ninjahub.lan (host-92-15-174-53.as43234.net. [92.15.174.53])
        by smtp.googlemail.com with ESMTPSA id w22sm20249113wmk.34.2019.12.16.06.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 06:42:26 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 2/2] kernel: irq: add must_hold() annotation
Date:   Mon, 16 Dec 2019 14:42:08 +0000
Message-Id: <20191216144208.29852-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191216144208.29852-1-jbi.octave@gmail.com>
References: <20191216144208.29852-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __must_hold() annotation to remove issue detected by sparse tool.
warning: context imbalance in irq_wait_for_poll - unexpected unlock

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/irq/spurious.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index 2ed97a7c9b2a..f865e5f4d382 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -34,6 +34,7 @@ static atomic_t irq_poll_active;
  * true and let the handler run.
  */
 bool irq_wait_for_poll(struct irq_desc *desc)
+	__must_hold(&desc->lock)
 {
 	if (WARN_ONCE(irq_poll_cpu == smp_processor_id(),
 		      "irq poll in progress on cpu %d for irq %d\n",
-- 
2.23.0


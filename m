Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476C8C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC4320880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfDHWJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:09:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41864 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDHWJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 18:09:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so18214196wrq.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 15:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9HzFqDc9NJaJB8wgaUl1nLAIjLvZboM2e8uHtcRyOYU=;
        b=YD6AcrvnizdHsVcUgK2k2LS07vpttJsamoswAoRjX4GCJsT+KKB39PCFGfXa/FI4d6
         MVycO8oVPqIvONIgphOXjHZ+e8kGsJadwQ6VZAbXGOffE2yx2VcVhXJAIUJTgYfvGJ/l
         vDf/AfFgDVFdzDtiBSVCN0gBWEaNSExi5OChKoiAlTYFnTCMC2M9H9yTMB27z6DCrYU1
         731L3lC/6WyTKwqFhdtVq7J9oIIbLyRJL20lTSDoS5au6MRzgfu8Rmp1aBHNZmCsp4g5
         DepBobWdIMqCb3G8YHETuHkM8rM+pfkFgmoKnQq7SnNgo1Hdh2TdazjSzpiYvUbjhKwh
         /trw==
X-Gm-Message-State: APjAAAXDXw2tas9d9hkpsm2g/0iPthzmX5mjMdG3anjwFkA4mMhMML4D
        qMVB/qq62PteFxb4a668514nbO4rL6o=
X-Google-Smtp-Source: APXvYqxgqws8BQaY3D7xyjEiA3Ix2Z/5KgaKz9tnhg+TsdFN7YJWTwQSAbMJyqUMYpmjvqe7KfxHMg==
X-Received: by 2002:adf:f68d:: with SMTP id v13mr19864821wrp.6.1554761367020;
        Mon, 08 Apr 2019 15:09:27 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-70-69-135.cust.vodafonedsl.it. [93.70.69.135])
        by smtp.gmail.com with ESMTPSA id y9sm53645012wrn.18.2019.04.08.15.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 15:09:26 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 0/2] sysctl: share commonly used constants
Date:   Tue,  9 Apr 2019 00:09:23 +0200
Message-Id: <20190408220925.13077-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the sysctl code there are a lot of duplicate constants used to validate
the user input, which could be put in a shared place. Some of them are not
even constant, fix this with the following patches.
The first one declares the shared constants, the second one makes use of
them for the kernel/ sysctls.
If merged, I will send separate patches for the other susystems.

Matteo Croce (2):
  proc/sysctl: add shared variables for range check
  kernel: use sysctl shared variables for range check

 fs/proc/proc_sysctl.c  |   5 ++
 include/linux/sysctl.h |   4 +
 kernel/pid_namespace.c |   3 +-
 kernel/sysctl.c        | 193 ++++++++++++++++++++---------------------
 kernel/ucount.c        |   6 +-
 5 files changed, 107 insertions(+), 104 deletions(-)

-- 
2.21.0


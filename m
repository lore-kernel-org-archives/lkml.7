Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40011C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0759C2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="rQWIFbYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfH1F0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 01:26:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34853 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfH1F0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 01:26:13 -0400
Received: by mail-ed1-f67.google.com with SMTP id t50so1544728edd.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 22:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RSaJ1tXAkh4doLHeo3tyy1XDUioubkLMlCs/RYmBMSA=;
        b=rQWIFbYP9P+NW5NhWi4eiy1Pqqm93RrDL7C59xDow8PORcG8rgbEG+Fo/SseaMhOtj
         hInAjkQNbl5iJe5ZptUZfON3gTnkrMRxe/6xH7MMvPs6rBfJoVsBlc/Hi57DG3mpOUX2
         o7REcMUKJiVIpCRHnrwhssuyVP1m4F9Hp+j0z4m0uTsORrHfgaDZt99VmErpNpU/yIZE
         wlvkZjDgxHjP9UuEHmj6pCZAX+fMiZqy9vp8bgrTgy+awAfOgqurFe7IFoiusUuqFjXN
         cxWjclRj1IXDOe0w3Fnft16IHVEpJProqc8UO/9f/6KdvHU8PFNV4RPC3JIM/nkXZvng
         ztag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RSaJ1tXAkh4doLHeo3tyy1XDUioubkLMlCs/RYmBMSA=;
        b=UNFuxfWVqunzF/vnBgJlp1EyGAwe4ocR0ZpK27zArLcujV4Ny/VAAyY8HzpWUs59qa
         NlpIfop+DJw3hn/byiwz4FQmqDOS1XeTimBXc0jlSaIBDxCjfFb6W+Cvsj064OrJkXBw
         6QriaB/OlNOQDJCxPitOdKTHhm4Af+k+EJ01p86JTY+y5dKw8tgUBsL9x3fumyv7fTDj
         Cfo9dDMacpgmJTdpg62kHpaGVM2LVlzC19dHNB+2DkGJ9eLS7qIgbHS2XtNLnHE0HAsS
         baX11DX0Yns3Lah7TYaf2LHp44dF9x9NgwjcmI0qZSH01936ANpuW09m6ciSBoLbTH9Y
         SLxQ==
X-Gm-Message-State: APjAAAUK1BkZZBLpNh2WcXjeYYT2MPUueAOaZZPWwkbq6Y48r6G1uyao
        baVpUqLpfObcy+t9TTVDB4bPzg==
X-Google-Smtp-Source: APXvYqzvmMgNVmBtq6WtS6ellVasw56WUn6GgXI71vVf08jyxlCBbwrdgkQEijoC/tOaCyoFbtkCLA==
X-Received: by 2002:a50:b307:: with SMTP id q7mr2111038edd.49.1566969972034;
        Tue, 27 Aug 2019 22:26:12 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id la5sm213063ejb.30.2019.08.27.22.26.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 22:26:11 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH 0/3] tracing: fix minor build warnings
Date:   Tue, 27 Aug 2019 22:25:46 -0700
Message-Id: <20190828052549.2472-1-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

trace.o gets rebuild on every make run when tracing is enabled,
which makes all warnings particularly noisy. This patchset fixes
some low-hanging fruit on W=1 C=1 builds.

Jakub Kicinski (3):
  tracing: correct kdoc formats
  tracing: remove exported but unused trace_array_destroy()
  tracing: make trace_array_create() static

 kernel/trace/trace.c | 47 ++++++++++++++------------------------------
 1 file changed, 15 insertions(+), 32 deletions(-)

-- 
2.21.0


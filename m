Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957D3C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693502189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHkNwfKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfGDFwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 01:52:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40521 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfGDFwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 01:52:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so4228804eds.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 22:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ccAtd/XzKmyo3sFMsPL2Axp/F49Jdngxli/Tjqq8k6s=;
        b=fHkNwfKjj7VqlrBRMEGJ5ApoeF0azL4rzRGGxqNBnhzNr8B3gMbYKRCCehINbvisVk
         43qYGIsE33Te7YC6/RYvuEvFW9SqmuPt2FcnDQ+2tUMVcEX/AfphMdbPB1C2938KBr28
         CaY/Qs5ZW/1c6ehdbiQwxJ/k/cAc9lnTtcfiEauLoTPWqesc7tqCEMQC3ky3L12IVS88
         R1JF8+dz+S4dr6zNz/sKxlbHqu26vw5iuGRqDG/HLAymyjskKIX/lmFeHWxJo3tNrREY
         GOi+1S3yO0V0HVQsJ4GXUk1vaGde7gGnx+aRl/+83SJxJItKupsxZ2t0c27pIg1HhDGT
         jR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ccAtd/XzKmyo3sFMsPL2Axp/F49Jdngxli/Tjqq8k6s=;
        b=E/Rl+0lyYFa05rodw8EM6dPVSNI7MssnLMDBk5Clt+9d8h1GkBPoa9LdhkoHfSnHLz
         Qq7eOlbdfNV3A+8OwPgDAaJpYvgxWrSqhSm55FE66xcKWbn6K9h1WxGzQ3cijqpJBiqn
         BTLC7tGbu5hpGedxy7t14ceYm6PdG/V26XS2F4iwiKEGqJGe9mLVZ47aUFSsaWfAKWA2
         O7nePwF9ohEU+FUHeL8L2IIzq8jkrm+2mwU7X2FEmZw5QLymr4lcjqde2zGKeyYtlUtu
         lVgU1tQ8XPiycrMTQMhjZXzGBTX+py1zA1GbFWikKCnylZokTp9HWdZLZtNSHc161PmI
         i3QQ==
X-Gm-Message-State: APjAAAU0dy6NDj/TWHDKPmIPqs9tPjUZkSIIEwFp6Q8sQW78EglSI9Cp
        UCeTtmRN8WD1HkdAiTXtfws=
X-Google-Smtp-Source: APXvYqxqJdI0tb77RRuQ1gbOjrMSVm0Z97aLyUChIzwfR64hN/kecvtnSlsHPqhQvbarXJfo9wWGlg==
X-Received: by 2002:a17:906:8048:: with SMTP id x8mr30937958ejw.87.1562219561202;
        Wed, 03 Jul 2019 22:52:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id j30sm1343532edb.8.2019.07.03.22.52.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 22:52:40 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        Evan Quan <evan.quan@amd.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 0/7] amdgpu clang warning fixes on next-20190703 
Date:   Wed,  3 Jul 2019 22:52:11 -0700
Message-Id: <20190704055217.45860-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I don't do threaded patches very often so if I have messed something up,
please forgive me :)

This series fixes all of the clang warnings that I saw added in
next-20190703. The full list is visible in the gist linked below and
each full individual warning can be seen in the GitHub link in each
patch.

https://gist.github.com/5411af08b96c99b14e60c60800e99a47

All of the warnings are fixed in what I believe is the optimal way but
the enum conversion warnings were the trickiest; please review carefully
as the code paths for some of them have changed (especially in patch 3
and 6).

Thank you!
Nathan

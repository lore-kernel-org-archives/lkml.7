Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268F7C2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 01:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA9C206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 01:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iP6JNjcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfLYBGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 20:06:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46698 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfLYBGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 20:06:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so20850141wrl.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 17:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0zGgacboR5FhlzsxMkhuulP1I0LChnVXb7P5KAUVsko=;
        b=iP6JNjcSn31FVQziFhKwwn2t3pTM8vlWUCrShoH9MJDAosBuj/KiNcx1vf8pNd7wG1
         QiUxrKh3iwhUIH6nxH7XcE6FTRE59SZ8Uh+YbeNnrA6Z+4rCnwLCTDLGEWoCVZkAIp62
         2VETkvDcNXpOXHVy1up2KVfXT1yUd/sZ+zP0J+IUwQs9cjKU5qqrl2QMc3WjmBJ1Aikd
         JiKP+gnqh92wDKBbtPe1qYG10udAupF0c9k+brOD5G/9QDFM7kTSusxXXnfeY4uSm3z1
         pFJfY6XJbgTTqIDcJqgpGuPKmdIK/PjWoTKRXfQVyZmV1ncdO/qyRLGUwtcyLnwiCUQG
         iWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0zGgacboR5FhlzsxMkhuulP1I0LChnVXb7P5KAUVsko=;
        b=AoPIU1mfYF4a5FfqdwmRs8cz7L2L4M8XE3GHcWFbf6naFVFVeeLwkwDoBzdYG1CN3D
         3Tu7yuPwWik5R/8k7J6VoAWQK01xbCLD6iJfMtTTAav/SujLA3ZHQ0D6fDXtb8snNqKf
         TOzeaNQ5/0FOs5h9lO/4nMS3YQ81sVoN1EvPce907Ue2T1sao9UgC0rG5zMgOyVfzwXO
         ZGVd/ZicEOASsF8YJNaREN4IDnsqe274Tk5vFB7/fbimGQE5PztHhXS+GChKd1oMdBqX
         QviTrOwQROZqdlv6rPt1VZdZ+2Tk/vb7MOD9g1P373JxfB/UVQd/DBcDO4ny97TMwc/j
         u98w==
X-Gm-Message-State: APjAAAW5Q3zqc989jqbl/aFJjdbuynpyHUfaklCkQSgJHFT4dIUmgTN+
        kkAOu7wrW0MxSpyyGzGGaNU=
X-Google-Smtp-Source: APXvYqysmD2sVl/eNjmOaZfVfpZd4euoYnmvq2Vt7G/i+H8BAtX7T/Qi2791EsGXTyiaakkZJM8clA==
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr36188586wrw.327.1577235981614;
        Tue, 24 Dec 2019 17:06:21 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id x26sm4066127wmc.30.2019.12.24.17.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 17:06:20 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/3] ARM: dts: meson: fixes for GPU DVFS
Date:   Wed, 25 Dec 2019 02:06:04 +0100
Message-Id: <20191225010607.1504239-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing my patch to add DVFS support to the lima driver [0] I
found one bug and two inconveniences with the GPU clocks in the
Meson8 and Meson8b .dts:
- the first patch is an actual fix so the two mali GPU clock trees can
  actually be used on Meson8b
- patch two and three are to prevent confusion when comparing the
  frequencies from the .dts with the actual ones on the system

Neither of these patches are critical, so I based them on top of
v5.6/dt (meaning they target Linux 5.6, not v5.5/fixes).


[0] https://patchwork.kernel.org/patch/11293193/


Martin Blumenstingl (3):
  ARM: dts: meson8b: fix the clock controller compatible string
  ARM: dts: meson8: use the actual frequency for the GPU's 182.1MHz OPP
  ARM: dts: meson8b: use the actual frequency for the GPU's 364MHz OPP

 arch/arm/boot/dts/meson8.dtsi  | 4 ++--
 arch/arm/boot/dts/meson8b.dtsi | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.24.1


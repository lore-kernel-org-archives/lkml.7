Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D66CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1026A206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAKkVnO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfLRMvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:51:45 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:46299 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfLRMvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:51:44 -0500
Received: by mail-pl1-f180.google.com with SMTP id y8so925056pll.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 04:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=FMyD/MSNBBcC50DW1kZoGY+MZ7/XSIpSWlAzw7z2Gug=;
        b=nAKkVnO2bx3KrwBfj56Elor9wqVHO6jodhd/FOFJKacDC7l0XAoQrxBs9MfazgF/AV
         EKEigUJZi/3afJMLyRehUQ06HTvgKYwi5p1l7WVzxbNzetGkY1IpZirTYWxc1goN4Eat
         KGeGTFnuQEINBdTdDGTjAwwofiHqPjfEtgs6VSqL/OKZ5xtZtCRKRAVQTN7F73dhKlxP
         cPNO3GBbsxtlp5BxgTtRo1QOoqLv1PhXvz53+TQWGdRlQ2x+qE8B6uKNfWOsWVqJr3Sf
         wuD97upmUsnAUkGvtufIMP3E5znuJhi8L5L/bePaqCTp41DN5UxQRI3XJD/BtCB13lb5
         IAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=FMyD/MSNBBcC50DW1kZoGY+MZ7/XSIpSWlAzw7z2Gug=;
        b=ab6uLSc0pLvDaRcLcaUkCs8wduAbSBRKtyVI4NH+NyK/v7jVizCV281sC2peEapAc9
         7huVfxE+Kp9cGNxzg4eXGZP0qC8xsuqcv37eq2Qbfkk/4E2gtUej0YYGex+9yv1nyHbM
         HltpmEV6OfjyY0FV43X7rDX7dgwtNMXcA2HN5gjgjAuKlGrvDYdSDzyy1GTnzgOpN7r1
         nBeKZ+UJmVPs76oVgh7fBj9UrmFgT/pEQWC2VNwRpEJ8lOfjlY36R7T6K3O9I3ccj9QB
         8DYm+CU/SpK712RaUmGKN90fFX/prIPg3K5IRfIxhrz2dLUP/qTfMDcKDYuIm7yDN1lU
         dbZg==
X-Gm-Message-State: APjAAAWqvaVaXF6OuP0igX573XbaI4x1EnV2cLP5w/AbcMgBha5MZFem
        ntBnw1mfvvXMCNRQtgRwbL4+9vo/cwn1bA==
X-Google-Smtp-Source: APXvYqxSw2W89Z1ed38sk+l/HZwuj1/iISIxcDi+mToLA+B8DJ8+lORbUmCuM7OZ4G31ALZIWr8a/w==
X-Received: by 2002:a17:902:8649:: with SMTP id y9mr2607392plt.67.1576673503966;
        Wed, 18 Dec 2019 04:51:43 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.139.103? ([2402:f000:1:1501:200:5efe:a66f:8b67])
        by smtp.gmail.com with ESMTPSA id z13sm2920796pjz.15.2019.12.18.04.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 04:51:43 -0800 (PST)
To:     arnaud.pouliquen@st.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] ALSA: soc: sti: a possible sleep-in-atomic-context bug in
 uni_player_ctl_iec958_put()
Message-ID: <739176c9-d889-0093-129c-25ff9c57b63b@gmail.com>
Date:   Wed, 18 Dec 2019 20:51:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep while holding a spinlock.
The function call path (from bottom to top) in Linux 4.19 is:

sound/soc/sti/uniperif_player.c, 229:
     mutex_lock in uni_player_set_channel_status
sound/soc/sti/uniperif_player.c, 608:
     uni_player_set_channel_status in uni_player_ctl_iec958_put
sound/soc/sti/uniperif_player.c, 603:
     _raw_spin_lock_irqsave in uni_player_ctl_iec958_put

mutex_lock() can sleep at runtime.

I am not sure how to properly fix this possible bug, so I only report it.

This bug is found by a static analysis tool STCheck written by myself.


Best wishes,
Jia-Ju Bai

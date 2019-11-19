Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B520C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52E8219F6
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTgcused"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKSJIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:08:54 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38906 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfKSJIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:08:54 -0500
Received: by mail-qk1-f193.google.com with SMTP id e2so17133387qkn.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 01:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=Wt+oX9fkrAikGfzu2MKOa2qUy+fReDWIJawgofjTH5s=;
        b=jTgcused0CeDh9NfglkHNJxwebk9PMHr2U245TK/0iVXUDll8rqWBQlhPv3LwN0zuT
         AV5ZjJmmcOvJaNG2fJHzYOFkIpN5o2yWIqZlfgXP91ne16eRtokTQqYPsPECIzj6mMl7
         /55LH/z6j1a1cRU0XcB0yx8SqQ/YzINOjeTlO5oZSVV++irsn5ANtrvWZhVY2+ZhoILe
         XqnS3ocdsWmuysi6XmnH19fC0mrh1UewWdODzdGHJsN0ihvyn2QxHliXJsm6wB3cck3C
         52CZenuhtmU9pe4jvxZivlpY7YrG0Ad0sbKy4/hj8lYhw4Of+XgS5aEmKWm8VoTHHLl2
         LswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=Wt+oX9fkrAikGfzu2MKOa2qUy+fReDWIJawgofjTH5s=;
        b=NYM8v9wHlyU7U4ciXSSMtITt2NLcKfTMarUyGtNaS2wk0sWEGl7qQdwYU5Fy5psaoM
         Igu6o/aFUAJdf6H1RJFynjizZyHPow/iuaLWpjKA/zGPSP1ckf/V8jsrHCpGTozUzStz
         oHjB/Mmq1oXNavSx5wG3UZa1qPqTbKpAY34SHDj5Wq2rIxc06vGKw854qSBmUPiarTHL
         eGN3qFN7sDvRHPmDrmN19mH+hdg0N3Sn2eJ/e+S78SAyggMabKiirCeA9HqC/0WEAaTh
         o4Wew5+3YiqW1ZOB/MUVtXfmQ/UUCNsfXTVI0NNW36UQBkdm2o2ZPvfYxo3rtsLDO8aW
         CTAA==
X-Gm-Message-State: APjAAAVA8+ZDP1SyAFA61oF9HPtWraoMeKqx04Sakg0mZ3qtbhdAiZsP
        B4/7UwE6VGUbV+VNiwQIh4U=
X-Google-Smtp-Source: APXvYqw/11kH/4uK+tZ2e1NapPLZgnNtB8M1EUCLNCTjD73AdoNE1r9bY0qO4Nprqn/U+CWxXUz9gA==
X-Received: by 2002:a37:ae05:: with SMTP id x5mr28138441qke.243.1574154531933;
        Tue, 19 Nov 2019 01:08:51 -0800 (PST)
Received: from dc740-pc ([186.0.171.141])
        by smtp.gmail.com with ESMTPSA id s75sm10022708qke.14.2019.11.19.01.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 01:08:50 -0800 (PST)
Message-ID: <c759bc50134ea434bfed0a183e0ce72984f5b609.camel@gmail.com>
Subject: [PATCH 01/01] Add VID to support native DSD reproduction on FiiO
 devices.
From:   Emilio Moretti <emilio.moretti@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 19 Nov 2019 06:08:48 -0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VID to support native DSD reproduction on FiiO devices.

Signed-off-by: Emilio Moretti <emilio.moretti@gmail.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 349e1e52996d..f5fc65aef628 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1658,6 +1658,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	case 0x25ce:  /* Mytek devices */
 	case 0x278b:  /* Rotel? */
 	case 0x292b:  /* Gustard/Ess based devices */
+	case 0x2972:  /* FiiO devices */
 	case 0x2ab6:  /* T+A devices */
 	case 0x3842:  /* EVGA */
 	case 0xc502:  /* HiBy devices */
-- 
2.20.1



Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9C9C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EB1208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Kc8zoi7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfD0GHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:07:04 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:50352 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfD0GHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:07:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id AD541F60
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 06:07:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kZmGyuuKKWs3 for <linux-kernel@vger.kernel.org>;
        Sat, 27 Apr 2019 01:07:02 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 84522F5F
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 01:07:02 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id x143so4859508itb.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 23:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NFlIqhQAiZ0fKBdX7sqqPlFbICv397OLf5KoFgtnxks=;
        b=Kc8zoi7baurWPlTU1x/nQLHBxVn40vnDnX+BlDg4nKi+7gxiwc3DP+cyQ54OiKWQbU
         rxOJUAotGkU6UkDJoyS+PvugK2b6W8gxtI0ZY2e29dqwUc9fce26RbIpi6JMpClLE3Nj
         vmFJuGeXStBkdjRxJWpQoF67x6+PwTQPAfgQIuBKAhik8v1i3jDtaBmVao1+psxcVC14
         6Zl1F944VZUPoJBgHYXEN9LNFGnr0szQTdJOKzpu2z0uuumo/MOmrFo/Pcw4ivTpIHDJ
         dqlT5z1lhQQde3M96I8rce6hOqigvhfjAV3FEZVoPtSbTw0wXCEf+jCKt+Po8aPhqE9j
         3p5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NFlIqhQAiZ0fKBdX7sqqPlFbICv397OLf5KoFgtnxks=;
        b=Oi2WuztdzYtywkykck2WYANNfWgXLIAuV3HZV0GfSpMpvhl8dWngskmuegqm6mtqBm
         QM93ofv0nOV5AsQdP2L2YLyCAwHj9qrIRPRyOz0FZXNsBKd+rPr7CROf5M/wegBCXsOp
         kWv1qb5g4iN4dPWkFGF77JIv03lfVZYnRZCRDRPGg+EC27kfL3hFvDc1OS0NVMYRRchu
         74ZQugxEAtDyTW7FJVKo/8barx5uZanhI0SPaztlEo2krye+S7FZgKxvawzIjQsApCkx
         VwX5STh7tb7Ekzv8SunfTd2YGlMW6Vrf7UKhS0tcZVT9A51ysRI3o0i2rd7qc+WS5kFj
         4cvQ==
X-Gm-Message-State: APjAAAW5n8IfZEGSyIIHadW5jiE3bkpHZ+tU3nBNMkpgz7RZdXNTpkee
        kKL3/Htr2+wSyTwpN6R4rkhfk+Q03DuGZQwSy/mkQvXh0RLHAD60JPoFMAslWlIMu+F0ICWV6nt
        x39BFmG1iiYXHSgCvlmxtTpnzSHoE
X-Received: by 2002:a5d:9d0a:: with SMTP id j10mr28060540ioj.196.1556345222217;
        Fri, 26 Apr 2019 23:07:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzS811HXtyXaCkgpoOpbax7PyFn3O06/h13VSIFhaFM9DP2JKm5kpfQ4hdDn9xpzx+c0mbK5Q==
X-Received: by 2002:a5d:9d0a:: with SMTP id j10mr28060531ioj.196.1556345222018;
        Fri, 26 Apr 2019 23:07:02 -0700 (PDT)
Received: from cs-u-cslp16.dtc.umn.edu (cs-u-cslp16.cs.umn.edu. [128.101.106.40])
        by smtp.gmail.com with ESMTPSA id k125sm5670880ita.1.2019.04.26.23.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Apr 2019 23:07:01 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: usb-audio: Fix a memory leak bug
Date:   Sat, 27 Apr 2019 01:06:46 -0500
Message-Id: <1556345208-1210-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In parse_audio_selector_unit(), the string array 'namelist' is allocated
through kmalloc_array(), and each string pointer in this array, i.e.,
'namelist[]', is allocated through kmalloc() in the following for loop.
Then, a control instance 'kctl' is created by invoking snd_ctl_new1(). If
an error occurs during the creation process, the string array 'namelist',
including all string pointers in the array 'namelist[]', should be freed,
before the error code ENOMEM is returned. However, the current code does
not free 'namelist[]', resulting in memory leaks.

To fix the above issue, free all string pointers 'namelist[]' in a loop.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 sound/usb/mixer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 73d7dff..53dccbf 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2675,6 +2675,8 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 	kctl = snd_ctl_new1(&mixer_selectunit_ctl, cval);
 	if (! kctl) {
 		usb_audio_err(state->chip, "cannot malloc kcontrol\n");
+		for (i = 0; i < desc->bNrInPins; i++)
+			kfree(namelist[i]);
 		kfree(namelist);
 		kfree(cval);
 		return -ENOMEM;
-- 
2.7.4


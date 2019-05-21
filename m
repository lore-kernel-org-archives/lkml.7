Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B98AC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BCF20863
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ix0I3Scy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfEURmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 13:42:47 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35986 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfEURmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 13:42:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id a8so30626878edx.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q1/eAW62EAJcde+3Yh/QNaf7LCM5ne82jfzUJ/PNdeU=;
        b=ix0I3ScyRSa2HuYR9sXZsh737pIZKeeWpw3IKjgqMf51mSBZTA7bIhKA0pvpI0FDc/
         6NH41oduTVu+fGdQbzMPIrGk6K2U/2GAnLl8A8rOiYKDg3pGPBEtDeU0fFI6BQLpb6vr
         aUbTzA3r64hXcOiDD9Kmus6S6WxI+Gu6duV+Ka86oPjeEvRQtpTxmDH/iN3B9NBeEK6u
         PC/QWDYKwj/Uv4n+muGn1UMsWlStiaCgGRmK4l/3whjQ8TyZoflN9gZr7OoRcZ+Vs+Ax
         JbJN/PXplHvqyLEcj3HLzRUDAJydsXS0Dt6fMAgqO8CBCtDUS6BWMlc+qIaNgXabJObX
         7RYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q1/eAW62EAJcde+3Yh/QNaf7LCM5ne82jfzUJ/PNdeU=;
        b=sYAJeO9byWuFs0rA9IfQV9zYUOiJ2evU6jvIEalT0fVl3gPkgqXwbzXvaw8VKzRdA/
         EgzcxzEZOw7N0ErDAvOjWoNhffszHBzgMHp69fDGxomgbvWXo4O1qFMuH4tPYG5ss/9F
         gTtLyqq3pHv/VLPn6B3CFs7s1sRAbOOz946BML2RYXcq0GrskauVLPYLpCMNUHySqwQX
         7rDkbv4ESCI7jjAcRPm+hjRIkK2Ajv84zMa/3g9TVg7ktO205El0h9k/NLuL07nV4ehe
         4gtkpM7BfulL7dByCtDVgeE8YaXq1IFfVONaR5Brz8qWm6ccal3/uwvWobxnMwuBIotq
         LvVw==
X-Gm-Message-State: APjAAAUAKGxP3wiamzU4s3x9C23my759CS5tYQ+uK407Gq72bYYOMy8b
        HtRd4vtQN3sXk4SmzyK9GKs=
X-Google-Smtp-Source: APXvYqzXbe4aG0oHNqV54mxIzxkYtOtDl6ueQqL2rP14D+slzFflcvP7Ric0vEZYdPQ5bbdxJuNW/w==
X-Received: by 2002:a17:906:63c1:: with SMTP id u1mr4660298ejk.173.1558460565396;
        Tue, 21 May 2019 10:42:45 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id e4sm3604949ejm.50.2019.05.21.10.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 10:42:44 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] staging: rtl8192u: Remove an unnecessary NULL check
Date:   Tue, 21 May 2019 10:42:21 -0700
Message-Id: <20190521174221.124459-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:2663:47: warning:
address of array 'param->u.wpa_ie.data' will always evaluate to 'true'
[-Wpointer-bool-conversion]
            (param->u.wpa_ie.len && !param->u.wpa_ie.data))
                                    ~~~~~~~~~~~~~~~~~^~~~

This was exposed by commit deabe03523a7 ("Staging: rtl8192u: ieee80211:
Use !x in place of NULL comparisons") because we disable the warning
that would have pointed out the comparison against NULL is also false:

drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:2663:46: warning:
comparison of array 'param->u.wpa_ie.data' equal to a null pointer is
always false [-Wtautological-pointer-compare]
            (param->u.wpa_ie.len && param->u.wpa_ie.data == NULL))
                                    ~~~~~~~~~~~~~~~~^~~~    ~~~~

Remove it so clang no longer warns.

Link: https://github.com/ClangBuiltLinux/linux/issues/487
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index f38f9d8b78bb..e0da0900a4f7 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -2659,8 +2659,7 @@ static int ieee80211_wpa_set_wpa_ie(struct ieee80211_device *ieee,
 {
 	u8 *buf;
 
-	if (param->u.wpa_ie.len > MAX_WPA_IE_LEN ||
-	    (param->u.wpa_ie.len && !param->u.wpa_ie.data))
+	if (param->u.wpa_ie.len > MAX_WPA_IE_LEN)
 		return -EINVAL;
 
 	if (param->u.wpa_ie.len) {
-- 
2.22.0.rc1


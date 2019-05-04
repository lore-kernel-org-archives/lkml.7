Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92986C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB04205F4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1Q6D7Wl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfEDSmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 14:42:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42422 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfEDSms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:42:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id x15so4296928pln.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vLOjCnO49yCOENX0uFQ1hXKTRCbqPnXn7dDmCUFzsZA=;
        b=t1Q6D7Wl+XPzM/8355mudFl2qDhrWUyNMz3fLiDhFp5j9ou4cUJJOSvBwbSeC++Q+3
         mFqR/EeZi+ZShb0jmpybC6cksZd/lQv1CScJThiA/0eJm44iLKuEBtFaFq6aBwWaM5Uj
         jcvkxRSt9ct7Ysr6qIshsYcZy8RGIwdpT13Ral7RDzugwm94vL7Rq39jbhT8Ns1dE8MC
         cQ1ro8TbDRr5LAwB3rzoc5Yj+jCJG/R1AEcOREIwb+8y+il1b42809+Jd2e6/34alXHh
         YCyoN8MphqUZWLGqCuJt1qkBvbe9Hi5L4qBgO9CkAlF64jj7aOrJnAvFSAnFrR7fw/Xk
         Lk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vLOjCnO49yCOENX0uFQ1hXKTRCbqPnXn7dDmCUFzsZA=;
        b=asKfGByNchjN0FZHrRSFkZOb8e4zlEKf5eJZl0P4HTBMq6OERsAD1aznzabkpi5gYA
         Fq8sr9D7p+R4pMhXX1ShbZwZ/vAo2IkYQrssbnlvQNOfN8Z0/5DyOxMXFM5WysMlsWfs
         nYSU3wFycFJe28vC/YubNRBg8W+O6nIOYPnH5N+QLG/Umt+U9yhmDMVwYny1ZdZC+iWv
         bh84Z0X2353CvtNFC1+lNzsZ1/P3p4WOay133JCajxCW7MRuag0lK0d1BVYUJzojcLvm
         zRtWTzEiA5w62EmB0NKuinHbQoCX9cVgoCaYcAldaYTfM7to+ecrz/ut8knrnssa63jO
         ktRw==
X-Gm-Message-State: APjAAAXTCmOjYrLM9m60o0wCgUVwCdrUp1yCGnYnzzqzk9uG/a9v4zeS
        1f/4wtUwxS9gbZtlgxYcaso=
X-Google-Smtp-Source: APXvYqyEuNHK4isBLDDxjIaqXH6Jr8t9DjMp1xmPRZhC20Y+wVDkkdhlOS/QvhnqXvEsDZZtonjECA==
X-Received: by 2002:a17:902:900a:: with SMTP id a10mr20733814plp.336.1556995368285;
        Sat, 04 May 2019 11:42:48 -0700 (PDT)
Received: from localhost.localdomain ([103.87.57.241])
        by smtp.gmail.com with ESMTPSA id 144sm7631784pfy.49.2019.05.04.11.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:42:47 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH 0/7] staging: rtl8723bs: core: Fix various checkpatch
Date:   Sun,  5 May 2019 00:12:30 +0530
Message-Id: <20190504184230.25514-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fix the following warnings:
-Remove multiple blank lines.
-Remove return in void function.
-Replace NULL comparison.
-Remove unnecessary parentheses.
-Remove braces from single if statement.
-Fix variable constant comparison.
-Move logical operator to previous line.

Vatsala Narang (7):
  staging: rtl8723bs: core: Remove blank line.
  staging: rtl8723bs: core: Remove return in void function.
  staging: rtl8723bs: core: Replace NULL comparisons.
  staging: rtl8723bs: core: Remove unnecessary parentheses.
  staging: rtl8723bs: core: Remove braces from single if statement.
  staging: rtl8723bs: core: Fix variable constant comparisons.
  staging: rtl8723bs: core: Moved logical operator to previous line.

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 79 +++++++------------
 1 file changed, 30 insertions(+), 49 deletions(-)

-- 
2.17.1


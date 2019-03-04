Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5204BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C40A20684
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="TTaSgRIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfCDXAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:00:14 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:34832 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDXAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 18:00:14 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 78DB2BCE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2019 23:00:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zHNLhQnt2IWJ for <linux-kernel@vger.kernel.org>;
        Mon,  4 Mar 2019 17:00:12 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4A45CB53
        for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2019 17:00:12 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id 142so757480itx.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 15:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rHaxqA0PsTZQam8an0UheOFnnZTIfjCzh05Nat7Rxng=;
        b=TTaSgRIEeaUx5f3YarletbKzXiyK6L1x3QIvgj2yLr1SSSDreSaGhBBv7KWv6LwjPl
         27c4IF9jOdihAAKeBNRoLsRB+v5hW0f21NmooM0X9vePXBuNXWskwVbhOU9vSXfLTAEx
         jOIsCdb+mP2Of9tVbvYTCWPXwe+Fn/7uTb7SeHI2h1mi1Pg9gcMwJ0tQUpm2sVtGouAz
         29pAu/5290O48IFHe6+GjbjqDKB/JuQAcaJg85/uvs80AP6odEjCJiv/04vWt0rrmwh8
         1XjQbFxkwLgYl6jmIs2/eDzhFzaOWc2amCr6ksgREiowizp7CcOLk/UPF35NjEaGvHAd
         npZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rHaxqA0PsTZQam8an0UheOFnnZTIfjCzh05Nat7Rxng=;
        b=WjsgVZL46Foimuxm6gQtyRVl9QGzPwN2N/YXS2MFZWsvjvjhlAc3gl/V2geZ55n2hV
         6wBT44WPh91bj85beiA6AYJlQi3qFQB0Mz3nT/xqheyOezga8eKHl/8S3KlDozvgkkr5
         JH9U5Kp0bbG/GGAeTUXw1p9ZB7xE+tKuQukZDcIm/Zc54DtrQrOhIPaWo+06XtCLal7B
         En6oEySb3AcMEn/ky8Eral9rs151cCNfh+cXrJMYas0YA1qOiNO9OY5oDp2huQZe37+t
         Hp5XxER6GfvsTZNSPThWDvQfzO8kFKxaJNAxfssUs80QKi44b9ahBB514qVC46ix5+P5
         Sjbw==
X-Gm-Message-State: APjAAAXbSOJ96Bgwia9LjG6snxGePb0aiskPouSroadNml452pdqmGD+
        MzNo5eNcU2zq5nC2WueZMoWmJENCdldvQIuII0XeA/oWlVkR7BvBtLbCGyi/dpvb93FO44ik68j
        3U0SNtdvcy/MkCjNBA1VTusDxKmkS
X-Received: by 2002:a24:7294:: with SMTP id x142mr973827itc.26.1551740411931;
        Mon, 04 Mar 2019 15:00:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqyEopQVltDSlgio0wxfM2ay0fNZn3/C9jgabRPjmuEfdGsc4kD1p7cpB8rKLKefCh4DKwIKFQ==
X-Received: by 2002:a24:7294:: with SMTP id x142mr973822itc.26.1551740411743;
        Mon, 04 Mar 2019 15:00:11 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id z11sm2821966iog.29.2019.03.04.15.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 15:00:11 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH]  ALSA: usx2y: Fix potential NULL pointer dereference
Date:   Mon,  4 Mar 2019 17:00:02 -0600
Message-Id: <20190304230003.13050-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 usb_alloc_urb can fail due to kmalloc failure and push the error
 upstream. Further this can cause a NULL pointer dereference in
 init_pipe_urbs. This patch avoids such a scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 sound/usb/usx2y/usb_stream.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/usb/usx2y/usb_stream.c b/sound/usb/usx2y/usb_stream.c
index b0f8979ff2d2..221adf68bd0c 100644
--- a/sound/usb/usx2y/usb_stream.c
+++ b/sound/usb/usx2y/usb_stream.c
@@ -104,7 +104,12 @@ static int init_urbs(struct usb_stream_kernel *sk, unsigned use_packsize,
 
 	for (u = 0; u < USB_STREAM_NURBS; ++u) {
 		sk->inurb[u] = usb_alloc_urb(sk->n_o_ps, GFP_KERNEL);
+		if (!sk->inurb[u])
+			return -ENOMEM;
+
 		sk->outurb[u] = usb_alloc_urb(sk->n_o_ps, GFP_KERNEL);
+		if (!sk->outurb[u])
+			return -ENOMEM;
 	}
 
 	if (init_pipe_urbs(sk, use_packsize, sk->inurb, indata, dev, in_pipe) ||
-- 
2.17.1


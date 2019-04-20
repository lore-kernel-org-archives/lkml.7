Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E97C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 13:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069C42087F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 13:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gxGPZ9lv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfDTMvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 08:51:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:33563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfDTMvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 08:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555764684;
        bh=ub3mAMcNh1mfanJyWXpEkJLVoct0m0L8TaU1rhV0I7M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=gxGPZ9lvFByoLzl8uf0g+KGDxnayecOWCYkrCuFGCawKcJmmDtk2CmJkRaxZK97er
         i3pJJvoC7g1YaT0nGWni3yXrpr41Ky7O/nWaqZlb0/rHZeGP6FVMNbUl1I405nugYX
         aX7clUYMfICC8xsu2a9WwMoliEt4zJJPC/J0huSc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mh6lB-1hUnsb2bmj-00MHfJ; Sat, 20
 Apr 2019 14:51:24 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Nayan Deshmukh <nayan26deshmukh@gmail.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Eric Anholt <eric@anholt.net>, Pixel Ding <Pixel.Ding@amd.com>,
        Sharat Masetty <smasetty@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sched: Fix description of drm_sched_stop
Date:   Sat, 20 Apr 2019 14:50:50 +0200
Message-Id: <20190420125053.32150-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:okTCytA79pzkYmEPFvY+M+knoi56Vuo6jUuAcENqTatsHUQikPN
 KYeJ3mG0HHCZ/12VdmlMklcZrfVcvD+Yb5M6vOaRTj5Vf8jPwP6IZzm52MlGxnUwsQF987A
 HIbSWrxQejVE5ldq5jTxysm9QH/0193917XLpZ+fYqm3YbgGp+pO4WKmAP78sWs/DapvLlS
 /WeUKhPWiPd7s/4LiODfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jiekJYLotuU=:jTEJJLESDKzlEN4B7tLZcp
 pndZb9N4XCscn8MgYp8LA5zUf0ejjYH4QKqLTVNHCMf3sNYnGf2iGOyqp59LNMq5mcVI45CVF
 Yb33rgicwJ5yMbEykkyNjSrlS/IXUguKtWe27Ond1ATIln4q7EMwcbbZ/fukdyTiKt7ZKb72H
 yKFh6wFw2/rVWTr0ggPnltlAirJG2CNG9KbdL33lNuN9lg4L/7z6DQCWaqw3ILk7o0HmM3e97
 fGQfTZZN5n/2q8QIWxChM2c8HxW/7qgKzzdWlIeSjyZr5OyrxMqJD6cmL2RQapwRpkhjgC+67
 CyZSe55rwhiR2jzJjFrepVq0ANWOL09lgYxNHQTRlWABcK5G12HxsIy8tmsWIWphVNC4A9XKQ
 VMmwpNGutHN/68DVsqGNn0uYWQajCmlndqNy0DtUNx7DeRqW3Xm8tsws7CEbbTHceGNguwtO1
 YrWPxw4bj3pB+8rf6zE0l6Iy85YnSHmTjN7nhLQ8FFbukByjoZNZ4DuMnL0tR4Yy39tjGqxeR
 NlE8Sj71CFwk2a7MF0N73PZ9WudDMk2HSAcgX0IDf9vtrpjhINbIJEiZpDMX3AaNGku2bGhm+
 u4KH9JmFJU4Kv/U2ZGVT9HPM+Rnt/khTgZiyTUIArpDZpvNhvuh6sAkiyZ5/O35+F44DRD7pX
 GdNlYeNgrCF9BKBoWeoBCYwn8iRowFVtC9C3P8U75VpXjnVvjELwgRNLYE0gdjczEU6LS3Z19
 HGpwn4idOFrjhaPyyZallngC24XxJYqmabGmIjNwoupMh3jTo5pnjnqj6kdRVIgPhSg6Mw6m4
 fmDZvRpA9OCFMpjin0rfcmDD8ftU5JmS8jIAQeiQvFnldvaYDcbLzWdmhql5QeMaCex5vDAcH
 CfdmLliyFOEpkcmQFE45kaaBlgi0cysKotcvY7QVa0HXTfqWzuex7qVmo8GJT4OqGNhzDsA9V
 AHKBCm+NlTg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 222b5f044159 ("drm/sched: Refactor ring mirror list
handling."), drm_sched_hw_job_reset is no longer there, so let's adjust
the doc comment accordingly.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/gpu/drm/scheduler/sched_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sche=
duler/sched_main.c
index 19fc601c9eeb..a1bec2779e76 100644
=2D-- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -366,10 +366,9 @@ void drm_sched_increase_karma(struct drm_sched_job *b=
ad)
 EXPORT_SYMBOL(drm_sched_increase_karma);

 /**
- * drm_sched_hw_job_reset - stop the scheduler if it contains the bad job
+ * drm_sched_stop - stop the scheduler
  *
  * @sched: scheduler instance
- * @bad: bad scheduler job
  *
  */
 void drm_sched_stop(struct drm_gpu_scheduler *sched)
=2D-
2.20.1


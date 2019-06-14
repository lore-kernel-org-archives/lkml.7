Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F91C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5562133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNIuip9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfFNMla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:41:30 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:37628 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfFNMl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:41:29 -0400
Received: by mail-wm1-f50.google.com with SMTP id 22so2189821wmg.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q3KNufnBIVUWKwyOgRWw8DnrVsx2V6k8xRAPzauAykA=;
        b=VNIuip9iNwbajuhEqq83zqdoDU2mB3Iz+0C3zEboe0MJYKOBG6e6f56vN2Jl4shncY
         yzu9EWuncAvoaiMHdjo1jIV7CClizTAi7s2oUHJqSd7GPsRf/B9PoM6tNAcjtwlLTdl/
         iD2UYJLiq3zlSwpsQnqfi8spyXsW+hksFUxwM+cA4+Yt2zkrKpssfQ7vvWKXOTRQ833r
         FOpehV3ea5pVmZTgaak+AdKgLXD9NENBgYJbXifPxpWx9TZroSvxa2z1e8tKnnE7rEE7
         OQjt/KHYHl1bujST7OrAVKhiVxLYfupax+W9VmdSsSczvjhvsHeZI1Bzn1Jb0MqgXT0k
         YCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q3KNufnBIVUWKwyOgRWw8DnrVsx2V6k8xRAPzauAykA=;
        b=I90H7qo3RWFBpeOf6lwhTb7bfnDwTangkwUk4qbiLn25rUrU6ooUZ5p2Lou4UbAYCB
         4y6o6P5z8x44XFhnQt5O+KGGUutINuKbWJtOsi1+Nb0oZdV1eV40UdcF6V20kSLWu31m
         8LUymobh2vVJ4Tjpx5bgtoRP2yiy3Gvj8vu0I6zYZrk0s6sFa4G5HomIA5Dk7Y8ze+RA
         hBCldrqvFVoZtIWAsH0XNoZOzpM9MJ3gjfgsH/mKfeNPSFeAWfc8ZQfbXnUn1h/TZ4GN
         nM4l1zxQBsNC25POjZ/nTZEf3MRJUkRtbF4tWTHpI+CdzXB0y9ixpcepiDjhC9Kxv6sq
         KX8w==
X-Gm-Message-State: APjAAAUVu15775THkhBO+WBx1bnJBp6dftKqLgjgGkVSQCJM1LhkM2FP
        2g+LDDFFrWr1s2BITDau6I4=
X-Google-Smtp-Source: APXvYqzTuaZA2po09mTfWbADtCQ6vzLAMrR316sQRMGMfvQSp4NO4+rPhbE1zafrK2aX71rqhjI3Sw==
X-Received: by 2002:a1c:a186:: with SMTP id k128mr8102073wme.125.1560516087737;
        Fri, 14 Jun 2019 05:41:27 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:e0eb:ed4e:b781:3e9f])
        by smtp.gmail.com with ESMTPSA id n1sm2648209wrx.39.2019.06.14.05.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 05:41:27 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     daniel@ffwll.ch, l.stach@pengutronix.de,
        linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
        yuq825@gmail.com, eric@anholt.net, peterz@infradead.org,
        thellstrom@vmware.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        lima@lists.freedesktop.org
Subject: ww_mutex deadlock handling cleanup
Date:   Fri, 14 Jun 2019 14:41:19 +0200
Message-Id: <20190614124125.124181-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ww_mutex implementation allows drivers to acquire locks on a set of locking
primitives with detection of deadlocks. If a deadlock happens we can then
backoff and reacquire the contended lock until we should finally be able to
acquire all necessary locks for an operation.

The problem is that handling those deadlocks was the burden of the user of
the ww_mutex implementation and at least some users didn't got that right
on the first try.

So this patch adds two macros to lock and unlock multiple ww_mutex instances
with the necessary deadlock handling. I'm not a big fan of macros, but it still
better then implementing the same logic at least halve a dozen times.

Please note that only the first two patches are more than compile tested.
And this only cleans up the tip of the iceberg, just enough to show the
potential of those two macros.

Please review and/or comment,
Christian.



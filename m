Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BE9C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 05:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A784D206D3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 05:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg1qWTXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfLIFJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 00:09:03 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34939 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfLIFJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 00:09:03 -0500
Received: by mail-pl1-f196.google.com with SMTP id s10so5283814plp.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 21:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3DXJ363+5xl2j1sX57ViRMxkOHfXjAx7yBh65KBs7ig=;
        b=Hg1qWTXro0aY3M/28qvCS4/SGnYd6+V8hCdu/fDuLOGUNjGoSJzXX3tDQaeFAcjrAG
         xlptcKXuTbDCkWEtxcaULgeB+sSqicfWMdTWsyEr2MkyxFIvhhXxzAFnl5rFYJfMOVyf
         dIIcqZKlyS2/+bCudDkUAr7/zuU1xCeImimG5Yu4JdrQs6++4jSbmgoNcEqbQNgF5g8n
         mBTQU0wbHw62z7R2HN2BQokegftX6VKpK/7uG7w2B740+xsoaUbMK1PO2Nzy3rx4/q05
         hThr6xbg1McIBUxdphO/mq5eZnylZTxpxKLzjgDA5qJ0AH/8LPLFJl3ykPDWsYh4MxL7
         EFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3DXJ363+5xl2j1sX57ViRMxkOHfXjAx7yBh65KBs7ig=;
        b=qlt/Qtq5WF6/LZ+ZDF+mVDqTsZRaaCq6iQRnHX8RzRA/yt6Oz3j7s9yJGBuCvedi1e
         pT1cLuoLj54/F5cWhVw1KYQ43XAbOVSB/JcupqYYGVtv8VAYDcDF1K8/I68JA0s05Hsq
         y1Qd7a2z2Q6OiiP1ukCwNH389mR5QpqBS6YsgzvpDdEcMv/D6UUIzloDnK5Ph4Vgf+pC
         XAzzFAj2zMCsQ9lVAkyPcFhiZD5Gq7AHRGLo6IVdnXhfaIHJYSzeYaTGXiN11G2D50pk
         RxL3PPEL8ABbF03xzMQ9QUXQOrxeezXU/SSc5CJ6opOcqIk9GmKYnHpk36NL4GKrpki3
         A+lw==
X-Gm-Message-State: APjAAAUVJOhcg/hRJxNr+HRAAJv7Y7zz7a/LjaEhSovAl5cvbSiFVTGE
        5OKDly7OkMMnM3PbZ3+H9D0=
X-Google-Smtp-Source: APXvYqzDp9QuVREtu7B4v0No/Yw+NgfbfvOPW4JKEGtuUyYRp07XFr4wWIb/z+eod004W0fwCJrFpg==
X-Received: by 2002:a17:90a:2188:: with SMTP id q8mr30061625pjc.47.1575868142620;
        Sun, 08 Dec 2019 21:09:02 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id k15sm25752119pfg.37.2019.12.08.21.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 21:09:01 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] tc358767 test mode
Date:   Sun,  8 Dec 2019 21:08:55 -0800
Message-Id: <20191209050857.31624-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series is a couple of patches exposing TestCtl register of
tc358767, which can be pretty handy when troubleshooting link problems.

Changes since [v2]:

    - Series rebased on 5.4 kernel

Changes since [v1]:

    - Debugfs moved into a standalone directory and is now created as
      a part of probe()

    - Added tstctl_lock to ensure mutual exclusion of tstctl code and
      bridge's enable/disable methods

    - tc_tstctl_set() changed to function only if bridge was previosly
      enabled

    - Added comment explaining data format expected by "tstctl"

    - Debugfs permission changed to reflect write-only nature of this
      feature

    - Original commit split into two

    - Minor formatting changes

Thanks,
Andrey Smirnov

[v1] lore.kernel.org/r/20190826182524.5064-1-andrew.smirnov@gmail.com
[v2] lore.kernel.org/r/20190912013740.5638-1-andrew.smirnov@gmail.com

Andrey Smirnov (2):
  drm/bridge: tc358767: Introduce __tc_bridge_enable/disable()
  drm/bridge: tc358767: Expose test mode functionality via debugfs

 drivers/gpu/drm/bridge/tc358767.c | 184 ++++++++++++++++++++++++------
 1 file changed, 148 insertions(+), 36 deletions(-)

-- 
2.21.0


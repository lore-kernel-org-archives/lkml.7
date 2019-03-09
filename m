Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F45C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A4A207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sON0Sdg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfCISbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:31:13 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:44910 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfCISbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:31:12 -0500
Received: by mail-qt1-f173.google.com with SMTP id d2so852264qti.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 10:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9yKIfocmQj+Rq3figk5hbD2WwJMA03nXK1qU9rQ1hxM=;
        b=sON0Sdg9E7+9aXXk/d5mqs4d+2xl76Bxy/aC+Qr/65BgAvl10x3ZVc3ef5qqiEkcCM
         /ZIMtUlZBvGh3FKt9nXMx8W2DewhhBdCO5nfDFS4aRzjYx6+zJUhKdBWCRgI3XnVrhdV
         AiQjKysXN7XAwx4Y/ot/uYU7s94Zxorc05j80gAxS1ECKJNcDytxcC0ZjLtKto4Xuhfa
         eGr7bJG3I1CT/YoqBaTVW6lnvrCc+YG/r87FKBOSq71kiq4/T9VeyJ5sxXCtcCWCUzyd
         mr58EgTbh+NRV+wzZplWtb8p/ckSJYENG80RqSkUY9nho7fu0em5orhF6eeU1EC++s/p
         LL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9yKIfocmQj+Rq3figk5hbD2WwJMA03nXK1qU9rQ1hxM=;
        b=jamHT6Gk/6QYyjIZII5eRzX34nc7iQ2ZBy2XnzByJGOvJ16CKcRzprIUMWYYYJsyNO
         2vb/1GRg5kRZiG+K0kSRpgAwQl2Y7R1KTUctcU+05aoGbLnzM/eXttO1ukkfW0pwAlAS
         Ms+GCXyvUeO79CjWJHVgmB2VE8tT89gko2OoOUiqH11XfQyWdQeBM2uC3eUjUCiXGo8k
         JZCWRxE1fG/xmKCfk8lqPX1JKE/ilpI5fVddEw9ghmZBiCD6tE1URjZ3P/IWetHFsnG5
         4862DogMDgdAi9NCmI/P5r1JNnpRrMCbWYUxD4Vn/ZQBzb9IK46/WHNBE13n7soLMTcR
         wk6Q==
X-Gm-Message-State: APjAAAU0R6duIQ/WfE6cTq/DNgu4sgvMlgZVj5Ev6aEArTUnPWaUwOPY
        O3sQMl4dADjzMujnz0ypFgI=
X-Google-Smtp-Source: APXvYqyoorCKgM/l3ez0w0QJ7PU5nZzE+Hr/A5/DqmAVdfvLKoLFQN6y2SSvCa2g1MGy0C+3c4XBog==
X-Received: by 2002:ac8:1c0e:: with SMTP id a14mr19274578qtk.259.1552156271585;
        Sat, 09 Mar 2019 10:31:11 -0800 (PST)
Received: from localhost.localdomain ([191.8.88.159])
        by smtp.gmail.com with ESMTPSA id f8sm558824qkl.11.2019.03.09.10.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 10:31:11 -0800 (PST)
From:   Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
Subject: [PATCH 0/5] Fix several coding style errors
Date:   Sat,  9 Mar 2019 15:30:42 -0300
Message-Id: <20190309183047.10781-1-gui.maeoka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix space around operators, pointer definition, constant on the right
side, assignment outside of if condition and else to follow close brace
at staging: rtl8723bs: os_dep.

Guilherme Tadashi Maeoka (5):
  Staging: rtl8723bs: os_dep: Fix assignment in if condition
  Staging: rtl8723bs: os_dep: Fix space required coding style
  Staging: rtl8723bs: os_dep: Fix else to follow close brace
  Staging: rtl8723bs: os_dep: Fix space in pointer definition
  Staging: rtl8723bs: os_dep: Set constant on right side

 .../staging/rtl8723bs/os_dep/osdep_service.c  | 52 +++++++++----------
 1 file changed, 26 insertions(+), 26 deletions(-)

-- 
2.17.1


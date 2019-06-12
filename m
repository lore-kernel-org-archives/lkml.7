Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E1BC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3036D206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXljOS9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbfFLEvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 00:51:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34241 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730250AbfFLEvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 00:51:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id c85so8869045pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 21:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+tVeozzvulLUwaDZlww2OwCv9jqjaP7+AKjXeXEP1kw=;
        b=qXljOS9GdbYUhEM576X6M+dFkz7yhLw9ykyWiWjr12gOx0ZyQ6wf79IkerbXOjLxbs
         omn23QrzwJi+x5Ugv1CIm+CBJ252vIZo+5SyG/HEkr6W712BRJjdth39DWN022G3ZhxK
         aPPso9D5OdmM2OVQktkwg68itVWTJqM/zZCCs18R8lxbpGyF9mktscszcoc6rOIn+wIJ
         ZsEMwuVXYaLVQc/pKywgsadJ02KUrJ881PWBQPPW/1PLk1pvYV3e5aZk0TQrT1Xj7Lw/
         3QbjQwpRk9mt2fMfFjqg9FLOyWI+A5HL1ldNgNQEYmfH2NVQGNDaITb1ofp55VgskKxE
         RCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+tVeozzvulLUwaDZlww2OwCv9jqjaP7+AKjXeXEP1kw=;
        b=B3BKuX7Gi9ievTTAMc8EV7zk2uQNDUCLJNMWQloYsgLSky7w0krUuSe5IU5sraOpHB
         MEPVgUQmIbs6qOyggGxP2WzLhS1Asb6jLW52nLuDfbHRubQ5wsvHJyCsiHozbzikC/qy
         se6Yb8FbYM8BQUh+0nEoIt73pbqMubv5eOjN/9THPUA5nrlrQag7IAlh3Bp8V4G77f9P
         JGxJ6xgdoFiCHxoCYk9BlHfo7jBQEHNPDPJ53iPoNtSFxe/vbyJCva9tDyOA6Qv0dnVd
         3lqM5AGqS2BGmsLXz8Xvyr9a5u/1vRdzJXwg6cwtAhC28PptqHpUg+klpN5XvbV32a5i
         lrCA==
X-Gm-Message-State: APjAAAVJ+6rw7YoKMykHuIz3aZjoXtwkb33IUuiIu5VWJ+4xdJD8PI1Y
        yNBelmPjPyrxdXmSJFVqm/wOmyw4
X-Google-Smtp-Source: APXvYqwEVUC6RXo1xkm5/gJsrJQSpL1BbEZH9JL/KnmFBUuWKvwvdOk5Uiw78GjHk9Mn2X18nAkRxQ==
X-Received: by 2002:a63:4c0f:: with SMTP id z15mr23099098pga.245.1560315112063;
        Tue, 11 Jun 2019 21:51:52 -0700 (PDT)
Received: from localhost.localdomain ([117.192.27.213])
        by smtp.googlemail.com with ESMTPSA id t184sm1072719pgt.88.2019.06.11.21.51.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 21:51:51 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, straube.linux@gmail.com
Subject: [PATCH 0/2] staging: rtl8712: cleanup struct _adapter 
Date:   Wed, 12 Jun 2019 10:21:29 +0530
Message-Id: <cover.1560314282.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In process of cleaning up rtl8712 struct _adapter in drv_types.h I have
fixed the camelcasing of lockRxFF0Filter and wkFilterRxFF0

Deepak Mishra (2):
  staging: rtl8712: Fixed CamelCase lockRxFF0Filter renamed to
    lock_rx_ff0_filter
  staging: rtl8712: Fixed CamelCase wkFilterRxFF0 renamed to
    wk_filter_rx_ff0

 drivers/staging/rtl8712/drv_types.h    | 4 ++--
 drivers/staging/rtl8712/rtl871x_xmit.c | 2 +-
 drivers/staging/rtl8712/usb_intf.c     | 2 +-
 drivers/staging/rtl8712/xmit_linux.c   | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.19.1


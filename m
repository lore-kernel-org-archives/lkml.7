Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2098CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5CD2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+zr5iHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732488AbfC0BvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:51:06 -0400
Received: from mail-it1-f181.google.com ([209.85.166.181]:37708 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfC0BvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:51:04 -0400
Received: by mail-it1-f181.google.com with SMTP id u65so14158240itc.2;
        Tue, 26 Mar 2019 18:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lZv19LqgJe3wIkOqteq6ZbmwjkrJJSrMfC6YqHvUPfc=;
        b=R+zr5iHPSRoPt9bhvrsvJ0Peqojj2+sedZOBtaTegV0VkOZ32vhSg8/X/tmKVji7wa
         WpUIHuMDDn75GoB1cJ/IgSIlCkENq6NQzlYI5Ku/+LivXkyPqnH2bgJ7kgxhHAakKIu0
         lWwOQAwRIzXv+hzTg2LXZZuV1tB9gONKisYOEIX0rlZtXjlCsLB5ERVYKjoPI8pLlG7X
         BpJBFJVbtXjJhDzXzAI+db/JrdZEiuZOLYEobeoXhx1jebp3Q5RVvfqA3GSHkV1GBJPO
         fkPkbr0DDlACfbjvBdpCcGEfMblcUfFCm/ydETwjNKZo41IccF5TSgTsxk39Cm1LWTK8
         ONMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lZv19LqgJe3wIkOqteq6ZbmwjkrJJSrMfC6YqHvUPfc=;
        b=bs4nX0BUU80LlJmPSqGmUTPkAGOuOboTY6tviZbEuAhKKYlbQMjpSPethND8HZQCl3
         NIUanoqvpSYx+px+LbIuxugS7fB88wjs3+FH5XNy/Ic82K+OUZWhSmg/leZsj4K8OtGu
         aTE464xsXDJ/wjD25Yc88LUVNhdTL3iRzO4Q+euxt9stUFPIKeN5ZhT4kNEIeWJR+xO+
         eN6N+Cg/XddZM+A9QWSH4LoYnn9jgm3bxp0pEq8C2Ug/IiHz+miA91XGTaCE3hd8vxJe
         KmNxhoZyGb9nJWvxyXhXU3D4qEv0Bu1C1g52wT7vY5lVd/CGGn0ChyJtvnkQC5s++OHp
         DDrA==
X-Gm-Message-State: APjAAAVLpQriMSyZurRqSNp5E+Cvhft9CB878++iZDicSAAY2PZdtJae
        gEIM2ufZducrOLBN7B6VCnY=
X-Google-Smtp-Source: APXvYqwiIhaVHym9Mqc+hbwstazplUv1i1KkuTjrrLzk1s2Q+Dx5LhvOdSXQPtU7CfnyhQ3/gDVpQA==
X-Received: by 2002:a24:5ec2:: with SMTP id h185mr1865931itb.19.1553651463864;
        Tue, 26 Mar 2019 18:51:03 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id e27sm4550040ioc.14.2019.03.26.18.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 18:51:03 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] staging: mt7621-mmc: correctness fixes
Date:   Tue, 26 Mar 2019 19:50:55 -0600
Message-Id: <20190327015057.9568-1-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now formatted according to checkpatch.pl, not my own semi-coherent sense
of what the kernel style should be.  No functionality changes.

George



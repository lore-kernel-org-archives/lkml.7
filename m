Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ADEFA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1670214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lq9z93Sq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbfKGJml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:42:41 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:45277 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbfKGJmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:42:39 -0500
Received: by mail-pf1-f177.google.com with SMTP id z4so2219658pfn.12;
        Thu, 07 Nov 2019 01:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uQYM89kRHH7dgWnRcZbS2fUE+Evf4zfFUahI2yZQehQ=;
        b=lq9z93Sq3s6768GZXvFx2wGQOdf8EhVyRlKanIlIJPwRqzP1b3jXyFPHy68rMvGk5v
         El8fBttPpQbH+ZxJkV1MfOlpYZ27eYjlfDQD72kqqON/F8qp2o9nhhkoQaXOU+xYo44I
         Qmxdg/iadOFvliXX+Np/KRFQKDVU505UmNBrGakDW4Beulm24rYCGd+0jtz4zkqUxEeR
         HtF2PgoNvosgERH1MtGjhg01cFDAyttzbZHcv+Fe/mH5yi7lyKurDZuhKx9VcWucMB01
         Af2FOavz6eocOzlsJKdwMvjQXL8v0nMxhvkbdev8Ssfnm1fd3kxRqkcD0v+JgHwLKAbZ
         dg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=uQYM89kRHH7dgWnRcZbS2fUE+Evf4zfFUahI2yZQehQ=;
        b=Z1BBXiwV1MWqKS8ngKStAPx6lk1xiihP3d/l9sUeT9KEwDTfEC2o+4hD23QXSGtJqN
         xssSR+vZzlG9KVteqyJYg8dm8yYGxCUiNPr7poDf7ZNIrbIlGyvSpJoXTz9Hd196G9JK
         SZx9RaHDCH+bA2qu8LPhYoJ3wmRxHtbopaHMAC1og2QcAzzSVr8f+EEuwiZTGbVOz+3H
         dH/jwWLjoEbKMKhWu3jA2qvPEIZqwhkM5MbT8arfqoP60OOJWQ2Vtb4nAZV/4mpeiCLC
         o723nzYFaYkN22s++wp7fiytuSC/LhDTSugzAHs5fbw7TUWfEoJ9BCnbG+j8OHDjja0K
         iQ+w==
X-Gm-Message-State: APjAAAUO4ZzE6SX7HZKQv9dwlab+O7u4uEkOhwq+foXB2F6rTv3odLKw
        uUFHKSFLXjHGGoUF+aY84QQwtKqE5ZM=
X-Google-Smtp-Source: APXvYqx6yGSJSOhtkKmiM095LncRp44OvC5Rd1pBrTl3bk3ZJHYS+Dr+3e+Z4xM+CbsnR+mKK0rKKg==
X-Received: by 2002:aa7:9482:: with SMTP id z2mr2764494pfk.98.1573119758546;
        Thu, 07 Nov 2019 01:42:38 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id 12sm1958195pfp.79.2019.11.07.01.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 01:42:37 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v2 0/4] clocksource: Add ast2600 support to fttmr010
Date:   Thu,  7 Nov 2019 20:12:14 +1030
Message-Id: <20191107094218.13210-1-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the AST2600 timer.

v2 adds r-b tags from Rob, Linus and Cédric (who reviewed the patches on the
openbmc mailing list[1]). I made two small naming changes in this
version that were suggested in review.

[1] https://patchwork.ozlabs.org/project/openbmc/list/?series=140990

Joel Stanley (4):
  clocksource: fttmr010: Parametrise shutdown
  clocksource: fttmr010: Set interrupt and shutdown
  clocksource: fttmr010: Add support for ast2600
  dt-bindings: fttmr010: Add ast2600 compatible

 .../bindings/timer/faraday,fttmr010.txt       |  1 +
 drivers/clocksource/timer-fttmr010.c          | 68 +++++++++++++++----
 2 files changed, 54 insertions(+), 15 deletions(-)

-- 
2.24.0.rc1


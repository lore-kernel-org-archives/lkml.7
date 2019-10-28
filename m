Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAD2CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 23:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7309A2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 23:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nlvc5i3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfJ1XBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 19:01:49 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:40505 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730303AbfJ1XBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 19:01:49 -0400
Received: by mail-lj1-f173.google.com with SMTP id u22so13150067lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 16:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=w88OVi9NUPe9HTwZlFh7dOWR8PhFSLUteBg6+LFvBn4=;
        b=Nlvc5i3yRy8+Wz1QPDQSV39J/dyh8GJGgtw13M+BldSQLYhFdElnRdGkz7WGYGiUaN
         9Aoh9Y6o2Q90vzhHro5qYrAkVx0Wz53gwsmtwiLeWwfqLaHJOaytCW55VkDpTkPMTmiT
         lGyc7An42NWGL2PIdnK4r4/qhejIqGj639YMlFwR0HYdWgKSdvTCPdcvI729Snqlm6sG
         lgij77Y+gaBRnxrzEK9hvZmuYB4GCA3samabvaqEG/Z/Z4E53Hbfc7MlmbOeNh5BSDNQ
         zusZ/mpgX7n6DngJgJl6MHF0bWU4GG4Uznp6hCgmueFjfBMh3FzKQc59Wxsy23IMLB9a
         gDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w88OVi9NUPe9HTwZlFh7dOWR8PhFSLUteBg6+LFvBn4=;
        b=MG4GC6nYU+9Z0I61Ce4+LIjLKS2owvmCZiKZFduQAWbasSjyAhjR141+6n6KAxOFi3
         15usXrcr/SvrPxZDUM0lAUQ5VPQ0bfdYGQORLcHSPJ6DErPkG7E5/bdPq1Q5mK8tIq2c
         L/emG9jGY+6qgMVPfzoWvuwu1DmD8npg/TjEATVrsRmBai/3o4AjykbW8PJSBnRuYaRU
         f2gDQpHoSJKXwoRN1TN+Zlij2iBYkwTyP/3tOhVVbY4Upng3ES1xHFSTqb/TDR05SveD
         VPObNyPpxmOfVibCJYk0asAyyh10Nz7lmjnh5Ncbmjvo6baKLstkIjSz+otQgL1zuCER
         3Vrg==
X-Gm-Message-State: APjAAAVjqPGdHhpvSEEq1U/ISVuOSgEdKIsfD3ZHouX6rXJCKoZ4jmEE
        JBxmgQ1VkQOmuK5aM3jNO9IlU5J4KvqJWw==
X-Google-Smtp-Source: APXvYqyH0OEdAHS1RNlEhIKr3mypNxf6Jx870MTcfbi95abRheA/Cmp0W2GjDQU/86WeOx6VlTVBuw==
X-Received: by 2002:a05:651c:28a:: with SMTP id b10mr152809ljo.193.1572303706849;
        Mon, 28 Oct 2019 16:01:46 -0700 (PDT)
Received: from localhost.localdomain ([93.152.168.243])
        by smtp.gmail.com with ESMTPSA id v9sm5676566ljk.56.2019.10.28.16.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 16:01:46 -0700 (PDT)
From:   Samuil Ivanov <samuil.ivanovbg@gmail.com>
To:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Samuil Ivanov <samuil.ivanovbg@gmail.com>
Subject: [PATCH 0/2] Staging: gasket: Implement apex_get_status() to check driver status
Date:   Tue, 29 Oct 2019 00:59:24 +0200
Message-Id: <20191028225926.8951-1-samuil.ivanovbg@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the TODO list:
- apex_get_status() should actually check status.

First patch implements the check.
Second removes the TODO comment in the function.
*** BLURB HERE ***

Samuil Ivanov (2):
  Staging: gasket: implement apex_get_status() to check driver status
  Staging: gasket: Clean apex_get_status function of comment

 drivers/staging/gasket/apex_driver.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.17.1


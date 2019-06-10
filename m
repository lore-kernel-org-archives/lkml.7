Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B139DC43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B8620820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="rcWrdec/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389466AbfFJUFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:05:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46689 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389170AbfFJUFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:05:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so4846611ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 13:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8SF78ZtQnVw4meJ8EJONYZwlPUHgQPUvTSa99AqdBgU=;
        b=rcWrdec/E9sDrmrCQDZ06tIyqcs5/k1EUESVSY+S1Cg6GQn6h9qy+BDmoYs1wsVg9I
         g42UkqXkrAlUMW6nP1Rz/XFK/wQj/GaU8nTQfeHt4ng8NonfnxijFoYq3PQ93p3CXGcT
         G32Heb8dJxd1L3dQzfANtPaMJmYEYuUiw29MRS/QWD8Os0kG/QpqN8bC62USIMOgwh0i
         AhIRRPuXpLl5MCITpL8Mjn/OT+EqwnS2zIAKR/9xz0bLbPAY7h1dqyubaOd5ORjJ8PqZ
         +TVZxzuabviG985UYi73kxFgNhhuBo81kUv4NC29vZLRUmtg5F6N/k7NuHKE5b2KpFRA
         1biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8SF78ZtQnVw4meJ8EJONYZwlPUHgQPUvTSa99AqdBgU=;
        b=C7h6l4bClLXQDPuaOVDjYVEXCCRjJLcxjrtoefRHMDLGYvOMGHbLS8hwUctDe/zREx
         lF4gHYyHcYfCW7G7Sz55Yp3BJKsfn4v/oWXGxfSmGLAjCeetjt1nEPR5HXK9UCOw1dKU
         1gLBmY5U1GAFtkRRHk7tImOmhF7HPIf4IXkC5hhpH9o/UNoJT78d9VKzR3cQPg8hn1ki
         MvBW8YpdHrwtC1J22ultax0HZWjHviALflL8QV799yeDg8Cq52DCKDSwAMabG3qAS1sH
         5gD45ll+F5u8ioxqX+dJpQD+QDdrEYYA9rrmmD0aW+1sS2Fez/x9mlgq5bD/nhGClxjT
         5cIw==
X-Gm-Message-State: APjAAAVPKMitqQQVZzl8k+KCMST4hJrjmZ3kHHjWmqU5qaO9ZlaJAdJV
        sLPPIkdkBdyb5eyeKaLQzbp4ZA==
X-Google-Smtp-Source: APXvYqxJkhuh6OlUK5H+u52AQvvvP//n3NzjSE12meA4CT/a1rcVee2qlkuqgalMfr2jAg57HDvkBQ==
X-Received: by 2002:a2e:86c1:: with SMTP id n1mr14005941ljj.162.1560197150994;
        Mon, 10 Jun 2019 13:05:50 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id f4sm2157079ljm.13.2019.06.10.13.05.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 13:05:50 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, jeremy@azazel.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 0/2] staging: kpc2000: minor fixes in kp2000_pcie_probe
Date:   Mon, 10 Jun 2019 22:05:33 +0200
Message-Id: <20190610200535.31820-1-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches fixes issues pointed out by Dan in a previous
staging/kpc2000 patch thread: many comments in kp2000_pcie_probe just
repeats the code and the current label names doesn't add any information
and makes it hard to follow the code.

Rename all labels and remove the comments that just repeats the code.

Simon Sandström (2):
  staging: kpc2000: improve label names in kp2000_pcie_probe
  staging: kpc2000: remove unnecessary comments in kp2000_pcie_probe

 drivers/staging/kpc2000/kpc2000/core.c | 80 ++++++++------------------
 1 file changed, 25 insertions(+), 55 deletions(-)

-- 
2.20.1


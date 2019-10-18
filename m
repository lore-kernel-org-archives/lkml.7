Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F129CCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D4B2089C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571408326;
	bh=gbykv9nMtwMQlIUqBAMFa2v3bGhqnDSJo2k7LMesMt0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=UUMPvM7AuHSS/DOBKJqdVVecJIwPMBXvPXPVev3V1UFarfLnKJhQzROxi4EeEV5xX
	 Ou5NDhvIys9GPwIXl5hbvvtYm4jKT3FI1p6RHWoWdP4JTkjZ9mHE5VZV/H1uN3SfI7
	 9GTv6gGZ+RYvTasuPUHh/i7n/8iDSLirCKNiUP58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410323AbfJROSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:18:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34169 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442881AbfJROSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:18:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id r22so4875596lfm.1;
        Fri, 18 Oct 2019 07:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6BOAy3JriHt04l5K3CVmH90dmduPZlD0+xmomkF+NEQ=;
        b=odu711jJyg9v3OqLcbHX8axO1JtZg/kfz23S3624OfEIAbyDuXP5rmBjEOSYNrdk8a
         Nwh9S4ZscZL48NsOXbbnuzBg0K3S3fGwkYUbJYTRLBMhrnQtBP53xpkDjTwGEfDo9SZy
         1cGyTvYEIvYTzPum594hDVUQvqJXO2H7uwNG1pKNu71s+iOEczGitr2c/GCdfq0/9LrL
         na+ql8A7Yg3YTmvI2PqrlmziKwxdHNn4oc405ge0pLlcBkqYRe7eTTnUhXQRy1Mn0k53
         UzgagbmO2Ua/Ns248qVKHasqTOnYyaJ2Kf+mzlY2+pf0rF2349u0oi/ldiZvYM+SvI+G
         9AJQ==
X-Gm-Message-State: APjAAAWrOOXEFs7VYCnMQs5UNSShOJH7Aeys4QcmOqNGpzOJsSvaBa9I
        YLLilo3UyOFcy/6PjTixVgE=
X-Google-Smtp-Source: APXvYqyOUPb5hV1qygpu4XWDBZ5RKw7Xjf72FI7+wSTcvEdZuEtht1cEcI2gNCCYbOuLtQirvmYNVw==
X-Received: by 2002:a19:ac46:: with SMTP id r6mr6310670lfc.127.1571408317700;
        Fri, 18 Oct 2019 07:18:37 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id x3sm2294029ljm.103.2019.10.18.07.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 07:18:36 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@xi.terra>)
        id 1iLT5c-0006C5-CO; Fri, 18 Oct 2019 16:18:49 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] USB: ldusb: fix ring-buffer bugs
Date:   Fri, 18 Oct 2019 16:17:48 +0200
Message-Id: <20191018141750.23756-1-johan@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot has been reporting a slab-out-of-bound/bad user copy in ldusb for
some time now.

This turned out to due to a bug in the read() implementation, which
would have read() access the uninitialised ring buffer and leak huge
amounts of slab data on URB completion errors (e.g. disconnect).

The first patch plugs the info leaks.

The second patch fixes a couple of issues in the custom ring-buffer
implementation, which before the first patch also could have led to
info leaks.

In an attempt to avoid copying the ring-buffer entry to a temporary
buffer while holding the spinlock, I added an smp_rmb() before
copy_to_user() which I think will suffice, but I'd appreciate if you
could help me verify that. Hence the RFC on that one.

The first commit could go to Linus meanwhile.

Johan


Johan Hovold (2):
  USB: ldusb: fix read info leaks
  USB: ldusb: fix ring-buffer locking

 drivers/usb/misc/ldusb.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

-- 
2.23.0


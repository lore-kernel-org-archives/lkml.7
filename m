Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0920C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 22:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E0420833
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 22:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="s/VAevDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfERWls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 18:41:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39363 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfERWlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 18:41:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id y42so12181753qtk.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 15:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YfANJ0NjSuT03hGxYrrybmRloobQ2aNV6k4ZVS8sjkk=;
        b=s/VAevDUzrN4FYKLzj6wS9/MMwq+kuH3vDcW/F4Fujom2rI550pYSulPYPa2DHYIoa
         vziuEPs7+KFZKSOy4dl3S8XsA3rR1xpt4h67jOFUcGvczSirRSoPZZ+ophuYFsVN0nKA
         KJXJ7PjsM6A0QMDUt4mE2IpJKVMc0JBo+JQlHXzpUXpOCQi3bR+vLnDAiEUhXrmDpJpx
         2jS67Tl+3ptVLwfqcKW8MDhwDjGiqfldiuA3Byur4rqXRY2LArH0gKJQirF/Ybv2wWXT
         9PyynABXznVJI7sX4K9U1EYK+stMfTaBmSqOdaQWcTOgDPZVPt6aFNn6D0wrEJNNO2o3
         rMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YfANJ0NjSuT03hGxYrrybmRloobQ2aNV6k4ZVS8sjkk=;
        b=brvrc8h6QgXssJq6Jnmp5lSsv8NcPhIcLGUzr6LRUtl7DOcDB8ZVoO3uhembVAonND
         ZUpTFj+YK77lxAi3izEltf5rIEoC12Oma72ZdohH7yKouuOSNzjNAtWJ+1zaUgn/7V0/
         yFpYSJqLowUd4+Qrr8HwFveyQg0cxhU146Y9BptccSJMxWaBcdSovVb/76yuoWruLQaf
         XeGBHxV9S4meftYQDgPM1wODuRgYfLso9hSextloAmQv2+CbLboSPAD1VHmlm/RmsneW
         TXI75bYXZWJbp3i+Z8PNR70yen2nfLDVwCn0D8jI77i4GBzRL/+lfOYgDhPSDoHtmvOh
         5BWw==
X-Gm-Message-State: APjAAAVgx9wle30mjYVhgQ4douqZfOYdJMqUPiWvhsefpcSqFQSjct8D
        ZJzrUz3R9CobYvfG/ktVAqtwHg==
X-Google-Smtp-Source: APXvYqwdNGqtocpFV8e81epFjCB39YB58+eSXKAmOz6uUNBChWqLKg71GxYgbQw6wTK6oeDaMXtTQg==
X-Received: by 2002:a0c:94b9:: with SMTP id j54mr14290525qvj.54.1558219307081;
        Sat, 18 May 2019 15:41:47 -0700 (PDT)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d32sm7348992qtk.0.2019.05.18.15.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 15:41:46 -0700 (PDT)
From:   =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
Subject: [RESEND PATCH 0/2] Enhance dt support and channel creation
Date:   Sat, 18 May 2019 19:41:34 -0300
Message-Id: <20190518224136.16942-1-barbara.fernandes@usp.br>
X-Mailer: git-send-email 2.22.0.rc0.1.g337bb99195.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches set a struct of_device_id with all the devices this
driver is able to manage and also add a macro to facilitate channel creation for
its two capacitance channels.

Bárbara Fernandes (2):
  staging: iio: cdc: ad7150: create of_device_id array
  staging: iio: cdc: ad7150: create macro for capacitance channels

 drivers/staging/iio/cdc/ad7150.c | 39 ++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 17 deletions(-)

-- 
2.22.0.rc0.1.g337bb99195.dirty


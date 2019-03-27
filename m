Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB245C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E432082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E40OAaz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfC0W2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:28:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39552 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC0W2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:28:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3so6912514pga.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 15:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v2fLDJLohMFc1kLJ2cYvqf1Mls9WFPVr5nSai/fXAlY=;
        b=E40OAaz39oi24C4XipMLcKBjEeNKFf/L1kN+YE5bI5PN65aB/H6N7XmfYL7ho04V9Q
         IaCx6pMrH5aiiIoHfS41QfxN0Ubi2tejW5CW0kvlJYhK6mY/weVkdgxqFhbym35PSoIG
         W15PTUPy2w9DbF5e3SxwQy/kc/ucjY/goaVq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v2fLDJLohMFc1kLJ2cYvqf1Mls9WFPVr5nSai/fXAlY=;
        b=rmqMG5cARSZ1Sy5yCzS1MdEHSlIl6MZM/Y8gU55iNTE8BH/CpyoGgGNJnOao5N9jzl
         groU3w9pIHSpkNPZ711PCVlO4yRjIm/pXhvDa/Pm5fq0yMju7GOntR0OBLFzjgdkfYRJ
         aK+Ll+GvlHbWwG38VeL9IqazDaEqaZwc9IzZaHQ5qH0WZTLH15yV62fhSoWvOVVoJktL
         6TUPy49qsbpC08dglxd0DOBVZjmf+9eFDvyyK745cHXg2xkal6rZ5B67hxOzeNYho8al
         QJ+a7AdbB1Y/vUzpnR5SsUvKnoXo+uMpfdbRL70K2m99sDKI6wyNoj9Yh8KgFGODQlCF
         9ycg==
X-Gm-Message-State: APjAAAXlXkldRbeqVthE2KFEZRCfB+CReT1iMBsuAcDZ9PB0Noufu91d
        BUACDHmtVwzdqTQGbGlSOciUuw==
X-Google-Smtp-Source: APXvYqzOYGYcyq7u9JsK1QFKXSpeOZMUFw7T+Ftd9LLv12sNrFE8EoPQZmg0PsTgkzu89Y0iNxkvvA==
X-Received: by 2002:a63:1247:: with SMTP id 7mr32325872pgs.352.1553725728973;
        Wed, 27 Mar 2019 15:28:48 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id p88sm36928347pfa.80.2019.03.27.15.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Mar 2019 15:28:48 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] loop: Better discard for block devices
Date:   Wed, 27 Mar 2019 15:28:39 -0700
Message-Id: <20190327222841.38650-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses some errors seen when using the loop
device directly backed by a block device. The first change plumbs
out the correct error message, and the second change prevents the
error from occurring in many cases.

The errors look like this:
[   90.880875] print_req_error: I/O error, dev loop5, sector 0

The errors occur when trying to do a discard or write zeroes operation
on a loop device backed by a block device that does not support discard.
Firstly, the error itself is incorrectly reported as I/O error, but is
actually EOPNOTSUPP. The first patch plumbs out EOPNOTSUPP to properly
report the error.

The second patch prevents these errors from occurring by mirroring the
discard capabilities of the underlying block device into the loop device.
Before this change, discard was always reported as being supported, and
the loop device simply turns around and does a discard operation on the
backing device. After this change, backing block devices that do support
discard will continue to work as before, and continue to get all the
benefits of doing that. Backing devices that do not support discard will
fail earlier, avoiding hitting the loop device at all and ultimately
avoiding this error in the logs.

I can also confirm that this fixes test block/003 in the blktests, when
running blktests on a loop device backed by a block device.


Changes in v3:
- Updated tags
- Updated commit description

Changes in v2:
- Unnested error if statement (Bart)

Evan Green (2):
  loop: Report EOPNOTSUPP properly
  loop: Better discard support for block devices

 drivers/block/loop.c | 70 ++++++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 22 deletions(-)

-- 
2.20.1


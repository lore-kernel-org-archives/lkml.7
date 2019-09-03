Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B79AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C8522CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kSu3Gk9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbfICQRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:17:03 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:47491 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfICQRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:17:03 -0400
Received: by mail-pf1-f201.google.com with SMTP id t65so6181415pfd.14
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UrlqrCIUzfMhHCe5wLYX0g77V45RijxDNiDyP3pgT14=;
        b=kSu3Gk9PM4NfwgdqpreP7IkrcxZKUGfh/Gg2sQoZAg2CdsYxa8/nOjytFhOHd2YQvY
         sDChXAY8pVl0ut4pI8JJimC7cOyd0egf6mtNQrRgTeRRPhG86RGOVUOEOHm74Xvg0TSJ
         ilk0dgeJec4iYaHwUhXXDvtacqrE65ifpiOtnrVSuFXQ6jBzvaqUGoRcTYsid92kONeh
         nsaIodZbK3IpsB54D+2AxH8vC8Pa1ApnCRHrDR46CLc6OcRjEgX4OygtVvPXTFgfl1Fw
         Pm3d5HVb8TQJLgrIL17SUCFT602XI4YiwEeKAzmEfeBcYZma/vBqdO3qUAl1OwUUXSlw
         96CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UrlqrCIUzfMhHCe5wLYX0g77V45RijxDNiDyP3pgT14=;
        b=H3zrX0mFSj2hxeXoK/118Ta6Md+O92WPn5UHmbkVExhyvMUfwl8YXducNDkTobPJSz
         asBwb4U2pmrkO0012UK1S6fVWPbMBCLkuFRM8l7ekDlUb373LXRXSbizoCBbL+3JelcN
         Q4tJhp6TIIe9b4gyKRSfbT/iphf+nRCP/UvUu8O/IQ5xiRijYMdrN3bckBgRMHga+154
         EJxFOyiU9i8InwOI37HbgLrhHkkO7TBsevY24Q2LMPEDJZqqm9v67/+40rByTtdnmA1d
         qi6XIa6jfP/V7lW7U0fxvLwM8XnjLWwWPk0QWnYNz7W5hXNv0GbHcpzG4zPil+RrfBLW
         Pnfw==
X-Gm-Message-State: APjAAAXE3H7u12nTC136enCV+uA/OFiD9KnXnzUo+ozF4mWxPcpARLcg
        XgyMwtmPxnsQlPuFqhWRtDHl7Qtag34=
X-Google-Smtp-Source: APXvYqx514tvSIuvTeW1+JBrh6dQloiVYGBy9lkamMCGeewg5BgyrCFeE8lQdhAeGjwqHdAf0hlbC5cQ+lQ=
X-Received: by 2002:a65:684a:: with SMTP id q10mr31337177pgt.417.1567527422227;
 Tue, 03 Sep 2019 09:17:02 -0700 (PDT)
Date:   Tue,  3 Sep 2019 09:16:51 -0700
Message-Id: <20190903161655.107408-1-hridya@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 0/4] Add binder state and statistics to binderfs
From:   Hridya Valsaraju <hridya@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Hridya Valsaraju <hridya@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the only way to access binder state and
statistics is through debugfs. We need a way to
access the same even when debugfs is not mounted.
These patches add a mount option to make this
information available in binderfs without affecting
its presence in debugfs. The following debugfs nodes
will be made available in a binderfs instance when
mounted with the mount option 'stats=global' or 'stats=local'.

 /sys/kernel/debug/binder/failed_transaction_log
 /sys/kernel/debug/binder/proc
 /sys/kernel/debug/binder/state
 /sys/kernel/debug/binder/stats
 /sys/kernel/debug/binder/transaction_log
 /sys/kernel/debug/binder/transactions

Hridya Valsaraju (4):
  binder: add a mount option to show global stats
  binder: Add stats, state and transactions files
  binder: Make transaction_log available in binderfs
  binder: Add binder_proc logging to binderfs

 drivers/android/binder.c          |  95 ++++++-----
 drivers/android/binder_internal.h |  84 ++++++++++
 drivers/android/binderfs.c        | 255 ++++++++++++++++++++++++++----
 3 files changed, 362 insertions(+), 72 deletions(-)

-- 
2.23.0.187.g17f5b7556c-goog


Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF72C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155F9208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DScvmQU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfH2VSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 17:18:30 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:57012 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfH2VS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 17:18:29 -0400
Received: by mail-vk1-f202.google.com with SMTP id r17so1850553vkd.23
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 14:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BW1c7IRnWjJoxQBtVPXO6COaVAzbUDcupsRP3+lK6WY=;
        b=DScvmQU+89L+hniqEK44TU04uVyqUiGLL9u5xg2ckht5a7CYd7E2LbeJo2RTqqmNN2
         ZRhaWXhwPL7tKn1cEgAFie5GiGnaKpFKFg7SmCIkGdQekr4q98LOlV4fMxG02PK9uHZC
         WoctCmJJGa70MK8ZZ8Yfnt/l05IgEzhqPuPhAoYrkOSF9AUUOhaxFwWJvtSGuxBCCHtP
         U1fE+DuLVt/48T4ldIdVCUv0RsvyvH8dPdH4mf9fwsVUAKa/eTGbKq5SspOi6yA43ngA
         QZ6+Jkrm7kE1CKneugmB5cVCaLDdPf5wlBnxZhkDwjN+uiCs23wBI3bg+qsQeY9EVGKG
         zqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BW1c7IRnWjJoxQBtVPXO6COaVAzbUDcupsRP3+lK6WY=;
        b=Za/ck7xguDhipcx0COq1sVsCYJkfRFZLlTsxE7Q+q4o9vzTOC9C+48ek6YfShYFaFJ
         pY5JDgyzIwTcyQTHOGjgVHiFkHHu4eiUVW0rxN4cZrulyMceH80XMVP7i+u5lTzh1f5V
         bP7q+Z4CR/q2YaO0vftq6L0634h1soT6c5O85lgl7mFKradkJD39KEX5C/a2dzP3YFbW
         YSj+Q4TvxJWf1nEvNhjOm4NBjcYGTqW2kaXhgjf062Ns3NIOKuuAKe3zXrWD70fPVWdg
         moOkny3BFuKLjrJFv/r0VbLEahJGVt4ZD8r4vxdtnyxBH4AcIlgz/KDhKJ7J9tDwiuIx
         DyiQ==
X-Gm-Message-State: APjAAAXjA7PHv8XOs5jF/xMmzt5dY4oVVIHWuISTXPFqKYpP13ic8CMG
        NEgBvbk7MfIL25RzE4qfLtF4PTJihVY=
X-Google-Smtp-Source: APXvYqyu46l4onHXaIOlHYncz+2ngOsHkdmb/+FxKLyBUQd7IXHI/mZdOzHaJoQ1YcZ8j38WtB/nO45BCts=
X-Received: by 2002:ab0:6648:: with SMTP id b8mr5538718uaq.99.1567113508553;
 Thu, 29 Aug 2019 14:18:28 -0700 (PDT)
Date:   Thu, 29 Aug 2019 14:18:08 -0700
Message-Id: <20190829211812.32520-1-hridya@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 0/4] Add binder state and statistics to binderfs
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


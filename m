Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0E7C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9ED206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfHNLkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:40:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38567 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfHNLkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:40:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so110777821wrr.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TfDFGn9xBFspmX5cBemBdinuQbO2xkupqQlduBuui6A=;
        b=L5Fhrv7c5vedy8UCmcPNRCfNmRzHIOBtQXiXM0TDHoqOsMt2ux/cB6Js0ZK5ChAZL0
         B3bPjKbUqUoqrtYQFUxRRwW74qIUwCmdXQodvkqhvvGbmpvPAGXplCrkDYwl5xZBNcio
         ypQ0++9sNyDZ7uPfcoiqDBK7Tu23zY/8ja9kIHFUAMBxHZa/CEJJGSMj0V8HdGQar/OK
         8vk/KWdvoaGFbSbBHktpi2R35D2/xhozCTRF/gac3NP7sJbLXZ2oQ4vxji5b88R8u62h
         HQSIj5RviSsniSVFkp862xpNDHvEHyNYYVN/vUDLbT8LM6rMIE5wXThoI96jwLMqp/zo
         Sz8w==
X-Gm-Message-State: APjAAAVtnbMVqk4DUIgbXNJNCRDUeYzlO2jvxBeN74cSQipQBvhfa3G1
        97pmn/lx1OzF0PEFEWDhn+Xyb6JKhwaU5A==
X-Google-Smtp-Source: APXvYqzcFoKfhorVqikyfuY9ZRC6b7eerGvEK4rndnPu8acr++apgjHIYDBg5sNyPg6Ubgueu8W9EQ==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr49123371wrs.348.1565782802049;
        Wed, 14 Aug 2019 04:40:02 -0700 (PDT)
Received: from localhost.localdomain ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id j9sm8924705wrx.66.2019.08.14.04.40.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 04:40:01 -0700 (PDT)
From:   christian.brauner@ubuntu.com
To:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Cc:     oleg@redhat.com, alistair23@gmail.com, ebiederm@xmission.com,
        arnd@arndb.de, dalias@libc.org, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, fweimer@redhat.com,
        palmer@sifive.com, macro@wdc.com, zongbox@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk, hpa@zytor.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v1 0/1] waitid: process group enhancement
Date:   Wed, 14 Aug 2019 13:38:21 +0200
Message-Id: <20190814113822.9505-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Hey everyone,

This patch adds support for waiting on the current process group by
specifying waitid(P_PGID, 0, ...) as discussed in [1]. The details why
we need to do this are in the commit message of [PATCH 1/1] so I won't
repeat them here.

I've picked this up since the thread has gone stale and parts of
userspace are actually blocked by this.

Note that the patch has been marked with v1 because I've changed the
patch to be more closely aligned with the P_PIDFD changes to waitid() I
have sitting in my for-next branch (cf. [2]).
This makes the merge conflict a little simpler and picks up on the
coding style discussions that guided the P_PIDFD patchset.

There was some desire to get this feature in with 5.3 (cf. [3]).
But given that this is a new feature for waitid() and for the sake of
avoiding any merge conflicts I would prefer to land this in the 5.4
merge window together with the P_PIDFD changes.

Thanks!
Christian

/* References */
[1]: https://www.sourceware.org/ml/libc-alpha/2019-07/msg00587.html
[2]: https://lore.kernel.org/lkml/20190727222229.6516-1-christian@brauner.io/
[3]: https://www.sourceware.org/ml/libc-alpha/2019-08/msg00304.html

Eric W. Biederman (1):
  waitid: Add support for waiting for the current process group

 kernel/exit.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.22.0


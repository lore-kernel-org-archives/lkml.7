Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79EBC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EA1206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="M/rwVKFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfGZJlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:41:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39151 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfGZJlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:41:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id u25so36758100wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 02:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sZakpoqaym6PsfEMEGIlfAyfufXMJwyfKIVWjWt4sec=;
        b=M/rwVKFHXcUBztKkbZz/jjMyEqkRgdmMkYGynHz2GkdLZgUM6lrZrdxevS1aQLNqZS
         8lnANdGaA3czqZdzzCBUC2Q89JJPWW5V+FCzrCtYga4jp835B2Gm9oQi+WseWTIFFZOi
         4zoBPWUW6QGDJ8h5NMzKSZaLrfDp4vPCimRfi32cecvn4VhfmolkC32ugAxhBWBx2Xb5
         dSXO09uWNIAvzVVuJjKLks7nKQUFcE6/yVWOD06GLkftgsU3EYHUGdwQbS08ZuIzn8KG
         L3TNZ+PD0AxuvAJYQzTnNesK1m1NOe88rd6PLu5oUXDUnSWHbMQsbhODmH/VYLy3Dw96
         na4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sZakpoqaym6PsfEMEGIlfAyfufXMJwyfKIVWjWt4sec=;
        b=A62PgFVXDa6M4b53qb/Glhk5mnL9FLTLRGiYntfceYbbONLvXk+TYlgg4TkrM8HQct
         6sNLmuq9XX3P16UG/PM7LwSOtjV+tq2lNN/J9svHqZVqUC/LthA22twpLUIird5Bz5rP
         ROcZTXdS8y0uAnU8S6LhxVv43YusZdYAnxWkJwr8E916nkWfcG9AQzbNg+W5whv4Mtft
         ulzs2wtzaPbiM4PKyNhYGI2qGl7YYxdItW0oL0+OaYSTDthyCfbW/Ya4teSPg2cKbfRb
         7vcfK7d7MrfwK2xAa08Cff51k+hEkP+uTyeCxofpzejVmbCxS2dw8g8dhZVrGknck8qj
         tqGw==
X-Gm-Message-State: APjAAAUytQ9E/fmyFYBnEebWWu38cX992FZ2WX8loOnlIHt5EGb9klDU
        nAP9hfev0Ha9S7UUXD1LYJOydWn+Hno=
X-Google-Smtp-Source: APXvYqza0l7ynfwjY4fT2uXw1gFK6yZFW5WnF2E8+aVo4xl+VlG6rlzd1OitPnjK4w4Qzkw4/be28A==
X-Received: by 2002:a1c:f415:: with SMTP id z21mr9822561wma.34.1564134063794;
        Fri, 26 Jul 2019 02:41:03 -0700 (PDT)
Received: from localhost.localdomain ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id r12sm61664892wrt.95.2019.07.26.02.41.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 02:41:02 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, oleg@redhat.com
Cc:     arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        joel@joelfernandes.org, tglx@linutronix.de, tj@kernel.org,
        dhowells@redhat.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 0/2] pidfd: waiting on processes through pidfds
Date:   Fri, 26 Jul 2019 11:39:32 +0200
Message-Id: <20190726093934.13557-1-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

/* v1 */
This adds the ability to wait on processes using pidfds. This is one of
the few missing pieces to make it possible to manage processes using
only pidfds.

Please note the following major changes (More details can be found in
the individual commit changelogs.):
- Add the new type P_PIDFD to waitid() instead of a new dedicated
  pidfd_wait() syscall.
  This is the same approach we discussed a few months ago and still
  prefer over adding a dedicated syscall.
- Adapt the tests to the new type P_PIDFD for waitid().
- Remove struct waitid_info patch.
  This will be sent out as a separate patch.
- Remove CLONE_WAIT_PID patch.
  This will be sent out as a separate patch.

The core patch for waitid is pleasantly small. The largest change is
caused by adding proper tests for waitid(P_PIDFD).

/* v0 */
Link: https://lore.kernel.org/lkml/20190724144651.28272-1-christian@brauner.io

Thanks!
Christian

Christian Brauner (2):
  pidfd: add P_PIDFD to waitid()
  pidfd: add pidfd_wait tests

 include/linux/pid.h                        |   4 +
 include/uapi/linux/wait.h                  |   1 +
 kernel/exit.c                              |  25 ++-
 kernel/fork.c                              |   8 +
 kernel/signal.c                            |   7 +-
 tools/testing/selftests/pidfd/pidfd.h      |  25 +++
 tools/testing/selftests/pidfd/pidfd_test.c |  14 --
 tools/testing/selftests/pidfd/pidfd_wait.c | 245 +++++++++++++++++++++
 8 files changed, 311 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_wait.c

-- 
2.22.0


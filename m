Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261DDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E245D2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0nuTi0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfCUH5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:57:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34774 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUH5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:57:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so3693703pgq.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wZG81c8dEeFwy7tgsH2gf9x5SLKzJTgGuvsMIcgLUpE=;
        b=H0nuTi0pwM4hCLCl+Vb+D5v+6ce+MoqF7Wlk/28pYWzie88QQSFtRuJmOeWn4kT4UN
         AQP/Klj4w8NU6rxZ/hYCAAUh5joiotKayth7tTSjIJrxK6jiIxxbMGa0tbJeC8QZ5SYt
         32NgN+AoNU0srsZHVwhznKLiVHGJ1wlRGuNe6GFc/BirABdp0g7OpKFFw6v6we1mPSUF
         mQnRVNikzziOtQOq3HPlKXyf6Zu+v+fYVqbh0KuWxvqqAjf09nSzpY9MYEnIdtanVjId
         tT3ypmixP6YwWWMmsv/pJUL9JNUYyok0XCvikozfCL0IXeiWOAztsb9sk/zeD/tyqiQX
         DDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wZG81c8dEeFwy7tgsH2gf9x5SLKzJTgGuvsMIcgLUpE=;
        b=FMpb2ZuxttO0bZ2GmH0jctkR2pfWxu/sjge46Vd2PTTw4KtpOFzUyQmerYuqPpQanh
         lAkqtjx1X+B6e3N76mEprbNPyB0PvoiaMJ3gVKs3ad/pcAcL3FpFHarYj7xp8V2sjdoM
         9/JWHjpeTQzeZcSVOP2q3YHFYYLTYwdy+HhGfdvgamH+l8o4XBs1jtVKQ8ZctwK3uIw/
         j2RPbqtMh6g2/b1vZd2VJXZW/hXPhVAVlsrE+VcwXzYhxhJQGdKdsNhq1DH/WC2S+DXM
         tjpp4FzyQ0EVZRMHJBRhia+WJc6W6cT0vCmflat78VuQYFYgsRYa9qvStKjE7jXnc47J
         XdjQ==
X-Gm-Message-State: APjAAAX8FrHyx11RpFP0/AnEEkx1vFAqVPv5EIfXAjJFJjnuNP1vHffM
        lcKVdHPIfRb5pSaR6JAuG2Q=
X-Google-Smtp-Source: APXvYqyge4QA8LQ1geVNj6LfFryDxX4mWkAeu/8/Rk79VAowxeNaBc6guiITW3JrvKx1kG9zmNyQSg==
X-Received: by 2002:a17:902:d715:: with SMTP id w21mr2133083ply.14.1553155053489;
        Thu, 21 Mar 2019 00:57:33 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e184sm6467148pfc.143.2019.03.21.00.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:57:32 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 00/18] locking/lockdep: Add comments and make some code
Date:   Thu, 21 Mar 2019 15:57:07 +0800
Message-Id: <20190321075725.14054-1-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

I recently looked at some system hang issues. While at it, I tried to use
and understand lockdep. These patches are made as a result. I believe they
should have helped me, so hopefully they do for others as well.

Many thanks to Bart, Joe, and Peter for their valuable comments.

Change from v2:
- Removed indent adjustments only patch
- Removed unnecessary if to else-if patch
- Made changes according to comments
- Added another doc addition patch

Change from v1:
- Rebased the patch series.
- Added more no-functional-change patches.
- Removed zapped locks in lock chains printing patch, which was a band-aid.
  The real problem was recently fixed by Bart.

Thanks,
Yuyang

--

Yuyang Du (18):
  locking/lockdep: Change all print_*() return type to void
  locking/lockdep: Add description and explanation in lockdep design doc
  locking/lockdep: Adjust lock usage bit character checks
  locking/lockdep: Remove useless conditional macro
  locking/lockdep: Print the right depth for chain key colission
  locking/lockdep: Update obsolete struct field description
  locking/lockdep: Use lockdep_init_task for task initiation
    consistently
  locking/lockdep: Define INITIAL_CHAIN_KEY for chain keys to start with
  locking/lockdep: Change the range of class_idx in held_lock struct
  locking/lockdep: Remove unused argument in validate_chain() and    
    check_deadlock()
  locking/lockdep: Update comment
  locking/lockdep: Remove unnecessary function pointer argument
  locking/lockdep: Change type of the element field in circular_queue
  locking/lockdep: Change the return type of __cq_dequeue()
  locking/lockdep: Avoid constant checks in __bfs by using offset
    reference
  locking/lockdep: Combine check_noncircular and check_redundant
  locking/lockdep: Update comments on dependency search
  locking/lockdep: Add explanation to lock usage rules in lockdep design
    doc

 Documentation/locking/lockdep-design.txt | 115 ++++++--
 include/linux/lockdep.h                  |  30 +-
 init/init_task.c                         |   2 +
 kernel/fork.c                            |   3 -
 kernel/locking/lockdep.c                 | 487 +++++++++++++++++--------------
 kernel/locking/lockdep_internals.h       |   1 +
 6 files changed, 378 insertions(+), 260 deletions(-)

-- 
1.8.3.1


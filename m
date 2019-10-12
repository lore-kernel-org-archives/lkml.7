Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39154C47404
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 00:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB3920663
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 00:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwdKcecD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfJLAh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 20:37:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46881 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfJLAh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 20:37:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id d1so11391386ljl.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 17:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f4Ki0HjVKaflfmxJ2byTawmZD59wBPdISnRBsFf1+EE=;
        b=GwdKcecDHoPtTKefPJDFPiTifnR2o2DiQsdu9eYxjZKHNGVh4M3eyOGTtSM4dIBG9w
         2RD8MYbieejLw0IVF+lNSxv0IoF0Tg5WlyczNlhvVquO1YUWfqC+lsZsa+DTKHu9ThbS
         t+PHqCQqQFlR0W2nZ4ZSIuYfyJmz7hREKLdbJEofiuaDJXYcxJNbydcD0h0c8WqVUJl9
         493ZoqzSV/+idkqjGDTon1NwD63dr4FCuieLRUOIjNQXWGJjMIBC2EOAfdD4LJ2YPLKp
         DXao1EjYBaRXqpKvw2MFhPr5LpYkb+twKkkUXKum9dBP/sPfT68zeszbwuqWLzIRsIQE
         MQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f4Ki0HjVKaflfmxJ2byTawmZD59wBPdISnRBsFf1+EE=;
        b=cZrZqU9vePX6/OU+9bMsvtkFY5QRXZdsqFHgHc5uT5VXWUa9huzcwP5TJlMT6sAfq/
         7igEovJXK9spZBNrsXivFgCtxQEWw6F4g4YolLqAy5iYGUinVqA4CHDloR0xeVh9jNuV
         Uq9sW2aaUz2a0rcu/OqzslQgVY2/ufWco1j1mZl5mgvEHOlD6zriGXDg4l+zStp/xug7
         oH9PnaWawXK57g4OWu0nIGCflPz9NPKpAnDsJkq8H94CwTvpWNQGiAy6vXmv+NLcahSq
         NgNfz2lUmTO4qrrYePQf0OArQTzx+REhvbHMT6VmhGo6+8QSu+4KWm4GDnAAuouEadhL
         r8Lg==
X-Gm-Message-State: APjAAAURSMpatZvWOesYtm5DZ9iYwMTxPr7hHOkCUmpmRjwBFGH2ZvMe
        UopsgWxHsyX4TIpW19sHoyg=
X-Google-Smtp-Source: APXvYqytgLNEilHpnDPZTz37dMIPamPyEfsAHb42Fyj4zkTggkCK5P5YAx4Af6P5wT6BgrshuxohoQ==
X-Received: by 2002:a2e:858d:: with SMTP id b13mr9538774lji.71.1570840646279;
        Fri, 11 Oct 2019 17:37:26 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id f22sm2346620lfa.41.2019.10.11.17.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 17:37:25 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 0/4] xtensa: fix {get,put}_user() for 64bit values
Date:   Fri, 11 Oct 2019 17:37:04 -0700
Message-Id: <20191012003708.22182-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series fixes return value, out-of-bound stack access and value
truncation in xtensa implementation of {get,put}_user() for 64bit
values. It also cleans up naming of assembly parameters in
__{get,put}_user_asm and __check_align_{1,2,4}.

Changes v1->v2:
- initialize result when access_ok check fails in __get_user_check
- initialize result in __get_user_asm for unaligned access

Al Viro (1):
  xtensa: fix {get,put}_user() for 64bit values

Max Filippov (3):
  xtensa: clean up assembly arguments in uaccess macros
  xtensa: fix type conversion in __get_user_[no]check
  xtensa: initialize result in __get_user_asm for unaligned access

 arch/xtensa/include/asm/uaccess.h | 105 +++++++++++++++++-------------
 1 file changed, 60 insertions(+), 45 deletions(-)

-- 
2.20.1


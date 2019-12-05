Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10EAC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9523A21835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgBkn5hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfLEVwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:52:00 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33799 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbfLEVwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:00 -0500
Received: by mail-io1-f65.google.com with SMTP id z193so5275443iof.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 13:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GRlSFT0QzdmXY4YjfE6+A7FuD4eMpUWLjxxFNql0P+g=;
        b=RgBkn5hqS5lY15vt1IV2Nrt1O5T1u86JM7Fo/iB48btQ2Pq6PMDfRU1866nDYUV2JB
         FeH8DnN8KlRPAePror5m+1MYfSiT/A9QOBUGsmRqyV1XI4AQgJRnhtyFJ8TQzp8RCmFd
         viPsCr+F6z7Ad0cGXCrf73mbeFEXyEsAXQEb5l1eRuVr/KUJSSXmYoHSJDU/NxOYe8/V
         GxPVlfCLRe2RHPe931PbDoX/D6uE7WMy8HMtcfij5OEYZgzReLF3JdnkV7/POhBpSNCp
         RIRwPvb03lbSe8etOb9uszxs9CRlsmARpoNr0DgZeW7IpPz/kRiutZ558Bv6Vx23Fsta
         HPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GRlSFT0QzdmXY4YjfE6+A7FuD4eMpUWLjxxFNql0P+g=;
        b=YgXHztMvUrkUI4lB8KfAVAG8R0W1yuXdP/jKXfyu8/ppy0YrjYS5u2XL129FVvV4a7
         QeDwUXIADm69uAua+q2a03Q3wjUYuU7hnDfFaluKatOkssoXkSyNHFNXHZFPl3hOdJf5
         adUc4xH29GP8sT+KdC3t+LHsvSgnsLaxIYK+wWP347ZA7OjtbGfHACpampRp9Km0tOAP
         1HtLdqJP2kqSi/nW9fQzTlI8RKwD6pH3xW0H1mSjdwKIw2nvSBsWIU6awoe/SSYtUpTS
         Bi17tZfXAIx5Y9E7W//ZwYBRTzluxS61ybuHgwJmfP+VV4SMfw0CoG2VQK5u06q8xoaj
         CIGQ==
X-Gm-Message-State: APjAAAVSF9BdsAwAHfMzDQwiGbXltBBX1deNrv8iwcttJVPzH+vDCcLz
        Rj9J+eCeFPGo68B4FbfqUGc=
X-Google-Smtp-Source: APXvYqxpR5g56lkPXR/d2Ejb5uzBPHEeHCdNs3iI+l5dC/igsZeMQlW5LhaokGNLMY9vxOljlTXgXg==
X-Received: by 2002:a02:3e83:: with SMTP id s125mr10729701jas.104.1575582719602;
        Thu, 05 Dec 2019 13:51:59 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:51:58 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 00/18] dynamic-debug cleanups, 2 new features
Date:   Thu,  5 Dec 2019 14:51:31 -0700
Message-Id: <20191205215151.421926-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes from v2:
  only claim one user flag, dont really need more
  fix patchset grooming err Reported-by: kbuild test robot <lkp@intel.com>
  quoting tweaks in Docs (unvalidated as better, but likely)
  rename to lib/dyndbg.c, update docs accordingly
  
changes from v1:
  dont drop trim_prefix yet, its harmless, and better supports old compilers.
  dont move externs to header, despite checkpatch

v1: https://lkml.org/lkml/2019/10/29/989
v2: https://lkml.org/lkml/2019/11/27/547

New Features (review):

accept new query input:
  file inode.c:100-200		# & line-range
  file inode.c:start_*		# & function

add 'u' user flag, allowing user to compose an arbitrary set of
callsites by marking them with 'u', without altering current
print-modifying flags.

extend flags-spec to allow filter-flags, which select callsites for
modification based upon their current flags.  This lets user activate
the set of callsites composed previously (u+p).

add negating flags to filter on absence of flags, or to negate a modification.

Jim Cromie (17):
  dyndbg-docs: eschew file /full/path query in docs
  dyndbg: drop obsolete comment on ddebug_proc_open
  dyndbg: raise verbosity needed to enable ddebug_proc_* logging
  dyndbg: rename __verbose section to __dyndbg
  dyndbg: fix overcounting of ram used by dyndbg
  dyndbg: fix a BUG_ON in ddebug_describe_flags
  dyndbg: refactor parse_linerange out of ddebug_parse_query
  dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'
  dyndbg: refactor ddebug_read_flags out of ddebug_parse_flags
  dyndbg: combine flags & mask into a struct, use that
  dyndbg: add filter parameter to ddebug_parse_flags
  dyndbg: extend ddebug_parse_flags to accept optional filter-flags
  dyndbg: prefer declarative init in caller, to memset in callee
  dyndbg: add user-flag, negating-flags, and filtering on flags
  dyndbg: allow negating flag-chars in modflags
  dyndbg: make ddebug_tables list LIFO for add/remove_module
  dyndbg: rename lib/dynamic_debug.c to lib/dyndbg.c
  dyndbg-docs: normalize comments in examples

 Documentation/admin-guide/dynamic-debug-howto.rst | 176 ++++++++++++++++-----------
 include/asm-generic/vmlinux.lds.h                 |   6 +-
 include/linux/dynamic_debug.h                     |   5 +-
 kernel/module.c                                   |   2 +-
 lib/Makefile                                      |   4 +-
 lib/{dynamic_debug.c => dyndbg.c}                 | 285 ++++++++++++++++++++++++++------------------
 6 files changed, 285 insertions(+), 193 deletions(-)

-- 
2.23.0


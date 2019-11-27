Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F2FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1F920835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1qEAryW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfK0RuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:50:25 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:34069 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfK0RuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:50:24 -0500
Received: by mail-il1-f195.google.com with SMTP id p6so21820291ilp.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 09:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mKRm+kUhexHkuGgI+4MqUr107/iLfqSeR0S/QaIpNT8=;
        b=Z1qEAryWSPDgL0Qx2hbSTyQUqA1HrjAytee63ZZ6Yq3KMJLEFXlhAwfboGCgudRhES
         1PCWrhNpLEDSuMEBY0IkxdcweFJRHfkdbFi2c6n6pyaQoUbV/mpWg2oQHUr3LxLEipTu
         bz0sxhyITXBrFxy/8Yl2dOgOpJlK3PxuPnNOLnWb42D73FvV345dThdLsi+WVuKSBceb
         +peK9TAh7QnSXXS3Y/pM7xkzzSpUiKHrS0JQTkN00CUlYwokbeyjf2hWFrRhtNh0ogpN
         j9xNV8Jw2O5D9lc1gaxrD5HZ1Y4Aoj4aqCnhQcbJPTTtqHW0oS8SUyTXdE8++PknREHt
         10dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mKRm+kUhexHkuGgI+4MqUr107/iLfqSeR0S/QaIpNT8=;
        b=Rm0tt7DXrOEzoJIkDziAl/pN3ykdJBRfZtzOo6eIlC0PkM7ojPBg3mRZhfzG0vy43M
         IvsRUMH5drLLZL6n+MgrG3ui6r6xwg6J3yNky84qkkYPBU6ha4b1izkfGdvCoS1cejh9
         I2CSqc4tr3wORkTyEh+O+69EeA5uwcjC1FDVkef+J9zZYrvhCofRMQofWMTWPHGTm1p8
         Y/qfaxNoPek3uNzR4GExhsgDN9fFRq6CuCQg/ehZLSCmGLvdjfjnpre9pCtXlGF6zUFg
         SpPh4avIpzExg2PZjFOHcMjIlaoAERLUMQNme7X5nCMjSeXJvi+6FrRCrHESsZaXdJbE
         xboQ==
X-Gm-Message-State: APjAAAVKAoRwz+iP0gewFblh3V81NE8dV/GfD39Ga8jTdK2SeHVE0CyL
        ku31hxRBW/NiY+vfxNSD7PE=
X-Google-Smtp-Source: APXvYqwB5BxHj83YQTTsWpQDPqYqDl8llg8qt05TXVOr8JVVgHbnAljK4Hy6+TW1Z27HKrOeVrcJfA==
X-Received: by 2002:a92:bb4a:: with SMTP id w71mr31407480ili.112.1574877023706;
        Wed, 27 Nov 2019 09:50:23 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id f8sm4546907ilf.36.2019.11.27.09.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:50:22 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>,
        saiprakash.ranjan@codeaurora.org
Subject: [PATCH 00/16] dynamic-debug cleanups, 2 new features
Date:   Wed, 27 Nov 2019 10:49:29 -0700
Message-Id: <20191127174929.1350995-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this is v2 of patchset posted earlier:
https://lkml.org/lkml/2019/10/29/989

changes from v1:
  dont drop trim_prefix yet, its harmless, and better supports old compilers.
  dont move externs to header, despite checkpatch

New Features (review):

accept new query input:
  file inode.c:100-200
  file inode.c:start_*

add 'xyz' user flags, allowing user to compose an arbitrary set of
callsites by marking them with user flags.  This takes 3 remaining
bits in the flags byte.

extend flags-spec to allow filter-flags, which select callsites for
modification based upon their current flags.  This lets user activate
the set of callsites composed previously (xy+p).

cc: <saiprakash.ranjan@codeaurora.org>


Jim Cromie (16):
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
  dyndbg: add inverted-flags, implement filtering on flags
  dyndbg: allow inverted-flag-chars in modflags
  dyndbg: make ddebug_tables list LIFO for add/remove_module

 .../admin-guide/dynamic-debug-howto.rst       |  72 +++--
 include/asm-generic/vmlinux.lds.h             |   6 +-
 include/linux/dynamic_debug.h                 |   7 +-
 kernel/module.c                               |   2 +-
 lib/dynamic_debug.c                           | 283 +++++++++++-------
 5 files changed, 232 insertions(+), 138 deletions(-)

-- 
2.23.0


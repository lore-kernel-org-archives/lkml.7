Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D40CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62532067D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grNFtvYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfJ2UAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:00:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33663 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfJ2UAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:00:01 -0400
Received: by mail-io1-f68.google.com with SMTP id n17so3103193ioa.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 13:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZiHJEpRT87Ht7I00eMsOyNZ2ZymipCmWCB4JEFs1gRc=;
        b=grNFtvYjZ0Gzg6ccE0Y0X+MdR8Nbi8tdBTGPIdt+WZaksHQbOEcNhVhUOcF1jky6sR
         6N7QXLiBdrhRssR0Ww47KXnyNzLAmJSTJjogB5Pl8hMa4RhYqSqZOZ/pAbchc26yhkiH
         UYpYHso3RIiI8aPo8/r6YIDkQ8kDaYnpNewofaZTJhgVmxqNhayFvXj1ioJqk4oOnEE5
         g5S6BJqgdrzYPbUqL9/utzZnYdWZ7iBelcdy6wKHwfa/gIFAGfebysLs51Rb8rsWKwrm
         NGYia3zR5iYzlJH4l9pa/sLUHT+pW2k3cX/MKXoOzTAegnJyo2GYSiJYc3+Cl3Hy+Ha2
         6Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZiHJEpRT87Ht7I00eMsOyNZ2ZymipCmWCB4JEFs1gRc=;
        b=tTfizOOU7gR8I3XquE2iVMYTMSO/aixkaPN49rockKIU87cVhMuBG3NcB45EHWHvMT
         xQw2cUU+0RgpaoG6SMhfr//Dsyg8mIhwDf0s1aWffWwBS6KH4XaKow7wRWAg+5fz4obz
         9TXIcgtOa+0NzbaPMq0lUe9P1BiwfTuByQV9Tkqrrxpvd5B4QpxFJ1dGRTQlPuVB8CWd
         NO2MO7zTl8amCe/TsqqrwFxQTic6iR/kU53VnlalgHw3YaERpvWdLWPx7dTkABLPq3eO
         guI2XCoPToxtUGxN/lsf1wYqpfN+H6c7+i4w2EHI4BbI9tdYmBDHxvAVYA3v8AQUbiGd
         I8+Q==
X-Gm-Message-State: APjAAAUn2KR7qFmSJeYut72MAJNPo2LEMNT5OzMZtxjsBqKFbYA+I3in
        0lAvFRB3TNQ//DG3CvN0+vQ=
X-Google-Smtp-Source: APXvYqwyWj/Ddgpi/tuCBVDYexLEi3MGb2JLWhFqWx9+cn99POXemyJWn1ljto3hFOWWY5OiRJ7uyQ==
X-Received: by 2002:a6b:5503:: with SMTP id j3mr5633019iob.151.1572379200182;
        Tue, 29 Oct 2019 13:00:00 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id i79sm577485ild.6.2019.10.29.12.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 12:59:59 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 00/16] dynamic-debug cleanups, 2 new features
Date:   Tue, 29 Oct 2019 13:59:48 -0600
Message-Id: <20191029195948.9586-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

random cleanups of obsolete code, comments, verbose output, etc.

accept new query input:
  file inode.c:100-200
  file inode.c:start_*

add 'xyz' user flags to callsites' flagstate, allowing user to compose
a set of callsites by marking them with user flags.

extend flags-spec to allow filter-flags, which select callsites for
modification based upon their current flagstate.  This lets user
activate the set of callsites composed previously.

Jim Cromie (16):
  dyndbg: drop trim_prefix, obsoleted by __FILE__s relative path
  dyndbg: drop overwrought comment on ddebug_proc_open
  dyndbg: raise verbosity needed to enable ddebug_proc_* logging
  dyndbg: rename __verbose section to __dyndbg
  dyndbg: parse flags last, restore original behavior
  dyndbg: fix overcounting of ram used by dyndbg
  dyndbg: fix a BUG_ON in ddebug_change
  dyndbg: refactor parse_linerange out of ddebug_parse_query
  dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'
  dyndbg: refactor ddebug_read_flags out of ddebug_parse_flags
  dyndbg: combine flags & mask into a struct, use that
  dyndbg: add filter parameter to ddebug_parse_flags
  dyndbg: extend ddebug_parse_flags to accept optional filter-flags
  dyndbg: prefer declarative init in caller, to memset in callee
  dyndbg: add inverted-flags, implement filtering on flags
  dyndbg: allow inverted-flag-chars in modflags

 .../admin-guide/dynamic-debug-howto.rst       |  72 +++--
 include/asm-generic/vmlinux.lds.h             |   6 +-
 include/linux/dynamic_debug.h                 |   7 +-
 kernel/module.c                               |   2 +-
 lib/dynamic_debug.c                           | 304 ++++++++++--------
 5 files changed, 236 insertions(+), 155 deletions(-)

-- 
2.21.0


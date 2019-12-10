Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BC5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED3B20726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjrAi2kX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfLJC17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:27:59 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:43472 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfLJC17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:27:59 -0500
Received: by mail-il1-f195.google.com with SMTP id u16so14711456ilg.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 18:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J6U1Hzpi4dOwN8xTI8JqdIZ7tuFR2CXBxejJP76HQAI=;
        b=HjrAi2kXVwqVvUUghTcWG/y1EvWiQzaFomBaouQhqVbPIgin4ec7CF6NRepXLsqQv5
         KzCzGM8gkc6iOPvoIVAXJAyTWDqrIAG9lOXi5elqWZ0lrGlK3T6fGyC6kvIhnSF+SQlZ
         FLwgxI+YuokUng1Gal3n9IzvsVDv17VeSrNz0Rw6Zc3Su//OanpzEFYdeckz+230H0NM
         HeHF0km0JLZasB0uhKuM3Lp3H1NaN6H7CesB56AvzO5/UQuEd4zloF0cqlF5iqWL/QRC
         aI5ewxuweWNCrWihY5uFc6ZVD2cVjZ6GsOKdLVfUWhuDI3q86fsvZaEuOS26zdwVp/57
         MWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J6U1Hzpi4dOwN8xTI8JqdIZ7tuFR2CXBxejJP76HQAI=;
        b=LJDwJVOymwKdsrvjZ1m+LsvCl6Hs3Y+wHMEc0NsY1F1uQqmjrneka4o84RA+1a7msu
         44IArMAEeUNSiuO6+mMNxcUavhUrhmz9JxoWyDYBEbHP/7mHyKfLIgea+llvpzgH0onN
         g19WxlFoZOIbDPA87KRCVKFOy9vN79ng1T7LZ+fT+Aw9jXTLzkTd/+vVXBZ7XCm6FdKc
         ZXJYz2Sk/qKPhG3e9U3B/dyjKETZlCclHKIFgEPy6QMAoZXxQvOiqbW9Vu1ix69eIKGO
         T+iVlwEyzdyfUlvurD+poMdY4nnv+hUWT01IZ/BqaJ79PiJ3nKTu5b4OxWWPd2jiJCMg
         Q9jw==
X-Gm-Message-State: APjAAAVPd6oG3aDXvFvAR2//mKUO8wpOUfbCuDTlrRGXSeOY4I11+XUJ
        OCAVyE2OvxnXVzIR8im7zt8=
X-Google-Smtp-Source: APXvYqxAEn4jV3IZW9jBO6R/kxLl+EZFG//LrA0w3UU3aw7RNAS3T+p2CX3uF9w4LGFKXiX8heD+qQ==
X-Received: by 2002:a92:5a52:: with SMTP id o79mr31572167ilb.201.1575944878554;
        Mon, 09 Dec 2019 18:27:58 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l9sm334052ioh.77.2019.12.09.18.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 18:27:57 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 00/16] dynamic-debug cleanups, 2 new features
Date:   Mon,  9 Dec 2019 19:27:26 -0700
Message-Id: <20191210022742.822686-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes from v3:
  drop name change, at best it was not fully considered
  microoptimization LIFO ddebug_tables list.
  drop doc example comment changes.
  use -v4 in format-patch
  
changes from v2:
  only claim one user flag, dont really need more
  fix patchset grooming err Reported-by: kbuild test robot <lkp@intel.com>
  quoting tweaks in Docs
  rename to lib/dyndbg.c, update docs accordingly
  
changes from v1:
  dont drop trim_prefix yet, its harmless, and better supports old compilers.
  dont move externs to header, despite checkpatch

v1: https://lkml.org/lkml/2019/10/29/989
v2: https://lkml.org/lkml/2019/11/27/547
v3: https://lkml.org/lkml/2019/12/5/735

New Features (review):

accept new query input:
  file inode.c:100-200		# & line-range
  file inode.c:start_*		# & function

add 'u' user flag, allowing user to compose an arbitrary set of
callsites by marking them with 'u', without altering current
print-modifying flags.

extend flags-spec to accept filter-flags before OP and mod-flags,
which select callsites for modification based upon their current
flags.  This lets user activate the set of callsites composed
previously (u+p).

add negating flags to filter on absence of flags, or to negate a modification.


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
  dyndbg: add user-flag, negating-flags, and filtering on flags
  dyndbg: allow negating flag-chars in modflags
  dyndbg: make ddebug_tables list LIFO for add/remove_module

 .../admin-guide/dynamic-debug-howto.rst       |  75 +++--
 include/asm-generic/vmlinux.lds.h             |   6 +-
 include/linux/dynamic_debug.h                 |   5 +-
 kernel/module.c                               |   2 +-
 lib/dynamic_debug.c                           | 281 +++++++++++-------
 5 files changed, 229 insertions(+), 140 deletions(-)

-- 
2.23.0


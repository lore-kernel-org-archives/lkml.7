Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A2EECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D71207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JajOTL3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393612AbfJPXCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 19:02:32 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:46103 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391366AbfJPXCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:02:32 -0400
Received: by mail-pg1-f202.google.com with SMTP id 195so314329pgc.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 16:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TOJsDjv2PITtO+I2kY79PfikRO0R2R+nAMh5A6+hbOU=;
        b=JajOTL3FBHYB10flWUxzWHuV8U8BExPlu2SCPP310A4oZrr/e8H7g3GVFIuYIaTAq9
         l6cDESess5ADq4YsN4ZicmEE2jUNDgmND07ChfhZXF6Wkf7glYyu+OsAVxCB8rbSgwCE
         Hub/sQF3XaZ71h/6KlSyTk7IVTI5f6KC1P9OMxwRE7wYIJj2Kifn9kw15W1LIExwyap2
         iSBeHWxzga8Fc4QS/MO0vViGZZz9oEt2019SoCcd4cyZLuzc5vJLu7gLV+N3tTuVx7/m
         hA/HA4EFJV/dyZOBm0UwdQW+d2ez6HxxiunDl/h/x+n7zdSOxw/1x3nFNMdCldn4mcHh
         +3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TOJsDjv2PITtO+I2kY79PfikRO0R2R+nAMh5A6+hbOU=;
        b=Qo+X22D4FKwPC1T4gkbOQ/MsgI3yN1I4ZiZqs7Wkdc4udq34/1lO87Yt+93XO4W8PJ
         wnVfWVxB/UIMAoveM0R4q0qrxfS++s1qRRfi294L4nzfp8J+p0VczpO8xbbHGfVxsaf/
         2GbXX9RsUTQThZn6XfaT3wq6pT+FeWwNPMBl8HQaH4rETGff47XczIiXZZkXgVokQ6UQ
         vfcAL8ckRNLbllpJztVZhjhq32DDlYiQpWcHr1+5jkg/u7UkIYWy0OVxrj5/13UiKuUV
         LD2kXRLqCafGLUenJPDIpZ0ubOeTNLTMKINZ6/3TnfUwtq0z+uODoCh3uP6TKRqCTlyn
         iadQ==
X-Gm-Message-State: APjAAAVwV1Jj7suW8/7Am1Otuctm0HgkGC9BIuGzR2R2ToNJQEirURZQ
        xPXjkroa8Wc9AKa/a8UVAROYqdSZEs7nDV5thkc=
X-Google-Smtp-Source: APXvYqynPl/YXL4Gk/7oYI+p6Y3KkiA1eZZEQh5vORv0ob1xBED01RJ8FGVLbRhOMDZhfsVFSxRW/vr+4vbUlnoy3S0=
X-Received: by 2002:a63:ce07:: with SMTP id y7mr652306pgf.234.1571266950938;
 Wed, 16 Oct 2019 16:02:30 -0700 (PDT)
Date:   Wed, 16 Oct 2019 16:02:06 -0700
Message-Id: <20191016230209.39663-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 0/3] drm/amdgpu: fix stack alignment ABI mismatch
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     harry.wentland@amd.com, alexander.deucher@amd.com
Cc:     yshuiv7@gmail.com, andrew.cooper3@citrix.com, arnd@arndb.de,
        clang-built-linux@googlegroups.com, mka@google.com,
        shirish.s@amd.com, David1.Zhou@amd.com, christian.koenig@amd.com,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The x86 kernel is compiled with an 8B stack alignment via
`-mpreferred-stack-boundary=3` for GCC since 3.6-rc1 via
commit d9b0cde91c60 ("x86-64, gcc: Use -mpreferred-stack-boundary=3 if supported")
or `-mstack-alignment=8` for Clang. Parts of the AMDGPU driver are
compiled with 16B stack alignment.

Generally, the stack alignment is part of the ABI. Linking together two
different translation units with differing stack alignment is dangerous,
particularly when the translation unit with the smaller stack alignment
makes calls into the translation unit with the larger stack alignment.
While 8B aligned stacks are sometimes also 16B aligned, they are not
always.

Multiple users have reported General Protection Faults (GPF) when using
the AMDGPU driver compiled with Clang. Clang is placing objects in stack
slots assuming the stack is 16B aligned, and selecting instructions that
require 16B aligned memory operands.

At runtime, syscall handlers with 8B aligned stack call into code that
assumes 16B stack alignment.  When the stack is a multiple of 8B but not
16B, these instructions result in a GPF.

Remove the code that added compatibility between the differing compiler
flags, as it will result in runtime GPFs when built with Clang.

The series is broken into 3 patches, the first is an important fix for
Clang for ChromeOS. The rest are attempted cleanups for GCC, but require
additional boot testing. The first patch is critical, the rest are nice
to have. I've compile tested the series with ToT Clang, GCC 4.9, and GCC
8.3 **but** I do not have hardware to test on, so I need folks with the
above compilers and relevant hardware to help test the series.

The first patch is a functional change for Clang only. It does not
change anything for any version of GCC. Yuxuan boot tested a previous
incarnation on hardware, but I've changed it enough that I think it made
sense to drop the previous tested by tag.

The second patch is a functional change for GCC 7.1+ only. It does not
affect older versions of GCC or Clang (though if someone wanted to
double check with pre-GCC 7.1 it wouldn't hurt).  It should be boot
tested on GCC 7.1+ on the relevant hardware.

The final patch is also a functional change for GCC 7.1+ only. It does
not affect older versions of GCC or Clang. It should be boot tested on
GCC 7.1+ on the relevant hardware. Theoretically, there may be an issue
with it, and it's ok to drop it. The series was intentional broken into
3 in order to allow them to be incrementally tested and accepted. It's
ok to take earlier patches without the later patches.

And finally, I do not condone linking object files of differing stack
alignments.  Idealistically, we'd mark the driver broken for pre-GCC
7.1.  Pragmatically, "if it ain't broke, don't fix it."

Nick Desaulniers (3):
  drm/amdgpu: fix stack alignment ABI mismatch for Clang
  drm/amdgpu: fix stack alignment ABI mismatch for GCC 7.1+
  drm/amdgpu: enable -msse2 for GCC 7.1+ users

 drivers/gpu/drm/amd/display/dc/calcs/Makefile | 19 ++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile | 19 ++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile | 19 ++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 19 ++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 19 ++++++++++++-------
 5 files changed, 60 insertions(+), 35 deletions(-)

-- 
2.23.0.700.g56cf767bdb-goog


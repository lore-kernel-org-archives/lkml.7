Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3586C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B1721670
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOlh0jPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfFXGYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 02:24:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38358 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfFXGYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 02:24:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so2253886pfn.5;
        Sun, 23 Jun 2019 23:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7OOsaxAN5ixXtIxH/sN7tLO0KmPMB9Rqm1XorQdXq1E=;
        b=iOlh0jPxa7GdWtkhlr4lwe15gANa42HHIYamJfsLQLJSNxG7L+Rr4kNJCnf1XI55DW
         DhlYGfFiXAJy3/P8NrGL5WqgB58H5wrNR/f3VlF0YMspLBMzilxjvHo398nuw70nGJXz
         8RCacdlFjfBpSBiTmYmzUVIhEzbzQlCkbAYeGnTqM1WgpOSTk14SMtwItnjCjw59V5zv
         l4aYG9UfBh3Rdq2LY1jZKKuLt4y80UkcWKd//5HOEUnUkOKmnkLex/id5hchtsYtecGP
         6lKbW0DuWu9vYE+4vqWZNovvVNVE3bwpa5TwrQrqxj7k7+DoxrFMeEcZhgUuwIDZ74kn
         YXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7OOsaxAN5ixXtIxH/sN7tLO0KmPMB9Rqm1XorQdXq1E=;
        b=SXy4xkTboXESaun4dXVHwzdRrDtBDwObsZFvMJP8YbRoO2s/C+oSbL/PcY1zke6gwy
         PyPCbYr+XFI4p/NK9cS2mCNa8JmeUeeGbMbQJZKh+TBf3qFj4FTOOCWcRLY2AKVCYUMG
         UgSev05cFFluTA89MENYMGGnr+yylsvOx/drXlyplZmxV9X+cXENJfj8xirgZ2jmQPLv
         c2l6JEB8e7GcrE1JzAIYgEOSD5V2ot0oSQcjoVZ5Cp3ptmLtavsWTARpyO/b2B2/lR6g
         ick2gCRQ9wwoFx+N6tQTJPZ5tVjqh2nn9U2VJxpQRriz+IgRZwS/9wOcy0SDOtjkLInn
         PT8Q==
X-Gm-Message-State: APjAAAUPMeVfD2Pxxx/s93ijjEf3vTPMTmGokbTbW6PtxECalmgvzqzQ
        LX4MtMsuZkA+fvaHgHw/KFxXujgB
X-Google-Smtp-Source: APXvYqxntwxtgfpQ5uVPA7XDE9orAu8ZKnlfrGEw9e7G8J95eAPrrUpo/6i6ixDKO1v0liilYQkYSA==
X-Received: by 2002:a17:90a:d151:: with SMTP id t17mr22705585pjw.60.1561357488434;
        Sun, 23 Jun 2019 23:24:48 -0700 (PDT)
Received: from prsriva-ThinkPad-P50s.hsd1.wa.comcast.net ([2601:602:9c01:c794:e00a:1dbc:5f62:b8ea])
        by smtp.gmail.com with ESMTPSA id 191sm2641620pfu.177.2019.06.23.23.24.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 23:24:47 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, roberto.sassu@huawei.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH V10 0/3] Add support for measuring the boot command line during kexec_file_load
Date:   Sun, 23 Jun 2019 23:23:28 -0700
Message-Id: <20190624062331.388-1-prsriva02@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kexec boot command line arguments are not currently being
measured.

Currently during soft reboot(kexec) 
  - the PCRS are not reset
  - the command line arguments used for the next kernel are not measured.
This gives the impression to the secure boot attestation that a cold boot took
place.
For secure boot attestation, it is necessary to measure the kernel
command line. For cold boot, the boot loader can be enhanced to measure 
these parameters.
(https://mjg59.dreamwidth.org/48897.html)

This patch set aims to address measuring the boot command line during
soft reboot(kexec_file_load).

To achive the above the patch series does the following
  -Add a new ima hook: ima_kexec_cmdline which measures the cmdline args
   into the ima log, behind a new ima policy entry KEXEC_CMDLINE.
   The kexec cmdline hash is stored in the "d-ng" field of the template data.
  -Since the cmldine args cannot be appraised, a new template field(buf) is
   added. The template field contains the buffer passed(cmldine args), which
   can be used to appraise/attest at a later stage.
   The kexec cmdline buffer is stored as HEX in the buf field of the event_data.
  -Call the ima_kexec_cmdline(...) hook from kexec_file_load call.

The ima logs need to be carried over to the next kernel, which will be followed
up by other patchsets for x86_64 and arm64.

The kexec cmdline hash is stored in the "d-ng" field of the template data.
and can be verified using
sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements | 
  grep  kexec-cmdline | cut -d' ' -f 6 | xxd -r -p | sha256sum

Changelog:
V10(since V9):
  -rebased over next-queued-integrity
  -code cleanup

V9(since V8):
  - code cleanup

V8(since V7):
  - added a new ima template name "ima-buf" 
  - code cleanup

V7:
  - rebased to next-queued-testing
  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/log/?h=next-queued-testing

V6:
  -add a new ima hook and policy to measure the cmdline
    args(ima_kexec_cmdline)
  -add a new template field buf to contain the buffer measured.
  [suggested by Mimi Zohar]
   add new fields to ima_event_data to store/read buffer data.
  [suggested by Roberto]
  -call ima_kexec_cmdline from kexec_file_load path

v5:
  -add a new ima hook and policy to measure the cmdline
    args(ima_kexec_cmdline)
  -add a new template field buf to contain the buffer measured.
    [suggested by Mimi Zohar]
  -call ima_kexec_cmdline from kexec_file_load path

v4:
  - per feedback from LSM community, removed the LSM hook and renamed the
    IMA policy to KEXEC_CMDLINE

v3: (rebase changes to next-general)
  - Add policy checks for buffer[suggested by Mimi Zohar]
  - use the IMA_XATTR to add buffer
  - Add kexec_cmdline used for kexec file load
  - Add an LSM hook to allow usage by other LSM.[suggestd by Mimi Zohar]

v2:
  - Add policy checks for buffer[suggested by Mimi Zohar]
  - Add an LSM hook to allow usage by other LSM.[suggestd by Mimi Zohar]
  - use the IMA_XATTR to add buffer instead of sig template

v1:
  -Add kconfigs to control the ima_buffer_check
  -measure the cmdline args suffixed with the kernel file name
  -add the buffer to the template sig field.

Prakhar Srivastava (3):
  Add a new ima hook ima_kexec_cmdline to measure cmdline args
  add a new ima template field buf
  call ima_kexec_cmdline to measure the cmdline args

 Documentation/ABI/testing/ima_policy      |  1 +
 Documentation/security/IMA-templates.rst  |  2 +-
 include/linux/ima.h                       |  2 +
 kernel/kexec_file.c                       |  8 ++-
 security/integrity/ima/ima.h              |  3 +
 security/integrity/ima/ima_api.c          |  5 +-
 security/integrity/ima/ima_init.c         |  2 +-
 security/integrity/ima/ima_main.c         | 80 +++++++++++++++++++++++
 security/integrity/ima/ima_policy.c       |  9 +++
 security/integrity/ima/ima_template.c     |  2 +
 security/integrity/ima/ima_template_lib.c | 20 ++++++
 security/integrity/ima/ima_template_lib.h |  4 ++
 12 files changed, 131 insertions(+), 7 deletions(-)

-- 
2.17.1


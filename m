Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089AEC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FEE2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GcqJod7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfGXSpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:45:18 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:51250 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfGXSpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:45:17 -0400
Received: by mail-vk1-f202.google.com with SMTP id s145so20669651vke.18
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 11:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IU8gVzvTj4FEVS/hFTH3haKdySYx9nqdy5hJ7NOTgWI=;
        b=GcqJod7p+JyIflNNvAqktW8ugP3/sfvE8IsvT3hluVA5YIjA12SPjYoF1x008F5fly
         nXgKE4GywMEa2Mdgog2yacskN7Gq9k5P7QPk1/tvMHmz1DGSc/71S2hGaniOiJTBgzmN
         CA0a30McFwbyg+410YQbNL3izq522zsjwqH26Ra2Ct44Jgh7bQm459lMpdLuJwWiVWqj
         D6vO/G3Q2GcP+cfF53eeBVZgjFvUnvzsD2HXpH9rvPT84bCMaFnZr99vhO51FL6ukgAR
         qozS0BeX0hhMi6zY9Y7ennbBAw4jDL6gMTQ8MJR9AJ9TXBsMxAjeq1PmRjn4jvN/qh1E
         ihTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IU8gVzvTj4FEVS/hFTH3haKdySYx9nqdy5hJ7NOTgWI=;
        b=au114XYywHQfXV0djVNS5l9U/tVXuE+9fjUvF0GTbYUiRlXI6aUaN3o9F+wXBlCZkV
         6/gddEqbyf8HHj493PPRfA/+cRVL7bnRJQ2ew/oSbOcaFOslv/ZhgOuv1/2ifHsDllCl
         gSD+eKGKgdZBx1YIIvQt6Lss84iQYIP8qJQA3U8o8uYoNKE6A10tbIjjVFRWFM0h8Xyh
         +WxcLjltOZZ/e+3QRLEFhHijk5A/AM5OwSnMKPkOhdDM1WHbzwonMXei/1K+tvtqy+XM
         AaDsTIhB0YnCRJGALGhL+vUWlBS3StSk+UFw1P06lgDKnCxdYzJp133owD1vNimJyyg0
         Ck5w==
X-Gm-Message-State: APjAAAXa8ScFTuS38bMAhubpzxQD2QMpLOQ/d4ewf+uXWSc+OWircF0T
        9HF/KftCmd3SN1L9J2XtpqNJh5m4
X-Google-Smtp-Source: APXvYqyicXAOZcBcNpC7yiCLrE6QyVS7nOmTa5VFG0NtIF8p7vyW1CphUKshs76kB3xXjY0d31u3Sfeb
X-Received: by 2002:a1f:2909:: with SMTP id p9mr32218026vkp.23.1563993916312;
 Wed, 24 Jul 2019 11:45:16 -0700 (PDT)
Date:   Wed, 24 Jul 2019 11:45:09 -0700
Message-Id: <20190724184512.162887-1-nums@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH 0/3] Perf UBsan Patches
From:   Numfor Mbiziwo-Tiapo <nums@google.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com
Cc:     linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com, Numfor Mbiziwo-Tiapo <nums@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are all errors found by running perf test with the
ubsan (undefined behavior sanitizer version of perf).

To repro the bug fixed in the "Fix insn.c misaligned address 
error" patch you must first apply the changes in the
Fix backward-ring-buffer.c format-truncation error and
Fix ordered-events.c array-bounds error patches since these
are necessary to get the ubsan version of perf to build.

To build the ubsan version, run:
make -C tools/perf USE_CLANG=1 EXTRA_CFLAGS="-fsanitize=undefined"

Numfor Mbiziwo-Tiapo (3):
  Fix backward-ring-buffer.c format-truncation error
  Fix ordered-events.c array-bounds error
  Fix insn.c misaligned address error

 tools/perf/tests/backward-ring-buffer.c | 2 +-
 tools/perf/util/intel-pt-decoder/insn.c | 3 ++-
 tools/perf/util/ordered-events.c        | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.22.0.657.g960e92d24f-goog


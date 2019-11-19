Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342C8C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC7C2245B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQhhVmFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfKSTaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:30:46 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:53832 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfKSTap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 14:30:45 -0500
Received: by mail-pf1-f201.google.com with SMTP id h2so17479901pfr.20
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 11:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=C47Ki3HabBbaxKIHhsS43LGLmAjUHPP9alFct2tZKio=;
        b=AQhhVmFWnFPcXgEc/Fk9f4e4x5ge44nDIJoAhq06dkr8uxhVWVodJBcAw6jHJBnHSv
         XVLDjEH6hlcjYJCj8rmlXhSI/MzVybNW+HRETZq0VCQE23W/K10hRk2FBE0iUcwF4eF9
         pocSqz04vLq6s74RaiVdieK/1p1PXI3RWfzPnp2NwquFVjrOT0w/+XdF+FmKOFzDDZfy
         nVFpwnL1fjbAmDA3yMmCu6c0GSj2cuTtbUtJhIZPof7fXdPVAkhiXCYs5FAvRIja2vNE
         y/33W28eNuTi/lhOFQG1DbNU/ICiItg7jIV1B243hN15HdPLDo6YW7tXTQXzBdHtFWrU
         /q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=C47Ki3HabBbaxKIHhsS43LGLmAjUHPP9alFct2tZKio=;
        b=aQzhIKdxtQTUW2dwtL3lOagEjWdOoyEFbqaLvHGN3ILnMKad99clrhZwRa7Hbu5cTw
         BXxAq60kUHC1MfMf+dCnmhEavEy7VJFJBu3G0Sq8TBp8z4uO+DnRj69awMw2H/+mCC6i
         BJNGQqy37Y3Mwq/t+9nVGruJdnyM+3aMeqZ0Q404rnzn4vQyuYqoZVPPhrbwSSaSARhr
         OllP/gkde66Hqtbzb3ZdvGfgNi1sFYHUNhdYTlgNCTXtqzm2sZlHDFGcLo8lUp6DjBq7
         td2hn/ybAk7UMUtCxtg6TLukoHZwbJURLpWsefi5auELbyziAiiYVyA8vjwJpVWnRJl5
         dWGA==
X-Gm-Message-State: APjAAAU8h8MUy/RDTZqtio6IJfBBZnOW1bgKXM4EljKzlRxqONn9Gw5G
        dFYt9BYQYsaiF6JzVU+XtW1ZR1q+QMiR
X-Google-Smtp-Source: APXvYqzNIz68u9dcwE5s1aVXZ2ZnlnOhQePgjaRrwKXmA62Rg/x1cqHffWrblYFqeoJW0i+OdYASh4loV7Gh
X-Received: by 2002:a63:a34e:: with SMTP id v14mr7487127pgn.58.1574191842857;
 Tue, 19 Nov 2019 11:30:42 -0800 (PST)
Date:   Tue, 19 Nov 2019 11:30:27 -0800
Message-Id: <20191119193036.92831-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v2 bpf-next 0/9] add bpf batch ops to process more than 1 elem
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>, Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduce batch ops that can be added to bpf maps to
lookup/lookup_and_delete/update/delete more than 1 element at the time,
this is specially useful when syscall overhead is a problem and in case
of hmap it will provide a reliable way of traversing them.

The implementation inclues a generic approach that could potentially be
used by any bpf map and adds it to arraymap, it also includes the specific
implementation of hashmaps which are traversed using buckets instead
of keys.

The bpf syscall subcommands introduced are:

  BPF_MAP_LOOKUP_BATCH
  BPF_MAP_LOOKUP_AND_DELETE_BATCH
  BPF_MAP_UPDATE_BATCH
  BPF_MAP_DELETE_BATCH

The UAPI attribute is:

  struct { /* struct used by BPF_MAP_*_BATCH commands */
         __aligned_u64   in_batch;       /* start batch,
                                          * NULL to start from beginning
                                          */
         __aligned_u64   out_batch;      /* output: next start batch */
         __aligned_u64   keys;
         __aligned_u64   values;
         __u32           count;          /* input/output:
                                          * input: # of key/value
                                          * elements
                                          * output: # of filled elements
                                          */
         __u32           map_fd;
         __u64           elem_flags;
         __u64           flags;
  } batch;


in_batch and out_batch are only used for lookup and lookup_and_delete since
those are the only two operations that attempt to traverse the map.

update/delete batch ops should provide the keys/values that user wants
to modify.

Here are the previous discussions on the batch processing:
 - https://lore.kernel.org/bpf/20190724165803.87470-1-brianvv@google.com/
 - https://lore.kernel.org/bpf/20190829064502.2750303-1-yhs@fb.com/
 - https://lore.kernel.org/bpf/20190906225434.3635421-1-yhs@fb.com/

Changelog since v1:
 - Fix SOB ordering and remove Co-authored-by tag (Alexei)

Changelog since RFC:
 - Change batch to in_batch and out_batch to support more flexible opaque
   values to iterate the bpf maps.
 - Remove update/delete specific batch ops for htab and use the generic
   implementations instead.

Brian Vazquez (5):
  bpf: add bpf_map_{value_size,update_value,map_copy_value} functions
  bpf: add generic support for lookup and lookup_and_delete batch ops
  bpf: add generic support for update and delete batch ops
  bpf: add lookup and updated batch ops to arraymap
  selftests/bpf: add batch ops testing to array bpf map

Yonghong Song (4):
  bpf: add batch ops to all htab bpf map
  tools/bpf: sync uapi header bpf.h
  libbpf: add libbpf support to batch ops
  selftests/bpf: add batch ops testing for hmap and hmap_percpu

 include/linux/bpf.h                           |  21 +
 include/uapi/linux/bpf.h                      |  21 +
 kernel/bpf/arraymap.c                         |   2 +
 kernel/bpf/hashtab.c                          | 244 ++++++++
 kernel/bpf/syscall.c                          | 571 ++++++++++++++----
 tools/include/uapi/linux/bpf.h                |  21 +
 tools/lib/bpf/bpf.c                           |  61 ++
 tools/lib/bpf/bpf.h                           |  14 +
 tools/lib/bpf/libbpf.map                      |   4 +
 .../map_lookup_and_delete_batch_array.c       | 119 ++++
 .../map_lookup_and_delete_batch_htab.c        | 257 ++++++++
 11 files changed, 1215 insertions(+), 120 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/map_tests/map_lookup_and_delete_batch_array.c
 create mode 100644 tools/testing/selftests/bpf/map_tests/map_lookup_and_delete_batch_htab.c

-- 
2.24.0.432.g9d3f5f5b63-goog


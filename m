Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D560FC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA79222ED
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bY/KO6kx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKSBoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 20:44:05 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:50504 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfKSBoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 20:44:05 -0500
Received: by mail-pl1-f201.google.com with SMTP id c18so12175501plo.17
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 17:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cGWE/qyVtF0Xm0XRgmS6v65MJoSNg2ouKO2ndi7seNg=;
        b=bY/KO6kxybSTMKllU0VSmuUp+hH40TarSc/VXouqS7EBfHj591iNMpKxkqYuVxFYHx
         RvL8p5NL+w33OCuaho+ZKJsPc4VJZuOx8JnxfZiYvZIu3CDdSIHY8/ep7GUTHBZQPKHv
         N6vRZOcQeGBrbAcztIl7TsIzRJeiQkfdPF3u3dTu2+vMg2A99GH/vkECiIa10i0L124M
         jcTZVaX0jLsElwKI6XDWBJVmHXRlzIYfEGjIkNfrKlU43Ixu4zekvM2oc4M/AGLTMoIn
         cIXJ50FH0992QNNkzwQ64vWbxzxzzaamsnZBqfoRrO0YmEmXORQz6zb/1yXwDM7Il87G
         FUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cGWE/qyVtF0Xm0XRgmS6v65MJoSNg2ouKO2ndi7seNg=;
        b=qQtW8qdZVCWgtftEUX0MAgK4fR51EOrbReCOgWLbr+Fs2pRSCzMYF5LSPqxmsMe2V+
         4c5b2l/YlZLKVibt/djJc+dGzjvG2lqFBiRbMbTUwGlVZhdquGzETX55RX5SccEoqEhO
         CifGO30HwShl4ULFffnMrigvnnvxSgZ6ZPQoGGLgZCLVpNUm6fkXqO6nivdyd5ExXCy3
         OoIINkPEPI5xbsx7MZrtOBB8LiohNaA4gswqn9vNOOFgHxpTSo+T5hm/F7BAOlekrO4D
         lS6dz7MgCLOYZn8zadDhgUEEl6b91xl6ItmB9u4AwMbTsoMntP9VEY8042mtw7l3KGav
         RcdA==
X-Gm-Message-State: APjAAAV4P1mc5smL/nUg7Oia2vRYq9VSttUA5D7ms+MzXbUphCKvt67m
        IJFr/EvsYx+Dfd9C+0eKo8tIYvqZLCQY
X-Google-Smtp-Source: APXvYqzp94KW+lXm0LZaQQNGcUtXuvrutP74p5xG+E2LoUBDzNYsDXea2jiZSeUfPgrKOo233sI5FDiQ+9Xu
X-Received: by 2002:a63:e26:: with SMTP id d38mr2621764pgl.44.1574127844187;
 Mon, 18 Nov 2019 17:44:04 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:43:48 -0800
Message-Id: <20191119014357.98465-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH bpf-next 0/9] add bpf batch ops to process more than 1 elem
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

Changelog since RFC:
 - Change batch to in_batch and out_batch to support more flexible opaque
   values to iterate the bpf maps.
 - Remove update/delete specific batch ops for htab and use the generic
   implementations instead.

Brian Vazquez (6):
  bpf: add bpf_map_{value_size,update_value,map_copy_value} functions
  bpf: add generic support for lookup and lookup_and_delete batch ops
  bpf: add generic support for update and delete batch ops
  bpf: add lookup and updated batch ops to arraymap
  tools/bpf: sync uapi header bpf.h
  selftests/bpf: add batch ops testing to array bpf map

Yonghong Song (3):
  bpf: add batch ops to all htab bpf map
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


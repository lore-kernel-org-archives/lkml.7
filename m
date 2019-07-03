Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58066C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B332218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FizreZQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfGCRCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:02:03 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:37417 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfGCRCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:02:02 -0400
Received: by mail-pg1-f201.google.com with SMTP id s5so1964071pgr.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 10:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PtzfnXHwir5t+OK6oGGR3xyRGAh0lHKhLg6y74Z7SLI=;
        b=FizreZQfOB54x6CBxj83tADQPZPzVR8/wChupBATHtmbdgjnMryGONlVDgnxLjKuYq
         3VV5dEtzc3rOyy5BHnKAdcoRvGWEwoVjf/4+gik2NSUYKmlR/p8FJLpB3I4CraYn178/
         R/xmnUwfUUzqNmcvqRa/NCBw5cTyAwsSFFBHR5IN84dyIor/8zLJdz85Vq6yeh6BiG3p
         iMtK0ogb/8C/lHsfN6RP4nJpyWYaK7/S5EDQUK9vud4VnpKOCcjvX9dRX+YJrnb+bMkk
         OpdJazGd+BNI/aHArshaRwnW1fF14xznm3LZ54tHv8PTFWFF/fkib1YSARjkYPSwmc3l
         4y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PtzfnXHwir5t+OK6oGGR3xyRGAh0lHKhLg6y74Z7SLI=;
        b=r2hmCP5BwQkfPkXv0ITtP7JHaig9LOaWqBBKJqDV7wEoJ/o+1noT0p64wLYHZhExCp
         lzfWcNSabVawzmcM+09EBGIGmttxYH3OH003GrAP39m80mijXYCVS/LSI+gdQ7Rv+794
         9gv0Nl1GwcD+d5R5aA42OmYCcM4rUgzlUjWeAaS6/rZ3N/EUM0QT4V9I/47uqSNuzx16
         qPBl+SYg19H3oG2YapdMalp9a9Ux9hPrnGQ7cQeK2pNA22/ZSAOm2EExbLJ3FcOyO+G7
         GAy0SAKmxBFULa7GbrUhnjLdJXaZsZ9qxykzFf76I352FmJUtwYPJ/4Hdlu/eMDyBBGy
         CqtQ==
X-Gm-Message-State: APjAAAU0DJzh7zSbkeHrR+pSeyXBrq96uzTqAZdYIvvAAbDULdevrQdm
        R+xFSmcF2l+MwBxeqze5Stf5A58BrGnu
X-Google-Smtp-Source: APXvYqwFUIvxlm1JZsLTU/DwtWcZRSkjscpz9PkPbEih6Nz94MHK2bwBsb5v9GSWKe3fWIQGB7QB2+hNQMz9
X-Received: by 2002:a63:c03:: with SMTP id b3mr38912759pgl.68.1562173321483;
 Wed, 03 Jul 2019 10:02:01 -0700 (PDT)
Date:   Wed,  3 Jul 2019 10:01:12 -0700
Message-Id: <20190703170118.196552-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next RFC v3 0/6] bpf: add BPF_MAP_DUMP command to dump
 more than one entry per call
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces a new command to retrieve a variable number of entries
from a bpf map.

This new command can be executed from the existing BPF syscall as
follows:

err =  bpf(BPF_MAP_DUMP, union bpf_attr *attr, u32 size)
using attr->dump.map_fd, attr->dump.prev_key, attr->dump.buf,
attr->dump.buf_len
returns zero or negative error, and populates buf and buf_len on
succees

This implementation is wrapping the existing bpf methods:
map_get_next_key and map_lookup_elem
the results show that even with a 1-elem_size buffer, it runs ~40 faster
than the current implementation, improvements of ~85% are reported when
the buffer size is increased, although, after the buffer size is around
5% of the total number of entries there's no huge difference in
increasing it.

Tested:
Tried different size buffers to handle case where the bulk is bigger, or
the elements to retrieve are less than the existing ones, all runs read
a map of 100K entries. Below are the results(in ns) from the different
runs:

buf_len_1:	 69038725 entry-by-entry: 112384424 improvement
38.569134
buf_len_2:	 40897447 entry-by-entry: 111030546 improvement
63.165590
buf_len_230:	 13652714 entry-by-entry: 111694058 improvement
87.776687
buf_len_5000:	 13576271 entry-by-entry: 111101169 improvement
87.780263
buf_len_73000:	 14694343 entry-by-entry: 111740162 improvement
86.849542
buf_len_100000:	 13745969 entry-by-entry: 114151991 improvement
87.958187
buf_len_234567:	 14329834 entry-by-entry: 114427589 improvement
87.476941

Changelog:

v3:
- add explanation of the API in the commit message
- fix masked errors and return them to user
- copy last_key from return buf into prev_key if it was provided
- run test with kpti and retpoline mitigations

v2:
- use proper bpf-next tag

Brian Vazquez (6):
  bpf: add bpf_map_value_size and bp_map_copy_value helper functions
  bpf: add BPF_MAP_DUMP command to dump more than one entry per call
  bpf: keep bpf.h in sync with tools/
  libbpf: support BPF_MAP_DUMP command
  selftests/bpf: test BPF_MAP_DUMP command on a bpf hashmap
  selftests/bpf: add test to measure performance of BPF_MAP_DUMP

 include/uapi/linux/bpf.h                |   9 +
 kernel/bpf/syscall.c                    | 252 ++++++++++++++++++------
 tools/include/uapi/linux/bpf.h          |   9 +
 tools/lib/bpf/bpf.c                     |  28 +++
 tools/lib/bpf/bpf.h                     |   4 +
 tools/lib/bpf/libbpf.map                |   2 +
 tools/testing/selftests/bpf/test_maps.c | 147 +++++++++++++-
 7 files changed, 388 insertions(+), 63 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog


Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED70DC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0284208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pN/qlGpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfHJHWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 03:22:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43521 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfHJHWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 03:22:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so47209176pfg.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 00:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Kqvj5qJEEnuY9tHLIsHKAJCMxbCgSGhB0GQjUNBVzjU=;
        b=pN/qlGpA8abF6Y2VoHoy92OQQq3CMSqbXoIdJstu1huvjtuHlzemsHlD29Ba4F4utO
         +UeK5KoVrRu0etzH0vcO+0ApJqNcZj9rXGCkyt8spxUyMFRjwPpnBazmuhaFXTLalP6S
         Lp3HrbOgwuVvifao/yYUZzeuG8ssfQguwrqXmPbyF6y2xGEq0hnw//LC8p68WagfSLKH
         rsdDWlhVsgB+I7499JpZZuII9CApUi7KTaRS9kXf7Bz8QZGRH4mKTTx/dZ3qKUZRgIpX
         as4l8zy4iN8rP05Li25xLA1FIzCeDmSr2Tads+zy6ie5E7UV6uHqoqqdm8w9xwu1etk3
         he6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kqvj5qJEEnuY9tHLIsHKAJCMxbCgSGhB0GQjUNBVzjU=;
        b=TvAwVkrU0BukCmNHzZohqLnmSevUsiccHpouY+H8ZCiMscVD90kKPuZfrWHveDmllN
         x55RlUzvqO2I/jPC2wO3RazPrEbBrN8zuWjUbOChQZyYi5NqJ/Z45cYJWsfzNXScjPo0
         0ZMjs8jkVJV4S0qA9Fm3akXRhC6PM+AeqVxnW3Dn8um8Cb5YkBIBRudqHXmRTrFfMPLB
         fS4JhwEIDNOjxSl5VLmmq2Ws3WzSt6U1+B9ueVAmfIy1ZK9tOBLgDpj5jr/BAKpN2gF2
         a+2KpMZrD3c7j3KoHBSmwPQyf543kMLXFRbCyut1AOR6qiUY3kpQZv6gA96Plbfjp89h
         g89Q==
X-Gm-Message-State: APjAAAVmOSP0Z5yVd8MJkBEgXDE6PkFsEEyMf5ZAgTXfB+eNLHhJid/X
        O8RoPi9jUfiAw0seyFpPdeb5Cg==
X-Google-Smtp-Source: APXvYqzWPFRraQJfw6z1Xg9lRpRTmgazGG+rZnbJsTWe4VcHA2vmbrAsasej8XE1f+jTi5V6mYDpug==
X-Received: by 2002:a17:90a:9f0b:: with SMTP id n11mr12981206pjp.98.1565421726801;
        Sat, 10 Aug 2019 00:22:06 -0700 (PDT)
Received: from localhost.localdomain (li456-16.members.linode.com. [50.116.10.16])
        by smtp.gmail.com with ESMTPSA id l17sm24872660pgj.44.2019.08.10.00.22.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 00:22:05 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>,
        Milian Wolff <milian.wolff@kdab.com>,
        Donald Yandt <donald.yandt@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mark Drayton <mbd@fb.com>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 0/2] perf: arm/arm64: Improve completeness for kernel address space
Date:   Sat, 10 Aug 2019 15:21:33 +0800
Message-Id: <20190810072135.27072-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to improve completeness for kernel address space for
arm/arm64; it adds architecture specific tweaking for the kernel start
address, thus can include the memory regions which are prior to '_stext'
symbol.  With this change, we can see the eBPF program can be parsed
properly on arm64.

This patch set is a following up version for the old patch "perf cs-etm:
Improve completeness for kernel address space" [1]; the old patch was
only to fix the issue for CoreSight ETM event; but the kernel address space
issue is not only limited to CoreSight event, it should be a common issue
for other events (e.g. PMU events), clock events for profiling eBPF
program.  So this patch set tries to resolve it as a common issue for
arm/arm64 archs.

When implemented related code, I tried to use the API
machine__create_extra_kernel_maps(); but I found the 'perf script' tool
directly calls machine__get_kernel_start() instead of running into
the flow for machine__create_extra_kernel_maps(); this is the reason I
don't use machine__create_extra_kernel_maps() for tweaking kernel start
address and refactor machine__get_kernel_start() alternatively.

If there have better method to resolve this issue, any suggestions and
comments are very welcome!

[1] https://lkml.org/lkml/2019/6/19/1057


Leo Yan (2):
  perf machine: Support arch's specific kernel start address
  perf machine: arm/arm64: Improve completeness for kernel address space

 tools/perf/Makefile.config           | 22 ++++++++++++++++++++++
 tools/perf/arch/arm/util/Build       |  2 ++
 tools/perf/arch/arm/util/machine.c   | 17 +++++++++++++++++
 tools/perf/arch/arm64/util/Build     |  1 +
 tools/perf/arch/arm64/util/machine.c | 17 +++++++++++++++++
 tools/perf/arch/x86/util/machine.c   | 10 ++++++++++
 tools/perf/util/machine.c            | 13 +++++++------
 tools/perf/util/machine.h            |  2 ++
 8 files changed, 78 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/arch/arm/util/machine.c
 create mode 100644 tools/perf/arch/arm64/util/machine.c

-- 
2.17.1


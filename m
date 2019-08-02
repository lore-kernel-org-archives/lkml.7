Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0F2C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FFF2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/jo0wtW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbfHBQjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:39:02 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:32832 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbfHBQjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:39:02 -0400
Received: by mail-io1-f53.google.com with SMTP id z3so12370755iog.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BG6pD3ylPrqGYChsYLSsxBPUz1G1ZRk1VbjazqRF+2s=;
        b=l/jo0wtWA0AY+2SQTOgHtkTU0Kua0NVFYDkdtEZe616wtEJoD2UD1ninnTSmhzDTr1
         oVaLCG1ldA+eeOZMpo6OsTzamiWSaNSppqBaqCc0su2ISzGRKORs5fse5RURU/cRPT2a
         44SdzQthyN8cIjwIPWb+7VEZnilVc5MfQeBuVIlp4JHoLrVKnwP7TR7rtTL/DctzSzEv
         3wAY8TjP/bFkh6wak6EZnGG2HqoXQQvQlOzoEAGAhKHUga8fEUIFN9Vflel2vlmfTm45
         Ml14IpvOpAI8WU1unyA96X+I3qh8sDwimPdPOktz6GzeoEZ8bkihfj0XlzRcuwzdN1Ll
         SQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BG6pD3ylPrqGYChsYLSsxBPUz1G1ZRk1VbjazqRF+2s=;
        b=HHugMSm8dKffi7KP7q7ijZ45B4oCiS9/9DCdc+uX7/pqjBAL2XQOl7sVwWpAsjs+hu
         2usdsUjLXIfzQ+PAAX4oTzgueUEtdb6pPY9ezZNd5TF0zX86Ufu3UJxUUusjoiOxnD4o
         eHMeVCJ+sjRGJYVrTW0XgzRmY/YLd7ZUe4mtm7yvfJnQAbSuiTOD49SNfKZy/zdqKAcl
         zZEXcTjHzXcgrROupTsy8grQ8lOxoEj/896YEQBubu3Laqwy2abdyTGQKi9+JvQWcDFM
         3fM1iEy6UwLBLTSRmZxmIHSARz8gY+ZHQgTaPn7laKKvWUruC88HDJv97ete3wgdjPwW
         fv/g==
X-Gm-Message-State: APjAAAWLEZFk+O1D1QQz7OhW4nhiLB1yDHPAgOdCL9+nhw+WxmzzUwS6
        +eFT/Qbd7ehxEGDQr1+YkFOsPSiBp3Qbgv8Cawjg/VdgM7bVkw==
X-Google-Smtp-Source: APXvYqxttYbruAnCsrIrNhYVinmIrq1x/si7xGcfeyFEmfDOOYJGSDove0lS6wfsnWzTcuewYuAXh2sL7xS/goFY3q8=
X-Received: by 2002:a6b:d008:: with SMTP id x8mr1345796ioa.129.1564763940947;
 Fri, 02 Aug 2019 09:39:00 -0700 (PDT)
MIME-Version: 1.0
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 2 Aug 2019 09:38:49 -0700
Message-ID: <CABPqkBQtnYM6E2F3JiZ2A5z8iR+MvxM5DH4L6KyAeSaBfnGEPw@mail.gmail.com>
Subject: [BUG] perf report: segfault with --no-group in pipe mode
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When trying the following command line with perf from tip,git, I got:

$ perf record --group -c 100000 -e '{branch-misses,branches}' -a -o -
sleep 1| perf report --no-group -F sample,cpu,period -i -
# To display the perf.data header info, please use
--header/--header-only options.
#
Segmentation fault (core dumped)

(gdb) r report --no-group -F sample,cpu,period -i - < tt
Starting program: /export/hda3/perftest/perf.tip report --no-group -F
sample,cpu,period -i - < tt
# To display the perf.data header info, please use
--header/--header-only options.
#

Program received signal SIGSEGV, Segmentation fault.
hlist_add_head (h=0xeb9ed8, n=0xebdfd0) at
/usr/local/google/home/eranian/G/bnw.tip/tools/include/linux/list.h:644
644 /usr/local/google/home/eranian/G/bnw.tip/tools/include/linux/list.h:
No such file or directory.
(gdb)

Can you reproduce this?
Thanks.

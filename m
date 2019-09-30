Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF946C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1A5216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbfI3QHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 12:07:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbfI3QHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:07:22 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE12C58569
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 16:07:21 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id p56so14358957qtj.14
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 09:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=AlAgWSZN3tYrGAUetJ0PxX2LldmwlKphz6GM87t+fR0=;
        b=Q8wm0o2f8YfH4F5Pe5Noufc4+vQxEkgWIje7M9XzCucsQ+oV1XOj6GIP2gK6K83Qc0
         0BiPDuXMQRcAKkhvxHeRlFPtGt1tL43FP8vTLoMIjQYuKszdCLvuDt5iG9XHxqmxMJ0l
         p3nus0mk5nV6MgjaUaRjnnixJlYOvlg74UVTSyx8SXpKinMkCefAf1OuHRkQwytjFjvS
         qWgSn2S6NuVBCX6VzwYE0m5zv91JiUCcjPpaf1CCgONABq30p3++jDRNZZVKhmvNgMcA
         UW5ScUyPrbcyQDSWmwq5TOtnCTjehHcEee0+gNJkURXdBzMWe2IzKHc/ToSL6HqqmgDM
         /IaQ==
X-Gm-Message-State: APjAAAXLXkgi+PbODqc06oSqULGrJ0OV0KdYuRH2r/EvLD3IRojohw0M
        LRImGJtur9cGIcAKnWG/yba2x2wJnkvDCrCowCzV/vvMMeEgI3XlU09DEHz5YdjM0pMBz2R0Z4p
        dB9u9cvJTWkWMQzhVGrTvrpHP
X-Received: by 2002:a37:515:: with SMTP id 21mr763838qkf.87.1569859640409;
        Mon, 30 Sep 2019 09:07:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwn2lO+qtSlieFtDNAL5Zi45Mn6EO2xY9cnkxx9E6Wiz4SQtkHTov4MNY3gLHrjNPTCa8epsA==
X-Received: by 2002:a37:515:: with SMTP id 21mr763811qkf.87.1569859640138;
        Mon, 30 Sep 2019 09:07:20 -0700 (PDT)
Received: from ?IPv6:2601:342:8200:6edc::b073? ([2601:342:8200:6edc::b073])
        by smtp.gmail.com with ESMTPSA id s23sm9020063qte.72.2019.09.30.09.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 09:07:19 -0700 (PDT)
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
From:   Laura Abbott <labbott@redhat.com>
Subject: mount on tmpfs failing to parse context option
Message-ID: <d5b67332-57b7-c19a-0462-f84d07ef1a16@redhat.com>
Date:   Mon, 30 Sep 2019 12:07:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Fedora got a bug report https://bugzilla.redhat.com/show_bug.cgi?id=1757104
of a failure to parse options with the context mount option. From the reporter:


$ unshare -rm mount -t tmpfs tmpfs /tmp -o 'context="system_u:object_r:container_file_t:s0:c475,c690"'
mount: /tmp: wrong fs type, bad option, bad superblock on tmpfs, missing codepage or helper program, or other error.


Sep 30 16:50:42 kernel: tmpfs: Unknown parameter 'c690"'

I haven't asked the reporter to bisect yet but I'm suspecting one of the
conversion to the new mount API:

$ git log --oneline v5.3..origin/master mm/shmem.c
edf445ad7c8d Merge branch 'hugepage-fallbacks' (hugepatch patches from David Rientjes)
19deb7695e07 Revert "Revert "Revert "mm, thp: consolidate THP gfp handling into alloc_hugepage_direct_gfpmask""
28eb3c808719 shmem: fix obsolete comment in shmem_getpage_gfp()
4101196b19d7 mm: page cache: store only head pages in i_pages
d8c6546b1aea mm: introduce compound_nr()
f32356261d44 vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API
626c3920aeb4 shmem_parse_one(): switch to use of fs_parse()
e04dc423ae2c shmem_parse_options(): take handling a single option into a helper
f6490b7fbb82 shmem_parse_options(): don't bother with mpol in separate variable
0b5071dd323d shmem_parse_options(): use a separate structure to keep the results
7e30d2a5eb0b make shmem_fill_super() static


I didn't find another report or a fix yet. Is it worth asking the reporter to bisect?

Thanks,
Laura

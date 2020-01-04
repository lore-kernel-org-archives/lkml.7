Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EA6C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEA424650
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578150250;
	bh=58jvLmd2ERc8fyoEu5gD74E7bU/hGllGSZGv04tNWYg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hgOScGX1UKOm1DbBpKOG/lNUxJQpfeG/BKAWG/oE4SCG8y7+Xz4yrQaKP1A/gjTlZ
	 Z1rD+wMg8Fv7vjh4aua523jUArGZjzNLfkhVTcX3HxqiT7CfqKs4G7heYVTbySlSWr
	 Rmd0Q2o+R1hXf5GrOq2vd53he1KBAxSYyZX5Ftiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgADPEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:04:08 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:54710 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgADPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:03:54 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 004F2gcQ018492;
        Sun, 5 Jan 2020 00:02:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 004F2gcQ018492
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578150163;
        bh=+Ym/FObftlApE4ehJPoyk8sOyxo8gIw2RqfNnfV/RE8=;
        h=From:To:Cc:Subject:Date:From;
        b=wMH38s3KOQQqZomKMm9xreZUT3T5uv077cd6fVWk6nxxMS8t1X8KpdjbV/MPapROV
         WuGHzLgrMDR3zU9UczvasLaEFmqH4XR34AHL0+qnz8b9hL2YqYr/qcwygDNUyk6Olq
         JXvI9ayW8h0XIoCs9FgXtVlOgcC7/L676JIUUuvpd+uGUYEhk0ZCdSqM0osNj0EVEL
         xr9WZ9wUi8VJVDw+08V4dm0tAC7spCUIZPnjzvhDi3jcXIkd1DQuyOFU5Zmcetwwjl
         gDUvs25OjjVRVgk7hgrJ5zul5DzN2sy12eqzOaLxq+r1WtWRNob4OruAysN8mqc3tC
         DWLXwW6V7UT0g==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/13] initramfs: a lot of cleanups
Date:   Sun,  5 Jan 2020 00:02:25 +0900
Message-Id: <20200104150238.19834-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Masahiro Yamada (13):
  initramfs: replace klibcdirs in Makefile with FORCE
  gen_initramfs_list.sh: remove unused variable 'default_list'
  gen_initramfs_list.sh: fix the tool name in the comment
  initramfs: rename gen_initramfs_list.sh to gen_initramfs.sh
  initramfs: remove redundant dependency on BLK_DEV_INITRD
  initramfs: make compression options not depend on INITRAMFS_SOURCE
  initramfs: make initramfs compression choice non-optional
  initramfs: specify $(src)/gen_initramfs.sh as a prerequisite in
    Makefile
  initramfs: generate dependency list and cpio at the same time
  initramfs: add default_cpio_list, and delete -d option support
  gen_initramfs.sh: always output cpio even without -o option
  initramfs: refactor the initramfs build rules
  gen_initramfs.sh: remove intermediate cpio_list on errors

 usr/.gitignore                                |   8 +-
 usr/Kconfig                                   |  26 ---
 usr/Makefile                                  |  97 ++++++----
 usr/default_cpio_list                         |   6 +
 ...gen_initramfs_list.sh => gen_initramfs.sh} | 167 +++++-------------
 usr/initramfs_data.S                          |   5 +-
 6 files changed, 112 insertions(+), 197 deletions(-)
 create mode 100644 usr/default_cpio_list
 rename usr/{gen_initramfs_list.sh => gen_initramfs.sh} (53%)

-- 
2.17.1


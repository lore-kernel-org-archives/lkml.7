Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1B9C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A99215A4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578074444;
	bh=wzXINAjDL9BlqfLzbgAjfQifFobuvek3IjcS8X/WUog=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NyKotdajhZkQQpj2QnYB/gGR7H1GiQ9WMdvjkamYA0WwIeBynVxcEqIswYhpBS7Q4
	 e2eE7G1IEH/zwDFm3aqMJp3kZ+KOgObVGqEQX4fkMZQK4cGv7W6REp0ODJmIkchv/H
	 FsczX5m2mV3Q17/zKrtLumSKP7w2U2Ly+W9cf8EY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgACSAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:00:39 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:16482 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgACSAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:00:37 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 003HxSJ1022724;
        Sat, 4 Jan 2020 02:59:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 003HxSJ1022724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578074369;
        bh=twjIgVjn2qzixnz2uckFK3hI7u2Oei2bObIaIGzNhH8=;
        h=From:To:Cc:Subject:Date:From;
        b=kw80uQ/4X6Ez5bNC7+m1RZPzrKNvWCnEP/hrZb/axVf6eeuOnlfYFOuUZ9PNfD+y2
         UP39mmaVR0p+OMIPW0rbZVEWB2A4UPxidGdSV5MTFxIGc4ZXm7TUkBEQFwbtznV9jh
         y+7FOoOmS3rS/F1OVEIwc/P4DY05sL1W5WWUPstk3mOz+cirnr4gPqIgi6Bxw/i7Qf
         gEbK0hxGsXra4Du/17b0vUduN1vT0sX5bsm4bPQyCjVHPlHsPDpFBo780sBijby3s+
         6J9PEcX5jxRK2yn0SzVS21l4bm6NV4O5fv912uGYJoPHjR5eThg27cDN45jmXeBSEy
         NjVGQpS1SKUAw==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] initramfs: a lot of cleanups
Date:   Sat,  4 Jan 2020 02:59:03 +0900
Message-Id: <20200103175915.26663-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada (12):
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
 usr/Makefile                                  |  92 ++++++----
 usr/default_cpio_list                         |   6 +
 ...gen_initramfs_list.sh => gen_initramfs.sh} | 167 +++++-------------
 usr/initramfs_data.S                          |   5 +-
 6 files changed, 111 insertions(+), 193 deletions(-)
 create mode 100644 usr/default_cpio_list
 rename usr/{gen_initramfs_list.sh => gen_initramfs.sh} (53%)

-- 
2.17.1


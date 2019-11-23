Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95DDC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 16:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CB52070E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 16:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="p3KMV9ET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfKWQFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 11:05:54 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:49455 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfKWQFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 11:05:01 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id xANG4l5H019106;
        Sun, 24 Nov 2019 01:04:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xANG4l5H019106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574525087;
        bh=H2tGAlg1+h2LUBCWdvUI7VC1wx4Pz4ZqLwpwarMDBnM=;
        h=From:To:Cc:Subject:Date:From;
        b=p3KMV9ET1bL7+f4btul4W6Yb2Bt25+Uws5pwgXVILo/j4xfjk6z4NHQ1pUZR0M/jo
         x00FmR+9UYPfD3KLE01mXOu9s1CBEeWGyCSGBQxqm6craegs40DuwJBLp2wdnqlvOb
         cp8vOy2rwjbiiw+DYkkXMMh7p+/1zNhLiPQVtF7pkH4cBEqLTsyY4XNvGhNM+zHoPs
         TlyzBmvA3Y7dhyhlD6ieun7owUTutLBpsKrVymaTPCkUUgi1WX1FV7G5zT1C3YXtEh
         zC6jJ6opkXat8cBVs0Y1eD0t3GkAqVhIwwTDHplSro3jpMQo2pBFHDqP+pKX4UVrwK
         Ncy+yQgb4T+2w==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/16] scripts/kallsyms: various cleanups and optimizations
Date:   Sun, 24 Nov 2019 01:04:28 +0900
Message-Id: <20191123160444.11251-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - Add a new patch that shrinks the table before the sort.

Masahiro Yamada (16):
  scripts/kallsyms: remove unneeded #ifndef ARRAY_SIZE
  scripts/kallsyms: fix definitely-lost memory leak
  scripts/kallsyms: shrink table before sorting it
  scripts/kallsyms: set relative_base more effectively
  scripts/kallsyms: remove redundant is_arm_mapping_symbol()
  scripts/kallsyms: remove unneeded length check for prefix matching
  scripts/kallsyms: add sym_name() to mitigate cast ugliness
  scripts/kallsyms: replace prefix_underscores_count() with strspn()
  scripts/kallsyms: make find_token() return (unsigned char *)
  scripts/kallsyms: add const qualifiers where possible
  scripts/kallsyms: skip ignored symbols very early
  scripts/kallsyms: move more patterns to the ignored_prefixes array
  scripts/kallsyms: move ignored symbol types to is_ignored_symbol()
  scripts/kallsyms: make check_symbol_range() void function
  scripts/kallsyms: put check_symbol_range() calls close together
  scripts/kallsyms: remove redundant initializers

 scripts/kallsyms.c | 287 ++++++++++++++++++++++-----------------------
 1 file changed, 142 insertions(+), 145 deletions(-)

-- 
2.17.1


Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F77FC28CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B2F25763
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EUKpa71h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfFCINc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:13:32 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:56793 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfFCINb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:13:31 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x538Cdop002048;
        Mon, 3 Jun 2019 17:12:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x538Cdop002048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559549560;
        bh=CSp6dvaAsVp+fen60fg+myoBPeV8iOlGhqeP8oJkU2M=;
        h=From:To:Cc:Subject:Date:From;
        b=EUKpa71hQh7iuTY1IYqESDW86tHlQhgGgdKflIKYHHvGpezMaBr8vawija1OYHQdQ
         2kqomTdlJ9AX7dwnGeuMJGBTNQbMyU8y2Om6/hb9p88FIvo74YPP584uHl1pvbk+8W
         S2woKzAkc4Atsb1KPfdMgFu4ZTC7bXejymZrHHiNlOwGXxHdHQ/nCi2PBr053KO2xL
         QB3KQtXIZlChUERhQjl3X6aAB/T04RiyfZNcEyVUoSMsc282eC1dJ8JgzQiqbtGSYr
         QzASsNn/C1EKROVY9bT3pgg138OC9hCB6OYbF/YxuKMx9XSjW/hhsZsMRGzU9J+zfc
         +S6/h5fsKfjKw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     arm@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>
Subject: [RESEND PATCH 0/2] memory: move jedec_ddr_data.c and jedec_ddr.h to drivers/memory/
Date:   Mon,  3 Jun 2019 17:12:31 +0900
Message-Id: <20190603081233.17394-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I believe this is a nice clean-up of directory path.

include/memory/ has existed just for containing one header,
and it is gone now.

There is no sub-system that takes care of drivers/memory/.
I sent this series some time ago, but I did not get any feedback.

I am resending it to ARM-SOC ML.
I hope Arnd or Olof will take a look at this.



Masahiro Yamada (2):
  memory: move jedec_ddr_data.c from lib/ to drivers/memory/
  memory: move jedec_ddr.h from include/memory to drivers/memory/

 drivers/memory/Kconfig                   | 8 ++++++++
 drivers/memory/Makefile                  | 1 +
 drivers/memory/emif.c                    | 3 ++-
 {include => drivers}/memory/jedec_ddr.h  | 6 +++---
 {lib => drivers/memory}/jedec_ddr_data.c | 5 +++--
 drivers/memory/of_memory.c               | 3 ++-
 lib/Kconfig                              | 8 --------
 lib/Makefile                             | 2 --
 8 files changed, 19 insertions(+), 17 deletions(-)
 rename {include => drivers}/memory/jedec_ddr.h (97%)
 rename {lib => drivers/memory}/jedec_ddr_data.c (98%)

-- 
2.17.1


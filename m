Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C30C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 07:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74EF2190F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 07:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="hpPs0XdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfHYHZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 03:25:00 -0400
Received: from sender-pp-o92.zoho.com ([135.84.80.237]:25491 "EHLO
        sender-pp-o92.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfHYHY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 03:24:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566717892; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=KnLkakjaSWOr8aqqTr5CVmVZ0xhvbC3+Hzys3ngPB39g/9DVfTGf6FxriPtWUw3V+ocE7xcdXiBchcnGSBTZXi6z4EQAEjqvwe/2zJumsOxKvqz3hJBxA/gxHRx+pXiUHUohFGihSmiuUJjZj5sPxl/8BxmkX/2wyir4TJPky08=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1566717892; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=3NNrUIjh0f1bPUDLf0taHzlL+12vPDpBw1ysyGZ4Buc=; 
        b=ZEZHYI5hbbIeaYzM23CnXFW8LU4NOXPqluvNw9GVZ1AiUrg3s4F8ejG+g4AM3v36/Kl0N19Iy2OPueldoP7b0PCcbV4XheoJj6F1tAKdrrQ/o0V0BuO65/o0KTp7TphJH/WNt3b7+0OU1RWSIP1lPD6FxlK03k9U77BY/If0NkQ=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=KrwyEn5/BSLfJ+YtUzU+AkVV8Rsm/8Xp8XERkgO5vJGf/a5HBAWdeaCAY9BmKxhtT/9qrg15sIm9
    e2m/S179nUw/TsI8YrIM+TAv44NjKCkHZ5cwjr4x9vP7ZNdCRHsD  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1566717892;
        s=zm2019; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=746;
        bh=3NNrUIjh0f1bPUDLf0taHzlL+12vPDpBw1ysyGZ4Buc=;
        b=hpPs0XdBa72lIv5iYS8vdFYeOPZ0/scJP2vh5TppahVjYOxh5JUjoICPUXIywQlY
        /5wAxfmIUw/SaxIWud5zXnC+h5bT0QFvX0bpRsbSG5x7PHGVYs82/Wdj/TiZ+6hAnTJ
        wuEqTplWtLijVl8tj2s1O/v8qX6bTgTl2J1wAJfg=
Received: from YEHS1XR3054QMS.lenovo.com (123.120.58.107 [123.120.58.107]) by mx.zohomail.com
        with SMTPS id 1566717891295534.7694710157881; Sun, 25 Aug 2019 00:24:51 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     prarit@redhat.com, tyu1@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH 0/3] optimize writecache_writeback for performance
Date:   Sun, 25 Aug 2019 15:24:30 +0800
Message-Id: <20190825072433.2628-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

Patch 1 and 2 are used for cleaning the code, and they have got
Acked-by from Mikulas.

Patch 3 is used for performance optimization when writeback_all,
which could save more than half of time.
Of course, if the blocks in writecache are more uncontinuous and
disordered, the more performance improvement would be gained from
this patch.

Huaisheng Ye (3):
  dm writecache: remove unused member pointer in writeback_struct
  dm writecache: add unlikely for getting two block with same LBA
  dm writecache: optimize performance by sorting the blocks for
    writeback_all

 drivers/md/dm-writecache.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

-- 
1.8.3.1



Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91DAC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7427B2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFjbnv1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDKPcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:32:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34186 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfDKPcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:32:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id r186so2222995wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=bz2mtDpEEkdsjYErS+P1Sqo7bE7LXJLomhtT0ZOpJ08=;
        b=TFjbnv1X6o180eQtuMAKTN6ZMi/yqZTYG+uqLlV1XHz2I2/Hr510hYvhD1KBwRWieS
         wfo13DtebcluWzzJs/C64Ua/++HWC2B5sw8rQ5Y7T1AYMZA/yl0r0haCUH+T1ASIwv+E
         QIz2tzAYWbk17tZiDyjp7GUthajAbLYR5gpaOJl4BDB8+bceA1Ioaehda//9l2KvHEEP
         9XCgu7Th8TBGJS+GHgMPyaTnFsaInXGd9/FKFMHmS2BzKcdZDfr+fw/oPrmeNA9klB9g
         zCd0Xv/LhrLOeafrrcwVGinQSYlVdmAoxI1JdXW+lOzgJg//8XAhRplfhleXk1B5jPD7
         v0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=bz2mtDpEEkdsjYErS+P1Sqo7bE7LXJLomhtT0ZOpJ08=;
        b=nchngcndWv82oI21c3HyUu3N39tKWkFVQ/O/hMv6CxG4Zpnc0sTF2akq0Gf4AErDoA
         m+zqLHW1uWcI/Q5Ve7zs1kerqzVGQa8m4WMoxC+/j1XSccAGV7g462d1VFk83n31s6gI
         I8bHlxCSYXZF8dig29Te+NQ/cgLFdJc2IfvtG2Smw6uuWkQm7G0OMXinKu/3q+QeUIrE
         gN/baj3jSjLg4wpzkbptye8APGofCPlwwX62KZWIXIxlT7YDBGT10DuYxoyPfleekoNQ
         H6e8CHs/NTk9oL71yIRYru+blFuJx3s6Gjre/BpeLyb+IFgaHK/K3p2lh1SOVPYLNwRz
         zWkg==
X-Gm-Message-State: APjAAAWJK4XhCnFvdz/IndKpr3KBz0ECUAyGFR+aE3MKxzk+SOVoUV1E
        OL2wNxZcQLP1vWGWoMndAPc=
X-Google-Smtp-Source: APXvYqxfk45rpn+3mDejm51IncQ1iTWpYmavMD5gxFChyIWZn7tGbGsqeOX6wmduKEZf0eroWYs2BA==
X-Received: by 2002:a1c:a9cb:: with SMTP id s194mr7444462wme.62.1554996735690;
        Thu, 11 Apr 2019 08:32:15 -0700 (PDT)
Received: from ?IPv6:::1? (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id f11sm50063634wrm.30.2019.04.11.08.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:32:15 -0700 (PDT)
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleksiy.Avramchenko@sony.com, Dan Streetman <ddstreet@ieee.org>
From:   Vitaly Wool <vitalywool@gmail.com>
Subject: [PATCH 0/4] z3fold: support page migration
Message-ID: <b86e6a5e-44d6-2c1b-879e-54a1bc671ad3@gmail.com>
Date:   Thu, 11 Apr 2019 17:32:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements page migration support and slightly better
buddy search. To implement page migration support, z3fold has to move
away from the current scheme of handle encoding. i. e. stop encoding
page address in handles. Instead, a small per-page structure is created
which will contain actual addresses for z3fold objects, while pointers
to fields of that structure will be used as handles.

Thus, it will be possible to change the underlying addresses to reflect
page migration.

To support migration itself, 3 callbacks will be implemented:
	1: isolation callback: z3fold_page_isolate(): try to isolate
the page by removing it from all lists. Pages scheduled for some
activity and mapped pages will not be isolated. Return true if
isolation was successful or false otherwise
	2: migration callback: z3fold_page_migrate(): re-check critical
conditions and migrate page contents to the new page provided by the
system. Returns 0 on success or negative error code otherwise
	3: putback callback: z3fold_page_isolate(): put back the page
if z3fold_page_migrate() for it failed permanently (i. e. not with
-EAGAIN code).

To make sure an isolated page doesn't get freed, its kref is incremented
in z3fold_page_isolate() and decremented during post-migration
compaction, if migration was successful, or by z3fold_page_isolate() in
the other case.

Since the new handle encoding scheme implies slight memory consumption
increase, better buddy search (which decreases memory consumption) is
included in this patchset.

Vitaly Wool (4):
   z3fold: introduce helper functions
   z3fold: improve compression by extending search
   z3fold: add structure for buddy handles
   z3fold: support page migration

  mm/z3fold.c |  638 ++++++++++++++++++++++++++++++++++++++++++++++++++-------------
  1 file changed, 508 insertions(+), 130 deletions(-)

   



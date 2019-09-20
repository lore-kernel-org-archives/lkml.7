Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20554C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88CF2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lj8TXUiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392990AbfITOi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:38:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33303 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389025AbfITOiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:38:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id r17so9714347wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QpV7/+yAaByU9Gkvq1/TvnZG5n90383ADAkpodmCXBA=;
        b=lj8TXUiuIegfzRLSf+IsVql/zQQi6GFZkqQDxgz95XHsiUsXg5DoeBHTX2r5lfEuVL
         99o/mHwpCF20bDx+1HOUdBYqPPcXQOkQQ9h1Syh2E2RcuD8hNK6Gd42Y9tIBKP1Y+PM3
         cFHd7RMsJTSbEAEja3SWep4tucmR+Jo3cdNLQhml7wo+yG5jTcXTWxRuM7h2Hz/vwCqt
         MGGHxUXcvar9xbktUx/GrnEC33yWbAM6/sZFmuwZWoVf/D4RZB+8cOS31kjekKOlHC3K
         VPOPcf6qjzRwp210fcvX0LdHM01TRUo8i3RIJJnORMEzFGTtcr5EJhXu5CC78nLaKvLt
         SoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QpV7/+yAaByU9Gkvq1/TvnZG5n90383ADAkpodmCXBA=;
        b=TzEK6NADrMgsyDZ9sLbZAgNaMWYL56ZrNNSW0M6TAS/M3EHRMRxCGXTglJoz856Gvk
         Kytp7Xpe67aBZ86TuC/UDL/xqwLC30Kwo8fsnnWHgs5AqLnj2Q/LBw2zdc1a7cCct3DY
         JsfSU/TMV91UwT5tvz16jbtyqoehPmUr6FK5grYin6XOy8JXSG/hDa+LNVUBFsPg2oWS
         CLJ6ng5p0ZkwB4WwgSD/1CjiWJY6AbORHAl+3Pcom0CD+A5Ou72hVKhmXwi312TrZeKt
         GipGA/X/6jXihQw2SbHLWtsKAwjOe2cahSTZE7yNIOslUvqCYezbjQvme44GjhEnBFpp
         yeig==
X-Gm-Message-State: APjAAAXEkWKJV+yfkbl/6DHZuPIbQPnWT0YQ9rm0zTo2A2lDD9ePKIGa
        3kjXYRisFKhWV+xXSB7l5tKZOmshQrsKZONaX8Q=
X-Google-Smtp-Source: APXvYqw0EraUFYMhhNXRZxVr3iyCe1OeR0Iuge+9+HdkT5FN0Vn52o2HVYZsNRrV6bRmbu8jYWhELT7ZMhNGnb7ayFg=
X-Received: by 2002:a05:600c:24d1:: with SMTP id 17mr3773509wmu.104.1568990332904;
 Fri, 20 Sep 2019 07:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <1568962478-126260-1-git-send-email-nixiaoming@huawei.com>
 <20190920114336.GM1131@ZenIV.linux.org.uk> <206f8d57-dad9-26c3-6bf6-1d000f5698d4@huawei.com>
 <20190920124532.GN1131@ZenIV.linux.org.uk> <20190920125442.GA20754@ZenIV.linux.org.uk>
 <eb679ad2-4020-951c-e4d1-60cb059a5ca8@huawei.com>
In-Reply-To: <eb679ad2-4020-951c-e4d1-60cb059a5ca8@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 20 Sep 2019 16:38:39 +0200
Message-ID: <CAFLxGvzeLTVfA17DMEi5tSkzkUgJncjX5oHWe207x7bfUtugtw@mail.gmail.com>
Subject: Re: [PATCH] jffs2:freely allocate memory when parameters are invalid
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>, dilinger@queued.net,
        LKML <linux-kernel@vger.kernel.org>, daniel.santos@pobox.com,
        linux-mtd@lists.infradead.org, houtao1@huawei.com,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 4:14 PM Xiaoming Ni <nixiaoming@huawei.com> wrote:
> I still think this is easier to understand:
>  Free the memory allocated by the current function in the failed branch

Please note that jffs2 is in "odd fixes only" maintenance mode.
Therefore patches like this cannot be processed.

On my never ending review queue are some other jffs2 patches which
seem to address
real problems. These go first.

I see that many patches come form Huawai, maybe one of you can help
maintaining jffs2?
Reviews, tests, etc.. are very welcome!

-- 
Thanks,
//richard

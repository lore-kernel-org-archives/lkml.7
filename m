Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED2DC4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F4E20820
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438319AbfIUPhk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 11:37:40 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:58904 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438303AbfIUPhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 11:37:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0E94B608310C;
        Sat, 21 Sep 2019 17:37:37 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8SXr9EMJTOpX; Sat, 21 Sep 2019 17:37:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 55133613E499;
        Sat, 21 Sep 2019 17:37:36 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bXykVNXxa5Ah; Sat, 21 Sep 2019 17:37:36 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1042D608310C;
        Sat, 21 Sep 2019 17:37:36 +0200 (CEST)
Date:   Sat, 21 Sep 2019 17:37:35 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Boris Brezillon <bbrezillon@kernel.org>, dilinger@queued.net,
        linux-kernel <linux-kernel@vger.kernel.org>,
        daniel santos <daniel.santos@pobox.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        David Woodhouse <dwmw2@infradead.org>
Message-ID: <1837147225.3667.1569080255850.JavaMail.zimbra@nod.at>
In-Reply-To: <b2425bd2-38e9-cb9b-4151-94891f3a71d1@huawei.com>
References: <1568962478-126260-1-git-send-email-nixiaoming@huawei.com> <20190920114336.GM1131@ZenIV.linux.org.uk> <206f8d57-dad9-26c3-6bf6-1d000f5698d4@huawei.com> <20190920124532.GN1131@ZenIV.linux.org.uk> <20190920125442.GA20754@ZenIV.linux.org.uk> <eb679ad2-4020-951c-e4d1-60cb059a5ca8@huawei.com> <CAFLxGvzeLTVfA17DMEi5tSkzkUgJncjX5oHWe207x7bfUtugtw@mail.gmail.com> <b2425bd2-38e9-cb9b-4151-94891f3a71d1@huawei.com>
Subject: Re: [PATCH] jffs2:freely allocate memory when parameters are
 invalid
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: jffs2:freely allocate memory when parameters are invalid
Thread-Index: jsGu5gCQ4Vd/48D/3p31+ncM705uWQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tao,

----- Ursprüngliche Mail -----
> Von: "Hou Tao" <houtao1@huawei.com>
> In Huawei we use jffs2 broadly in our products to support filesystem on raw
> NOR flash and NAND flash, so fixing the bugs in jffs2 means a lot to us.
> 
> Although I have not read all of jffs2 code thoroughly, I had find and "fixed"
> some bugs in jffs2 and I am willing to do any help in the jffs2 community. Maybe
> we can start by testing and reviewing the pending patches in patch work ?

yes, this is a good idea.
In MTD's patchwork the jffs2 queue is in bad shape. I tried to catch up
but failed to find enough time. So with more eyeballs I think we can bring it
in shape again.
Basically we need to classify which patches fix important stuff and which do not.

Some time ago I make xfstests work with jffs2, I can share (and upstream) these
patches too.
One of my goals is making sure that we don't break jffs2. xfstests can help.

Are you on the OFTC IRC network? On #mtd you can find us MTD guys.

Thanks,
//richard

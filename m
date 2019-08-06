Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EDDC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A272089E
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732950AbfHFObn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:31:43 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:38408 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbfHFObn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:31:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 15BAD60632C5;
        Tue,  6 Aug 2019 16:31:41 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6tSzbEOwQAU8; Tue,  6 Aug 2019 16:31:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CF0AA60632C6;
        Tue,  6 Aug 2019 16:31:38 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cpqRSinVYc4o; Tue,  6 Aug 2019 16:31:38 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 83B8460632C5;
        Tue,  6 Aug 2019 16:31:38 +0200 (CEST)
Date:   Tue, 6 Aug 2019 16:31:38 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Liu Song <fishland@aliyun.com>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        liu song11 <liu.song11@zte.com.cn>
Message-ID: <797425154.59041.1565101898396.JavaMail.zimbra@nod.at>
In-Reply-To: <20190806142140.33013-1-fishland@aliyun.com>
References: <20190806142140.33013-1-fishland@aliyun.com>
Subject: Re: [PATCH] ubifs: limit the number of pages in shrink_liability
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: limit the number of pages in shrink_liability
Thread-Index: cczq56dldsF78VWHvcAJFcITyquhhQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Liu Song" <fishland@aliyun.com>
> An: "richard" <richard@nod.at>, "Artem Bityutskiy" <dedekind1@gmail.com>, "Adrian Hunter" <adrian.hunter@intel.com>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "liu song11"
> <liu.song11@zte.com.cn>
> Gesendet: Dienstag, 6. August 2019 16:21:40
> Betreff: [PATCH] ubifs: limit the number of pages in shrink_liability

> From: Liu Song <liu.song11@zte.com.cn>
> 
> If the number of dirty pages to be written back is large,
> then writeback_inodes_sb will block waiting for a long time,
> causing hung task detection alarm. Therefore, we should limit
> the maximum number of pages written back this time, which let
> the budget be completed faster. The remaining dirty pages
> tend to rely on the writeback mechanism to complete the
> synchronization.

On which kind of system do you hit this?
Your fix makes sense but I'd like to have more background information.

UBIFS acts that way for almost a decade, see:
b6e51316daed ("writeback: separate starting of sync vs opportunistic writeback")

Thanks,
//richard

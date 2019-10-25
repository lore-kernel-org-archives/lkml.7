Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742DBCA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 02:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E92A21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 02:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391102AbfJYCvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 22:51:01 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2065 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732696AbfJYCvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:51:00 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 4208DBF4F971B1226BAC;
        Fri, 25 Oct 2019 10:50:56 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 25 Oct 2019 10:50:44 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 25 Oct 2019 10:50:44 +0800
Date:   Fri, 25 Oct 2019 10:53:35 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Philippe Liard <pliard@google.com>
CC:     <phillip@squashfs.org.uk>, <linux-kernel@vger.kernel.org>,
        <groeck@chromium.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] squashfs: Migrate from ll_rw_block usage to BIO
Message-ID: <20191025025334.GA210047@architecture4>
References: <20191018010846.186484-1-pliard@google.com>
 <20191025004531.89978-1-pliard@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191025004531.89978-1-pliard@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 09:45:31AM +0900, Philippe Liard wrote:
> > Personally speaking, just for Android related use cases, I'd suggest
> > latest EROFS if you care more about system overall performance more
> > than compression ratio, even https://lkml.org/lkml/2017/9/22/814 is
> > applied (you can do benchmark), we did much efforts 3 years ago.
> >
> > And that is not only performance but noticable memory overhead (a lot
> > of extra memory allocations) and heavy page cache thrashing in low
> > memory scenarios (it's very common [1].)
> 
> Thanks for the suggestion. EROFS is on our radar and we will
> (re)consider it once it goes out of staging. But we will most likely
> stay on squashfs until this happens.

EROFS is already out of staging in mainline right now,
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/erofs/

If you agree on that, I'd suggest you try it right now
since it's widely (200+ million devices on the market)
deployed for our Android smartphones and fully open source
and open community. I think this is not a regrettable
attempt and we can response any question.

https://lore.kernel.org/r/20191024033259.GA2513@hsiangkao-HP-ZHAN-66-Pro-G1

In my personal opinion, just for Android use cases,
I think it is worth taking some time.

Thanks,
Gao Xiang


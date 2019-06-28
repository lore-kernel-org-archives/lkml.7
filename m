Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCBCC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CDE20644
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfF1Gsd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:48:33 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:36596 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfF1Gsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:48:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CEDF46089331;
        Fri, 28 Jun 2019 08:48:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3lpGg--qV6w5; Fri, 28 Jun 2019 08:48:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 817816089332;
        Fri, 28 Jun 2019 08:48:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vZ0P4sgDZbfv; Fri, 28 Jun 2019 08:48:28 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 46B946089331;
        Fri, 28 Jun 2019 08:48:28 +0200 (CEST)
Date:   Fri, 28 Jun 2019 08:48:28 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1@huawei.com
Cc:     david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        david <david@sigma-star.at>,
        boris brezillon <boris.brezillon@free-electrons.com>,
        yi zhang <yi.zhang@huawei.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <455367016.19242.1561704508169.JavaMail.zimbra@nod.at>
In-Reply-To: <1561698143-5027-1-git-send-email-chengzhihao1@huawei.com>
References: <1561698143-5027-1-git-send-email-chengzhihao1@huawei.com>
Subject: Re: [PATCH RFC] mtd: ubi: Add fastmap sysfs attribute
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: Add fastmap sysfs attribute
Thread-Index: LGtMcgAbFQrQ8WTgV4gLe2Q2i5xyZw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhihao Cheng,

----- Ursprüngliche Mail -----
> +	else if (attr == &dev_fastmap)
> +		ret = sprintf(buf, "%d\n", ubi->fm ? 1 : 0);
> 	else

I fear this is not correct. ubi->fm is an internal data structure
of UBI.
UBI sets it to NULL while it updates fastmap, and updates it later.
So userspace would see false negatives.

Thanks,
//richard

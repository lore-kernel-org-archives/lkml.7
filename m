Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9C2C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9FC20645
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfGCW5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 18:57:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:40589 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGCW5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 18:57:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x63MvDeS012356;
        Wed, 3 Jul 2019 17:57:14 -0500
Message-ID: <319ae04497cf1982076bf801cfdf565046096fd4.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 OPT2] driver core: Fix use-after-free and double free
 on glue directory
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Muchun Song <smuchun@gmail.com>
Cc:     rafael@kernel.org, prsood@codeaurora.org, mojha@codeaurora.org,
        gkohli@codeaurora.org, linux-kernel@vger.kernel.org
Date:   Thu, 04 Jul 2019 08:57:13 +1000
In-Reply-To: <20190703193606.GA8452@kroah.com>
References: <20190626144021.7249-1-smuchun@gmail.com>
         <20190703193606.GA8452@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-03 at 21:36 +0200, Greg KH wrote:
> 
> > -static struct kobject *get_device_parent(struct device *dev,
> > -					 struct device *parent)
> > +/**
> > + * __get_device_parent() - Get the parent device kobject.
> > + * @dev: Pointer to the device structure.
> > + * @parent: Pointer to the parent device structure.
> > + * @lock: When we live in a glue directory, should we hold the
> > + *        gdp_mutex lock when this function returns? If @lock
> > + *        is true, this function returns with the gdp_mutex
> > + *        holed. Otherwise it will not.
> 
> Ugh, if you are trying to get me to hate one version of these patches,
> this is how you do it :)
> 
> A function should not "sometimes takes a lock, sometimes does not,
> depending on a parameter passed into it"  That way lies madness...

Yes, I prefer this approach to the fix but I dont like the patch either
for the same reason...

 ...

> Anyway, this is a mess.
> 
> Ugh I hate glue dirs...

Amen...

Ben.



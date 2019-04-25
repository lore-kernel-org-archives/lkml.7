Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21E7C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BAC20652
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfDYJYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:24:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:49608 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfDYJYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:24:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x3P9OdMm015565;
        Thu, 25 Apr 2019 04:24:40 -0500
Message-ID: <24b0fff3775147c04b006282727d94fea7f408b4.camel@kernel.crashing.org>
Subject: Re: [PATCH] driver core: Fix use-after-free and double free on glue
 directory
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Muchun Song <smuchun@gmail.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 25 Apr 2019 19:24:39 +1000
In-Reply-To: <20190423143258.96706-1-smuchun@gmail.com>
References: <20190423143258.96706-1-smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-23 at 22:32 +0800, Muchun Song wrote:
> There is a race condition between removing glue directory and adding a new
> device under the glue directory. It can be reproduced in following test:
> 

 .../...

> In order to avoid this happening, we we should not call kobject_del() on
> path2 when the reference count of glue_dir is greater than 1. So we add a
> conditional statement to fix it.

Good catch ! However I'm not completely happy about the fix you
propose.

I find relying on the object count for such decisions rather fragile as
it could be taken temporarily for other reasons, couldn't it ? In which
case we would just fail...

Ideally, the looking up of the glue dir and creation of its child
should be protected by the same lock instance (the gdp_mutex in that
case).

That might require a bit of shuffling around though.

Greg, thoughts ? This whole gluedir business is annoyingly racy still.

My gut feeling is that the "right fix" is to ensure the lookup of the
glue dir and creation of the child object(s) are done under a single
instance of gdp_mutex so we never see a stale "empty" but still
poentially used glue dir around.

This should also be true when creating such gluedir in the first place
in fact, though that race is a lot harder to hit.

Cheers,
Ben.



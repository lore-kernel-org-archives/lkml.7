Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5707DC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 10:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3008721473
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 10:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfD1KKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 06:10:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:56902 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfD1KK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 06:10:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x3SAAJxT002276;
        Sun, 28 Apr 2019 05:10:20 -0500
Message-ID: <a37e7a49c3e7fa6ece2be2b76798fef3e51ade4e.camel@kernel.crashing.org>
Subject: Re: [PATCH] driver core: Fix use-after-free and double free on glue
 directory
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Muchun Song <smuchun@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        zhaowuyun@wingtech.com
Date:   Sun, 28 Apr 2019 13:10:19 +0300
In-Reply-To: <CAPSr9jHhwASv7=83hU+81mC0JJyuyt2gGxLmyzpCOfmc9vKgGQ@mail.gmail.com>
References: <20190423143258.96706-1-smuchun@gmail.com>
         <24b0fff3775147c04b006282727d94fea7f408b4.camel@kernel.crashing.org>
         <CAPSr9jHhwASv7=83hU+81mC0JJyuyt2gGxLmyzpCOfmc9vKgGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-25 at 23:44 +0800, Muchun Song wrote:
> I agree with you that the looking up of the glue dir and creation of its child
> should be protected by the same lock of gdp_mutex. So, do you agree with
> the fix of the following code snippet?

The basic idea yes, the whole bool *locked is horrid though. Wouldn't it
work to have a get_device_parent_locked that always returns with the mutex held,
or just move the mutex to the caller or something simpler like this ?

Ben.



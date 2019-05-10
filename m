Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C30C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F48217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfEJWG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 18:06:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58510 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfEJWGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 18:06:25 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B4E8B133E975E;
        Fri, 10 May 2019 15:06:24 -0700 (PDT)
Date:   Fri, 10 May 2019 15:06:22 -0700 (PDT)
Message-Id: <20190510.150622.135840136910324302.davem@davemloft.net>
To:     tobin@kernel.org
Cc:     gregkh@linuxfoundation.org, roopa@cumulusnetworks.com,
        nikolay@cumulusnetworks.com, tyhicks@canonical.com,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bridge: Fix error path for kobject_init_and_add()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190510025212.10109-1-tobin@kernel.org>
References: <20190510025212.10109-1-tobin@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 10 May 2019 15:06:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tobin C. Harding" <tobin@kernel.org>
Date: Fri, 10 May 2019 12:52:12 +1000

> Currently error return from kobject_init_and_add() is not followed by a
> call to kobject_put().  This means there is a memory leak.  We currently
> set p to NULL so that kfree() may be called on it as a noop, the code is
> arguably clearer if we move the kfree() up closer to where it is
> called (instead of after goto jump).
> 
> Remove a goto label 'err1' and jump to call to kobject_put() in error
> return from kobject_init_and_add() fixing the memory leak.  Re-name goto
> label 'put_back' to 'err1' now that we don't use err1, following current
> nomenclature (err1, err2 ...).  Move call to kfree out of the error
> code at bottom of function up to closer to where memory was allocated.
> Add comment to clarify call to kfree().
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
> 
> v1 was a part of a set.  I have dropped the other patch until I can work
> out a correct solution.

Applied and queued up for -stable, thanks.

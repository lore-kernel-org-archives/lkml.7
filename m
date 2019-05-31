Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82702C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F0526F61
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfEaVqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 17:46:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51068 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfEaVqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 17:46:37 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 991A615015E81;
        Fri, 31 May 2019 14:46:36 -0700 (PDT)
Date:   Fri, 31 May 2019 14:46:35 -0700 (PDT)
Message-Id: <20190531.144635.1962054387021988238.davem@davemloft.net>
To:     bjorn.andersson@linaro.org
Cc:     aneela@codeaurora.org, clew@codeaurora.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] net: qrtr: Implement outgoing flow control
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190531011753.11840-3-bjorn.andersson@linaro.org>
References: <20190531011753.11840-1-bjorn.andersson@linaro.org>
        <20190531011753.11840-3-bjorn.andersson@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 31 May 2019 14:46:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Thu, 30 May 2019 18:17:50 -0700

> +	flow = radix_tree_lookup(&node->qrtr_tx_flow, key);
> +	if (flow)
> +		atomic_set(&flow->pending, 0);

You can't just zero out an atomic counter without extra synchronization
which protects you from the increment paths.

And since you'll need a lock to cover all of those paths, you don't
need to use an atomic_t and instead can use a plain integer.

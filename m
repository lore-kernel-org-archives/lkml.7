Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD16C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C7B20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfDKVCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:02:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35028 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKVCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:02:04 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B959C14CCEF5D;
        Thu, 11 Apr 2019 14:02:03 -0700 (PDT)
Date:   Thu, 11 Apr 2019 14:02:03 -0700 (PDT)
Message-Id: <20190411.140203.1367510571263899902.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dns: remove redundant zero length namelen check
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190409125912.11600-1-colin.king@canonical.com>
References: <20190409125912.11600-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 11 Apr 2019 14:02:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Tue,  9 Apr 2019 13:59:12 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> The zero namelen check is redundant as it has already been checked
> for zero at the start of the function.  Remove the redundant check.
> 
> Addresses-Coverity: ("Logically Dead Code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to net-next.

However it does look like two sets of semantics were considered.
In one case rejecting a zero namelen and in another having it
mean whatever the strings length is modulo the max of 256.

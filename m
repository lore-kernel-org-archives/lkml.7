Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6395CC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 20:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36ACB20850
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 20:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfEJU2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 16:28:03 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57044 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbfEJU2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 16:28:03 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6D5B014E0DA4F;
        Fri, 10 May 2019 13:28:02 -0700 (PDT)
Date:   Fri, 10 May 2019 13:28:00 -0700 (PDT)
Message-Id: <20190510.132800.1971158293891484440.davem@davemloft.net>
To:     hofrat@osadl.org
Cc:     aneela@codeaurora.org, gregkh@linuxfoundation.org,
        anshuman.khandual@arm.com, david@redhat.com, arnd@arndb.de,
        johannes.berg@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qrtr: use protocol endiannes variable
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1557450533-9321-1-git-send-email-hofrat@osadl.org>
References: <1557450533-9321-1-git-send-email-hofrat@osadl.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 10 May 2019 13:28:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>
Date: Fri, 10 May 2019 03:08:53 +0200

> diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
> index dd0e97f..c90edaa 100644
> --- a/net/qrtr/qrtr.c
> +++ b/net/qrtr/qrtr.c
> @@ -733,7 +733,8 @@ static int qrtr_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
>  	struct qrtr_node *node;
>  	struct sk_buff *skb;
>  	size_t plen;
> -	u32 type = QRTR_TYPE_DATA;
> +	u32 type = 0;
> +	__le32 qrtr_type = cpu_to_le32(QRTR_TYPE_DATA);
>  	int rc;

Please try to preserve as much of the reverse chrimstas tree here rather
than making it worse.

Thank you.

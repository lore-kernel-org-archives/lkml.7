Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12749C31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 20:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96D62184D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 20:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfFOUcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 16:32:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39354 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfFOUcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 16:32:42 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F126814EB8616;
        Sat, 15 Jun 2019 13:32:41 -0700 (PDT)
Date:   Sat, 15 Jun 2019 13:32:41 -0700 (PDT)
Message-Id: <20190615.133241.1697724537695155418.davem@davemloft.net>
To:     houjingyi647@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix double-fetch bug in sock_getsockopt()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190613104457.GA6296@hjy-HP-Notebook>
References: <20190613104457.GA6296@hjy-HP-Notebook>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 15 Jun 2019 13:32:42 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: JingYi Hou <houjingyi647@gmail.com>
Date: Thu, 13 Jun 2019 18:44:57 +0800

> In sock_getsockopt(), 'optlen' is fetched the first time from userspace.
> 'len < 0' is then checked. Then in condition 'SO_MEMINFO', 'optlen' is
> fetched the second time from userspace without check.
> 
> if a malicious user can change it between two fetches may cause security
> problems or unexpected behaivor.
> 
> To fix this, we need to recheck it in the second fetch.
> 
> Signed-off-by: JingYi Hou <houjingyi647@gmail.com>

THere is no reason to fetch len a second time, so please just remove
the get_user() call here instead.

Also, please format your Subject line properly with appropriate subsystem
prefixes etc.

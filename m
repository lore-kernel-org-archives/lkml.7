Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E991AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 01:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87C62133F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 01:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfCXBtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 21:49:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35254 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbfCXBtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 21:49:11 -0400
Received: from localhost (unknown [50.233.106.125])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C3AF514B47A72;
        Sat, 23 Mar 2019 18:49:10 -0700 (PDT)
Date:   Sat, 23 Mar 2019 21:49:10 -0400 (EDT)
Message-Id: <20190323.214910.174783827736915395.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     jon.maloy@ericsson.com, ying.xue@windriver.com,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com,
        natechancellor@gmail.com, tuong.t.lien@dektech.com.au,
        canh.d.luu@dektech.com.au, tung.q.nguyen@dektech.com.au,
        mohan.krishna.ghanta.krishnamurthy@ericsson.com,
        netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tipc: avoid a clang -Wuninitialized warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190322141819.641588-1-arnd@arndb.de>
References: <20190322141819.641588-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 23 Mar 2019 18:49:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 Mar 2019 15:18:13 +0100

> clang notices that we pass 'maddr' into the tipc_bearer_xmit() function
> without having initialized it first:
 ...
> This is harmless because it won't use 'maddr' if the
> queue is empty, but it's better to make that explicit
> and not even call the function in that case.
> 
> As clang is able to inline the check, it then notices that
> the code is safe.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

It looks like Jon's patch took care of this.

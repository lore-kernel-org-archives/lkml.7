Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55182C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3703C20872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404834AbfIJIJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 04:09:32 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53050 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404739AbfIJIJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 04:09:31 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4F5F8154A86C5;
        Tue, 10 Sep 2019 01:09:28 -0700 (PDT)
Date:   Tue, 10 Sep 2019 10:09:23 +0200 (CEST)
Message-Id: <20190910.100923.398630420341862032.davem@davemloft.net>
To:     chunguo.feng@amlogic.com
Cc:     edumazet@google.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] tcp: fix tcp_disconnect() not clear tp->fastopen_rsk
 sometimes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190906093429.930-1-chunguo.feng@amlogic.com>
References: <20190906093429.930-1-chunguo.feng@amlogic.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 10 Sep 2019 01:09:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chunguo feng <chunguo.feng@amlogic.com>
Date: Fri, 6 Sep 2019 17:34:29 +0800

> From: fengchunguo <chunguo.feng@amlogic.com>
> 
> This patch avoids fastopen_rsk not be cleared every times, then occur 
> the below BUG_ON:
> tcp_v4_destroy_sock
> 	->BUG_ON(tp->fastopen_rsk);
> 
> When playback some videos from netwrok,used tcp_disconnect continually.
 ...
> Signed-off-by: fengchunguo <chunguo.feng@amlogic.com>

This still needs review.

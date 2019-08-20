Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335E7C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 01:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A7D2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 01:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfHTBMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 21:12:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39050 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfHTBMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 21:12:23 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2FA0414B5632F;
        Mon, 19 Aug 2019 18:12:22 -0700 (PDT)
Date:   Mon, 19 Aug 2019 18:12:19 -0700 (PDT)
Message-Id: <20190819.181219.24181991280730634.davem@davemloft.net>
To:     zhang.lin16@zte.com.cn
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, willemb@google.com,
        edumazet@google.com, deepa.kernel@gmail.com, arnd@arndb.de,
        dh.herrmann@gmail.com, gnault@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        jiang.xuexin@zte.com.cn
Subject: Re: [PATCH] sock: fix potential memory leak in proto_register()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1566178556-46071-1-git-send-email-zhang.lin16@zte.com.cn>
References: <1566178556-46071-1-git-send-email-zhang.lin16@zte.com.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 19 Aug 2019 18:12:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhanglin <zhang.lin16@zte.com.cn>
Date: Mon, 19 Aug 2019 09:35:56 +0800

> If protocols registered exceeded PROTO_INUSE_NR, prot will be
> added to proto_list, but no available bit left for prot in
> proto_inuse_idx.
> 
> Signed-off-by: zhanglin <zhang.lin16@zte.com.cn>

This won't build with CONFIG_PROC_FS disabled.

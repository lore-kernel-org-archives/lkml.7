Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E527C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7702081C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfEVTrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:47:55 -0400
Received: from nautica.notk.org ([91.121.71.147]:40778 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732565AbfEVTru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:47:50 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id EC896C009; Wed, 22 May 2019 21:47:48 +0200 (CEST)
Date:   Wed, 22 May 2019 21:47:33 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v2] 9p/cache.c: Fix memory leak in
 v9fs_cache_session_get_cookie
Message-ID: <20190522194733.GA4766@nautica>
References: <20190522194519.GA5313@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190522194519.GA5313@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bharath Vedartham wrote on Thu, May 23, 2019:
> v9fs_cache_session_get_cookie assigns a random cachetag to v9ses->cachetag,
> if the cachetag is not assigned previously.
> 
> v9fs_random_cachetag allocates memory to v9ses->cachetag with kmalloc and uses
> scnprintf to fill it up with a cachetag.
> 
> But if scnprintf fails, v9ses->cachetag is not freed in the current
> code causing a memory leak.
> 
> Fix this by freeing v9ses->cachetag it v9fs_random_cachetag fails.
> 
> This was reported by syzbot, the link to the report is below:
> https://syzkaller.appspot.com/bug?id=f012bdf297a7a4c860c38a88b44fbee43fd9bbf3
> 
> Reported-by: syzbot+3a030a73b6c1e9833815@syzkaller.appspotmail.com
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>


Thanks!

I'm on limited internet right now but will run tests and queue this up tomorrow

-- 
Dominique

Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920D8C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6094D2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfDECzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 22:55:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57760 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfDECzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 22:55:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hCF0k-0004lZ-Lq; Fri, 05 Apr 2019 02:55:22 +0000
Date:   Fri, 5 Apr 2019 03:55:22 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "wanghai (M)" <wanghai26@huawei.com>
Cc:     syzbot <syzbot+6024817a931b2830bc93@syzkaller.appspotmail.com>,
        alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        andriy.shevchenko@linux.intel.com, davem@davemloft.net,
        dmitry.torokhov@gmail.com, f.fainelli@gmail.com,
        idosch@mellanox.com, joe@perches.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, stephen@networkplumber.org,
        syzkaller-bugs@googlegroups.com, tyhicks@canonical.com,
        yuehaibing@huawei.com, gregkh@linuxfoundation.org
Subject: Re: kernel BUG at net/core/net-sysfs.c:LINE!
Message-ID: <20190405025522.GI2217@ZenIV.linux.org.uk>
References: <000000000000e644ba0584bdf7e8@google.com>
 <79eff7ec-4127-e58c-bf11-ade3b482fb43@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79eff7ec-4127-e58c-bf11-ade3b482fb43@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 11:19:03AM +0800, wanghai (M) wrote:
> Can someone fix this issue? Thanks.

Revert the bogus patch, perhaps?  Because bogus it is - failure of
register_netdevice() should NOT drop the reference it's been given.
It's up to the caller and that's when the name will be freed.

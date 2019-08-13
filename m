Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9CBC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6F120840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfHMEFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 00:05:54 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:60496 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfHMEFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:05:53 -0400
Received: from toshiba (85-76-66-155-nat.elisa-mobile.fi [85.76.66.155])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 6960AB0040;
        Tue, 13 Aug 2019 07:05:50 +0300 (EEST)
Message-ID: <5D523729.B7BF986@users.sourceforge.net>
Date:   Tue, 13 Aug 2019 07:06:01 +0300
From:   Jari Ruusu <jariruusu@users.sourceforge.net>
MIME-Version: 1.0
To:     Ben Hutchings <ben@decadent.org.uk>
CC:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        Hulk Robot <hulkci@huawei.com>, Jan Kara <jack@suse.cz>,
        "zhangyi (F)" <yi.zhang@huawei.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 3.16 043/157] ext4: brelse all indirect buffer 
 inext4_ind_remove_space()
References: <lsq.1565469607.761898531@decadent.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Hutchings wrote:
> From: "zhangyi (F)" <yi.zhang@huawei.com>
> 
> commit 674a2b27234d1b7afcb0a9162e81b2e53aeef217 upstream.

[snip]

> --- a/fs/ext4/indirect.c
> +++ b/fs/ext4/indirect.c
> @@ -1481,10 +1481,14 @@ end_range:
>                                            partial->p + 1,
>                                            partial2->p,
>                                            (chain+n-1) - partial);
> -                       BUFFER_TRACE(partial->bh, "call brelse");
> -                       brelse(partial->bh);
> -                       BUFFER_TRACE(partial2->bh, "call brelse");
> -                       brelse(partial2->bh);
> +                       while (partial > chain) {
> +                               BUFFER_TRACE(partial->bh, "call brelse");
> +                               brelse(partial->bh);
> +                       }
> +                       while (partial2 > chain2) {
> +                               BUFFER_TRACE(partial2->bh, "call brelse");
> +                               brelse(partial2->bh);
> +                       }
>                         return 0;
>                 }
> 

Above patch is really messed up. Alone that patch is livelocking
and file system corrupting. Look at those new while loops. Once the
while condition is true once, it is ALWAYS true, so it livelocks.

It absolutely needs follow-up patch from <yi.zhang@huawei.com>
"ext4: cleanup bh release code in ext4_ind_remove_space()"
upstream commit 5e86bdda41534e17621d5a071b294943cae4376e.

For more info about how to trigger that bug, see this earlier email

https://marc.info/?l=linux-kernel&m=155419973129522&w=2

For 3.16 kernels you may need to set CONFIG_EXT4_USE_FOR_EXT23=y
so that ext4 code handles ext3 file systems.

-- 
Jari Ruusu  4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD  ACDF F073 3C80 8132 F189

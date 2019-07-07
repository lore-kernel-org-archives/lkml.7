Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52015C5B578
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 03:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAC12083B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 03:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562470675;
	bh=NSUhT03/N1dAomU6Y1lmRVJq8O8g6qPmcXLaYh8VDWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AMXYs6POkQoc3ouINafsiXsLzYkee+Q5fVlzlcwSr/tcho4fAq5IZVK4HlUM+6c8C
	 de8ZWYazi1h2rIH0w23+lkfBSjWqx6Avhe2v/T6Dd5anVQRZI0InaZwPrDYNLmT/Mu
	 ktHw2MNOw/4m+7FIa8mBVX018mqiPPPHMrFDwRWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfGGDhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 23:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbfGGDhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 23:37:47 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D36B32083B;
        Sun,  7 Jul 2019 03:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562470666;
        bh=NSUhT03/N1dAomU6Y1lmRVJq8O8g6qPmcXLaYh8VDWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XjyayPdPoyHC8PvLyHFWTlMsNu5kqeAU7JgVQGm/FtWxLlmz4ps41cHsRprYaDNlj
         0qKmAc4F+5/rHdXFWZzR0ifJSi/WWxAGCPPA29bEaRxqq130WhKf2NtbJ8KWj4kriy
         QVFGNOS52WsfjqPK8mnsf0XX59oz5j2Nw0h2hnuM=
Date:   Sat, 6 Jul 2019 20:37:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nilfs2: do not use unexported
 cpu_to_le32()/le32_to_cpu() in uapi header
Message-Id: <20190706203745.af0bf9bd5dd46e94fa5e1ff9@linux-foundation.org>
In-Reply-To: <20190605053006.14332-1-yamada.masahiro@socionext.com>
References: <20190605053006.14332-1-yamada.masahiro@socionext.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Jun 2019 14:30:06 +0900 Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> cpu_to_le32/le32_to_cpu is defined in include/linux/byteorder/generic.h,
> which is not exported to user-space.
> 
> UAPI headers must use the ones prefixed with double-underscore.
> 
> Detected by compile-testing exported headers:
> 
> ./usr/include/linux/nilfs2_ondisk.h: In function ‘nilfs_checkpoint_set_snapshot’:
> ./usr/include/linux/nilfs2_ondisk.h:536:17: error: implicit declaration of function ‘cpu_to_le32’ [-Werror=implicit-function-declaration]
>   cp->cp_flags = cpu_to_le32(le32_to_cpu(cp->cp_flags) |  \
>                  ^
> ./usr/include/linux/nilfs2_ondisk.h:552:1: note: in expansion of macro ‘NILFS_CHECKPOINT_FNS’
>  NILFS_CHECKPOINT_FNS(SNAPSHOT, snapshot)
>  ^~~~~~~~~~~~~~~~~~~~
> ./usr/include/linux/nilfs2_ondisk.h:536:29: error: implicit declaration of function ‘le32_to_cpu’ [-Werror=implicit-function-declaration]
>   cp->cp_flags = cpu_to_le32(le32_to_cpu(cp->cp_flags) |  \
>                              ^
> ./usr/include/linux/nilfs2_ondisk.h:552:1: note: in expansion of macro ‘NILFS_CHECKPOINT_FNS’
>  NILFS_CHECKPOINT_FNS(SNAPSHOT, snapshot)
>  ^~~~~~~~~~~~~~~~~~~~
> ./usr/include/linux/nilfs2_ondisk.h: In function ‘nilfs_segment_usage_set_clean’:
> ./usr/include/linux/nilfs2_ondisk.h:622:19: error: implicit declaration of function ‘cpu_to_le64’ [-Werror=implicit-function-declaration]
>   su->su_lastmod = cpu_to_le64(0);
>                    ^~~~~~~~~~~

Seems fairly serious.  I'm thinking this needs a cc:stable?

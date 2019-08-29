Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AFEC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65ED72077B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=volatile.bz header.i=@volatile.bz header.b="fs9EH6dX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfH2Ogg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:36:36 -0400
Received: from mx1.volatile.bz ([185.163.46.97]:53822 "EHLO mx1.volatile.bz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfH2Ogg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:36:36 -0400
Received: from thedarkness.local (unknown [IPv6:2600:6c5d:4200:1e2a:a077:9bc9:2f0:8eb9])
        by mx1.volatile.bz (Postfix) with ESMTPSA id 2E8E32F44;
        Thu, 29 Aug 2019 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=volatile.bz;
        s=default; t=1567089393;
        bh=dIygAd+GskXlJd02wsFKTXP3LiBbYusrlSD4b5VFWc4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=fs9EH6dXvM3d12xH4cTty5GccnQcwDxZti5Ktd3Qshd982Aw7CBfXQ2KUH6JHp4Zg
         QBmxZFX2t/D34+0MZAZwyyqVpDOseNtgLodKzrtzOd2mSSPDitw/sylEUqMa3sDi1k
         9J4PJuFYlxq8Q5glBMt32VbXPeaeUX61ILdJKk5w=
Date:   Thu, 29 Aug 2019 10:36:28 -0400
From:   Dark <dark@volatile.bz>
To:     Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH] um: Rewrite host RNG driver.
Message-ID: <20190829103628.61953f50@thedarkness.local>
In-Reply-To: <CAFLxGvyiviQxr_Bj57ibTU4DQ1H5wQC4DE5DNFBtAFoohcgbsg@mail.gmail.com>
References: <20190828204609.02a7ff70@TheDarkness>
 <CAFLxGvyiviQxr_Bj57ibTU4DQ1H5wQC4DE5DNFBtAFoohcgbsg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 15:26:24 +0200, Richard Weinberger <richard.weinberger@gmail.com> wrote: 
> So, you removed -EAGAIN handling, made everything synchronous,
> and changed the interface.t
> I'm not sure if this really a much better option.

I should have been more clear here that I'm using the interfaces 
provided by `drivers/char/hw_random/core.c` for consistency with the
other hardware RNG drivers and to avoid reimplementing stuff that's 
already there. 

It might be a bit hard to see in the diff, but I pass the file 
descriptor to `os_set_fd_async()` to prevent it from blocking.

For the -EAGAIN handling, I'm passing it onto the caller. Since you 
mentioned it, It would be better to handle it in the driver itself 
so I'll update the patch to address that.

> Rewriting the driver in a modern manner is a good thing, but throwing the
> old one way with a little hand weaving just because of a unspecified issue
> is a little harsh.
> Can you at lest provide more infos what problem you're facing with the
> old driver?

Most of it boiled down to it silently breaking if /dev/random on the 
host were to block for any reason, and there was the userspace tool
requirement to properly make use of it. With that said, the interface 
was also inconsistent with the other hardware RNG drivers which would 
require a rewrite to address anyway.

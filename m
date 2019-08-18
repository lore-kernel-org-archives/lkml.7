Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6297EC3A59E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380E821773
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566119394;
	bh=zJeFs7U/OKJWGGAMgwGEyd/YRXXtatS0kuwxKva2EtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qoCZ9kl3B4d6v67qYGRJFQU9yUEP41eHaX6J+/M+nKYaEhwlb2AHvRIQrHetP4HBk
	 grTBqqr98WCYSYMseOrnxTh9zAvXkeHMffRbAkOH75yNRBBL8x9oFzDeZNKUubnmEc
	 PNOIu4ei/GP616Pl/mB1vpEgNBs/5KWUI3OrafVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfHRJJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 05:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfHRJJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:09:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F3792173B;
        Sun, 18 Aug 2019 09:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566119392;
        bh=zJeFs7U/OKJWGGAMgwGEyd/YRXXtatS0kuwxKva2EtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0UZqnSyoKKQI2GubQ7wUWVIzzCcywbZk0Vo5WOBVxQoz0OxWGEiiXXyd2WEKHQbN8
         +nUz3Fi4lJqCIQKluFrSEk+kOlmFp23ugbEb7oiWGNF8pk3mmYPGEdXDrRd6Z4NSDn
         /sYRTOi+IAPVeIgSOSpwJEki9pCCk8/4CidsmOIE=
Date:   Sun, 18 Aug 2019 11:09:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Gao Xiang <hsiangkao@aol.com>, Jan Kara <jack@suse.cz>,
        Chao Yu <yuchao0@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
        devel <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Darrick <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>, tytso <tytso@mit.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Pavel Machek <pavel@denx.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] erofs: move erofs out of staging
Message-ID: <20190818090949.GA30276@kroah.com>
References: <20190817082313.21040-1-hsiangkao@aol.com>
 <1746679415.68815.1566076790942.JavaMail.zimbra@nod.at>
 <20190817220706.GA11443@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1163995781.68824.1566084358245.JavaMail.zimbra@nod.at>
 <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1405781266.69008.1566116210649.JavaMail.zimbra@nod.at>
 <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 11:03:53AM +0200, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > I agree with you, but what can we do now is trying our best to fuzz
> > all the fields.
> > 
> > So, what is your opinion about EROFS?
> 
> All I'm saying is that you should not blindly trust the disk.
> 
> Another thing that raises my attention is in superblock_read():
>         memcpy(sbi->volume_name, layout->volume_name,
>                sizeof(layout->volume_name));
> 
> Where do you check whether ->volume_name has a NUL terminator?
> Currently this field has no user, maybe will add a check upon usage.
> But this kind of things makes me wonder.

You have looked at reiserfs lately, right?  :)

Not to say that erofs shouldn't be worked on to fix these kinds of
issues, just that it's not an unheard of thing to trust the disk image.
Especially for the normal usage model of erofs, where the whole disk
image is verfied before it is allowed to be mounted as part of the boot
process.

thanks,

greg k-h

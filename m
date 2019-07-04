Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E200C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A1E21882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2p98X98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfGDKCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 06:02:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35902 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfGDKCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 06:02:22 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so2842681plt.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 03:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AHAOh7FBxYQUboNiiix/lSgcCWAvw4RHDpwodpRKdNs=;
        b=Q2p98X98irjXvs/iO/RhgVHs6Fge85Y5iF373sUnY3qNCrHybAjkpOg2173g30ukn9
         HceW3sPP1hcjiOirEYf1+2mbxehzwjbOdybYng+r5jcyFlXNsHvgeNL89Q3S+MFrxv12
         Rg/JCjywQszl4f7Mb90cJMn6Y5sCGTNGVuW0A1qsFWjYht58BcSwfcWaKbWKdYpJhTK+
         2OL5lza0T8EGCgP+/sjaYM9zJ6O96cbpqVgRV/sFu5KLA9MJEl767XFzWRKGIARGVIGN
         YVM8rxsGOi8DS9TO2jE10VLDKy3iWLNFkeOLvvZKL7EKKDLLU4bDYr0Aklq71Uabo+FM
         V/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AHAOh7FBxYQUboNiiix/lSgcCWAvw4RHDpwodpRKdNs=;
        b=Ewi5CYe9KAEpMdzYU3bicnKh8BCh4rEYhHFWM/Hy2NFUedxua3U1KvJpvd5wfxIXbh
         rKL1LQvB6X249CLW/gy/oA/qtpiGjVxHlYSvqSpEIZ9kue0EjG4RqGgDhjfBCpBOYTFj
         WP/9Sjwiehh3lPCklVmLsIPRFkmQ39QFifgJwfPdF6M99U/2Xa4GuqWa9xCn1QW81vS4
         rOL/hQVEjuWvfOZAldVwPkO99wcHZJ6yr/F5Vyz4zWD0H6DeMkjRUZPQHsLhH4WxRvtq
         DdWaigv01uL/bzTxEvoU/0AN5oR5bJqr2islg6yWZHxHLZ1U0PFxJN0j2ORinxFRsO7Z
         CK/g==
X-Gm-Message-State: APjAAAXIAeT9X4bfqnAzROibT67HQXelSHteYIYj6ymmJvW4GoEfQS5y
        oPDqnLZic99Y6DqeW3xC71M=
X-Google-Smtp-Source: APXvYqyUpSz5kViPDgxvt9wrV2Cyk1yHzTLql9qU6i3mRjiEnK1Vbw4O//g0ryQX4vvxf+WtJC1zCQ==
X-Received: by 2002:a17:902:2aa8:: with SMTP id j37mr46217419plb.316.1562234541812;
        Thu, 04 Jul 2019 03:02:21 -0700 (PDT)
Received: from localhost ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id w187sm5189791pfb.4.2019.07.04.03.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jul 2019 03:02:21 -0700 (PDT)
Date:   Thu, 4 Jul 2019 18:02:07 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, yuchao0@huawei.com,
        linux-kernel@vger.kernel.org, huyue2@yulong.com,
        linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH RESEND v3] staging: erofs: remove unsupported ->datamode
 check in fill_inline_data()
Message-ID: <20190704180207.0000374e.zbestahu@gmail.com>
In-Reply-To: <20190704052649.GA7454@kroah.com>
References: <20190702025601.7976-1-zbestahu@gmail.com>
        <20190703162038.GA31307@kroah.com>
        <20190704095903.0000565e.zbestahu@gmail.com>
        <20190704052649.GA7454@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019 07:26:49 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Jul 04, 2019 at 09:59:03AM +0800, Yue Hu wrote:
> > On Wed, 3 Jul 2019 18:20:38 +0200
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> >   
> > > On Tue, Jul 02, 2019 at 10:56:01AM +0800, Yue Hu wrote:  
> > > > From: Yue Hu <huyue2@yulong.com>
> > > > 
> > > > Already check if ->datamode is supported in read_inode(), no need to check
> > > > again in the next fill_inline_data() only called by fill_inode().
> > > > 
> > > > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > > > Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> > > > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > > > ---
> > > > no change
> > > > 
> > > >  drivers/staging/erofs/inode.c | 2 --
> > > >  1 file changed, 2 deletions(-)    
> > > 
> > > This is already in my tree, right?  
> > 
> > Seems not, i have received notes about other 2 patches below mergerd:
> > 
> > ```note1
> > This is a note to let you know that I've just added the patch titled
> > 
> >     staging: erofs: don't check special inode layout
> > 
> > to my staging git tree which can be found at
> >     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> > in the staging-next branch.
> > ```
> > 
> > ```note2
> > This is a note to let you know that I've just added the patch titled
> > 
> >     staging: erofs: return the error value if fill_inline_data() fails
> > 
> > to my staging git tree which can be found at
> >     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> > in the staging-next branch.
> > ```
> > 
> > No this patch in below link checked:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/log/drivers/staging/erofs?h=staging-testing  
> 
> Then if it is not present, it needs to be rebased as it does not apply.
> 
> Please do so and resend it.

Hm, no need to resend since it's included in another patch below.

ec8c244 staging: erofs: add compacted ondisk compression indexes.

Thanks.

> 
> thanks,
> 
> greg k-h


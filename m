Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D6CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC81820700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgAiW3Fn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfDCGjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:39:14 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34799 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfDCGjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:39:14 -0400
Received: by mail-yb1-f195.google.com with SMTP id c2so5886997ybn.1;
        Tue, 02 Apr 2019 23:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Q886u9zHF5Jw+jgMMiuvSY4uKHl4OXyt8PRU+wkSVo=;
        b=YgAiW3Fnf7WVOTgwAm4GHO/Vu5I1YtzVyVXorsP3C1Eoy4RfqBj7LYm2f/ttXC+UBK
         gLcTbgREGEq3M0vsjlJVUiF/95PDXlQxe99sPxe7jdkrejzgEHzGxQX8psgjCsDa2ZDO
         XTi89f5thrzSN3c2XOCGonh0YewCRVAJ3W9xUxVdcKEUeLTmSyRQAI7X/usSK4c1CQNr
         M8c6sT0J4K05EjFmB764slnq5jyl83fifa2iSkvtFCctGYMXwAHRBrhn+DFw5WJB+i66
         4lhNiDbtaW3j4QBc/M2bTVVvNszhWvss4rUovMSVJUGoVYBJcIZDjXxBABvpvZd/DTRf
         TF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Q886u9zHF5Jw+jgMMiuvSY4uKHl4OXyt8PRU+wkSVo=;
        b=NE72y9kGNuTlhd+g8kGaHzBT6a5carAIPU6fXTlJKev8kCvffe1zp9XJR8VmGg56ad
         ENj8+tn/8yVyeOYRcxvKcwSKR0a6DGWTUmAwygdwYMYdj/I4AAynLmyOIpgbfieZtQl1
         fSzuw1qxaHe1u7aRww4dtxuSIsawA7GNpiYovvJWk0D7NZVBcEXYR8SnKMiADHTdI2ZL
         jhapj6HgCqHLX5IIE7JOPUYLaYBg6oDK/3UA8k5Ffo21hUQDSSK/gkgG7EVS3SSXM4wC
         TLaLfXHcgcgnSIHllEQgNkc/CSYnLr30paEHMaWxFt7fRCC9DrFT61MFK460lkRzP37b
         6d3A==
X-Gm-Message-State: APjAAAVEuHAz37251mCNl3ILdYTWjQ9VDYumlEwR5/EfHNcemMtoorVB
        Nv2wiCKNLRQFUJguElGDr5APjg5kgGQq4iAIwK0=
X-Google-Smtp-Source: APXvYqy9LZ856fOHavp9aGf+c8OsTdDYHRIKbogr342ZfEj/6+JLyGkQRlYNH92z5ImHD1G3E2JHyDNV2ag/vhVONHs=
X-Received: by 2002:a25:e601:: with SMTP id d1mr18770250ybh.265.1554273553677;
 Tue, 02 Apr 2019 23:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190403145609.6eda97b6@canb.auug.org.au> <b5e42db8-a873-5667-f179-78cadf5b2bf5@linaro.org>
In-Reply-To: <b5e42db8-a873-5667-f179-78cadf5b2bf5@linaro.org>
From:   Bo YU <tsu.yubo@gmail.com>
Date:   Wed, 3 Apr 2019 14:39:02 +0800
Message-ID: <CAKq8=3JWvzCo04cmVKAQ-Wpa0nS8ShOw2e7HP_fpBz6HZg+Drw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 char-misc.current tree
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 1:07 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 03/04/2019 04:56, Stephen Rothwell wrote:
> > Hi all,
> >
> > Today's linux-next merge of the char-misc tree got a conflict in:
> >
> >    drivers/misc/fastrpc.c
> >
> > between commit:
> >
> >    01b76c32e3f3 ("misc: fastrpc: add checked value for dma_set_mask")
> >
> > from the char-misc.current tree and commit:
> >
> >    977e6c8d1d18 ("misc: fastrpc: use correct spinlock variant")
> >
> > from the char-misc tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> Greg did request Bo YU to rebase this patch on top of char-misc tree.
 Yes.The patch was v2 after rebasing char-misc tree.
>
> That would be a real fix for this conflict, until then this fixup should
> work.
Is there any modifies need me?
Anyway thank everyone!
>
> --srini
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >

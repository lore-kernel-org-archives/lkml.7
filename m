Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A6AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F189F207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568925252;
	bh=fxEOZ+wxqFHb5KjsGQbhIwearrNAHYDUmV3yixALdCc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sB2sFhqfp31CFXvkNKBhMvBqtg5A9qvUcwWTyLuxk3uMDiEkz/faprp7zrUjKwcBd
	 0YNyUqeLElbNDC0aaUrurGyR0SLgI/tDrc4SEwWoI6o9KqKtW7nGe8pdtFGei9wklr
	 WnwN9quP/18EFkqQlYaepUAK416O0R/KQgOGK/s8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404664AbfISUeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 16:34:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38446 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404583AbfISUeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 16:34:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so4935631ljn.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 13:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6grpKTdDHfrbCxCmgX04tALzM2BaTcUONJxBFtS7/lc=;
        b=S3FWlmtalm02jQyJlhwBVUyRbo4LVnG04lBW17Zh/rM24U46hU9edZ8kfmA06+aF9P
         OCDHQuGS85M+r15ZS8w8p2AuuOaxpYBIEy7/K399Ohz2kO+HjNMiBSjs53Jhs8Tayd30
         RhVK3wUpwCIOZyzj1b4OwhDrWT6ry27EnqdWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6grpKTdDHfrbCxCmgX04tALzM2BaTcUONJxBFtS7/lc=;
        b=kqjPg3vsmjPbfOxceIFzeSysDCgucHQRJ+C6XiHnushqopJ4VLwwnViQdRppaRoUZU
         u85G3U+EBYUTVHxtA5teIcTAAKD7rHYIgEryOM11IJ2cqL5Qd/HqOyuRS7Dx51tcrlEp
         Wq0uLdJ2L+uZDeMggAnqQ/WNfpg+5Lmf3zYrHW0Kxw2IiX4gRvo6IMy9EzGVwah2O6MY
         XtHlrq7jfrj1QQeyIZ17NO9sYWYJhBSDRHl05IRMB+hN+ldwD4Yc29fj2b+kEP7aCucd
         bYdjDEbc3TNTGUBmyqQPmtKSA1w6rj3Q9VYZ4ghJCM+eocSa8qNtnZW+WD++T5U8Szd2
         UT/Q==
X-Gm-Message-State: APjAAAWrPaFzCB39UtkIOBvZvN5vPHEb8NnTuDFnGNCqWNjRYlUBbCiQ
        5csW1EPfeC9c3gM34gwW0xMz4jZHhUA=
X-Google-Smtp-Source: APXvYqxlNT5hkhQz5IWBw/Ug5nHd7pn91BZh82VPZTHPwB03ejP9mfXXHB/jkhW40kgUAOla7qyZyA==
X-Received: by 2002:a2e:2bda:: with SMTP id r87mr6338482ljr.3.1568925248488;
        Thu, 19 Sep 2019 13:34:08 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id c16sm1791053lfj.8.2019.09.19.13.34.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 13:34:07 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id d17so3350393lfa.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 13:34:07 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr6102537lfp.61.1568925247160;
 Thu, 19 Sep 2019 13:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190918152748.GA21241@infradead.org>
In-Reply-To: <20190918152748.GA21241@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Sep 2019 13:33:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXF63BKNJH=GtnnoJmXZHEnRwjgeu4foJQvFYYBm9HHA@mail.gmail.com>
Message-ID: <CAHk-=wjXF63BKNJH=GtnnoJmXZHEnRwjgeu4foJQvFYYBm9HHA@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping updates for 5.4
To:     Christoph Hellwig <hch@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>
Cc:     linux-mmc@vger.kernel.org,
        iommu <iommu@lists.linux-foundation.org>,
        xen-devel@lists.xenproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 8:27 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> please pull the dma-mapping updates for 5.4.

Pulled.

> In addition to the usual Kconfig conflics where you just want to keep
> both edits there are a few more interesting merge issues this time:
>
>  - most importanly powerpc and microblaze add new callers of
>    dma_atomic_pool_init, while this tree marks the function static
>    and calls it from a common postcore_initcall().  The trivial
>    functions added in powerpc and microblaze adding the calls
>    need to be removed for the code to compile.  This will not show up
>    as a merge conflict and needs to be dealt with manually!

So I haven't gotten the powerpc or microblaze pull requests yet, so
I'm not able to fix that part up yet.

Intead, I'm cc'ing Michael Ellerman and Michal Simek to ask them to
remind me when they _do_ send those pull requests, since otherwise I
may well forget and miss it. Without an actual data conflict, and
since this won't show up in my build tests either, it would be very
easy for me to forget.

Micha[e]l, can you both please make sure to remind me?

             Linus

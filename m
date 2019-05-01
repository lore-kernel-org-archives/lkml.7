Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989D9C04AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60652208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9cRJ1QZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfEARAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 13:00:23 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:39945 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfEARAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 13:00:23 -0400
Received: by mail-vs1-f51.google.com with SMTP id e207so5911824vsd.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fKeHm+YnMFQhnE5COYYd2wTHTYE5yGwHo3lDdnebjM4=;
        b=c9cRJ1QZQtCO0/mYbd0/5i4CUar4BNukWTS+G7jpwqDiNzZNV1I2edB+dOMbqXzfQN
         mhW68V4DfHLuHMdUGgFuw3BtCW6wAMRLTGARVl9g24jKKOObBPLzumTeE6Ku3J/zC/Rs
         3kKoRtXLz+OH40U9zaDIKNjnYtAm3sAsF9MfgJr3YB/1AReKlm/skRORZDQ9HVlkxL+f
         zJz1f4+jYMAYy/PU6bHdIuWRtCw1kB8ks9BemTUwcrrGzu34XCiyKAqYhPCuMUja77PS
         L1YKR17HUUy1neMNs0cNdR37rpUDpDaPudaVB9kgFJZXXZ1cWQBxdLvqV5CVr3BdlKhF
         liLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKeHm+YnMFQhnE5COYYd2wTHTYE5yGwHo3lDdnebjM4=;
        b=We//gpZVhsnVZvi0SlCv14VdmM57FbB9G21Drp7lejMVTd+51VYY39IvvLJPHUfTS0
         PQNkL53NQSW1hBSpeMceSSWC75nnObD0Xw9kyw5xqV3kb3Dr8RA7EM4rc44CFxYJn1+C
         VfBpdcujxvOEDrJy362RYmDeEF2nf3esOwuKAT7MOQycKGiVHdygxuUnP11o6Sg9WpJc
         yOWxa3+OpD0rMmHWWjiv82RqO25XUKU+QI9rtvDcNn0R3WhvChMkieNhlgmKIxtTIgDP
         h+NbVp9jhEGnEM3GeQoYHui8JLsBZnNsFIXIUsHIxjo+StwCmV7orJT2XWpRqJxc7Yyl
         aAfA==
X-Gm-Message-State: APjAAAVwCVbUcqN7Mn6zv8y/7WyR7POCmcIW36pFPAcHNAQ8Gb4fdjNT
        iun6jX+j1p82aht6bDjud8B2A4na86d+P53xNc+ydg==
X-Google-Smtp-Source: APXvYqyUqlL9jpVL90DkvvlHC4IlULAcsEjfbXtupVrOhb+mGnoHYGwhZSQ0zSjaCUnEraTNpHXEENzrDsXLSmJMKA0=
X-Received: by 2002:a67:7444:: with SMTP id p65mr38135332vsc.104.1556730021507;
 Wed, 01 May 2019 10:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190501160636.30841-1-hch@lst.de>
In-Reply-To: <20190501160636.30841-1-hch@lst.de>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 1 May 2019 10:00:10 -0700
Message-ID: <CABCJKudfkFB4QGp4J6E5r2Td+Wqw0dTYfMZkxVh9DgR7N=JwyA@mail.gmail.com>
Subject: Re: fix filler_t callback type mismatches
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 9:07 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Casting mapping->a_ops->readpage to filler_t causes an indirect call
> type mismatch with Control-Flow Integrity checking. This change fixes
> the mismatch in read_cache_page_gfp and read_mapping_page by adding
> using a NULL filler argument as an indication to call ->readpage
> directly, and by passing the right parameter callbacks in nfs and jffs2.
>

Thanks, Christoph! This looks much cleaner.

I tested the patches on a kernel compiled with clang's -fsanitize=cfi
and the fixes look good to me. However, you missed one more type
mismatch in v9fs_vfs_readpages (fs/9p/vfs_addr.c). Could you please
add that one to the series too?

Sami

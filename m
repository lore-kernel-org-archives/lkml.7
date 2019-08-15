Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C93C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97922206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565885621;
	bh=+uEmJo/K1S3t/sO1LBEt4JZWxFC3fADysWvtxqUG5XA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fjYG5Jt4b2dGSz5IsRwsOab3ykuOfZFO43vgaLMEIgcV7qOM1K7hY7vSo22Sg/dVz
	 w66BYNX8e/cIwHpvytyJmvbq1dyJzW1iKnq1rXpf0g/iUzBtuAH11SZ8lGNcit15Sn
	 19dpg8QWnXbIApKDf8DnAGddl2b7JQC9Tb3Mzzw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbfHOQNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:13:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42448 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbfHOQNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:13:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id l14so2690235ljj.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FuOQKA7vgPA06is52x9xKpXiDGgbCZoxJgLKNkyGfUs=;
        b=GiMGu61r0de7kE+jxFqk2ISTMZec3MCIu0HBqAiSXGeSP8AeU/RC1ZhX/syTNiFag1
         vef2zaQMkRgI5yQRnEcUQA2HqnQz4O2DAMgPqxYorQxLdg6N07Qt35SI/EEKkX7h+ocx
         AGxQCZHY70aVP3rFrb29kL6nHWXMwFLTwSK+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FuOQKA7vgPA06is52x9xKpXiDGgbCZoxJgLKNkyGfUs=;
        b=lPPZY90SjzMj+mAyPwzLGV5MXZafJRuMAS8fzcBylezvPzkb1r0Vpxpy1nU2R7axyf
         R5721WmtAZRjbTYw1J8bge5ZPh1f2bwKG2tmSApACUR92cMAsXgwDMgNKMgJ8mup9+EM
         LIQ/FBKQA9vbk34FPdEXkU4+I1f81/5xwvFYnz6gd/TEpWGiRQI8/ksD5i7YM/dFgx5V
         8Lw4FNXJT/JNlQL5ZDnYrajYlLalq9A34MKqu+Z4wHQ9RiOMzxGmWqPaznGNbzPzWvEO
         uB+MT/OMIl2RDerRH7goEX1VsZKPUrhak+toTxEGa8d/WDt/97PTRHpVU0zHceLQ+7U2
         TKYg==
X-Gm-Message-State: APjAAAVBv8YrrsSOQg0oDWydHVlGp0wfi35bE+dI0whOXi29mc40+j9m
        9l/MEvbZEzAUVYyCYGsRpUE+Hf6nTFs=
X-Google-Smtp-Source: APXvYqxs+6VjJwpzPDOHwLAawmU0Cph8wP3PiVW2ER2B0jmksyLw6IOYBh2npVQD00lmpM39uFX2rg==
X-Received: by 2002:a2e:8ed5:: with SMTP id e21mr3123242ljl.156.1565885617130;
        Thu, 15 Aug 2019 09:13:37 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id d21sm513224lfc.73.2019.08.15.09.13.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 09:13:36 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id m24so2693298ljg.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:13:35 -0700 (PDT)
X-Received: by 2002:a2e:7018:: with SMTP id l24mr3046966ljc.165.1565885615360;
 Thu, 15 Aug 2019 09:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190815044155.88483-1-gaoxiang25@huawei.com> <20190815044155.88483-8-gaoxiang25@huawei.com>
In-Reply-To: <20190815044155.88483-8-gaoxiang25@huawei.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Aug 2019 09:13:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUs+b=iVKM3mVooXgVk7cmmC67KTmnAuL0cd_cMMVAKw@mail.gmail.com>
Message-ID: <CAHk-=wiUs+b=iVKM3mVooXgVk7cmmC67KTmnAuL0cd_cMMVAKw@mail.gmail.com>
Subject: Re: [PATCH v8 07/24] erofs: add directory operations
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Theodore Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Richard Weinberger <richard@nod.at>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 9:42 PM Gao Xiang <gaoxiang25@huawei.com> wrote:
>
> +
> +static const unsigned char erofs_filetype_table[EROFS_FT_MAX] = {
> +       [EROFS_FT_UNKNOWN]      = DT_UNKNOWN,
> +       [EROFS_FT_REG_FILE]     = DT_REG,
> +       [EROFS_FT_DIR]          = DT_DIR,
> +       [EROFS_FT_CHRDEV]       = DT_CHR,
> +       [EROFS_FT_BLKDEV]       = DT_BLK,
> +       [EROFS_FT_FIFO]         = DT_FIFO,
> +       [EROFS_FT_SOCK]         = DT_SOCK,
> +       [EROFS_FT_SYMLINK]      = DT_LNK,
> +};

Hmm.

The EROFS_FT_XYZ values seem to match the normal FT_XYZ values, and
we've lately tried to just have filesystems use the standard ones
instead of having a (pointless) duplicate conversion between the two.

And then you can use the common "fs_ftype_to_dtype()" to convert from
FT_XYZ to DT_XYZ.

Maybe I'm missing something, and the EROFS_FT_x list actually differs
from the normal FT_x list some way, but it would be good to not
introduce another case of this in normal filesystems, just as we've
been getting rid of them.

See for example commit e10892189428 ("ext2: use common file type conversion").

               Linus

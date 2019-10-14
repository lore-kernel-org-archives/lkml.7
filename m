Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EC0C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C90A21721
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ROJPairY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbfJNNko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:40:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40924 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfJNNkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:40:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so19825883wrv.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 06:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yz8motMdO8hwswIG17yGoW+Rc2pHrBN1ncSLiZFe/nk=;
        b=ROJPairYywrNQCO5Qzmg/pPIHjvDbDqoWhVWqwXLbqk8IowzzIIP9GYi0BAFpPRevb
         k/01s9xjWqpDKjNYUOP6CRJk0TF3cEVHdRdZQBD4CGmm7a4bTLuJHNXI5IaNdctNCkLo
         7XiIHLnAMEw89sNiHst8Rvdn3AvKUz+tjjGbveN550otzTyJGA/xTvC8tgYc8aO9My9C
         HKxIT+61L7tFNnWqpPKd1KcwELAb+wUFViRYXn01iRj4ZX1KkR2J1hekyaVuj0AhWmIo
         JcY4RKRsStoU6iDFGV8XJxFlFE7yl3ioK9ZIbjHOH1d1TK7xYF5tacr9SexgHvDWuoHj
         /iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yz8motMdO8hwswIG17yGoW+Rc2pHrBN1ncSLiZFe/nk=;
        b=QkK+Is4dfywUTajPpKwbdV3ABZ9XFmkjoXGY2gqq5znebD5J2kNeBXtwNQ1jCIzbp9
         JDCwMBk4w9NufcOuR7Wdj+gLKNEDQwOUSizh6Y6M/cI5dJAh/aewgGBr1QqPjUESz4tZ
         /FIcCWPbDuHr9WmKVRJeAQKlShAczFVcg3z5yyFy1TdRYSmWdavCPv9VJ8FrGF1mU7VM
         D2GIHSQdFeklFVWZrMfOiB5cZ5OeNZD7J7jDfHpAvqsq3KS6BDd/IZXsp/hpgQ84K6+t
         1vXGIljo9CkvILZ7H4bEdN+aBmo0FdX7bksQNeQhKmEoALg05GpC0ZTSV5Q4sA+gTmB/
         B20w==
X-Gm-Message-State: APjAAAUrupL7BGc9J72H3fF9m8+gdFNL/HM7IdBH5oMKU478rtmcgeS/
        zS7omRJQAfVhS3pTofXkEcDu9A==
X-Google-Smtp-Source: APXvYqyA/IWGs8D+OAWAwKCoR06m/6tAcFRfHfuFBIta3rDtuUPfXkKA+NdzmflX1L6cTGyFVArZDQ==
X-Received: by 2002:a05:6000:1202:: with SMTP id e2mr11991170wrx.162.1571060441442;
        Mon, 14 Oct 2019 06:40:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7687:11a4:4657:121d])
        by smtp.gmail.com with ESMTPSA id a2sm30978110wrt.45.2019.10.14.06.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 06:40:40 -0700 (PDT)
Date:   Mon, 14 Oct 2019 14:40:37 +0100
From:   Quentin Perret <qperret@google.com>
To:     Dmitry Goldin <dgoldin@protonmail.ch>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel\\\\\\\\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joel\\\\\\\\@joelfernandes.org" <joel@joelfernandes.org>,
        Ben Hutchings <ben@decadent.org.uk>, adelva@google.com,
        natechancellor@gmail.com, maennich@google.com
Subject: Re: [PATCH] kheaders: substituting --sort in archive creation
Message-ID: <20191014134037.GA79684@google.com>
References: <oZ31wh8h96sDGJ_uQWJbvFDzh4-ByMMeoyOhTLmfdf5B5T0KWgLhhNbC49J6EM_Nlgo_zH-bUScrWxYTgP9eNNMF1D5AbpcbIHbBuzbS_44=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oZ31wh8h96sDGJ_uQWJbvFDzh4-ByMMeoyOhTLmfdf5B5T0KWgLhhNbC49J6EM_Nlgo_zH-bUScrWxYTgP9eNNMF1D5AbpcbIHbBuzbS_44=@protonmail.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Wednesday 09 Oct 2019 at 13:42:14 (+0000), Dmitry Goldin wrote:
> From: Dmitry Goldin <dgoldin+lkml@protonmail.ch>
> 
> The option --sort=ORDER was only introduced in tar 1.28 (2014), which
> is rather new and might not be available in some setups.
> 
> This patch tries to replicate the previous behaviour as closely as possible
> to fix the kheaders build for older environments. It does not produce identical
> archives compared to the previous version due to minor sorting
> differences but produces reproducible results itself in my tests.
> 
> Signed-off-by: Dmitry Goldin <dgoldin+lkml@protonmail.ch>
> ---
>  kernel/gen_kheaders.sh | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
> index aff79e461fc9..5a0fc0b0403a 100755
> --- a/kernel/gen_kheaders.sh
> +++ b/kernel/gen_kheaders.sh
> @@ -71,10 +71,13 @@ done | cpio --quiet -pd $cpio_dir >/dev/null 2>&1
>  find $cpio_dir -type f -print0 |
>  	xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).)*?\*\///smg;'
> 
> -# Create archive and try to normalize metadata for reproducibility
> -tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
> -    --owner=0 --group=0 --sort=name --numeric-owner \
> -    -Jcf $tarfile -C $cpio_dir/ . > /dev/null
> +# Create archive and try to normalize metadata for reproducibility.
> +# For compatibility with older versions of tar, files are fed to tar
> +# pre-sorted, as --sort=name might not be available.
> +find $cpio_dir -printf "./%P\n" | LC_ALL=C sort | \
> +    tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
> +    --owner=0 --group=0 --numeric-owner --no-recursion \
> +    -Jcf $tarfile -C $cpio_dir/ -T - > /dev/null
> 
>  echo "$src_files_md5" >  kernel/kheaders.md5
>  echo "$obj_files_md5" >> kernel/kheaders.md5
> --
> 2.23.0

FWIW:

  Tested-by: Quentin Perret <qperret@google.com>

It turns out this issue broke something in our CI, could this patch be
queued as a -rc4 fix ?

Thanks,
Quentin

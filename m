Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DA9C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21ABA207FF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ZpWRnF1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbfJCOIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 10:08:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37061 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfJCOIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:08:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id p1so86370pgi.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 07:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bQzJN683dZCArQWtEWKjhWHu+59KWgkuyOh2HrgIXCM=;
        b=ZpWRnF1H8pzxnrmf8sV21CSx+5MEPuj1PYmZ+DcgPvTvtKCdbxcXtMHaGz5YEFeTwV
         BhkhubM7Zv8Q/F/QvFvL/sv7Is6kR5r1SOBBcqI1MPzgXIGTv9X7srMbKe0EKszjIxe3
         oUXKxyRHdlvKDI/d3ZIIAf/7IkaicqdGfS4Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bQzJN683dZCArQWtEWKjhWHu+59KWgkuyOh2HrgIXCM=;
        b=Wnopup21DuEN/TE4BO56qifiqIgAjRBXHJt47QY4zJnPsMuyxyIrHutOnllnoNwhNH
         DUQN80+3mdxFgNkh6ZoiDV/wNwNYzTlQegGNhjlVgVfvhwhyJGZEXPERUiTHao11/L6g
         Qn5kRBhyfp8yNCUQTXm6BJ3Xg6EnktodLNoFsWq+EY6oAbflhw0mS7qELn2dw0rxReBy
         37Ce8gGkpDRXzXaBofGjlzTVeL82lJY/ZSsDkKNqo6Tw6uKnp8m7pgzXBEO0CHCHoDjn
         +SjLu4pWn+TUzqucDDGjnvRGfX9nGa1RGV7kU/9D4q5rE13pXpF9JEUqPD0ZyI5w1f+Q
         YiZA==
X-Gm-Message-State: APjAAAW6tPoP4z/6NNTRhCcajv7rgxZyU43FWwDmnkcCjx8TqasThGU/
        ECLdrz7ZkjI7TbUMPwK/2fJ+4A==
X-Google-Smtp-Source: APXvYqwZlMEDDnWjMEILzt21dSbDCzG/aIujQn+8DWLmWjAryvq7teYdDHPo8unKvjlnzW3NZwg1yg==
X-Received: by 2002:a65:534a:: with SMTP id w10mr9704936pgr.375.1570111717048;
        Thu, 03 Oct 2019 07:08:37 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j24sm3361392pff.71.2019.10.03.07.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 07:08:36 -0700 (PDT)
Date:   Thu, 3 Oct 2019 10:08:35 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Dmitry Goldin <dgoldin@protonmail.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] kheaders: making headers archive reproducible
Message-ID: <20191003140835.GG254942@google.com>
References: <IQMyD-PDXUKT0AUM6nMO2xzV3oJqgdois_F-LtaUnpMXywiuwxH1pPZL_SAv4eYu-PwyhoTxPHqXQ295i2DsjMwUyQqm6ARydcgqySKoqlo=@protonmail.ch>
 <CAK7LNAS1-HnsGTD1=sUm0L-gFjf3+q0qpuRQb1wREmzTs4UuVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAS1-HnsGTD1=sUm0L-gFjf3+q0qpuRQb1wREmzTs4UuVw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 10:50:06AM +0900, Masahiro Yamada wrote:
> Hi Dmitry,
> 
> 
> (+CC Ben Hutchings, who might be interested)
> 
> 
> On Sun, Sep 22, 2019 at 10:38 PM Dmitry Goldin <dgoldin@protonmail.ch> wrote:
> >
> > From: Dmitry Goldin <dgoldin+lkml@protonmail.ch>
> >
> > In commit 43d8ce9d65a5 ("Provide in-kernel headers to make
> > extending kernel easier") a new mechanism was introduced, for kernels
> > >=5.2, which embeds the kernel headers in the kernel image or a module
> > and exposed them in procfs for use by userland tools.
> >
> > The archive containing the header files has nondeterminism through the
> > header files metadata. This patch normalizes the metadata and utilizes
> > KBUILD_BUILD_TIMESTAMP if provided and otherwise falls back to the
> > default behaviour.
> >
> > In commit f7b101d33046 ("kheaders: Move from proc to sysfs") it was
> > modified to use sysfs and the script for generation of the archive was
> > renamed to what is being patched.
> >
> > Signed-off-by: Dmitry Goldin <dgoldin+lkml@protonmail.ch>
> > ---
> >  kernel/gen_kheaders.sh | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> 
> Thanks, this produced the deterministic archive for me.
> 

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> 
> While you are here, could you also update the following hunk
> in Documentation/kbuild/reproducible-builds.rst
> 
> ---------->8---------------
> The kernel embeds a timestamp in two places:
> 
> * The version string exposed by ``uname()`` and included in
>   ``/proc/version``
> 
> * File timestamps in the embedded initramfs
> ---------->8---------------
> 
> 
> With the documentation updated, I will pick it soon.
> 
> Thank you.
> 
> 
> 
> 
> > diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
> > index 9ff449888d9c..2e154741e3b2 100755
> > --- a/kernel/gen_kheaders.sh
> > +++ b/kernel/gen_kheaders.sh
> > @@ -71,7 +71,10 @@ done | cpio --quiet -pd $cpio_dir >/dev/null 2>&1
> >  find $cpio_dir -type f -print0 |
> >         xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).)*?\*\///smg;'
> >
> > -tar -Jcf $tarfile -C $cpio_dir/ . > /dev/null
> > +# Create archive and try to normalized metadata for reproducibility
> > +tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
> > +    --owner=0 --group=0 --sort=name --numeric-owner \
> > +    -Jcf $tarfile -C $cpio_dir/ . > /dev/null
> >
> >  echo "$src_files_md5" >  kernel/kheaders.md5
> >  echo "$obj_files_md5" >> kernel/kheaders.md5
> > --
> > 2.19.2
> >
> >
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

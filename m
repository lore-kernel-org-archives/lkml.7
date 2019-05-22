Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE677C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBC721473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAeFcgUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbfEVUj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:39:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36792 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfEVUj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:39:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id a8so5682561edx.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 13:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5+9nllOgOqGcyGmrfvDcUmSOWrC8yFHggzrCe9UTYtE=;
        b=bAeFcgUdf/5ML1E/MzzENtD5awT0MWiwgoQceHkJe6ahA/Fh2TvIRjjnOWkk2U9x7U
         jFutO3QG2OzVXpVsN3gfeFQq2EYaRFrvgdb+8L4zNudZ/VZlkhKlu97/IA7kE/Uqlxjr
         kkyuVrQ5PUTdtwGfH8LQs9b25v6q66tFD5jDwAVSGbEJ+ydXeBuHz/RdEdRUCTu0K49b
         5F5e4cXTEz4zXk870+4pyKlTkr/ouldN08tNKlbYssamZRjcIt4uniIkuByd1KJxu/yB
         X/MIDLxXzYirAb9vrQ7Pik/dbmE3Rgjf+LXpBiksEmsCs2sdGfi6d6B23L7siLv9iEv9
         M8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5+9nllOgOqGcyGmrfvDcUmSOWrC8yFHggzrCe9UTYtE=;
        b=DaC3QYgR+EkqKphPY6ex8LU9QWINnBiUD0OzvnBREjGaxFkukrT4Qbfpzt7/MkBnqg
         F42WUXAfmxAjK8Oen35wDxOtwtSlz7Paexq8HNDnM6BrugGUp0sp6Xp/m3vJHaFHR5wI
         9AsWZybQytuiLX6NQnlrpLHvnIRfU8q2v2trm+aA60asMGnK0XrRizXOdkE6hVugV8pc
         v83Ec2i83+FVI10aYZohH60NcJz6xOcE/2DaImQO6YXQKSeT0yrBFiTeO6TfHQM2oJNC
         GifrCwpWUX7LcsGkZxJ6Rgfswn/7g4Fwh2g0e18TXT2g+5u6HfxP2DBcZgztWVHtF7LX
         WaXg==
X-Gm-Message-State: APjAAAXTkmkXiBK66JXhVqV7T7s6bUrDTLJr3gEMtvxPNYSy+74vjLXJ
        at2NU5wQWl4JaHHf/+N+m8g=
X-Google-Smtp-Source: APXvYqwdcYbffM8j3NtaUcd13nLdkMEMPS+kUm87hN0wNkX7ubA9YLhqMepwGFh4egh4KeMKQF+uJQ==
X-Received: by 2002:a17:906:2518:: with SMTP id i24mr61244810ejb.169.1558557566207;
        Wed, 22 May 2019 13:39:26 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id v16sm7360487edm.56.2019.05.22.13.39.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 13:39:25 -0700 (PDT)
Date:   Wed, 22 May 2019 13:39:23 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] staging: rtl8192u: Remove an unnecessary NULL check
Message-ID: <20190522203923.GA95273@archlinux-epyc>
References: <20190521174221.124459-1-natechancellor@gmail.com>
 <20190522070418.GP31203@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522070418.GP31203@kadam>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 10:04:18AM +0300, Dan Carpenter wrote:
> On Tue, May 21, 2019 at 10:42:21AM -0700, Nathan Chancellor wrote:
> > Clang warns:
> > 
> > drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:2663:47: warning:
> > address of array 'param->u.wpa_ie.data' will always evaluate to 'true'
> > [-Wpointer-bool-conversion]
> >             (param->u.wpa_ie.len && !param->u.wpa_ie.data))
> >                                     ~~~~~~~~~~~~~~~~~^~~~
> > 
> > This was exposed by commit deabe03523a7 ("Staging: rtl8192u: ieee80211:
> > Use !x in place of NULL comparisons") because we disable the warning
> > that would have pointed out the comparison against NULL is also false:
> > 
> 
> Heh.  Weird.  Why would people disable one and not the other?
> 
> regards,
> dan carpenter
> 

-Wtautological-compare has a lot of different sub-warnings under it,
one of which is the one shown. -Wno-tautological-compare turns off all
of those other sub-warnings. The reason that was done is there are quite
a few of them:

https://gist.github.com/nathanchance/3336adc6e796b57eadd53b106b96c569

https://clang.llvm.org/docs/DiagnosticsReference.html#wtautological-compare

It is probably worth looking into turning that on, I'm going to try to
do that as I have time.

Cheers,
Nathan

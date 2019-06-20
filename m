Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343F9C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CE32083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSYg5gUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfFTUPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:15:54 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37642 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfFTUPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:15:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id w13so6498058eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JUOkJu07O+IW6MoPhdQt/JKgqUkCkkDq6yx/iX7wBQA=;
        b=FSYg5gUde8DWZ1DWTpWdFjbN4iYG7u1oXTRfGBNADJVVK7LrxSIXQd+pd5SxyynS9N
         Cenl7pvCXijdvmXYC7Rh/KJr0TP8bAxtOfZR3hnKagpp39rV52jD4jElwlZyi2pn7eiK
         AfWbP0Hef/Gk7lEF4TOTa0I2VLZ1ffLa8e16w+BQ5rz1fT6+wgzahe8YI31zNSVleeEk
         9DEuuU5zXmDRtI5HHAr8T7C9y10XwbFu2RIq+6A2cVPZfy41lLpyFxV1oLHzoel+Cldi
         GAGJFBxZouCUeXlj/ROBRDcLqoAcjk0efSkezKM3ogNeuTyiydKQYaVfC01+X8u+0unI
         xFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JUOkJu07O+IW6MoPhdQt/JKgqUkCkkDq6yx/iX7wBQA=;
        b=dQiZvq7H0PTkoWaqpXiNaybJn5HaljDCXuCfyyIqEhdf7Erpous6vaGtWR3WHC1SDk
         2gJWzPAirqRhpHFTZ2YE34c9nhoqt1kBcOQN4nyPnhGge1PmPk13AVRPYnlFuQWVwKaz
         euovv+tA7sUViOP0qn+kD8O1oF1KF84W/OT+udkUjZIry1nu3tkSdxgHBM7kJx9MTt3v
         jk/UsbltoHoWLmoJVaHj7l78g9PoE1A3jVirz6UhM5oz3Hs3GCwHAssTG5GbVQr1Wtke
         0ftSdtKrqiA/34rbbgsJg6//waVeF6ZW7wQjJRT+8V4891BzO7CO8vT8fdc5ztBdXzyo
         X8cA==
X-Gm-Message-State: APjAAAWZbzRDyLnUc1jVZ4zhukU19vS00hgg33IXaqSXoateFgLG7ikm
        shO3cASsI5Gn/OfbjKpQRNk=
X-Google-Smtp-Source: APXvYqz2GpvLDQC36pwSn4cJtgNpRxNa/to4az7JZm/Hz5FpyteYwsXMluOlEW70lP/Jc5u2/h2bLw==
X-Received: by 2002:a17:906:4f8f:: with SMTP id o15mr13238011eju.129.1561061752157;
        Thu, 20 Jun 2019 13:15:52 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id m32sm148321edc.89.2019.06.20.13.15.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 13:15:51 -0700 (PDT)
Date:   Thu, 20 Jun 2019 13:15:49 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] mtd: mtd-abi: Don't use C++ comments
Message-ID: <20190620201549.GA65397@archlinux-epyc>
References: <20190620155505.27036-1-natechancellor@gmail.com>
 <CAKwvOdk7ZTcWEXPTBASPzk1SjOdnONawtQJkR-jU=REFSo1hVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk7ZTcWEXPTBASPzk1SjOdnONawtQJkR-jU=REFSo1hVQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 12:56:58PM -0700, Nick Desaulniers wrote:
> On Thu, Jun 20, 2019 at 8:55 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > When compiled standalone after commit b91976b7c0e3 ("kbuild:
> > compile-test UAPI headers to ensure they are self-contained"),
> > a warning about the C++ comments appears:
> >
> >   In file included from usr/include/mtd/mtd-user.hdrtest.c:1:
> >   In file included from ./usr/include/mtd/mtd-user.h:25:
> >   ./usr/include/mtd/mtd-abi.h:116:28: warning: // comments are not
> >   allowed in this language [-Wcomment]
> >   #define MTD_NANDECC_OFF         0       // Switch off ECC (Not recommended)
> >                                           ^
> >   1 warning generated.
> >
> > Replace them with standard C comments so this warning no longer occurs.
> 
> Should there be a fixes by tag?
> -- 
> Thanks,
> ~Nick Desaulniers

Normally, I would have added one but this issue has been present since
the beginning of git history. According to Thomas Gleixner's pre-git
history tree, it would be:

Fixes: 7df80b4c8964 ("MTD core include and device code cleanup")

but since that hash doesn't exist in the normal git history, I don't
think it is worth adding. Of course, if the maintainers want to add it,
I won't object.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git

Cheers,
NAthan

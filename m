Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B1CC2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FCD21655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs/OOHPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgABELA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:11:00 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36705 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgABELA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:11:00 -0500
Received: by mail-qk1-f196.google.com with SMTP id a203so30963043qkc.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 20:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7c8fSbGvbA1ynlJwMkjbIsnSNe/qBHR0E0TeQPRUlrM=;
        b=hs/OOHPtHgtIxcXZC877ywf2AYQF2P93kpBM7D3Ci1LMCRxiReDY5UxzZihst4PBO2
         c+naKgjhUlBlWReayrHOtU/phhFBuneAbcgMXRY3L3dK1Se5UBTQu/Ia4/IQCf6Q4z+T
         RSHlS88IiOv9wd+Jk6vI3HWg4BI7Xg94JXs20mXNrWaz81PO8dh8NIYjDNKtHIDUPZmT
         cWRwgIDJwtlw5iiSZPl1Qx/IRhCwoL4qUXucP14DqXbdMYZs5Xm8m2vXBPkWlFb/+9jT
         REF5vQMjCns3LJ4tVOEdWxgy3CVbnRCSqTueXtfxv6VkuXE0ef9rnSp4hwW43XgQEUx/
         nF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7c8fSbGvbA1ynlJwMkjbIsnSNe/qBHR0E0TeQPRUlrM=;
        b=dANDVkXHJJprn9mjBQuqIqQAzsVf1nmVHU291yiVKXpdKyUaNZM7IS3kuDGaqpS1Hz
         Qf2jgbQgRfuBZY06E0nqTvglxrWWfT21IC+jvDAEyAOq+/Gp7f5rMjjPE9khLxvcww8d
         ppmnJrDdZvSNeSIGUDYT/CkEWquwOWlCvYm3O1SJnoAgJ1GHcsF8t7ZZm/IlhAk5b4lQ
         Z+EJIxFJN1vtcxbfuVR/sTEZFx/44Hg7qAkWHy6IMNiV2KZrsxQSzDuK0WZAaCqcubwZ
         HZ83SPAL5nPClmH3BmDkwey2+ClNzIpoD7ianW1xSeK8/TO0+DNqxJW9mHPrPNJqucEB
         e2Ow==
X-Gm-Message-State: APjAAAWNygvfIIaNwrxMEP2cJxnszvItSR5MYhTWyUpAWUP3vk9upz4C
        nXkdmTWvGKiuEvkBTv8zk0k=
X-Google-Smtp-Source: APXvYqwlblsZQ+1lLp2lnqIyjMMesESklWLVUyREILEA4mAqomsTrn75Yn9gT+3DP8coDQfW4rNuYA==
X-Received: by 2002:a05:620a:15d8:: with SMTP id o24mr64717363qkm.52.1577938258976;
        Wed, 01 Jan 2020 20:10:58 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q130sm14712214qka.114.2020.01.01.20.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 20:10:58 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 1 Jan 2020 23:10:57 -0500
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     youling 257 <youling257@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] early init: open /dev/console with O_LARGEFILE
Message-ID: <20200102041056.GA535736@rani.riverdale.lan>
References: <20191231150226.GA523748@light.dominikbrodowski.net>
 <20200101003017.GA116793@rani.riverdale.lan>
 <20200101183243.GB183871@rani.riverdale.lan>
 <CAHk-=whzgLPi4szh8xOKysuS9CKaQESngc=n0omBVpwdQ822aw@mail.gmail.com>
 <CAOzgRdYqqYNU8jyXCu88RLstWhQUANUroQDz71fEjfDoEg-VqQ@mail.gmail.com>
 <CAHk-=wj4CBDJ=VvUkQBcYC1XwyG6bDpWXg+iv6NyEE1eV+SKKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj4CBDJ=VvUkQBcYC1XwyG6bDpWXg+iv6NyEE1eV+SKKA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2020 at 08:00:25PM -0800, Linus Torvalds wrote:
> On Wed, Jan 1, 2020 at 7:09 PM youling 257 <youling257@gmail.com> wrote:
> >
> > test this patch.diff, no the system/bin/sh warning, fixed.
> 
> Good to finally have figured out the silly reason this broke.
> 
> I may end up deciding just to revert after all, but even if I do that,
> I'll just feel a lot better about knowing _why_ things broke.
> 
> Thanks a lot for all the testing you did,
> 
>                    Linus

Huh. Feels good to have helped finding the bug, even though I thought it
couldn't *possibly* be the source of the problem.

"There are more things in heaven and earth, Horatio,
Than are dreamt of in your philosophy."

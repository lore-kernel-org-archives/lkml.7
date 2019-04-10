Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D46C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32FD2082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bSr7MxHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbfDJSeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:34:12 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37139 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbfDJSeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:34:12 -0400
Received: by mail-vs1-f66.google.com with SMTP id w13so1970903vsc.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 11:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EWEqtNllEvpYJI4SR8SxraijSXCc4AK8CwC4R1aamEI=;
        b=bSr7MxHCBXn6h0g3WRGDyc2DhbuqqkdN6kW4p22Hos+GjTZLWrFrQlrp7jWHR6ShdZ
         2uemyxpXrWgr4x5PSuKplueV9Xenc396YezASzbUdmimeusHUAsVR9xEc9/Ce4YVvdd/
         +FKf9Ta+3vfdBUTnObARr7b4AQUoa15vGEWKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EWEqtNllEvpYJI4SR8SxraijSXCc4AK8CwC4R1aamEI=;
        b=HDc9HG4VbxKc3QahtJzHDCC7JYnSc1MIRnEn/SBsrQSqVQDs4R8hTE9NjMv4FicmHy
         DgER2mFde3vL13r7IDp5llACWsonQ6tyxlfCrgdkRZiwUig70qXV4k1YJFoME+gz+XJi
         IZggcR8CswVJOh91tjPnFxXvMcLlVhZfQScwMw8y/DbWhmdC1TCrnrVUHBbyVqf6FYNX
         4WXvG793itS8kTzXsn5bnW7NGmSD4pc8XrxugE89MOrx3hbR6y8aiUfPQsfyn42MBe8i
         tVfTbbexuxmHvlD63rPmG0hWBdRzXuutReo0xDdQNWGdsRtwMF+4S+PeDF389fM02W9I
         yMDQ==
X-Gm-Message-State: APjAAAXlnydLECZqcxd57aMHZHFks6yQU7+OFimM6ZCV914dO7+Y7a31
        R0Mdg3RcCdBu8BeqkplMrAWX36dgAMo=
X-Google-Smtp-Source: APXvYqy/u4YVPqHlCLGlvZI2xCK3X55nz3yQEpCWr538N2fK3nVyYmusEYq2UM/OOySZRCQHrH4AEQ==
X-Received: by 2002:a67:8e0a:: with SMTP id q10mr26209780vsd.56.1554921250969;
        Wed, 10 Apr 2019 11:34:10 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id t128sm28393514vka.36.2019.04.10.11.34.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 11:34:10 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id a190so1981749vsd.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 11:34:10 -0700 (PDT)
X-Received: by 2002:a67:7816:: with SMTP id t22mr24096520vsc.115.1554920858548;
 Wed, 10 Apr 2019 11:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190404055128.24330-1-alex@ghiti.fr> <20190404055128.24330-3-alex@ghiti.fr>
 <20190410065908.GC2942@infradead.org> <8d482fd0-b926-6d11-0554-a0f9001d19aa@ghiti.fr>
In-Reply-To: <8d482fd0-b926-6d11-0554-a0f9001d19aa@ghiti.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 11:27:27 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKt8f7=DKrvcPg-NUJGbc-vanMNojfDsEiBt3vP05G4oQ@mail.gmail.com>
Message-ID: <CAGXu5jKt8f7=DKrvcPg-NUJGbc-vanMNojfDsEiBt3vP05G4oQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] arm64, mm: Move generic mmap layout functions to mm
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Paul Burton <paul.burton@mips.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 12:33 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> On 04/10/2019 08:59 AM, Christoph Hellwig wrote:
> > On Thu, Apr 04, 2019 at 01:51:25AM -0400, Alexandre Ghiti wrote:
> >> - fix the case where stack randomization should not be taken into
> >>    account.
> > Hmm.  This sounds a bit vague.  It might be better if something
> > considered a fix is split out to a separate patch with a good
> > description.
>
> Ok, I will move this fix in another patch.

Yeah, I think it'd be best to break this into a few (likely small) patches:
- update the compat case in the arm64 code
- fix the "not randomized" case
- move the code to mm/ (line-for-line identical for easy review)

That'll make it much easier to review (at least for me).

Thanks!

-- 
Kees Cook

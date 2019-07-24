Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5DEC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0D820659
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daangUid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388677AbfGXTcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:32:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44232 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388653AbfGXTca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:32:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so48068790edr.11;
        Wed, 24 Jul 2019 12:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RmmUOfw6KdNJB7Dw3A649BONg+TVcJuxBPKeIVpSw5Y=;
        b=daangUidITkUVKr7vk3OUx08Gl1Jxg57OGBaW32/VfgcDYW4r8ueSaHlvl7prjeAAn
         6hbbOLWpvFqcVTCDWVzqtuonDNxTeBQ+SKsmAZa2QZG5GqbYinzXg9AQ78AarKMfpjje
         3IQG9AXksuIrunc2zx7/mlH6K0s4IGMvmxff7cHuLu5R8mGFv5U79S7o+KLdAHgA95Lr
         uN4yR1koyNq/sBo4AzrOFlpzNT0eZeoXLnzT7iCkJWsONrShxQpzSGGp7Us4+8mQ1sNf
         vIPKBtPZPxJUw3XWCA/roIuHPsq7vBfCJS3fZ69Vvb6pSNJKIcsFkES1O2U9mLRunOvz
         kkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmmUOfw6KdNJB7Dw3A649BONg+TVcJuxBPKeIVpSw5Y=;
        b=B4FhwRlMmV/HpR7cZinVEBhsvjD7k9K/ZAnnBZsHwvc4k1+25q0Tp8go0N/2+Ro9QF
         4NR0BOThx/E1dBHcoKPo8tR8jC4UwCKDUXk2TgVd5RqeIhJOqBMcAzNGwWYkDvWeAayM
         T/AJexE2DddYjmZosyXTCqSzv8aEGbG1l89zbzSUsG0H5+CzOHr5J9cMvpwKNsZKsA/6
         6Fa4gRbyBFWFF2SxkUniErUzCjtO/N6rc7EO4JqpaES8yd0UJ/Qy3Wya9CBMKMCicCzK
         RqtU1C9QVmC94qQiz5xjkA2phmS54hmihEyaDX7YCA6PAXDvdyoo2xbMSI20OZFfA94C
         M4mQ==
X-Gm-Message-State: APjAAAVuS75jfJ6mrzh9hwmBsrRYva0WJctAsuKGboqkmMME3U0eMV6I
        3dPpVvusT3V3B4PnUj6Ia9UdwddUYBGgdhVytFmNeyHlnAw=
X-Google-Smtp-Source: APXvYqzQK3O5v+7yVlFJSGeU4C2I4d4sf8cRDv+2qxowZgzIVi2SvDX7ph8dKH/Lo5xszlodW3vLefHeISTmBsyrRKY=
X-Received: by 2002:a17:906:7f16:: with SMTP id d22mr64449323ejr.17.1563996748713;
 Wed, 24 Jul 2019 12:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190625143715.1689-1-hch@lst.de> <20190625143715.1689-10-hch@lst.de>
 <20190717215956.GA30369@altlinux.org> <20190718.141405.1070121094691581998.davem@davemloft.net>
In-Reply-To: <20190718.141405.1070121094691581998.davem@davemloft.net>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Wed, 24 Jul 2019 22:32:17 +0300
Message-ID: <CADxRZqx-jEnm4U8oe=tJf5apbvcMuw5OYZUN8h4G68sXFvDsmQ@mail.gmail.com>
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
To:     David Miller <davem@davemloft.net>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Christoph Hellwig <hch@lst.de>, khalid.aziz@oracle.com,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 12:14 AM David Miller <davem@davemloft.net> wrote:
> > So this ended up as commit 7b9afb86b6328f10dc2cad9223d7def12d60e505
> > (thanks to Anatoly for bisecting) and introduced a regression:
> > futex.test from the strace test suite now causes an Oops on sparc64
> > in futex syscall.
> >
> > Here is a heavily stripped down reproducer:
>
> Does not reproduce for me on a T4-2 machine.
>
> So this problem might depend on the type of system you are on,
> I suspect it's one of those "pre-Niagara vs. Niagara and later"
> situations because that's the dividing line between two set of
> wildly different TLB and cache management methods.
>
> What kind of machine are you on?

David,

the first test where it was discovered was done on my test LDOM named
ttip, hardware (hypervisor) is T5-2 server, running under Solaris 11.4
OS.
ttip LDOM is debian sparc64 unstable , so with almost all the latest
software (gcc 8.3.0, binutils 2.32.51.20190707-1, debian GLIBC
2.28-10, etc..)

For another test, i also installed LDOM with oracle sparc linux
https://oss.oracle.com/projects/linux-sparc/ , but I've to install a
more fresh version of gcc on it first, since system installed gcc 4.4
is too old for a git kernel (linux-2.6/Documentation/Changes lists gcc
4.6 as a minimal version), so I choose to install gcc-7.4.0 to /opt/
(leaving system installed gcc 4.4 under /usr/bin). Compiled and
installed git kernel version, i.e. last tag 5.3.0-rc1 and ran the
test. Kernel still produced oops.

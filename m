Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77546C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4397E20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfHITRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 15:17:12 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36756 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHITRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 15:17:11 -0400
Received: by mail-qk1-f194.google.com with SMTP id g18so1233707qkl.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 12:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngypOX0p/lDF6ThQM396JuxB1rK3mJwNaBHjmuZzR/M=;
        b=t1NBBkJkbaKrR9qqqTwbwSzVSlivwCz3kn+EzwINCu5jqWGT7Z41t0CLEcJ3E7dEH5
         xxR1kcOIe8bFsJCgd6tT1b4XqYpwiwsbeEf0xS7YKWcxmfPwNUE5/MQh4U3Z3CCyN35h
         FlsuUM/vA6EmclyrZsBIwEDaXqA8lYoOxib0JyloJWvE7w1BJTKB89t0WmEmBoup5r1A
         MS4H0gCvcS3kGgSenaxwmcUR3OOzppSr0fAUgnNk7SxSe3LNj8GTljEUbo1gyiadn16A
         iePhPTYQ7tGbUEg/UNQ7d6opokgmvCNT4rWnLovNMOLD8wB4F7lI/0ZXQiuCKISuJmQ1
         qabg==
X-Gm-Message-State: APjAAAVc9fJ0CCtvKtCSMuAHD62lpuiGYXhBhJMQRfxHKJRxJvg4mjnJ
        4PUq9DKNcjVfIVBVSOfDT6oYbjjDs+pMIsyX3PY=
X-Google-Smtp-Source: APXvYqyS+rCffHQkgotu89qIYFzMBS8JFYn4d9Rz5KFypo6nhDAgNP+7D5JmFL7X12hDwwcbCHxXb5aCPmsjeP/bx0c=
X-Received: by 2002:a37:5f45:: with SMTP id t66mr19800397qkb.286.1565378230710;
 Fri, 09 Aug 2019 12:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <201908090321.bRMBBE6A%lkp@intel.com> <CAK8P3a0FT1FCkvik++TJxnp8=36+9EW-tjo0UXdGPZxw_MMPfQ@mail.gmail.com>
 <20190809155329.vqbquhjhz25khrgx@treble>
In-Reply-To: <20190809155329.vqbquhjhz25khrgx@treble>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 9 Aug 2019 21:16:53 +0200
Message-ID: <CAK8P3a06aYPv_+v+LpJp1ohYXbJNjBU_YjPcAuWOhFeUSwUdLA@mail.gmail.com>
Subject: Re: [arnd-playground:randconfig-5.3-rc2 32/347] fs/reiserfs/prints.o:
 warning: objtool: __reiserfs_error()+0x80: unreachable instruction
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 5:53 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Thu, Aug 08, 2019 at 10:45:34PM +0200, Arnd Bergmann wrote:
> > On Thu, Aug 8, 2019 at 9:06 PM kbuild test robot <lkp@intel.com> wrote:

> > Josh, is this warning above something you are interested in? I don't
> > think it happens in mainline, but it could happen anywhere. I think
> > the patch below can be dropped once clang is fixed, but I have so far
> > been unable to build a new compiler for testing.
>
> From a brief glance I think you need to remove __reiserfs_panic from
> objtool's global_noreturns[] array.

Right, makes sense. Added to my private patch now.

      Arnd

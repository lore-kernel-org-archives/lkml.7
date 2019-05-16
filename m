Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB5CC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 20:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C272070D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 20:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558040382;
	bh=6ar+VWes5x8vVhPkHDf0GVQM4+1UB4ble0K8wdXqY4U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KW7uGqCqpyWknOX1sseeGinonOaJ0k41SZadITDMzSZehGgC/dB4oQv88s6ZJgYz3
	 WLMQ2S/BrtDs5pUHJ8VmE0XOCN7hEStByiM3kYrTRGp99DmInHVG7W+GCVPxfDBne6
	 S7GPFy+bJ1/KYNb0tN3aS38qaHnZ0B3sKvJ6hL+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfEPU7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 16:59:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38694 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbfEPU7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 16:59:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id y19so3716537lfy.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 13:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6oAPPlUpIkCtQ/levc8RsxEk+htcahssCA/GznIL0Us=;
        b=YZ8c/cm5aMA7k3clC9oPBSrTRPSLiXxoGN+/rRTEEZuA1eKzCtY+bAPltIYlKN4zli
         WJVE0BF2AxNUuBeHaqBEKA6z6gR46laXsGrUbQXk6EdimWFAv+u89zWsDjZL7k1NccgW
         DlnxbLwfAWIL+QPoKXeDP9PbQ4U0PizyusWaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6oAPPlUpIkCtQ/levc8RsxEk+htcahssCA/GznIL0Us=;
        b=Z36st/xgmNGUnHRx3IbXhsVxu38e4xATVLGKMTkQ6pcYGy+lIqHlUdFpzXYWu2KVxO
         2H9DPGI996anVgvzBL06i2YuTs1vvfxHYIPKvqqVInkyviXOM7UMyHBCKW9XA6XOFC+7
         3F4kgOUz9XthEfpZqX67iCLwutEUiG4I/iYVzjenYaA3GwdVD34Jd8tKFji7JcA/Ed0z
         ToPx4Dez9/GYb8m7ohmQS0GZ9cpj2wwcG7CDLZk4pKvsR2/ZR2yLsoe3DiK7yXB/0yUY
         u6VZYRZB9OKEcSgdvnxMpeR96NgFug8JpFwngxA7Mt7iVk2NcGmVbQrVzjA0H11MLGfo
         9lDw==
X-Gm-Message-State: APjAAAXFJTB50Q2XGbDTUjwciXVje/dgAsciRMh9W9b6BnMxCMZY2TZW
        +xJJeKpS2EhRd3QM8vVwOK1qvbcM72g=
X-Google-Smtp-Source: APXvYqyaCCEKPGcnE5+Go3ommoloTxrcCrNi6H79bpACYDJ9AqYSGftaHC9PCiaLslU+D1jkiNsx3A==
X-Received: by 2002:a19:ec12:: with SMTP id b18mr24967968lfa.149.1558040378644;
        Thu, 16 May 2019 13:59:38 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id h11sm1167352lfh.8.2019.05.16.13.59.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 13:59:38 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id y19so3716475lfy.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 13:59:38 -0700 (PDT)
X-Received: by 2002:ac2:510b:: with SMTP id q11mr23412586lfb.11.1558040376948;
 Thu, 16 May 2019 13:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
 <CAHk-=wgiv5ftb+dq7N8cN4n2YX3VkyzeQccywn07Xu9xhOLTSw@mail.gmail.com> <CAK8P3a2EEuxh3uhsqauEC_vROZ7tQHhFwxgiLUnrgtpMdb3kuA@mail.gmail.com>
In-Reply-To: <CAK8P3a2EEuxh3uhsqauEC_vROZ7tQHhFwxgiLUnrgtpMdb3kuA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 May 2019 13:59:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiH=vGjsW9MdWFGsgto2W+71sA4XJ7CSubpXkbpC_bGKA@mail.gmail.com>
Message-ID: <CAHk-=wiH=vGjsW9MdWFGsgto2W+71sA4XJ7CSubpXkbpC_bGKA@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic: kill <asm/segment.h> and improve nommu
 generic uaccess helpers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 1:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
>
> I have reconfigured it locally now and pushed an identical tag with a
> new signature. Can you see if that gives you the same warning if you
> try to pull that?

No, same issue:

   [torvalds@i7 linux]$ git fetch
git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic
tags/asm-generic-nommu
   From ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic
    * tag                         asm-generic-nommu -> FETCH_HEAD
   [torvalds@i7 linux]$ git verify-tag FETCH_HEAD
   gpg: Signature made Thu 16 May 2019 01:28:54 PM PDT
   gpg:                using RSA key 60AB47FFC9095227
   gpg: bad data signature from key 60AB47FFC9095227: Wrong key usage
(0x00, 0x4)
   gpg: Can't check signature: Wrong key usage

That's the same key you used previously.

I think you have to do some gpg edit-key magic or something, and then
the key need to be refreshed.

But I really despise the usability of gpg, so what do I know?

              Linus

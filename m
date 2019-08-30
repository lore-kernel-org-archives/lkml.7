Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D104C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B84123439
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfH3UdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 16:33:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43680 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbfH3UdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 16:33:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id b11so9027839qtp.10;
        Fri, 30 Aug 2019 13:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2hE6pOXI9YwgYTXoFXhAGtS+qXq/OZAAT0OYkj0YuE=;
        b=nHcTVcc38YcVRLpHfDZh7y7iohrEvlaENAafBTGrfcAab8D4bZFrMUi7avpumflyer
         3Dq7KFOdrRH0wENFriIzZllV3+QUfeJXIE7HcjXjRWCqheuzR1MPxJClm6Kc85Szvggq
         aCUAqP1nH2BlrHNIT1wdBli0zMZn2BxnexLUyFgV+mznIXAKNByolI0BKc+UUojRzmJT
         HMZjEm0JxcQ+jHVvZlCBA3raxGsZpNoOlRopbjuhbtjwo+fah6bCZxqKlGlEJ87o+Og1
         haZTWw+JUYTOHfpsGFpkdNx5jolUDhi0EkfHAMTbLX1DJRmQx8+ZnpE/RcZcgT22Ici6
         LdpA==
X-Gm-Message-State: APjAAAWefEHGGXFDfL0IK2gWtAAiU0dQ5X6uEB9axmQhca9bpfUnaO1U
        eOYN3E0GjYcdKBEg05QFw8p4voYqEhZmIxrgUII=
X-Google-Smtp-Source: APXvYqzNLmASV9zbZWIDANsCXyZ0gD0AajjB+nlVkHem8tbUSIpFypUjy64Chv0ThgUcKdpjgNdza02VbGy4KagIrcQ=
X-Received: by 2002:ac8:239d:: with SMTP id q29mr17353365qtq.304.1567197187083;
 Fri, 30 Aug 2019 13:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a16=ktJm5B3c5-XS7SqVuHBY5+E2FwVUqbdOdWK-AUgSA@mail.gmail.com>
 <20190830202959.3539-1-msuchanek@suse.de>
In-Reply-To: <20190830202959.3539-1-msuchanek@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Aug 2019 22:32:51 +0200
Message-ID: <CAK8P3a2XzubLT4gkAzmu9u17bXB1dznbZm=vGPAzyS74fNa=Kg@mail.gmail.com>
Subject: Re:
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        Allison Randal <allison@lohutok.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Firoz Khan <firoz.khan@linaro.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 10:30 PM Michal Suchanek <msuchanek@suse.de> wrote:
>
> Subject: [PATCH] powerpc: Add back __ARCH_WANT_SYS_LLSEEK macro
>
> This partially reverts commit caf6f9c8a326 ("asm-generic: Remove
> unneeded __ARCH_WANT_SYS_LLSEEK macro")
>
> When CONFIG_COMPAT is disabled on ppc64 the kernel does not build.
>
> There is resistance to both removing the llseek syscall from the 64bit
> syscall tables and building the llseek interface unconditionally.
>
> Link: https://lore.kernel.org/lkml/20190828151552.GA16855@infradead.org/
> Link: https://lore.kernel.org/lkml/20190829214319.498c7de2@naga/
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

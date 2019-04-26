Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81639C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5476D2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfDZJ17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:27:59 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42458 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZJ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:27:58 -0400
Received: by mail-qt1-f193.google.com with SMTP id p20so3303812qtc.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 02:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykH6tRLt8Ll6itrFRxda+AdUFEuxNErHJYSXMLsqQf8=;
        b=B8Yow5/9HwrTgiZ8VrpDrNVF5hiYudtlCy6221nvduVTy99gRq1VdpTKp7N92ngL2c
         OMxGJrd/k3r91GnCFeQZOIhXmSiA+WVZNGAjbLEo0PpZgmAyndV75ZMTZTOM5SFFnFQb
         E42WlUVoOiobtOqGqGSL2kydN40zIxA6cCXANco2PlnlIIrCqK5jcdrO1mbbiL8oAZlK
         VL/nvsKnr8aXAey+tiYSDRkRspkhYmShX/HhxxJUbo1653XTXcIGPNpyIeSTBUvsQznz
         R4jwwj2KfwpqJqpI1pQlkn2lOVz5AKVnxFKEfVc10aAu53jf4q1CO7/rgc39ZTpKrWmP
         0vUQ==
X-Gm-Message-State: APjAAAVVtGcvCgV/sAc0Um/ZcudSlGJajmMF9MOGr8hy3LajSd4FhyIQ
        Z0egef6QUexaPZv9r1HpDmHL3c9wvMdKaSpnHh4=
X-Google-Smtp-Source: APXvYqwxTIe+gsprQoMQrIvvXgjxstg8l9FIAHkf6+TZ4gu2HFJ5CZ9KxNfToWBJOLarYh1Fd2c5PfhVI1rpkIA2g14=
X-Received: by 2002:a0c:b24e:: with SMTP id k14mr22221821qve.180.1556270877498;
 Fri, 26 Apr 2019 02:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190425203101.9403-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20190425203101.9403-1-linux@rasmusvillemoes.dk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Apr 2019 11:27:41 +0200
Message-ID: <CAK8P3a1Fu64YhQzvSEy8j3oZ3XwUN81fY+K6Z6ksHhqDWzbxNA@mail.gmail.com>
Subject: Re: [PATCH] mod_devicetable.h: reduce sizeof(struct of_device_id) by
 80 bytes
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Mattias Jacobsson <2pi@mok.nu>, Jeff Mahoney <jeffm@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:31 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> A typical kernel image has hundreds of static struct of_device_id
> instances (a lot of which are sentinel all-zeroes), each occupying
> ~200 bytes. Nobody initializes the .compatible member with strings
> anywhere near 128 bytes, so a lot of that memory is simply wasted.
>
> To verify, I first had the 0day bot chew on a patch adding a dummy
> extremely long .compatible string, and I did get an email saying that
> the patch resulted in lots of new
> "warning:initializer-string-for-array-of-chars-is-too-long"
> warnings. Then I had it chew on a version of this patch reducing to 46
> (because gcc unfortunately does not warn when the literal sans the
> terminating nul just fits), and got a SUCCESS mail listing 107
> config/arch combinations.
>
> For an arm imx_v6_v7_defconfig kernel, .rodata becomes 70K smaller;
> .init.data shrinks by another ~13K, making the whole kernel image
> about 83K, or 0.3%, smaller.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

The space savings are nice, but I wonder if the format of these
structures is part of the ABI or not. I have some vague recollection
of that, but it's possible that it's no longer true in this century.

scripts/mod/file2alias.c processes the structures into a different
format and seems to be written specifically to avoid problems
with changes like the one you did. Can anyone confirm that
this is true before we apply the patch?

      Arnd

Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2868FC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1D220674
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555520243;
	bh=IiiSQ0uwBOM/gPOfTLVTC9s9Pow/Mp2zFXO0aN6M04Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2RlfoLxjxm40dEXfXVfGfVW3h4XoqFZua9T0D0kFy7KgifMa30NNyMJ4MsWu7qF0Z
	 mo7ZolR96jaLqcTuCrsrg8UAXOq0+n7K9oMCp5+LUF11vDKqKN/aJPy1aFGP/5q0jt
	 he81ehzFSeaibJ0Fs2ySjlBE0KHHxh5BokaCfp/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732938AbfDQQ5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:57:21 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45469 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbfDQQ5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:57:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id y6so23090175ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 09:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e9lZbMtDKygZ2DfMvT54TFa3e24d9xoZ0epEXOcQrX0=;
        b=N1H+13ULwDC+M3GXrj0q6BqQVsZgIPGQQAt1qzjWjlIE2T3boxhwovLMZhBRInW+IS
         wGCznU07ozdKWbn2wFvSHWvS+yOaeLs4ZmJ0A9AX+Ug2O610w4Na6yKcpLJzcVB8F4aS
         GdDoIQNJE32V1sSKg5NVPyl80P4+PPTryGbw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e9lZbMtDKygZ2DfMvT54TFa3e24d9xoZ0epEXOcQrX0=;
        b=Izx9TxIG3BI1W9Jo2Jb6D4koMNNKD0xYYgfwkZkm4BkIamnOkh7h+lydD3v7W8WWNq
         WOqJvuvKRQUevhHk4aoJo1pnDFNMut0ZFDUm82+ir+14t05li3AtCWYeeIvr6Zzi7bf7
         69LnqElkd07Pa7y+R74cLCqMrFlYfPQNWTnqARwt8+NBLDTZh59wJbtdYRSOFnRnsAgo
         E8KXJAfYGTqdXRm5zJSrLp7LKRc96PqCrycMKSmKy0ov5VMUEgHln+Snq7D0fdZF3oYo
         +yJcStNzPBChaVb+b0Z0/0/2t3xoc3WUXqVWON5DnBJZOGdOfMesPBUFncICC458ttl1
         /Luw==
X-Gm-Message-State: APjAAAVk4M3rKXXFZe66vttWQVE8lY5OjHY4bC/VWYfHchKDhwyRCBDi
        pQ8eIfDX+8G5QEh1PzYTJjpjNURoGqo=
X-Google-Smtp-Source: APXvYqz8oVuqAgIN6bBJbggxNlVzn+4GRWGkbyOrO94dDF0n3MOz7CFHPG36ICLgF+HUuyvRXYkpsw==
X-Received: by 2002:a2e:204e:: with SMTP id g75mr14098181ljg.92.1555520238841;
        Wed, 17 Apr 2019 09:57:18 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id s24sm10986690ljs.30.2019.04.17.09.57.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 09:57:17 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id u17so19444949lfi.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 09:57:17 -0700 (PDT)
X-Received: by 2002:a19:48c9:: with SMTP id v192mr29389550lfa.136.1555520237474;
 Wed, 17 Apr 2019 09:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org> <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190416110906.6c773aff@mschwideX1> <20190416140658.2cb73a3f@mschwideX1>
 <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
 <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
 <20190417094637.51ad4c67@mschwideX1> <20190417100244.42e29736@mschwideX1>
In-Reply-To: <20190417100244.42e29736@mschwideX1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Apr 2019 09:57:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5j-zMo7hVNxiw3+5L2d1WQVm3x4fbpg=OXLzDh8FhYg@mail.gmail.com>
Message-ID: <CAHk-=wj5j-zMo7hVNxiw3+5L2d1WQVm3x4fbpg=OXLzDh8FhYg@mail.gmail.com>
Subject: Re: Linux 5.1-rc5
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 1:02 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> Grumpf, that does *not* work. For gup the table entries may be read only
> once. Now I remember why I open-coded p4d_offset, pud_offset and pmd_offset
> in arch/s390/mm/gup.c, to avoid to read the table entries twice.
> It will be hard to use the common gup code after all.

Hmm. The common gup code generally should do the "read only once"
thing too (since by definition the gup-fast case is done without
locking), although it's probably the case that most architectures
simply don't care.

What would it require for the generic code to work for s390?

                    Linus

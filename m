Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F231C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B07620675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfCFPA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:00:58 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33315 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfCFPA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:00:58 -0500
Received: by mail-qk1-f193.google.com with SMTP id x9so6960410qkf.0;
        Wed, 06 Mar 2019 07:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dRgQUsVieWSMnEeq8mzUMe/ZK+SK7Zl0dY98Q2McR6I=;
        b=bk1lzliGypN4vS7GtEXpzraN/d02W1+2KfGc/r9d++3MBpHglQbzzuH4p/WJpsVEvR
         bsoEVJU18guLE1tYcT3uldkS7xhhmhxqAj9VPoL5e5aCjBrdS3iUDyW+4penOI6mtXg8
         RYudaqdyaHYAtk1Mxw3S4q8qYA1wOnRbRu3u2waa8kRDGsOYS34//z5Nz8Xy9omI1Wy5
         2DSxpByZNG4OIO5q8pajd3SS9paIES48Z/cjTOwOUVcjUFYi/0v7vOuPU+VKRyMmpejn
         1Ar8TA9iJaqSFntyZq4tAJ50s1AzHlCfmeIXt4WCQat74zZ1b5OjB5ayXOiaHxmMb7w/
         Cqwg==
X-Gm-Message-State: APjAAAUZtV7IgymmN7sueXZ2PgjcOm6GDyp68i3tbUbTbEEq9m+JalCp
        1lI3PJfEqCK+kLUCDDoOCTC2S+HdZEIqzHlTz04=
X-Google-Smtp-Source: APXvYqzar9u9+FuBE8inZZLMWheGN9iGOJZAz917VW/CChj2r9qOSwTTmvmDfXmEk+oDsNwleDVRwq3UxqHRQzQPFqI=
X-Received: by 2002:ae9:dec2:: with SMTP id s185mr5763755qkf.107.1551884456573;
 Wed, 06 Mar 2019 07:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20190306142944.834167-1-arnd@arndb.de> <3614a6b8-0c2f-747c-ce60-b58e79c5cec5@redhat.com>
In-Reply-To: <3614a6b8-0c2f-747c-ce60-b58e79c5cec5@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Mar 2019 16:00:39 +0100
Message-ID: <CAK8P3a1nZU984gSsbw2pg2a4nPSfc687BusJXwQHvs8U8LXvdw@mail.gmail.com>
Subject: Re: [PATCH] ipc: Fix building compat mode without sysvipc
To:     Laura Abbott <labbott@redhat.com>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 3:44 PM Laura Abbott <labbott@redhat.com> wrote:
>
> On 3/6/19 6:29 AM, Arnd Bergmann wrote:
> > As John Stultz noticed, my y2038 syscall series caused a link
> > failure when CONFIG_SYSVIPC is enabled but CONFIG_COMPAT is
> > enabled:
> >
>
> is this supposed to be "CONFIG_SYSVIPC is disabled" to match the
> subject?

Fixing it now, thanks!

      Arnd

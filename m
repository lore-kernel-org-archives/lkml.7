Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5666C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B300120821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555404636;
	bh=f6/YiWjBun6bQXsUksOBXHfIektNAD9DiMiA5I9IL54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0TBe4AV3E8j4ZcJqJ6Y5NVcGLb/8CvuqxsxSZAfVSxDmxpjOa8qVEDfAfwRhB7P0R
	 PtRbS8iupQuQ3OjbQGLDAC7yzmAKr3rPizfWVUuEL6IW6V5vggaYO2z+s6V4lffIw6
	 YwXiqB6f9Qy0XSQqBTo7ibXQkfmE0aMnHbk5oZmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfDPIuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:50:35 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39299 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfDPIuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:50:35 -0400
Received: by mail-ot1-f66.google.com with SMTP id f10so16924593otb.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 01:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6/YiWjBun6bQXsUksOBXHfIektNAD9DiMiA5I9IL54=;
        b=dAcsU2T7E5chgF6Pd8RjJKZ9qJSdzd4nhWQcfOAYfSKH421f8M5Yp00AQBod3SuPN1
         6N14mBC18CnC3n5JP95Jfl/qwg073paHCQgkH0sEbpI6CuDEv17Qo5xwxPk4rV17Iz2x
         Yre5odkG+CNd52p2XzYBsCsnW2ZmvXzmuKBsapDD6Fr2eHs8KcmuQnpPgY6ssOVx9YTU
         CMw5GgHx8N5aH4f1+GxPHazNlsJAK5Db2LooGQvtbJ1BnGxJ2ElV1LC+F6NCWDYNsII6
         aAUm6X3UpT7T5OtMwlU0zJuX8KKujDcyL+/qvY/t7wgD7wO+ixYffypD23GfJPWvLtw4
         tViw==
X-Gm-Message-State: APjAAAWj+2K5o3QNJwGptHRsO48Pb369ZhvJsk0xodniEUFSR0ImpJRf
        Qv5OPrEi7yZEARb8xZTsBTKd54htirP5G2WWoLI=
X-Google-Smtp-Source: APXvYqxzWN5QAHZQXCI6y7OzuzmQ57qwGh3/piwv712pGBmtv0/f6YXi6zGWgaeTs2jf86FBKLui+OERvxVbs5PhzFU=
X-Received: by 2002:a05:6830:11d0:: with SMTP id v16mr16534208otq.159.1555404634514;
 Tue, 16 Apr 2019 01:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190412154819.oiztq2uf4teuxewn@macpro-scc.lancs.ac.uk>
 <CAJZ5v0hSTVHp43TtK9_yjcy2t2V9jSL6VyPJg9cQHE2SYBOejA@mail.gmail.com> <20190415152900.7axwpeczvu7i5kkj@macpro-scc.lancs.ac.uk>
In-Reply-To: <20190415152900.7axwpeczvu7i5kkj@macpro-scc.lancs.ac.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Apr 2019 10:50:23 +0200
Message-ID: <CAJZ5v0gj1p0KNUZkZ3JG2ppK1706GSfY3J12mDNx-E75Y_J3Cg@mail.gmail.com>
Subject: Re: [PATCH 2/2] driver core: fix statics initilisation
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 5:29 PM Willy Wolff <willy.mh.wolff.ml@gmail.com> wrote:
>
> Thank you for your review.
>
> I follow https://kernelnewbies.org/FirstKernelPatch to write this patch.
> It's not stated that checkpatch.pl is for new patches only. Moreover,
> https://kernelnewbies.org/FirstKernelPatch#Running_checkpatch.pl suggest to
> run over the entire file.

I'm not sure about the source of that recommendation.

In any case, running it over the entire file doesn't mean that you
should or even need to make all of the warnings in that file go away.

> Also, uninitialised static global variable are initialised to 0 by default.
> Thus, initialising driver_deferred_probe_enable to false (which is 0) is
> redundant.

Yes, it is redundant, but it also is harmless AFAICS.

> As my knowledge, initialised global goes to .data section, and uninitialised
> goes to .bss.
>
> What does it mean for the kernel? Is this still hold?

No, I don't think so.

> Are performance or memory footprint of the kernel be affected?

No, they aren't.

The only difference this makes is the removal of redundant
initialization to 0, which may be regarded as a cleanup, but not as a
fix IMO.

If that's the only reason you have to change the file in question,
doing something else instead of that may be a better allocation of
your time.

Thanks!

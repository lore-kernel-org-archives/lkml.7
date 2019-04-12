Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED284C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D0120869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555097556;
	bh=gR/9fCMB0ol53XyfIfFWCBw74NeQrI4eIbNOjzeqB9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TfHcycDR4CweoHkX9GsnvgshricHS8L9rZr1A6sCu00iwoSARos1sGeunqBfK3gYs
	 izBqv8DUXSlIpv1qkHyga5BAX2xd6zXZEKbVWRqyZXKAZKHECc712NSgC8hTV9Qk7I
	 fTmoPqE8aXmww3HXusiDGa12ngdKjpR+Fbgh5TqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfDLTcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:32:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33383 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfDLTcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 15:32:35 -0400
Received: by mail-ed1-f68.google.com with SMTP id d55so8538238ede.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 12:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fL6Pbpktz1jLAglVEkV/isN/w3tNz9RyGJicSn0MlQ4=;
        b=ZAHVXriT2xHpRcZVgYBieUPxZLCavtQqaFoWH2irk9L13hBdZEFJZTcoVX42M2yQOD
         ubS4/L9K8pu0dY5u/bpThS38Kzx1NmPtbsq3A13Tz/517X7i3QIJ106pM7+xBpjxyRD3
         mwIZdKUL7bbC5Zztyp99+Xo7RsEQKXMyG9+ZNK5HWKtcOfVYRGR5gcqGIud305/e42eJ
         xFYKcQlozJ8tDBgQ0hhAe6IC2d8x35EbfgsJRQ6p/FlohEhC27DbiuYhlvBewXHVqTkz
         5ka0Fi/wFU961Nff1vY2GNfh25BaY5es8ISDAmskRuolmckXgqLlFzgrAdqM5n8knUJC
         tLcw==
X-Gm-Message-State: APjAAAWZ2E7OG/ncA089e/8aJP1XlTghRod8TpozLxTjO4UlAsFeMzlN
        EdW4pgKebvWK96g7j9DNthkgKKwHZBJDeWO1uM/Od3qa
X-Google-Smtp-Source: APXvYqwJeMD3Kplfqaqg6ek94h1Pey/RS5YmfwyPyVzKwHjt2Pa6B4LETdeQ9bL7ppYMnR1uVDxZAC4SENbtmdf8Q/A=
X-Received: by 2002:a50:a704:: with SMTP id h4mr35645423edc.7.1555097553542;
 Fri, 12 Apr 2019 12:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190226062012.23746-1-lenb@kernel.org> <20190226185131.GP2861@worktop.programming.kicks-ass.net>
In-Reply-To: <20190226185131.GP2861@worktop.programming.kicks-ass.net>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 12 Apr 2019 15:32:22 -0400
Message-ID: <CAJvTdKkwCDdV0G1XS-C=WQqt9UtvQ+Vk-_aBRxW8j4VO98g7zQ@mail.gmail.com>
Subject: Re: [PATCH 0/14] v2 multi-die/package topology support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 1:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Feb 26, 2019 at 01:19:58AM -0500, Len Brown wrote:
> > Restored sysfs core_siblings, core_siblings_list
> >
> >       v1 proposed re-defining this existing attribute to
> >       be the threads in a die, rather than in a package.
> >
> >       For compatibility, decided rather to keep this
> >       attribute unchanged, for now, even though
> >       its name makes little sense, and it makes
> >       no sense in a multi-die system.
>
> So why do things that make no sense?

>>> 7) /sys/devices/system/cpu/cpuX/topology/core_siblings:
>>>
>>> internal kernel map of cpuX's hardware threads within the same
>>> physical_package_id.

This definition tells you what cpus are in what package.
That is fine, it is useful, and it is in use.

What doesn't make sense is that it is called "core_siblings".
Who is to say that the map of CPUs inside a package has anything to do
with "cores"?
Sometimes it does, sometimes it doesn't...

> What breaks?

User space applications, such as lscpu and hwloc are using this attribute
per its definition, to figure out what cpus are in what packages.
If we change the definition to match the attribute's name, they break.
If we change the attribute name to match the definition, they break.

So the plan is to simply leave this attribute and its definition in place,
deprecate it, and move to the new attribute names that don't have
the word "siblings" in them -- which imply a known fixed topology.

We can schedule this attribute to be deleted some day,
but changing it and hoping you've updated all of user-space
would be a unnecessary pain.

Len Brown, Intel Open Source Technology Center

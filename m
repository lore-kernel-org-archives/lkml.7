Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937F5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F193207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnWfTpId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfLQJd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 04:33:58 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:46315 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfLQJd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 04:33:58 -0500
Received: by mail-il1-f193.google.com with SMTP id t17so7817875ilm.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 01:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8eG+k8BuzXeMCLhHkocbEDnQz+3iI+yQZc36T4dIqck=;
        b=XnWfTpIdNJsmfGYXmvEL1QiHKCu7/oza9XU0W0pJcBUpxAhffF7NB1dmNpKQaWtWtl
         2YkrEwL8Xs3ugl1oPrtoo5qNDadxO0pX4lVJQ51wNEVB3MWH/Tri1MC15sPKhgUsm54Y
         iVg5QFWueJANfOViyqJ27BdEyg5Yo/wvG0xCan6UWrqn1tjXXtwKRy6YfZgw3aCPwT8c
         dcOh4oCP3nK1qL+exZnxfBIgKTJDFjbzAWE0+l9/SDeinwoG/Lw2laH9y0rXjicwjvOc
         T8/RQKQb05Di4i32nDEgg+58Bs2SoD2idZ0zmEN+61FiugrggVbB4Kg50qPqnUbHX17P
         kK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8eG+k8BuzXeMCLhHkocbEDnQz+3iI+yQZc36T4dIqck=;
        b=agfDwxgG5eZ/HLONHtDppBy/Gdyx3AVAcnWxHWFcfz3qxrL6OK8XEk5GCkuezoyaG6
         bjW5FerkXlWyE90XFW07IocF36I1O30I4po4vHZQ7d0IdEF8mNJ4im2lUXIEwKIEmaJ8
         yTB5Iq82Uh9SQKKc+pxKhUFu2Ai0vVClDf01Q5/hu+tD0H4Kj5vEZJRZLteJSWara8HS
         J4J4cOuUUOU1+HLz4xJHQcUYJAuR37G67OJsCetQFi689rdxCM9mtvt4piznkFaICkSR
         zCrhm0Gy7vGtI0J2rpXkFeAhoaCEkn5qJj6s0V7V34DnmM2AfcDifg4rG7CYfMIYBdci
         BvcQ==
X-Gm-Message-State: APjAAAWf/g/PnCtOsNYuvDBAVq34tqQ/wOlg6DbpoFrk6sjWho2aRbDS
        eVK1hZtJHZSKq4GDhw08kFbN9ntnm2gzRwNbdJQ=
X-Google-Smtp-Source: APXvYqxD4ViQEMl2rgvUqjyJoMTO/lGR7uS73ZM5wLyKzGNKn9nx40dzVJNan7B8pOOPyDBHiRISXB7O4EgHW3dZ3Pg=
X-Received: by 2002:a92:465c:: with SMTP id t89mr16780379ila.263.1576575237113;
 Tue, 17 Dec 2019 01:33:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac0:9191:0:0:0:0:0 with HTTP; Tue, 17 Dec 2019 01:33:56
 -0800 (PST)
In-Reply-To: <20191217064254.GB3247@light.dominikbrodowski.net>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
 <20191217051751.7998-1-youling257@gmail.com> <20191217064254.GB3247@light.dominikbrodowski.net>
From:   youling 257 <youling257@gmail.com>
Date:   Tue, 17 Dec 2019 17:33:56 +0800
Message-ID: <CAOzgRdZR0bO14fyOk5jLBUkWwgsf7fx41JMQr-Hr6nss1KSmLw@mail.gmail.com>
Subject: Re: [PATCH 4/5] init: unify opening /dev/console as stdin/stdout/stderr
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had been Revert "fs: remove ksys_dup()" Revert "init: unify opening
/dev/console as stdin/stdout/stderr", test boot, n the system/bin/sh
warning.

2019-12-17 14:42 GMT+08:00, Dominik Brodowski <linux@dominikbrodowski.net>:
> On Tue, Dec 17, 2019 at 01:17:51PM +0800, youling257 wrote:
>> it caused Androidx86 /system/bin/sh: No controlling tty: open /dev/tty: No
>> such device or address
>> /system/bin/sh: warning: won't have full job control
>>
>> Androidx86 alt+f1 root on tmpfs, alt+f2/f3 root on rootfs.
>
> Are you sure it is caused by the patch you reference? It's really only
> moving code around, and does not depend on tmpfs/rootfs. The exact same
> three calls are made before and after the change, see
> 	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b49a733d684e0096340b93e9dfd471f0e3ddc06d
>
> The preceding patch (3/5) needs a bugfix which already is upstream, though.
> 	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7de7de7ca0ae0fc70515ee3154af33af75edae2c
>
> Thanks,
> 	Dominik
>

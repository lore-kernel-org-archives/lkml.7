Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EAFC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94F8218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576716915;
	bh=mgki2qfqszAmVYVkJa0WoZ+P8xvCtD0/uXX+vIVnvgk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oiygytvNkx9SxRNANoXYr9EpHljO+Gyu1MuXfbGXcZLC7fUfPiLM5uFzzFbzQb+Lt
	 vO6/efu5CqfwK7t7E12gsKlLtWOMuLGGXeXRwsqUfVWCusTB683z/NzREdbI/dOPm1
	 aas3BCqyy7GFyG4U3L1c7uJDqukyCYF/jQ6oUkeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLSAzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 19:55:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36904 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLSAzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 19:55:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id b15so3067734lfc.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 16:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8DZn9Pjgw5bCednPFYW/Dq3Fv9354h2FlZV84shXnIU=;
        b=Sf947xK3wUhl8A/UOSP4SwhxldixBoovxe4GHZek8oc9rSS3pPSToJwLOg07+ouRPY
         Gnnd/uRKTlq/qOHtpQ6qQSsHvXqv9Zu47/Ge2nIdH6ZCKkSd4H0b/pFs6kydi+1zJDWe
         MW4E5CTwi6wJsOdS4pI0C/IrpR3hNJLrV0jms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8DZn9Pjgw5bCednPFYW/Dq3Fv9354h2FlZV84shXnIU=;
        b=tn3CNFuZ4XFiTghrwdoYWvv5ssPhT/wRdBd1uJbpwVRRq4uages9P/F/GSGZ+1t9hn
         JgFZ7Jqq1FFIrCoU6rgfr4Xw0tCKFLUeJOM1/27hGv9Iu24HdrIJfGmX3Gts9/z1GvPt
         cUT9rPERAFJalJRlGD7gxVQ85mjmpAg8qsoTemf6CuLymbTWfnEmhIkFVqWQf+KPgUJz
         cel2rQWMtERqLJ8V0emmSrHjcfhT2E88n04Y/UBgBv0l8cc4cmx2+w+wPCSHIOKGi1d5
         B+SJkUJxaCYq1PZgnLdLTTKCSRVyfttof/GPGbMqC7sIzMczm4pUhY2YFvE7zboH7JQk
         x/QQ==
X-Gm-Message-State: APjAAAUywZch8rkvMovldv4I9NrgzoR3sRfkSwjq7GJWQO1TZv+kDxaZ
        Hn/6+HWWdDZ4QIT7EkNgkXocq+r3j6g=
X-Google-Smtp-Source: APXvYqwo4+3IwjRwd+6KQwDzIoWvMachR+8Gx3WuuoCLs9pxPu9ZK6CWzoAzh1fapIb6Or2NTOXWoA==
X-Received: by 2002:a19:8842:: with SMTP id k63mr3563174lfd.90.1576716911356;
        Wed, 18 Dec 2019 16:55:11 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id v2sm1907715ljv.70.2019.12.18.16.55.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 16:55:10 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id r19so4250969ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 16:55:10 -0800 (PST)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr3858125ljj.97.1576716909873;
 Wed, 18 Dec 2019 16:55:09 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
 <b2ae78da-1c29-8ef7-d0bb-376c52af37c3@yandex-team.ru> <CAHk-=wgTisLQ9k-hsQeyrT5qBS0xuQPYsueFWNT3RxbkkVmbjw@mail.gmail.com>
 <20191219000013.GB13065@localhost> <20191219001446.GA49812@localhost> <CAHk-=wgMiTbRPp6Fx_A4YV+9xL7dc2j0Dj3NTFDPRfjsjLQTWw@mail.gmail.com>
In-Reply-To: <CAHk-=wgMiTbRPp6Fx_A4YV+9xL7dc2j0Dj3NTFDPRfjsjLQTWw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Dec 2019 16:54:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjv7ntiCpdTg+fvfbP8EoxT4d9QmMp0FRtvm+cU3viCPQ@mail.gmail.com>
Message-ID: <CAHk-=wjv7ntiCpdTg+fvfbP8EoxT4d9QmMp0FRtvm+cU3viCPQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Akemi Yagi <toracat@elrepo.org>, DJ Delorie <dj@redhat.com>,
        David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 4:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This looks correct to me.

Note the "looks". I checked that it applied on current -git, and I
read through the patch, and checked that it almost matched my
original, but I didn't _test_ it in any way.  Caveat emptor.

            Linus

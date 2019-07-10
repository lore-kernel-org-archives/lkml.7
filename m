Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ACFC74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172F420844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562784033;
	bh=yExmFBRBHITPWgHmVoqpIvMcAM3AyXUh5KloGZIqBg4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ks+Gzh1FJy6wv+erU4rjKwNWXnPkVMWeqItGJfnxR1h8UkoT6QeboyiL8t+4snGlm
	 Li6CHRnirMA0w2K57KWuP7tmq0D/SWYnjTcjoZIlLjxDwNtdpmkUDmPJJP7zTGr5ba
	 M4swlJQtFA+QUn+010Xk8f6VAjT0D7kxT6KmXRPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfGJSkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 14:40:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36048 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfGJSkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 14:40:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so3116272ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 11:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ACmc6Zk3yvPsjSlh9JXaf5Fcr66pcTHjs/FxOsnQE8I=;
        b=QqzRHS66/HWbWJVQy89IkLjhwQ6FdiLAf/SDhmoYlz9xAV08ML7gacoHmb6ebFZdrL
         JGgKVD2j/jHcVfclGkPAmVxIInInsAAPswRwILu/9bTJysHNs4ig14MWs6itn+1m5f5N
         cnCLxugftTU0V66dMzy1T+RTzTeYneZpg8K9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACmc6Zk3yvPsjSlh9JXaf5Fcr66pcTHjs/FxOsnQE8I=;
        b=k0kQfb6KA/zdKYg0QkwVYOw6lJYQHO/kJsAJ4jbey4i45UAMmPefgHLM2Iv2HfMX7N
         PfJClmJmICS6fbRZyAF9kKqJWHvg3KU3mkpK1L2JOO79mNGvGKklsj4DqxU5LqpsYLIt
         0i3xwkoOnyXFLexanF11/OqFjyNRstWDfhoQmBbREty5YNFLTyufyoBSOsG/K2vbeYCO
         gcEf6Lm7CuxIFUNYdBS33UQsZqmcTM1JeRGPz7AXC2z4ybLl769mVogJgCnpNm4ffVIK
         2U5Gc1jRoGyrv1IlxXqTO3kPGtjpKN0sOykFsOGnZzFOPecozz4yCsV96cDi6VnHIaK8
         9vlw==
X-Gm-Message-State: APjAAAV2HuvdmQOHV7rReM/y2AmfqPMEYGtkjG28QgNg51S7XTdUvhv5
        ryvnIxkapd5fNmJrJIUSH5m8LFObo1s=
X-Google-Smtp-Source: APXvYqxaZAz6dM94b8b9/2qSIq3L7DLO6xY/U8TidnPcOe+OZ89WWqEzQ5p7FNIHsquqC5+WqPFITw==
X-Received: by 2002:a2e:89c8:: with SMTP id c8mr18676532ljk.70.1562784028301;
        Wed, 10 Jul 2019 11:40:28 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id s19sm580548lji.38.2019.07.10.11.40.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 11:40:27 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id v85so2298598lfa.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 11:40:26 -0700 (PDT)
X-Received: by 2002:a19:641a:: with SMTP id y26mr14812999lfb.29.1562784026692;
 Wed, 10 Jul 2019 11:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190708162756.GA69120@gmail.com> <CAHk-=wigbHd6wXcrpH+6jnDe=e+OHFy6-KdVSUP2yU5aip-UAg@mail.gmail.com>
 <CAHk-=wgkWTtW-JWVAO0Y6s=dRgZGAaTWAsOuYaTFNJzkF+Z_Jg@mail.gmail.com>
 <CAHk-=whJtbQFHNtNG7t7y6+oEKLpjj3eSQOrr3OPCVGbMaRz-A@mail.gmail.com>
 <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com>
 <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de>
 <CAHk-=wj5E=WTz3jfNFnupCPoLXDyFZdW1xgKvuuU-M1_7MEqaw@mail.gmail.com>
 <CAHk-=wghD6CzP7NxHzG4_-bAqOiad_aAohdETDTpUpyci55kfg@mail.gmail.com>
 <CAHk-=wgqVLVeBZi8t+2GpTxGdFpD2FsdkL81irF8tc=qqG0t_w@mail.gmail.com> <CAHk-=wjh+h_-fd-gJz=wor42ZNmqq46QnB90jyfzqmKLsLFWOg@mail.gmail.com>
In-Reply-To: <CAHk-=wjh+h_-fd-gJz=wor42ZNmqq46QnB90jyfzqmKLsLFWOg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Jul 2019 11:40:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh9CrjiwBGrC60sdYHxth7717rePT=iB4UJFgrOUFM0XQ@mail.gmail.com>
Message-ID: <CAHk-=wh9CrjiwBGrC60sdYHxth7717rePT=iB4UJFgrOUFM0XQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>, Jiri Kosina <jkosina@suse.cz>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 10:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think there is _another_ problem too, and maybe it's the APCI one,
> but this one triggers some issue before the other issue even gets to
> play..

No, the other problem was the keyring ACL support from David Howells,
which seems to have broken encrypted disk setups.

So apparently I wasn't impacted by the ACPI thing, but had two other
issues instead. Not a great start to the merge window.

                 Linus

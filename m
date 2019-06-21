Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63CBC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 22:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C902084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 22:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561155586;
	bh=Yr+8cNaWwZaZrftJhz2ZpQQ+4eC5SROdu2ZTa9+UWGM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GbC3aj85JKy9IZbxrM4gcxxykOy9hIivhpVrItiD4QFuQTlWX3D5+iTi7bCFsb28l
	 nYaW+PAilI9cE9AQ4cL41aLC/WGm3831WaHvm8N55ZIj3CQ+Sr/hfsyNXDlFNUXTFt
	 sLJLdd/pxx0hA6S2Adsai7Apdx3XXeheVdosttTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfFUWTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 18:19:44 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:44327 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfFUWTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 18:19:44 -0400
Received: by mail-lj1-f181.google.com with SMTP id k18so7256653ljc.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 15:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnhyB5vk+XiyLXNMoZEM9dhU0jTrIQzBci7bAAtuoaE=;
        b=a9/ijy3BN58/m6zYcz1WvuxZVURngMcAjm2x8xNyRdZxxj0rMw43d7H7IuqgEVi/Ho
         6X5fZNMXAwUlFyykTCQmA6YBh2Z65MerKRko2lTP3HIsf7gMw0jxTOP/98vW8p8fbUxq
         sRglJ6SGtMg0SvxfzBHfj8YiD6lBiPUBFZLnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnhyB5vk+XiyLXNMoZEM9dhU0jTrIQzBci7bAAtuoaE=;
        b=jZPzPc9UUXInKqIlY9bN8sGMpw5hJ0fX7D9YskDTfzWaEhJ7hKMxwn2vgzl8KVxzk+
         S5As2sWRqmY6CdcoRe/3+M4qxYyKwPdwRAho0S51LQtq4FUfdfRRiznFYxe0UkQOQIBO
         YU1PDtxxJ6CgqEqR9YzDxuJqSIU3kAxq2kbm6rXEee+eTexmDe8wDP8NUnF7eSdaZEab
         gf77/TqwJTacgKMNtnd0fXeBx0aCkm9NHMSn6dJ12YYcaGhy/CNxyHRoxqIxRhaV25rx
         vXjhwxm1TnkGm9N3loBMWj8aHCweSUhSANhMLi7yPD+sYeBR4Oovb+G3uiPrYvfZNzEm
         JeDg==
X-Gm-Message-State: APjAAAUmhpeZfx8cgs20zdJpU9uUvsgxrZ0kUFMZFflA7p3TPGKn7ymO
        KMI5ziJho5kKvm/lvjTjeEi3ecVmyjQ=
X-Google-Smtp-Source: APXvYqwEgVjCnmZJPmqTF6lfXsz7AcY5u0zs8SDOFquMQZAdfjz1IWiDvdHT0/RsadWaR2CNML4dtw==
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr36270070ljl.155.1561155581925;
        Fri, 21 Jun 2019 15:19:41 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id f1sm557604ljf.53.2019.06.21.15.19.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 15:19:40 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 16so7249498ljv.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 15:19:40 -0700 (PDT)
X-Received: by 2002:a2e:9a58:: with SMTP id k24mr28824220ljj.165.1561155580434;
 Fri, 21 Jun 2019 15:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <a624ec85-ea21-c72e-f997-06273d9b9f9e@valvesoftware.com> <20190621214139.GA31034@kroah.com>
In-Reply-To: <20190621214139.GA31034@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Jun 2019 15:19:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXoBMWdBahuQR9e75ri6oeVBBjoVEnk0rN1QXfSKK2Eg@mail.gmail.com>
Message-ID: <CAHk-=wgXoBMWdBahuQR9e75ri6oeVBBjoVEnk0rN1QXfSKK2Eg@mail.gmail.com>
Subject: Re: Steam is broken on new kernels
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Eric Dumazet <edumazet@google.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 2:41 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> What specific commit caused the breakage?

Both on reddit and on github there seems to be confusion about whether
it's a problem or not. Some people have it working with the exact same
kernel that breaks for others.

And then some people seem to say it works intermittently for them,
which seems to indicate a timing issue.

Looking at the SACK patches (assuming it's one of them), I'd suspect
the "tcp: tcp_fragment() should apply sane memory limits".

Eric, that one does

       if (unlikely((sk->sk_wmem_queued >> 1) > sk->sk_sndbuf)) {
               NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPWQUEUETOOBIG);
               return -ENOMEM;
       }

but I think it's *normal* for "sk_wmem_queued >> 1" to be around the
same size as sk_sndbuf. So if there is some fragmentation, and we add
more skb's to it, that would seem to trigger fairly easily.
Particularly since this is all in "truesize" units, which can be a lot
bigger than the packets themselves.

I don't know the code, so I may be out to lunch and barking up
completely the wrong tree, but that particular check does seem like it
might trigger much more easily than I think the code _intended_ it to
trigger?

Pierre-Loup - do you guys have a test-case inside of valve? Or is this
purely "we see some people with problems"?

               Linus

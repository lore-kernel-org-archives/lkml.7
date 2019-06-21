Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88761C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 23:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACC0206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 23:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561161295;
	bh=qNcY7zdYYAwH6EQq5T5DZ4AHuUfGHxfuKenL+lf1Tfs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QycfNKg+Wi8wmPJllIV1unXLuw+HxUMcCsBlq4D6ssIXxV4phh6i1t1FBV8TegyNb
	 9dLqVIf9I3wZJMBkysYwePiEsbV6ImDbplcjXQ87348FbOQ4Ay4bBtTdIlIDTvvsYy
	 evE7p8SH1R44gOtPirZPjot7r/TntpDMZTyVOv3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfFUXyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 19:54:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41362 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfFUXyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 19:54:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id 136so6174964lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 16:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQK18XIcxlXIt/29Bx6Bkf5h9dlomFFNrBoRe9o+KJ0=;
        b=gfe2/07nsLCM4qgKuiUO65QDBttbOccAQdNobA1xekF618PiPqAOIqOMIh8gbpJTZV
         uPaKagNO+30GqS3DntMCpxfQNNhBi1W39Mco86uNkkAa9mUMLcAm9zaySloDE+th7C/e
         aIu8CN9p5Lve08uiZ2QGlvPXn128PcPU1POzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQK18XIcxlXIt/29Bx6Bkf5h9dlomFFNrBoRe9o+KJ0=;
        b=bAwCqIJISHH5lAwUz4gGD6yhDMIfM1cDRGLGusUy+8wT80Gn2Sga70/YjB+0SaUTKT
         a2rPGrhetSefm86UkGQo2vNnTMLjgRBX+vKGpodJGfVswFU6/kVPKXWIN+gwRATfo9+m
         RzxDnXuTH2jXU28mGT9mCCz3CMaaumZnjRlJ7t8Bih4h1L+MzAFVEiP65rp+8vXDQfM2
         DFNtKS4YaQu4gkFr/vc4oL4Gj+x0hfyV7ed3+PZNwEIBk0O9kbB9p8U0G7DD5vCNCwu/
         zvd0VNa1XelYyO3wvn/gcNrkUTivVdTwjxRHal9CU1jql0XVxoIorVnuESJSLfPdfztW
         GD8w==
X-Gm-Message-State: APjAAAXOI8TCZCUvNIvjQNMrAVocTjcFm1URezoTi57zyfM/fCQp6rXT
        QO6bhQCbowXKFtPINzAKD7ONRWq4PWs=
X-Google-Smtp-Source: APXvYqwIAsCcbY7+fHpj8U8NHU7XyWK9gTDturqGMkCJ33bkg4uEmg2UNS3ckBi1jT8MarXdboKd3Q==
X-Received: by 2002:a19:6a01:: with SMTP id u1mr4667274lfu.141.1561161291102;
        Fri, 21 Jun 2019 16:54:51 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r2sm567783lfi.51.2019.06.21.16.54.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 16:54:50 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id p17so7439275ljg.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 16:54:50 -0700 (PDT)
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr35965670ljk.90.1561161290001;
 Fri, 21 Jun 2019 16:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <a624ec85-ea21-c72e-f997-06273d9b9f9e@valvesoftware.com>
 <20190621214139.GA31034@kroah.com> <CAHk-=wgXoBMWdBahuQR9e75ri6oeVBBjoVEnk0rN1QXfSKK2Eg@mail.gmail.com>
 <CANn89iL5+x3n9H9v4O6y39W=jvQs=uuXbzOvN5mBbcj0t+wdeg@mail.gmail.com>
In-Reply-To: <CANn89iL5+x3n9H9v4O6y39W=jvQs=uuXbzOvN5mBbcj0t+wdeg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Jun 2019 16:54:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZ=8VSjWuqeG6JJv4dQfK6M0Jgckq5-6=SJa25aku-vQ@mail.gmail.com>
Message-ID: <CAHk-=wjZ=8VSjWuqeG6JJv4dQfK6M0Jgckq5-6=SJa25aku-vQ@mail.gmail.com>
Subject: Re: Steam is broken on new kernels
To:     Eric Dumazet <edumazet@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric is talking about this patch, I think:

   https://patchwork.ozlabs.org/patch/1120222/

I guess I'll ask people on the github thread to test that too.

                  Linus

On Fri, Jun 21, 2019 at 3:38 PM Eric Dumazet <edumazet@google.com> wrote:
>
> Please look at my recent patch.
>  Sorry I am travelling....
>
> On Fri, Jun 21, 2019, 6:19 PM Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>> On Fri, Jun 21, 2019 at 2:41 PM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> >
>> > What specific commit caused the breakage?
>>
>> Both on reddit and on github there seems to be confusion about whether
>> it's a problem or not. Some people have it working with the exact same
>> kernel that breaks for others.
>>
>> And then some people seem to say it works intermittently for them,
>> which seems to indicate a timing issue.
>>
>> Looking at the SACK patches (assuming it's one of them), I'd suspect
>> the "tcp: tcp_fragment() should apply sane memory limits".
>>
>> Eric, that one does
>>
>>        if (unlikely((sk->sk_wmem_queued >> 1) > sk->sk_sndbuf)) {
>>                NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPWQUEUETOOBIG);
>>                return -ENOMEM;
>>        }
>>
>> but I think it's *normal* for "sk_wmem_queued >> 1" to be around the
>> same size as sk_sndbuf. So if there is some fragmentation, and we add
>> more skb's to it, that would seem to trigger fairly easily.
>> Particularly since this is all in "truesize" units, which can be a lot
>> bigger than the packets themselves.
>>
>> I don't know the code, so I may be out to lunch and barking up
>> completely the wrong tree, but that particular check does seem like it
>> might trigger much more easily than I think the code _intended_ it to
>> trigger?
>>
>> Pierre-Loup - do you guys have a test-case inside of valve? Or is this
>> purely "we see some people with problems"?
>>
>>                Linus

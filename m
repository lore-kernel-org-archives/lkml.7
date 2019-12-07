Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB0EC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 04:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A32206D6
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 04:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575691311;
	bh=joy/B5/1KS6PV1WRE8tFHoiMElRANVZfYceAXfaRVac=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=baU8QCxgLEQnGExAr7/WvaAiZXzXIdNrFSaRG+SZUdJbEdEw0tmfazCIDW9KTcNvQ
	 mciETtV4CVBY2PhV9SaiSsO6D3Gxu1WGUikIRyNfk1Zl2LUfAZTmCcVhIfe/iR9jO/
	 3xJaYt0J8WXratOLlQzGDoWv5khokYHIVXCV4sNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfLGEBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 23:01:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35190 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfLGEBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 23:01:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id j6so9827283lja.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 20:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=D9bKHIb2A+ygTSdf7+zChgWhyt6dX/dK0jQhf4W59Is=;
        b=VewXPpWS3+yURzc9MxeOz56Shx1+ekHKKsZfJnkLg9gHFEScXDb5QEN818XuMQTXYe
         NyJTv407dJJ9d7NrQabS6rsC/IYYbwFbxjny2fxTVVGjPfxy1f48xIkLhmJy8IQJILgZ
         BI217t4bFVF2NVTgqWRTPYknLUJ/qIOuDYDFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=D9bKHIb2A+ygTSdf7+zChgWhyt6dX/dK0jQhf4W59Is=;
        b=fc5LutpoSvuIT+UC5RxVGrIcRtAW3uK4xC3NMIx1W/U7J0vwB85PQqVSkfIFG+An9K
         9X5GEtvNDqbKjJUxJgUIAnmymHiy7f3sETzuApuiVRjvacmg5WdEVVG4PbiQh83MNwQN
         rwv2jyoitaayuj6Sfo7r5WRKHWbnK1QhOb87mAhBufb21zo/r+nVkuZVy7DIVACj42IU
         ai9Cb0Ty3gn3/fPPAAOh2rD8gEnFN27Mz5CxZr/Kvz1vyz5vgmXIQrWlDzigcJrnxKm5
         /qKDnT2J1q44/+8i4TuOgpT6l0DHwvWFnC6WNJxoAEo4c7QHhSwBFoRWetlH/sM7bLtv
         UWzg==
X-Gm-Message-State: APjAAAWsB/FWO1nbt1o+Tw7uPoygR6eb65FN1D5A8nlICFmt50MvjAmr
        vI0Olst3bHpZ/ZiewovWeKEfWX22lR8=
X-Google-Smtp-Source: APXvYqyaAjbxLUYN31f0M8dB1Xu+acVGKJbWMabMayMpTv9uDhrqXq7gdgr3+Xrf6IIku8SnhVZ3hA==
X-Received: by 2002:a2e:2201:: with SMTP id i1mr10050868lji.110.1575691307262;
        Fri, 06 Dec 2019 20:01:47 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id j18sm7441357lfh.6.2019.12.06.20.01.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 20:01:46 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id m30so6769279lfp.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 20:01:46 -0800 (PST)
X-Received: by 2002:ac2:465e:: with SMTP id s30mr6736611lfo.134.1575691305722;
 Fri, 06 Dec 2019 20:01:45 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com> <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
In-Reply-To: <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 20:01:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=whnf=avRa4JVoiEB+75mSpnAKuoQSFaxOJWHfqX3mqUqg@mail.gmail.com>
Message-ID: <CAHk-=whnf=avRa4JVoiEB+75mSpnAKuoQSFaxOJWHfqX3mqUqg@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 7:50 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I assume it's the added "do_wakeup = 0" (not the spinlock) that ends
> up having some subtle issue.

Ahh, and then later that is removed, but when it is removed it also
remote the wakeup before the pipe_wait(). So whatever issue that
commit introduces ends up remaining.

I wonder if the extra wakeups ended up hiding some other bug. We do
extra wakeups on the write side too, with a "FIXME! Is this really
true?" comment..

              Linus

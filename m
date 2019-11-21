Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B429C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42F220855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQrCnz7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfKUMAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 07:00:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42044 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726342AbfKUMAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 07:00:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574337637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q5rBJ14foXXsUIH3cvZz1qwUhkNTdgEVQ2KMu92pgrc=;
        b=CQrCnz7KI+3ROnhDazKP6zZsV+s/KTSZ4WwSu+KrY+C1rseLogXNZIx7gs9mzP1bGDXsdS
        IVWVHTA4b/g3B2+5NFSXIgvsLhao9ICBeYTgmO8cdIBgf52H9EewiI6HYwJ3JKHahkIEk6
        0pEloZLO0n+O5cGwchwnA9aIjGhbZ2w=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-VTMESFl6Pb2fgyUKIXHswA-1; Thu, 21 Nov 2019 07:00:30 -0500
Received: by mail-lf1-f71.google.com with SMTP id q28so861397lfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 04:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=x7Br6MUt5GIrekmwoW3W/dVDofzaSmCZ4ehtQgntfJg=;
        b=ZC//oH/Qm6m8faCSTo8DmDembWSqZJjLNenbUlx5f7sF0JoO8YPTQAVMhKkjJtrVZw
         SdRUPwdHkRc8UHtpvSr2DrI3JBei7pJ+/KglXWu3pfwB0KF6SCogaWNOIEI0V+9bztbQ
         pmiH1E3tQ89YeszEyUnYtzXg7wuk+NfkcAJa6I1i5orbYbYOu614+CqPn3le7rFHsqWg
         PZvBPxTSgBen60BFgJKHXFZDw2lB9BUp6IIPEkdlgvdRgXhkM2XG3V1Rtm2yqyQAZBWY
         4n3hVQBl9XgSZQbVvOiO0yYczFL/UzXXynreI43PigZzXf9gFGgdSY7NA7BTkw1EXq96
         86YQ==
X-Gm-Message-State: APjAAAWCqgMkdbNXMxI/lhf6aFqBS/A/gjoxs8UXMarL/X2NvMJuTskQ
        f3khobkDqbsqrUBvh464Z0JD7Lus0pC7OcgWLh/n8QZeA9YbLruT5mPXqua+m/FkTe7YtDANU3b
        BXOWESXiOgBEAeSphatx9A3sF
X-Received: by 2002:ac2:4a71:: with SMTP id q17mr7003180lfp.179.1574337629138;
        Thu, 21 Nov 2019 04:00:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwoeKMb/g8JM/lXuuI1qNoHv9YuoiOe6iH1WkPLFXbg9oIhgY0S6Dx/PfPzgSPCEeKonyhh5w==
X-Received: by 2002:ac2:4a71:: with SMTP id q17mr7003168lfp.179.1574337628964;
        Thu, 21 Nov 2019 04:00:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id k25sm1144384ljg.22.2019.11.21.04.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 04:00:27 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C838A1818BA; Thu, 21 Nov 2019 13:00:26 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH RFC net-next] net: WireGuard secure network tunnel
In-Reply-To: <CAHmME9rmFw7xGKNMURBUSiezbsBEikOPiJxtEu=i2Quzf+JNDg@mail.gmail.com>
References: <20191120203538.199367-1-Jason@zx2c4.com> <877e3t8qv7.fsf@toke.dk> <CAHmME9rmFw7xGKNMURBUSiezbsBEikOPiJxtEu=i2Quzf+JNDg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 21 Nov 2019 13:00:26 +0100
Message-ID: <87lfs9782t.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: VTMESFl6Pb2fgyUKIXHswA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

>> > +     MAX_QUEUED_INCOMING_HANDSHAKES =3D 4096, /* TODO: replace this w=
ith DQL */
>> > +     MAX_STAGED_PACKETS =3D 128,
>> > +     MAX_QUEUED_PACKETS =3D 1024 /* TODO: replace this with DQL */
>>
>> Yes, please (on the TODO) :)
>>
>> FWIW, since you're using pointer rings I think the way to do this is
>> probably to just keep the limits in place as a maximum size, and then
>> use DQL (or CoDel) to throttle enqueue to those pointer rings instead of
>> just letting them fill.
>>
>> Happy to work with you on this (as I believe I've already promised), but
>> we might as well do that after the initial version is merged...
>
> I've actually implemented this a few times, but DQL always seems too
> slow to react properly, and I haven't yet been able to figure out
> what's happening. Let's indeed work on this after the initial version
> is merged. I think this change, and several more like it, will be the
> topic of some interesting discussions. But that doesn't need to happen
> /now/ I don't think.

Agreed. Let's wait until the initial version is merged and use that as a
base to benchmark against... :)

-Toke


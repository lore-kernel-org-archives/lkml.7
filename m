Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B383AC4332F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 23:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD6A21744
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 23:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cktz3ao/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393358AbfIGX1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 19:27:47 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33614 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfIGX1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 19:27:46 -0400
Received: by mail-oi1-f195.google.com with SMTP id e12so7636506oie.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 16:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1zJ0TPSDPQe2jjqzRvgXCz31bKGqz8DKDmN9bP9UxZA=;
        b=cktz3ao/0xa6tsnolwFaEnv4l9l0TKOEh5MdgLwCL74y5htq6wPQWscMtJ3dMvMl2S
         7srTgi3i2QPTwLvb15MTgPIJHkDdTaLIovbGcmkTyoYutK1VK2pxkLadk396JelkPSH2
         FB29g3xVHVxEBRAIncpCuortLknsxEGMg0B7g8e3nz9ZyYmGfwuuhlhMjsY4LoqdAZRV
         2K+1RWRUh1ldLR70L3w8RGJkk5EP/WO6k0T+iJMW0/EGZ/4G9G9LHKiHw2A9nfbsvlkg
         r0KVCVd2W91os7rAFJTdKW4cD56tXgOhm2tuFZsO73UPF/SMpCGSVTtBolanOvknpwSY
         d+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1zJ0TPSDPQe2jjqzRvgXCz31bKGqz8DKDmN9bP9UxZA=;
        b=SCv2UZhXNmi4JimGLQI3ToNRcvw+ffBOK1lXaKK9aXwUc/0yQpkGfWjtZa2SyyUXy9
         GsvSdjbD8jxwera/M4AHC6xQoVWUzDfyCsRcjtjIPValR8CMu2ea6zj4jlg41XVBtQpM
         /9bcBZLyEzoh1XvMUU3HqkhZ2nYcv/EywQqCOlBGD3dMtqxFzPbvm/fuiDfDlAxbUbrL
         WBL9Z6kGa4LP5/wT/6xLtLzaPoyu87scmytDCDRwIP06VRZ/IRPwR3wIxwOZLYqKHZHR
         VQYtIoiqeNJ3OfQpGDZDuePGhKuUS9lGRA8wZ4K05tjOlkb5vmCpITBdJJtpxl1XdfCg
         QFJw==
X-Gm-Message-State: APjAAAXEohIzPb0ffaTQxcokE6WHP96791p98KVmu1OzEI/2qPKUfXvM
        bIJe2zIudMnyoprnmLHky5HZrw==
X-Google-Smtp-Source: APXvYqycZMZwMchY5FodSOB+zmw29VW1bk7TlS4UyND29R+0teseFzE8+mdeQ/eEzJO8cCm/tv4+Mw==
X-Received: by 2002:aca:36c4:: with SMTP id d187mr12451315oia.93.1567898865095;
        Sat, 07 Sep 2019 16:27:45 -0700 (PDT)
Received: from ?IPv6:2600:1702:3c30:7f80:9400:3301:18ae:bc94? ([2600:1702:3c30:7f80:9400:3301:18ae:bc94])
        by smtp.gmail.com with ESMTPSA id 19sm3335336oin.36.2019.09.07.16.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Sep 2019 16:27:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: perf_event wakeup_events = 0
From:   Theodore Dubois <tbodt@google.com>
In-Reply-To: <972489.1567896331@turing-police>
Date:   Sat, 7 Sep 2019 16:27:39 -0700
Cc:     a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CDBCD40D-F873-4EE9-96A9-F8AF105921E9@google.com>
References: <CAN3rvwA+Dnqj4O79f6rNfO50VjbAC3YwJ7CW2ze2aBLzkSJRgQ@mail.gmail.com>
 <943813.1567863629@turing-police>
 <123C743E-C322-45DB-8796-BF6B6EE9CA80@google.com>
 <972489.1567896331@turing-police>
To:     =?utf-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 7, 2019, at 3:45 PM, Valdis Kl=C4=93tnieks =
<valdis.kletnieks@vt.edu> wrote:

> So an entry is made in the buffer. It's not clear that this =
immediately triggers
> a signal=E2=80=A6

I think the documentation says it does when wakeup_events is 1. The code =
for
perf backs this up:
=
https://github.com/torvalds/linux/blob/a9815a4fa2fd297cab9fa7a12161b166572=
90293/tools/perf/util/evsel.c#L1051-L1054
The puzzle is what happens when wakeup_events is 0. The documentation =
saying
"more recent kernels treat 0 the same as 1" suggests it should behave =
the same,
but then why would perf set it to 1 after zero-initializing it?

> So you need to look at what size mmap buffer is being allocated.  It's =
*probably*
> on the order of megabytes, so that you can buffer a fairly large =
number of entries
> and not take several user/kernel transitions on every single entry=E2=80=
=A6

It=E2=80=99s 512 KiB. Each sample is 40 bytes (the sample_type is IP | =
TID | TIME |
PERIOD, and each one of those 8 bytes). 40 bytes per sample * 4000 =
samples per
second * 1.637 seconds is 261920 which is almost exactly half the =
buffer.

So does wakeup_events =3D 0 means it causes a wakeup when the buffer is =
half
full? I don't see anything in the man page about this....

If you'd like to try yourself, this is the strace command I've been =
using:
strace -ttTv -eperf_event_open,mmap,poll -operf.strace perf record =
stress --cpu 1 --timeout 1

~Theodore

>=20
> On Sat, 07 Sep 2019 09:14:49 -0700, Theodore Dubois said:
>=20
> Reading what it actually says rather than what I thought it said.. :)
>=20
>       Events come in two flavors: counting and sampled.  A counting =
event  is
>       one  that  is  used  for  counting  the aggregate number of =
events that
>       occur.  In general, counting event results are gathered with a  =
read(2)
>       call.   A  sampling  event periodically writes measurements to a =
buffer
>       that can then be accessed via mmap(2).
>=20
> For some reason, I was thinking counting events.  -ENOCAFFEINE. :)
>=20
>> sample_freq is 4000 (and freq is 1). Here=E2=80=99s the man page on =
this field:
>>=20
>>       sample_period, sample_freq
>>              A "sampling" event is one that generates an  overflow  =
notifica=E2=80=90
>>              tion  every N events, where N is given by sample_period. =
 A sam=E2=80=90
>>              pling event has sample_period > 0.
>=20
> There's this part:
>>              pling event has sample_period > 0.   When  an  overflow  =
occurs,
>>              requested  data is recorded in the mmap buffer.  The =
sample_type
>>              field controls what data is recorded on each overflow.
>=20
> So an entry is made in the buffer. It's not clear that this =
immediately triggers
> a signal...
>=20
>   MMAP layout
>       When using perf_event_open() in sampled mode, asynchronous =
events (like
>       counter overflow or PROT_EXEC mmap tracking) are logged  into  a =
 ring-
>       buffer.  This ring-buffer is created and accessed through =
mmap(2).
>=20
>       The mmap size should be 1+2^n pages, where the first page is a =
metadata
>       page (struct perf_event_mmap_page) that contains various bits of =
infor?
>       mation such as where the ring-buffer head is.
>=20
> So you need to look at what size mmap buffer is being allocated.  It's =
*probably*
> on the order of megabytes, so that you can buffer a fairly large =
number of entries
> and not take several user/kernel transitions on every single entry...
>=20
>> If I=E2=80=99m reading this right, this is a sampling event which =
overflows 4000 times a second.
>=20
> And 4,000 entries are made in the buffer per second..
>=20
>> But perf then does a poll call which wakes up on this FD with POLLIN =
after
>> 1.637 seconds, instead of 0.00025 seconds
>=20
> At which point perf goes and looks at several thousand entries in the =
ring buffer...


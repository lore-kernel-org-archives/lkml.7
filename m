Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B3BC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC88720854
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vOIlUXfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436491AbfIGQOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 12:14:54 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40057 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388922AbfIGQOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 12:14:54 -0400
Received: by mail-oi1-f196.google.com with SMTP id b80so7464745oii.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 09:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=67/9yX4CYmzQuXVxFuLwYF2vOFab+xNGUYDWuJ33ilY=;
        b=vOIlUXfZDrT/dkG/9dxwtHw50w7O0oel7uB2bleklbFz6qo0QEbxKAjRv5QvESyxCX
         vAKn8kgvA99ZChudHrcDSfedq76QsM99j0ecPh+Sa2oEHXiA7IdlsT4F/+4zvTk8dJFB
         /kUEvf/VIFWL9EH4lBLEHsTPG7460uC+5TPG4cDnzewmVfdaty9eLf1GPNa8ZWqRdSlT
         r+cflcnnT2U4b88IU+skT3jnoJMWNAldpR/btRuDyLJXQB7q/6BQ3L46T1kLo1X5kDQF
         1wpWzJ92b8nP6XsIgTxRgc0cGi4ZFjQD71oXKB4iytZSahxRu1YbpVmHLEsmcvGvHojY
         7mRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=67/9yX4CYmzQuXVxFuLwYF2vOFab+xNGUYDWuJ33ilY=;
        b=Qny8k8BiCtUmrKlMUnkbToa6rZtWJxfeNGzQQ8Sz+d+WI3KF5QwwLjl3wLU6KAW1AF
         5DnAhGo9MCL/IFpdSQoPa8cTL5p1u23DIPj9seMJyCvQw7LhU+CA4GhEKQS+BWcqNLrE
         0ZYo6GDGzHF9m5nx+hEXI6L3Exgc8RZ4TTIGjTiq2zN48/2YvCQH/5hgrf39x2NG0dZF
         SyL4PRdJe+TmScZtEZFj7+Ur5l/RBeS/njKHIAn+AwLFpDU27zPu2ld5mSSNo3pAX2NG
         nmU80gKohgI5TS58utbfDT3JGONb/kTjHwXtWOSEkdrPqbc6X/wFJ2Ahp7k/Ixt1rSRW
         iavQ==
X-Gm-Message-State: APjAAAUDoqX7/svBlj7Pua6d/w+wa7zZQuiv1jqBnF0PQGQWVIdbW7SQ
        tTiEss/DEdDyCtm9xoPcAposXQ==
X-Google-Smtp-Source: APXvYqy+bNvGrNJp1DmUCTGerZbG47XOH37urhiO7l7w+38hSC1SI1k+2u0It8yyi8yDVANK2jP/nA==
X-Received: by 2002:aca:281a:: with SMTP id 26mr11534164oix.163.1567872892434;
        Sat, 07 Sep 2019 09:14:52 -0700 (PDT)
Received: from ?IPv6:2600:1702:3c30:7f80:218c:ca82:e9af:bf6a? ([2600:1702:3c30:7f80:218c:ca82:e9af:bf6a])
        by smtp.gmail.com with ESMTPSA id m17sm3407648otr.51.2019.09.07.09.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Sep 2019 09:14:51 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: perf_event wakeup_events = 0
From:   Theodore Dubois <tbodt@google.com>
In-Reply-To: <943813.1567863629@turing-police>
Date:   Sat, 7 Sep 2019 09:14:49 -0700
Cc:     a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <123C743E-C322-45DB-8796-BF6B6EE9CA80@google.com>
References: <CAN3rvwA+Dnqj4O79f6rNfO50VjbAC3YwJ7CW2ze2aBLzkSJRgQ@mail.gmail.com>
 <943813.1567863629@turing-police>
To:     =?utf-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> The man page for perf_event_open(2) says that recent kernels treat a =
0
>> value for wakeup_events the same as 1, which I believe means it will
>> notify after a single sample. However, strace on perf(1) shows that =
it
>> uses wakeup_events=3D0, and it's definitely not waking up on every
>> sample (it seems to be waking up every few seconds.)
>> tools/perf/design.txt says "Normally a notification is generated for
>> every page filled". Is the documentation wrong, or am I
>> misunderstanding something?
>=20
>       wakeup_events, wakeup_watermark
>              This  union sets how many samples (wakeup_events) or =
bytes (wakeup_watermark) happen before an overflow
>              notification happens.  Which one is used is selected by =
the watermark bit flag.
>=20
>              wakeup_events counts only PERF_RECORD_SAMPLE record =
types.  To receive overflow  notification  for  all
>              PERF_RECORD types choose watermark and set =
wakeup_watermark to 1.
>=20
>              Prior  to Linux 3.0, setting wakeup_events to 0 resulted =
in no overflow notifications; more recent ker?
>              nels treat 0 the same as 1.
>=20
> My reading of that is that in pre-3.0 kernels, you could choose to not =
get overflow
> notifications, and now you'll get them whether or not you wanted them.
>=20
> Under "overflow handling", we see:
>=20
>       Overflows are generated only by sampling events (sample_period =
must have a nonzero value).
>=20
> So the reason strace says perf is only waking up every few seconds is =
probably
> because you either launched perf with options that only create trace =
events, or
> it takes several seconds for an overflow to happen on a sampling =
event. A lot
> of those fields are u64 counters, and won't overflow anytime soon.  =
Even the
> u32 counters can take a few seconds to overflow....

I launched perf record with the default options. Here=E2=80=99s one of =
the perf_event_open calls from strace:

08:57:37.083733 perf_event_open({type=3DPERF_TYPE_HARDWARE, =
size=3DPERF_ATTR_SIZE_VER5, config=3DPERF_COUNT_HW_CPU_CYCLES, =
sample_freq=3D4000, =
sample_type=3DPERF_SAMPLE_IP|PERF_SAMPLE_TID|PERF_SAMPLE_TIME|PERF_SAMPLE_=
PERIOD, read_format=3DPERF_FORMAT_ID, disabled=3D1, inherit=3D1, =
pinned=3D0, exclusive=3D0, exclusive_user=3D0, exclude_kernel=3D1, =
exclude_hv=3D0, exclude_idle=3D0, mmap=3D1, comm=3D1, freq=3D1, =
inherit_stat=3D0, enable_on_exec=3D1, task=3D1, watermark=3D0, =
precise_ip=3D3 /* must have 0 skid */, mmap_data=3D0, sample_id_all=3D1, =
exclude_host=3D0, exclude_guest=3D1, exclude_callchain_kernel=3D0, =
exclude_callchain_user=3D0, mmap2=3D1, comm_exec=3D1, use_clockid=3D0, =
context_switch=3D0, write_backward=3D0, namespaces=3D0, wakeup_events=3D0,=
 config1=3D0, config2=3D0, sample_regs_user=3D0, sample_regs_intr=3D0, =
aux_watermark=3D0, sample_max_stack=3D0}, 134206, 18, -1, =
PERF_FLAG_FD_CLOEXEC) =3D 23 <0.000023>

sample_freq is 4000 (and freq is 1). Here=E2=80=99s the man page on this =
field:

       sample_period, sample_freq
              A "sampling" event is one that generates an  overflow  =
notifica=E2=80=90
              tion  every N events, where N is given by sample_period.  =
A sam=E2=80=90
              pling event has sample_period > 0.   When  an  overflow  =
occurs,
              requested  data is recorded in the mmap buffer.  The =
sample_type
              field controls what data is recorded on each overflow.

              sample_freq can be used if you wish to use frequency =
rather than
              period.   In  this case, you set the freq flag.  The =
kernel will
              adjust the sampling period to try and achieve the desired  =
rate.
              The rate of adjustment is a timer tick.

If I=E2=80=99m reading this right, this is a sampling event which =
overflows 4000 times a second. But perf then does a poll call which =
wakes up on this FD with POLLIN after 1.637 seconds, instead of 0.00025 =
seconds.

The man page snippet you pasted seems to be a different definition of an =
overflow event, but that doesn=E2=80=99t make sense either: the event =
generates a sample 4000 times a second, and 0 (supposedly the same as 1) =
would mean to wake up the FD after 1 sample, which would be 0.00025 =
seconds.

~Theodore=

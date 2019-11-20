Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D1DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FFA222DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Un1BLBTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfKTIuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:50:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20575 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727950AbfKTIuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 03:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574239833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pyGUSb3iPoT2jrlA3M0XHrhRYzJ4C1SALQy+tY3R52w=;
        b=Un1BLBTM9mqGun6rYQ33piPvGeyFsyhb3O9tUDisbfuvcnuMMv3uRz8GLgpFkDIswMKSIN
        DW+1rJMko3fziKB9Hvm94kAiTS0QDqmBG0FPtIG/Sf40YmablWmoOguHgobc52ZVGKyxX5
        epweqVteGRosqWl8FnnRFden6E1QTE4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-rvLNioMeN4Wzx5fPDTu4ag-1; Wed, 20 Nov 2019 03:50:30 -0500
Received: by mail-wm1-f70.google.com with SMTP id f191so4757849wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 00:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LJg4PoKwLNjAV6c7RLZlItrhlkdFabPZta3ShMZA+rk=;
        b=X4bjPtz6bVZMZH3YUzNUEkCA6d0bp5q6mNkaq4zEpnSHilUtqxNCjSfDz2pxDrsw7J
         zuIrlPFlBQPDDnNFgt18F9fpfmn4Ga8L/9lF7Xn92cAAy6O7IQFOSOOeWpuLB7heHNuB
         HCixYTkGr9cj9T3fq3KqbFGSt52ov4HbyyTpsmLIwK0+3L8BYbPWI7J6pQNl6JQnPZBk
         50XlVE5tshZ7DnFn2Nsy7Xx9gwUlQkNyAggrk/AMkhCvy7y0gsRH+4KBIuowBMvn1qN1
         FqVifBgkYEs2NulaaG3TdgMOe+RoohpUJgpk4rpMuPyNEq9366rzgMj5Z7f8hvr8fdTR
         WlhA==
X-Gm-Message-State: APjAAAVi5i45Lnw8/5uIKeXbqg7/lIK7yeZ9fbQHp+Wk/C9kS4+/MdVx
        BP+d9CP9+F+p1fsHP60SqcNEEKpGfPDbCDsEVk6SgMGB6028aNm2KXgRxFZREK4pIJQXo6RKP6G
        MZYpnmzGGPNPC+uD+nvgCLU+e
X-Received: by 2002:adf:e312:: with SMTP id b18mr1848089wrj.203.1574239828710;
        Wed, 20 Nov 2019 00:50:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqzCm59GNSjfFbKMdn+jFdB5tLiEBu8+2MBZEClPJ4MnrB7QvpyiYmBdZTkB4UgluMk/SKlDeA==
X-Received: by 2002:adf:e312:: with SMTP id b18mr1848046wrj.203.1574239828336;
        Wed, 20 Nov 2019 00:50:28 -0800 (PST)
Received: from localhost.localdomain ([151.29.177.194])
        by smtp.gmail.com with ESMTPSA id d18sm31281112wrm.85.2019.11.20.00.50.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 00:50:27 -0800 (PST)
Date:   Wed, 20 Nov 2019 09:50:24 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Philipp Stanner <stanner@posteo.de>
Cc:     linux-kernel@vger.kernel.org, Hagen Pfeifer <hagen@jauu.net>,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de
Subject: Re: SCHED_DEADLINE with CPU affinity
Message-ID: <20191120085024.GB23227@localhost.localdomain>
References: <1574202052.1931.17.camel@posteo.de>
MIME-Version: 1.0
In-Reply-To: <1574202052.1931.17.camel@posteo.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-MC-Unique: rvLNioMeN4Wzx5fPDTu4ag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On 19/11/19 23:20, Philipp Stanner wrote:
> Hey folks,
> (please put me in CC when answering, I'm not subscribed)
>=20
> I'm currently working student in the embedded industry. We have a device =
where
> we need to be able to process network data within a certain deadline. At =
the
> same time, safety is a primary requirement; that's why we construct every=
thing
> fully redundant. Meaning: We have two network interfaces, each IRQ then b=
ound
> to one CPU core and spawn a container (systemd-nspawn, cgroups based) whi=
ch in
> turn is bound to the corresponding CPU (CPU affinity masked).
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0Container0=A0=A0=A0=A0=A0=A0=A0Container1
> =A0=A0=A0-----------------=A0=A0-----------------
> =A0=A0=A0|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0|=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|
> =A0=A0=A0|=A0=A0=A0=A0Proc. A=A0=A0=A0=A0|=A0=A0|=A0=A0=A0Proc. A'=A0=A0=
=A0=A0|
> =A0=A0=A0|=A0=A0=A0=A0Proc. B=A0=A0=A0=A0|=A0=A0|=A0=A0=A0Proc. B'=A0=A0=
=A0=A0|
> =A0=A0=A0|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0|=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|
> =A0=A0=A0-----------------=A0=A0-----------------
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0^=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0^
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0|
> =A0=A0=A0=A0=A0=A0=A0=A0CPU 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0CP=
U 1
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0|
> =A0=A0=A0=A0=A0=A0=A0IRQ eth0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0IRQ eth1
>=20
>=20
> Within each container several processes are started. Ranging from systemd
> (SCHED_OTHER) till two (soft) real-time critical processes: which we want=
 to
> execute via SCHED_DEADLINE.
>=20
> Now, I've worked through the manpage describing scheduling policies, and =
it
> seems that our scenario is forbidden my the kernel.=A0=A0I've done some t=
ests with
> the syscalls sched_setattr and sched_setaffinity, trying to activate
> SCHED_DEADLINE while also binding to a certain core.=A0=A0It fails with E=
INVAL or
> EINBUSY, depending on the order of the syscalls.
>=20
> I've read that the kernel accomplishes plausibility checks when you ask f=
or a

Yeah, admission control.

> new deadline task to be scheduled, and I assume this check is what preven=
ts us
> from implementing our intended architecture.
>=20
> Now, the questions we're having are:
>=20
> =A0=A0=A01. Why does the kernel do this, what is the problem with schedul=
ing with
> =A0=A0=A0=A0=A0=A0SCHED_DEADLINE on a certain core? In contrast, how is i=
t handled when
> =A0=A0=A0=A0=A0=A0you have single core systems etc.? Why this artificial =
limitation?

Please have also a look (you only mentioned manpage so, in case you
missed it) at

https://elixir.bootlin.com/linux/latest/source/Documentation/scheduler/sche=
d-deadline.rst#L667

and the document in general should hopefully give you the answer about
why we need admission control and current limitations regarding
affinities.

> =A0=A0=A02. How can we possibly implement this? We don't want to use SCHE=
D_FIFO,
> =A0=A0=A0=A0=A0=A0because out-of-control tasks would freeze the entire co=
ntainer.

I experimented myself a bit with this kind of setup in the past and I
think I made it work by pre-configuring exclusive cpusets (similarly as
what detailed in the doc above) and then starting containers inside such
exclusive sets with podman run --cgroup-parent option.

I don't have proper instructions yet for how to do this (plan to put
them together soon-ish), but please see if you can make it work with
this hint.

Best,

Juri


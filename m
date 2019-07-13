Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A137C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 12:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31522084C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 12:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Rd0v5fl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfGMMtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 08:49:18 -0400
Received: from forward102j.mail.yandex.net ([5.45.198.243]:35525 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727504AbfGMMtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 08:49:18 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Jul 2019 08:49:15 EDT
Received: from mxback18o.mail.yandex.net (mxback18o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::69])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id 23991F20A68;
        Sat, 13 Jul 2019 15:42:45 +0300 (MSK)
Received: from smtp4p.mail.yandex.net (smtp4p.mail.yandex.net [2a02:6b8:0:1402::15:6])
        by mxback18o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id nYnhEFJwaK-ghTuSjZB;
        Sat, 13 Jul 2019 15:42:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1563021765;
        bh=M6u5ifgvcKCDiMoAtaCSx9r5NE6GN+qLFbSlRYQjToU=;
        h=In-Reply-To:Cc:To:Subject:From:References:Date:Message-Id;
        b=Rd0v5fl/cErza2qfKkWjKo56n9FvSM26gKiTItCOV/vqBOM/5vHa6qBwhZsHp52ep
         FDDHQ9rnoIp5CNFBkSaS89R4oCtwyNMmlcyXmfCzFlrhu0GSmcTAx5hX3gxhZQwbJN
         qnwv1QUJQIBV9wdi0qavSIwCT7QAup1Rl0Tg95cA=
Authentication-Results: mxback18o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp4p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id yuTssl00fg-ggTuFJco;
        Sat, 13 Jul 2019 15:42:42 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Sat, 13 Jul 2019 15:42:40 +0300
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
Subject: Re: [PATCH 4/8] perf evsel: Do not rely on errno values for
 precise_ip fallback
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Message-Id: <1563021760.12557.0@yandex.ru>
In-Reply-To: <20190708154207.11403-5-acme@kernel.org>
References: <20190708154207.11403-1-acme@kernel.org>
        <20190708154207.11403-5-acme@kernel.org>
X-Mailer: geary/3.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much! Just wondering, would it maybe worth to backport=20
the fix to stable kernel too?

=F7 =F0=CE, =C9=C0=CC 8, 2019 at 12:42, Arnaldo Carvalho de Melo=20
<acme@kernel.org> =CE=C1=D0=C9=D3=C1=CC:
> From: Jiri Olsa <jolsa@kernel.org>
>=20
> Konstantin reported problem with default perf record command, which
> fails on some AMD servers, because of the default maximum precise
> config.
>=20
> The current fallback mechanism counts on getting ENOTSUP errno for
> precise_ip fails, but that's not the case on some AMD servers.
>=20
> We can fix this by removing the errno check completely, because the
> precise_ip fallback is separated. We can just try  (if requested by
> evsel->precise_max) all possible precise_ip, and if one succeeds we=20
> win,
> if not, we continue with standard fallback.
>=20
> Reported-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Quentin Monnet <quentin.monnet@netronome.com>
> Cc: Kim Phillips <kim.phillips@amd.com>
> Link: http://lkml.kernel.org/r/20190703080949.10356-1-jolsa@kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/evsel.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 4a5947625c5c..69beb9f80f07 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1785,14 +1785,8 @@ static int perf_event_open(struct perf_evsel=20
> *evsel,
>  		if (fd >=3D 0)
>  			break;
>=20
> -		/*
> -		 * Do quick precise_ip fallback if:
> -		 *  - there is precise_ip set in perf_event_attr
> -		 *  - maximum precise is requested
> -		 *  - sys_perf_event_open failed with ENOTSUP error,
> -		 *    which is associated with wrong precise_ip
> -		 */
> -		if (!precise_ip || !evsel->precise_max || (errno !=3D ENOTSUP))
> +		/* Do not try less precise if not requested. */
> +		if (!evsel->precise_max)
>  			break;
>=20
>  		/*
> --
> 2.20.1
>=20

=


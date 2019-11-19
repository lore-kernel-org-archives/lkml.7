Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F627C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 03:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3741B2230E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 03:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYHhKlmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfKSDVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 22:21:12 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33099 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfKSDVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 22:21:11 -0500
Received: by mail-yb1-f194.google.com with SMTP id i15so8226670ybq.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 19:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mFaLd4e47p1nbHz6KkT9DdFzCO3R8/J3SwU/uegrQWk=;
        b=BYHhKlmnf+bHn+BnSMwltlXHReS4Vt0wlmEvqRbKf8o+wm144ZXK3GZBUcIQoWmXbt
         WlQY6YoTII9N+wQMoYCO9ANCBjXJXbDw6tfnMVq3pL7ROM/zD6S+O4g+TIq79eVU3uIH
         iCFA3lBEpYGljwsvxev3kl+QMzd+ZZ77CP+7RFR1Cvugg2ZzNd22Wur4IV+K/6tCehXF
         bRh59A/AYmbP4q/HX6T3sjTIrQjpzflfzTS5V1dl5C/5xmDp9V5EHybaaeVF9shzX8Ia
         L32SawTDeG4QiK1mw1HIH/Esowf2agC0DTTPfJ1ADMq12X+J6VN/9aq1XxBpwTn90yNg
         1zbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mFaLd4e47p1nbHz6KkT9DdFzCO3R8/J3SwU/uegrQWk=;
        b=nTKGehj5ZW2nL55bSWecZ4C6J02WP+tImNc/A3RgHkQ2Liuh3CitWnE7D9t5LELTvL
         Tvk9h7I0Q1y3YuQ7cb6sUutALT8gs57QfGfjCr/howbWLhHakk11rPsUv+isKFTwEVbJ
         yjBTEmfpUPXTBilas4BvMjsV7QhEnxCMn9e/r6Uz1Wi3Hs1zn3y7f+5fxrbnHQdSHUSx
         6pTPJB43iy25EJi7lx89x5twzpwgUm3F3RixyaFt2qhsl5X/4PmNay0ExeHDR7HS9aGe
         kvhjcsTwKvCIf3riVCeTiCeViiDtMFTOil+koPeQEjq+RdiV3sfZywAOutVI5Q7cYhjj
         p66g==
X-Gm-Message-State: APjAAAWSclASbvW3p+vxseE7vXjNBtlJE2mn12h+YCmJNirtH+yq/3/k
        hKyhL2I6Z13+vVtuRUSbDwk=
X-Google-Smtp-Source: APXvYqwTpRYOKj31e8ymqJwV33XKvxt3ZPD5CVdeIcU3NfvLI17put00tHRd6rzWILQ1/JEFo9BR1w==
X-Received: by 2002:a25:361d:: with SMTP id d29mr26397014yba.276.1574133670379;
        Mon, 18 Nov 2019 19:21:10 -0800 (PST)
Received: from wirelessprv-10-194-242-239.near.illinois.edu (mobile-130-126-255-125.near.illinois.edu. [130.126.255.125])
        by smtp.gmail.com with ESMTPSA id l68sm8867477ywf.89.2019.11.18.19.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 19:21:09 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] perf vendor events: Make the power8/power9 event files
 valid JSON
From:   Subho Banerjee <ssbanerje@gmail.com>
In-Reply-To: <E980D3B0-4519-451C-A0D7-7A8CE1A5AB2C@gmail.com>
Date:   Mon, 18 Nov 2019 21:21:07 -0600
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <529EC552-AF92-45FD-9043-AB5A570B29AD@gmail.com>
References: <20191117231600.27632-1-ssbanerje@gmail.com>
 <20191118221316.GG20465@kernel.org>
 <E980D3B0-4519-451C-A0D7-7A8CE1A5AB2C@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,
I am uncertain which commit you are working on.=20

The command that you sent fails on the latest commit of the master =
branch (af42d3466bdc8f39806b26f593604fdc54140bcb) on =
kernel/git/torvalds/linux.git.

Is there a more up to date version of the perf tools that I should be =
looking at instead of what is in the kernel repo?

ssbaner2@dvorak:~/linux$ git rev-parse --verify HEAD
af42d3466bdc8f39806b26f593604fdc54140bcb


ssbaner2@dvorak:~/linux$ diffstat -l -p1 =
0001-perf-vendor-events-Make-the-power8-power9-event-file.patch | while =
read filename ; do echo $filename ; cat $filename | json_verify ; done
tools/perf/pmu-events/arch/powerpc/power8/cache.json
parse error: invalid object key (must be a string)
                                        [   {,     "EventCode": "0x4c0
                     (right here) ------^
JSON is invalid
tools/perf/pmu-events/arch/powerpc/power8/floating-point.json
parse error: invalid object key (must be a string)
                                        [   {,     "EventCode": "0x200
                     (right here) ------^
JSON is invalid
tools/perf/pmu-events/arch/powerpc/power8/frontend.json
parse error: invalid object key (must be a string)
                                        [   {,     "EventCode": "0x250
                     (right here) ------^
JSON is invalid
tools/perf/pmu-events/arch/powerpc/power8/marked.json
parse error: invalid object key (must be a string)
                                        [   {,     "EventCode": "0x351
                     (right here) ------^
JSON is invalid
tools/perf/pmu-events/arch/powerpc/power8/memory.json
parse error: invalid object key (must be a string)
                                        [   {,     "EventCode": "0x100
                     (right here) ------^
JSON is invalid
tools/perf/pmu-events/arch/powerpc/power8/other.json
parse error: invalid object key (must be a string)
                                        [   {,     "EventCode": "0x1f0
                     (right here) ------^
JSON is invalid


Regards,
Subho

> On Nov 18, 2019, at 9:18 PM, Subho Banerjee <ssbanerje@gmail.com> =
wrote:
>=20
> Hi Arnaldo,
> I am uncertain which commit you are working on.=20
>=20
> The command that you sent fails on the latest commit of the master =
branch (af42d3466bdc8f39806b26f593604fdc54140bcb) on =
kernel/git/torvalds/linux.git.
>=20
> Is there a more up to date version of the perf tools that I should be =
looking at instead of what is in the kernel repo?
>=20
> ssbaner2@dvorak:~/linux$ git rev-parse --verify HEAD
> af42d3466bdc8f39806b26f593604fdc54140bcb
>=20
>=20
> ssbaner2@dvorak:~/linux$ diffstat -l -p1 =
0001-perf-vendor-events-Make-the-power8-power9-event-file.patch | while =
read filename ; do echo $filename ; cat $filename | json_verify ; done
> tools/perf/pmu-events/arch/powerpc/power8/cache.json
> parse error: invalid object key (must be a string)
>                                         [   {,     "EventCode": "0x4c0
>                      (right here) ------^
> JSON is invalid
> tools/perf/pmu-events/arch/powerpc/power8/floating-point.json
> parse error: invalid object key (must be a string)
>                                         [   {,     "EventCode": "0x200
>                      (right here) ------^
> JSON is invalid
> tools/perf/pmu-events/arch/powerpc/power8/frontend.json
> parse error: invalid object key (must be a string)
>                                         [   {,     "EventCode": "0x250
>                      (right here) ------^
> JSON is invalid
> tools/perf/pmu-events/arch/powerpc/power8/marked.json
> parse error: invalid object key (must be a string)
>                                         [   {,     "EventCode": "0x351
>                      (right here) ------^
> JSON is invalid
> tools/perf/pmu-events/arch/powerpc/power8/memory.json
> parse error: invalid object key (must be a string)
>                                         [   {,     "EventCode": "0x100
>                      (right here) ------^
> JSON is invalid
> tools/perf/pmu-events/arch/powerpc/power8/other.json
> parse error: invalid object key (must be a string)
>                                         [   {,     "EventCode": "0x1f0
>                      (right here) ------^
> JSON is invalid
>=20
>=20
> Regards,
> Subho


Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B29C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5DD20863
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYOcOsup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388246AbfFJHpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:45:53 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41302 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387781AbfFJHpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:45:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id 136so5905426lfa.8;
        Mon, 10 Jun 2019 00:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KaGUlt+JnSXrHA2yb3CMJr0TxbR0/I2dJZtL4yhXyNc=;
        b=NYOcOsupnA51BkPW46zf9UrTCt0QPHRrGBvb46LBJyF50/5iaEGDzS0PNfNtyWhhaW
         PpI642elJSx6qYABSdjUHgrfUMxqyEwFuP02V54D62d49KYGcFgCQh6dClIQZpJ3V/Wp
         V/5famDSKlO/yTAcjGLlTLqq6Rlnvs12+VAAVPk+qad/Ek+0skr81fGrqXDWJ1qwqeyd
         NtsLLQ/buBSXZ+kPzOOzhi7g6UWLhp5GV0rnpeJoRieRf5A+YFbmVrKixDdFa2NERnYP
         adyIYTu5FuF0eiLA8rUzVtyrc2Nfk4d4MFE9HvB9kQuwwkZSaxaSIrd9Roqo1CpINfSC
         eJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KaGUlt+JnSXrHA2yb3CMJr0TxbR0/I2dJZtL4yhXyNc=;
        b=JcPNpaXoGDEqfNr/nWsnmZKjskIQGUptPuyGNldQSp4rmEGC94mpQEAESVHvh0Gqv6
         ZJWt4wkP0xhkusip7725uwIEdfr1GwnDZeB8ZnbaBUiYNzcrI8RlldIZDCCXmW/XyLMh
         mulVulqCIIg4o6HVmCF2uQgIBh3a86xcaCRrY4BheQG5GzQx7aiItgRJgVUjscxm+pfm
         StqqdOtzYI+WXmMJhNCWmIO4aTpqxOpWH29HtuhtCvOcvF29T6REg8rrZHpK/yDoietI
         YXr9VDU03fONLWsmWUMETBln+vz4nZq4Ypwue5mkbdEHFY5HBQmLii7mA75xsHtGjYPF
         cikQ==
X-Gm-Message-State: APjAAAW+hHjTPLss9snkekLbHGWgl7tMt0GrND5JA3aIMnGZ/MuR6Yto
        MmubpKDm/JZ/M7Bxgbr/KZ0r+9DfQD4s+rFUzNU=
X-Google-Smtp-Source: APXvYqwtzPf762Zs1WIRlRLR2qsTL3RC0hnVj+12MIU16I9lJ88ATfRlCUx/GISCZ7YCzivuS7wL44QFDw2YUPtm8OA=
X-Received: by 2002:a19:48c3:: with SMTP id v186mr33715271lfa.42.1560152751547;
 Mon, 10 Jun 2019 00:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <1559222962-22891-1-git-send-email-ufo19890607@gmail.com>
 <20190606142644.GA21245@kernel.org> <20190606144614.GC12056@krava> <20190606181504.GD21245@kernel.org>
In-Reply-To: <20190606181504.GD21245@kernel.org>
From:   =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date:   Mon, 10 Jun 2019 15:45:40 +0800
Message-ID: <CAHCio2ghCkRwKZ0XGTeNK90wnry-0i7arT28bsYhHx4BNZuzoA@mail.gmail.com>
Subject: Re: [PATCH] perf record: Add support to collect callchains from
 kernel or user space only.
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Wind Yu <yuzhoujian@didichuxing.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wang Nan <wangnan0@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,  Jirka

> perf_event_attr.exclude_callchain_kernel to 0

I don't think we should set 0 for the desired callchins,  because we
will set exclude_callchain_user to 1 if perf_evsel is function event.

void perf_evsel__config(struct perf_evsel *evsel, struct record_opts
*opts, struct callchain_param *callchain)
{
        ...
        if (perf_evsel__is_function_event(evsel))
                evsel->attr.exclude_callchain_user =3D 1;

        if (callchain && callchain->enabled && !evsel->no_aux_samples)
                perf_evsel__config_callchain(evsel, opts, callchain);
}

If we set exclude_callchain_user to 0 , it will catch user callchain
for function_event.  So, it will be best to just set the
exclude_callchain_xxx to 1.

> So that the user don't try using:

    > perf record --user-callchains --kernel-callchains

> expecting to get both user and kernel callchains and instead gets
> nothing.

I will add a note in the doc.


Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> =E4=BA=8E2019=E5=B9=B46=
=E6=9C=887=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=882:15=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Em Thu, Jun 06, 2019 at 04:46:14PM +0200, Jiri Olsa escreveu:
> > On Thu, Jun 06, 2019 at 11:26:44AM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > So that the user don't try using:
>
> > >     pref record --user-callchains --kernel-callchains
>
> > > expecting to get both user and kernel callchains and instead gets
> > > nothing.
>
> > good catch.. we should add the logic to keep both (default)
> > in this case.. so do nothing ;-)
>
> Yeah, not using both or using both should amount to the same behaviour.
>
> Can be done with a patch on top of what I have in my tree now.
>
> - Arnaldo

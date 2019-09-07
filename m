Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DCDC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 13:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91CD218AE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 13:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393184AbfIGNkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 09:40:40 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:46554 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390058AbfIGNkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 09:40:39 -0400
Received: from mr2.cc.vt.edu (mr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x87DebKW019618
        for <linux-kernel@vger.kernel.org>; Sat, 7 Sep 2019 09:40:37 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x87DeWGv008434
        for <linux-kernel@vger.kernel.org>; Sat, 7 Sep 2019 09:40:37 -0400
Received: by mail-qt1-f200.google.com with SMTP id l23so9945268qtp.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 06:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=yFUeLoQShDR+4twQHthnh9JSioQjP2ZsNxvdKLKbDu8=;
        b=tY9eV/8mPalLsvChcaAWn9aiormmqBNlE2gjca+CA3T2We1YOPwpGkN1Gq0Fy8YSMx
         n6psmNFPlEf/wKPC86Tl4R2yq+tyEFjLcDKabBc+nwK+ob/ldWfymedJbfYcEj6r+O5W
         7GXgatNeMslPIh/YqMvqDzPcKdixkxEY5q4f0tqH65ZHY6xc6lOlDiv+aKibNnvnzrcn
         QJHBq73l2vFIsETes20YBFtLmEFx/gcQfnk/+eo3sFwfpEAeOHoYMnvk+9y38eR8fykj
         aPph3O9lXTlGSMVa+pNWvAAhg1FBuKn1ZcPsi2BMEfpx5yjUAueSO8RvQ3aUizxvpPPb
         TMOg==
X-Gm-Message-State: APjAAAUWJNUZbcD7cutSt6iTrfN/kSfJGZ7oDMR2Xm9MKqurDzSsfoKE
        7GlZmI27qm5IZGGRUavrJ7DIpRPhkV8CBSjCTW47r4GyevCAxYDo8JLZho83URq2t6FffY4UuD2
        HdRL9wfqWWbJYGsQ9KQPqETOG0W5WSMw3bSE=
X-Received: by 2002:ae9:f506:: with SMTP id o6mr14816380qkg.368.1567863632590;
        Sat, 07 Sep 2019 06:40:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz2CAlmxIqQbfDmtk2u4wRTGn+ncmmjIfcHnO2DRVxMBlEeunNWGN9SB/a0CGOohtJAPPo/RA==
X-Received: by 2002:ae9:f506:: with SMTP id o6mr14816364qkg.368.1567863632317;
        Sat, 07 Sep 2019 06:40:32 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id a4sm5812696qtb.17.2019.09.07.06.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 06:40:30 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Theodore Dubois <tbodt@google.com>
Cc:     a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: perf_event wakeup_events = 0
In-Reply-To: <CAN3rvwA+Dnqj4O79f6rNfO50VjbAC3YwJ7CW2ze2aBLzkSJRgQ@mail.gmail.com>
References: <CAN3rvwA+Dnqj4O79f6rNfO50VjbAC3YwJ7CW2ze2aBLzkSJRgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1567863629_4251P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 07 Sep 2019 09:40:29 -0400
Message-ID: <943813.1567863629@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1567863629_4251P
Content-Type: text/plain; charset=us-ascii

On Fri, 06 Sep 2019 16:28:24 -0700, Theodore Dubois said:
> The man page for perf_event_open(2) says that recent kernels treat a 0
> value for wakeup_events the same as 1, which I believe means it will
> notify after a single sample. However, strace on perf(1) shows that it
> uses wakeup_events=0, and it's definitely not waking up on every
> sample (it seems to be waking up every few seconds.)
> tools/perf/design.txt says "Normally a notification is generated for
> every page filled". Is the documentation wrong, or am I
> misunderstanding something?

       wakeup_events, wakeup_watermark
              This  union sets how many samples (wakeup_events) or bytes (wakeup_watermark) happen before an overflow
              notification happens.  Which one is used is selected by the watermark bit flag.

              wakeup_events counts only PERF_RECORD_SAMPLE record types.  To receive overflow  notification  for  all
              PERF_RECORD types choose watermark and set wakeup_watermark to 1.

              Prior  to Linux 3.0, setting wakeup_events to 0 resulted in no overflow notifications; more recent ker?
              nels treat 0 the same as 1.

My reading of that is that in pre-3.0 kernels, you could choose to not get overflow
notifications, and now you'll get them whether or not you wanted them.

Under "overflow handling", we see:

       Overflows are generated only by sampling events (sample_period must have a nonzero value).

So the reason strace says perf is only waking up every few seconds is probably
because you either launched perf with options that only create trace events, or
it takes several seconds for an overflow to happen on a sampling event. A lot
of those fields are u64 counters, and won't overflow anytime soon.  Even the
u32 counters can take a few seconds to overflow....


--==_Exmh_1567863629_4251P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXXOzTAdmEQWDXROgAQI0ORAAhzyWz2/envWdQp6CiUDuijiIHo2vesWE
A1eU14T5lwVnxGQ0Z+R2/syFlPjBvx3TgRzRh24/JOcA07FnKNrWjRfEsuGeq+1Y
E8oSniutgEyPEKsEBLTOKTIqa9rWX/6ci7tWrujAgQ3FUW+zfKTX3F1P0tp+FAed
i2Mjo39nmSjG8TfmB5E3rlm08tnHlG3VlbWdMkdF3SiHyb47cMrMJNjpomrKi0PK
oBbqwgCRukjvcylQhvEgGHswJw8syoBc4wsgkV6USUl3BI8bzFFtHFeWpWK4uMuh
eU9VU2zBLWDtf6c8KwGzhFhQAPlvvgclNAH0aGdYPLEsTuFC1VsKz0rpVA/uDU/s
a/Oz6yQbeOtciH85emN890MmByEkMgonmgczRA/MtuZXLFS+mDhmN9DubGqbTYaw
BW7Vaz9Dmz6AXSblPdhG2CZQT106ZBWE9UXRWH20TFgbAew5U6g9X6OGzTPwM/Z1
mzefZ7HNWUK+XpXaD+voHSdRKZfnQh8pL/2m+gTW42BRudzajS0nKMAjull1huB+
Mf+RX3uH3wbuLNuG10oJeflT9X12YQyeZgpmC9a5FkehcE5hvgOa1J0s5M2MrXAt
5Xa/qIyDJ79GAd+oSAG8ENR3CbHclwVemsAfzcRSUa/yscsM6QIEKSYGiMa28n+E
GkRivLsNxdg=
=ZDUo
-----END PGP SIGNATURE-----

--==_Exmh_1567863629_4251P--

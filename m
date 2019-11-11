Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED0BC17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154F721783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwVw/MSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfKKOFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:05:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36729 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfKKOFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:05:39 -0500
Received: by mail-ot1-f67.google.com with SMTP id f10so11330945oto.3;
        Mon, 11 Nov 2019 06:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hkWWZbsPhAe/B+lg1NTrPkrZfdIPdtnDPLZ91eTI/hg=;
        b=lwVw/MSbrrSR96HQiTRGjp4qyBLP9BUVvOJ7zUjQCJ+Bl51zdrH0ZeOYPfQadmnrQv
         LC5pnKVzGGUcbXy6983YIevobRGuUKI8LfdKq87vJVZ+tQLGuXqUNjr6WV+SKGRZeNG5
         SAUmQffDJJdfo3GY1YHH0dmHFc7/IFMLCI++HYj0MOvgYZwynSc8XJ58ylbJ0pq+J+3d
         tw4DkYPn71ln2qqUxDBP/pCGu2ZTb0zVjMcLZjiGi/NSbiSK3er1e+4bLrJoUjs79t5Q
         XRTuWN3LbqzYx5ByPRiLLGnmUAIv/qwtEknadUJmdAlv4XPahOJY0XdT9crvnySe5hmr
         KWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hkWWZbsPhAe/B+lg1NTrPkrZfdIPdtnDPLZ91eTI/hg=;
        b=GzagR0fdtY7WlsJVA/cI5mq1yR091sWgCAuwT46BZc+sJciyhR7bkizfC9t4KBbSL2
         tbg3bynXyFZL2h3cmgzFn+Ic8nKjsnUnyx0qjRYSbqw1s8CDp2sPl20g9HeCn+TGo4hV
         82hqInCTSqYpBLcNI4y0pgh7pLOcJjyvoCrDgfUzCxDUHk96vbnLvhgz5rWJDY5PP7MN
         Qi8nexvejVWjDWjGP2PsSlp9DatjKfi72qC0yrZk5+0/TAbFhdJDoYzoeEVUYa4lvH73
         8DwH24aOTxSNEaaFNEO/9FUM/WH4+UHc49l6I0nMw0pUaXLmR9aaXdapd6hUJZ6+9Cpq
         kFJA==
X-Gm-Message-State: APjAAAWa8wyjkSCrVs3wrKB2C3k1dWiSuSiCdTMaU5NW/ZFbkbCB9vd8
        y+EGNSTO/gJQZH6992rH6NQpa3E/pwmKlbq2LT8=
X-Google-Smtp-Source: APXvYqwKDHSLwIppJngXejpzqHPV4YxZhwzU8jDUQEbttYpesGP+AXtsC0jFnvcDk5ZDCNQNKmxcyJVC4p07NzbkNRQ=
X-Received: by 2002:a05:6830:3:: with SMTP id c3mr8817650otp.15.1573481138383;
 Mon, 11 Nov 2019 06:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20191014141718.22603-1-narmstrong@baylibre.com>
 <20191014141718.22603-2-narmstrong@baylibre.com> <20191023201141.GA21235@bogus>
 <CA+3zgmsJPsvXgsjDQKKrSG+UNdY3SK+hKCTD2X3hGG+OXejHig@mail.gmail.com> <CAKgpwJWU3jB0DWEKE09TOV+YLceBFJ75ZirAXQbuhj8v3FwjXg@mail.gmail.com>
In-Reply-To: <CAKgpwJWU3jB0DWEKE09TOV+YLceBFJ75ZirAXQbuhj8v3FwjXg@mail.gmail.com>
From:   Tim <elatllat@gmail.com>
Date:   Mon, 11 Nov 2019 09:05:27 -0500
Message-ID: <CA+3zgmtJqN-3Q-kjMhh58B+T7z_1TA-C6be7+UP6nuQb7eq=8A@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc: dt: bindings: usb: dwc3: Update entries for
 disabling SS instances in park mode
To:     Jun Li <lijun.kernel@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Felipe Balbi <balbi@kernel.org>, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Speculation;

Maybe the kernel maintainers prefer to optimistically permit future
products to easily remove workarounds via quirk flags.
Even if data from testing were shown, and it did not impact
performance, code reduction and clarity are desirable.

On Sun, Nov 10, 2019 at 8:58 PM Jun Li <lijun.kernel@gmail.com> wrote:
>
> Hi Neil
>
> As I got the information from Synopsys, this bug exists on current IP ver=
sions,
> and per my tests with external USB3 hub + 2 Super speed udisks on data
> read by dd, I can reproduce this issue with different kernel versions, al=
so I
> didn't see obvious performance drop by dd tests after disable park mode f=
or
> super speed, so should we just disable it by default so no need a quirk?
>
> Li Jun
>
> Tim <elatllat@gmail.com> =E4=BA=8E2019=E5=B9=B411=E6=9C=8811=E6=97=A5=E5=
=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=888:42=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Thanks for working on this Neil,
> > Is there something that needs doing for this patch to make it into 5.3 =
or 5.4?
> > As previously mentioned the patch set fixes the issue on affected hardw=
are;
> >     https://patchwork.kernel.org/patch/11164515/
> >
> >
> >
> > On Wed, Oct 23, 2019 at 4:11 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Mon, Oct 14, 2019 at 04:17:16PM +0200, Neil Armstrong wrote:
> > > > This patch updates the documentation with the information related
> > > > to the quirks that needs to be added for disabling all SuperSpeed X=
HCi
> > > > instances in park mode.
> > > >
> > > > CC: Dongjin Kim <tobetter@gmail.com>
> > > > Cc: Jianxin Pan <jianxin.pan@amlogic.com>
> > > > Reported-by: Tim <elatllat@gmail.com>
> > > > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > >
> > > Sigh, what's one more to the never ending list of quirks...
> > >
> > > Acked-by: Rob Herring <robh@kernel.org>

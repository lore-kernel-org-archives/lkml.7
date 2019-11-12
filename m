Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525EBC17447
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E81206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbDnTVrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKLBsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:48:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46769 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfKLBsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:48:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id b3so16669678wrs.13;
        Mon, 11 Nov 2019 17:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/bjIqi6hO/adh9b46mmU09qR2JgvrPKcPXsn9PKpydQ=;
        b=HbDnTVrRBD0jVKHLLydC03N06oTzh50Z5atOgRLw2IGC+WSPbw+CBtnAhZ9mE6wenq
         YZlYtu47iMNQxdTRXULdKWL6bgV6ccf7NJPqCMhENEYrsbFeApa63dcWoooL2277eHhG
         ULwctVuQtS33qqUFutyjmnVJ64CqDpvbk4bVYxkVA0Pbaa0IhzN7mR3chlCBkhlJxNFt
         hkqoMZeAmwadBaR1u6Onx0G5lGSUj8Cu8gXOn5UXAaGUNzUVVpoxOh3D3qq32OKnZW5u
         bZ16EvG8hQ0eKh9Da6QFH21godYwbZpHmRMYJpXAfszDFFhiIGnyIT1DmujUS6AxKbix
         pRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/bjIqi6hO/adh9b46mmU09qR2JgvrPKcPXsn9PKpydQ=;
        b=H8DvR7dLqduD4P4wecSmJ9kZZ1NJxKRf7CiJLl9/4HJN5kQi4ImeW75XTecKz41bDy
         s4sKoznxxzgRE8rQrykvW+5C9EFtrDOTRv9yueRuTv8mgrdwxds9LC01Bln1NVxZS43U
         mYZxboZsa/ioq1itEmBTiNHWdT2EhEjoAbkbmWlHeHZe9h7oMChIOZcAtg8QwShTQ++5
         ulrGdqRn8vuX/HMrVLU4/Mp1ZhQlBnJcwvUGRBb9yuh1EUuQHC16+1FcMq9welQOHXgt
         w/IuUl18oTPFWWCP1ZHTZJ4A8XpcJAWI93lBW+U8BLgvygMdyf+89lHjruiwbXKKe4Xa
         wUzw==
X-Gm-Message-State: APjAAAXfm0VCsH6/3raD3h/+2GKFIZ9JFAVo9inon8634reybNL73opB
        q8HZ2T4CNk/GBE0aRYN2cBKXnQrFrPVbYGy5eoI=
X-Google-Smtp-Source: APXvYqxuxcgymK9jAB/5KQHDa1nDO97DkTPn+jtJT1mWCOODP321UsjLE7Cfn2IHOUjA0/iissWb1hTqLp0z9NvLe7Q=
X-Received: by 2002:adf:8088:: with SMTP id 8mr22613309wrl.230.1573523315058;
 Mon, 11 Nov 2019 17:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20191014141718.22603-1-narmstrong@baylibre.com>
 <20191014141718.22603-2-narmstrong@baylibre.com> <20191023201141.GA21235@bogus>
 <CA+3zgmsJPsvXgsjDQKKrSG+UNdY3SK+hKCTD2X3hGG+OXejHig@mail.gmail.com>
 <CAKgpwJWU3jB0DWEKE09TOV+YLceBFJ75ZirAXQbuhj8v3FwjXg@mail.gmail.com> <CA+3zgmtJqN-3Q-kjMhh58B+T7z_1TA-C6be7+UP6nuQb7eq=8A@mail.gmail.com>
In-Reply-To: <CA+3zgmtJqN-3Q-kjMhh58B+T7z_1TA-C6be7+UP6nuQb7eq=8A@mail.gmail.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Tue, 12 Nov 2019 09:48:22 +0800
Message-ID: <CAKgpwJWj9nqF-j2e+hNZZUtqGY92-2o1cUNWWh0ugePrwjbtsA@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc: dt: bindings: usb: dwc3: Update entries for
 disabling SS instances in park mode
To:     Tim <elatllat@gmail.com>
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

by a quirk, those platforms without this quirk can't benefit this fix.

if later this bug is fixed by some reversion of dwc3 IP, we can easily
remove the workaround by a IP version check:
if (dwc->revision < DWC3_REVISION_PARK_MODE_FIXED)
{
          disable park mode for ss;
}

Li Jun

Tim <elatllat@gmail.com> =E4=BA=8E2019=E5=B9=B411=E6=9C=8811=E6=97=A5=E5=91=
=A8=E4=B8=80 =E4=B8=8B=E5=8D=8810:05=E5=86=99=E9=81=93=EF=BC=9A
>
> Speculation;
>
> Maybe the kernel maintainers prefer to optimistically permit future
> products to easily remove workarounds via quirk flags.
> Even if data from testing were shown, and it did not impact
> performance, code reduction and clarity are desirable.
>
> On Sun, Nov 10, 2019 at 8:58 PM Jun Li <lijun.kernel@gmail.com> wrote:
> >
> > Hi Neil
> >
> > As I got the information from Synopsys, this bug exists on current IP v=
ersions,
> > and per my tests with external USB3 hub + 2 Super speed udisks on data
> > read by dd, I can reproduce this issue with different kernel versions, =
also I
> > didn't see obvious performance drop by dd tests after disable park mode=
 for
> > super speed, so should we just disable it by default so no need a quirk=
?
> >
> > Li Jun
> >
> > Tim <elatllat@gmail.com> =E4=BA=8E2019=E5=B9=B411=E6=9C=8811=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=888:42=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Thanks for working on this Neil,
> > > Is there something that needs doing for this patch to make it into 5.=
3 or 5.4?
> > > As previously mentioned the patch set fixes the issue on affected har=
dware;
> > >     https://patchwork.kernel.org/patch/11164515/
> > >
> > >
> > >
> > > On Wed, Oct 23, 2019 at 4:11 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Mon, Oct 14, 2019 at 04:17:16PM +0200, Neil Armstrong wrote:
> > > > > This patch updates the documentation with the information related
> > > > > to the quirks that needs to be added for disabling all SuperSpeed=
 XHCi
> > > > > instances in park mode.
> > > > >
> > > > > CC: Dongjin Kim <tobetter@gmail.com>
> > > > > Cc: Jianxin Pan <jianxin.pan@amlogic.com>
> > > > > Reported-by: Tim <elatllat@gmail.com>
> > > > > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > >
> > > > Sigh, what's one more to the never ending list of quirks...
> > > >
> > > > Acked-by: Rob Herring <robh@kernel.org>

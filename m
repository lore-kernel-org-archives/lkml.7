Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10683C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64C22084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzPkNF7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfKLKvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:51:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37860 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfKLKvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:51:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id t1so17981593wrv.4;
        Tue, 12 Nov 2019 02:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w3da61b7JGSuBbFW6srTkqcNOALgI1mXsG7keOhSKoE=;
        b=KzPkNF7vLNMPI7wGcpmPKJalQ5TUNvUedqERtpafvcrKVrmh7EjsuZemhpR6OHxdK5
         u+ArAuoXHhBSuufU9nkJuJ46YCS1bDkxm3keA82EHAEoh9AgMpRjs568uZIm2eC4BptZ
         PQtU0v2i27TfrbZWwyi6452Y3EQ6NttTFiQx3bFAEilOtbTyU+M3sT4bFiC7cQ36nzFZ
         yT+xMLkYUqyhXKRvK35qar3+ecDY3LKvVhsXaPlJ+1Lfi4/KgBuAXt/jFfXa/9rZyVYy
         /ZhNEJF0Mbyo+jQYcJFezSWS0YWnz68ZAPoQ8yOJnscfDRwbM1bx9TtIxDSLl48as4eS
         ndpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w3da61b7JGSuBbFW6srTkqcNOALgI1mXsG7keOhSKoE=;
        b=tWy8V8lKdxomWfFdW9FcsOQC/6rozMBMzwvTuQoTv1uH0CLCDUeUk5zu5Wh+FOANsb
         S+Dr61hZ280FnFdxSjlwF8eJ0lnyNTV7RxrMLHRlUMyaDemlsheIZHc7jNPm8UoV8wvk
         SHcYN2jKYis5iPsHkSUw97hRSD3rQ8VZIBWSj0ySX3yzo9q7L7AywfXHb8Uh7EJbGrpC
         KgsRsPEmpACV9b3qA5l+WGYnz5CZWKa6ysr2+JK3iMHmz7s/NypdEXNWKbAd8YSanWJ9
         L4pyZUJW0kNYw3FeoC8Y7Qmm82u8D+TFmo9yE9lo7HcSoMobSrT2VvEjTJRv7VYrsQL2
         ekRA==
X-Gm-Message-State: APjAAAWo7zTiu+kQMuB8c8zrpCsCRzdYu6ALh2jtWpHKpuJnl0I3RItt
        NnHAc6r9Hgj0kbUt8Dx/DUcdJ2ND52bya85B1Ul8V34evjE=
X-Google-Smtp-Source: APXvYqyi2uw32VMwilcptszDlBFN/85aP+rGSUIN70dz2Tdhs5NchrnBpWKZXr2pFLmq3r7c6O2KfeR3bxkToj+cktw=
X-Received: by 2002:adf:c449:: with SMTP id a9mr3868494wrg.240.1573555883099;
 Tue, 12 Nov 2019 02:51:23 -0800 (PST)
MIME-Version: 1.0
References: <20191014141718.22603-1-narmstrong@baylibre.com>
 <20191014141718.22603-2-narmstrong@baylibre.com> <20191023201141.GA21235@bogus>
 <CA+3zgmsJPsvXgsjDQKKrSG+UNdY3SK+hKCTD2X3hGG+OXejHig@mail.gmail.com>
 <CAKgpwJWU3jB0DWEKE09TOV+YLceBFJ75ZirAXQbuhj8v3FwjXg@mail.gmail.com> <c32007f5-88b9-45c5-b542-b1dc4dbc76ea@baylibre.com>
In-Reply-To: <c32007f5-88b9-45c5-b542-b1dc4dbc76ea@baylibre.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Tue, 12 Nov 2019 18:51:10 +0800
Message-ID: <CAKgpwJVHF6Ytdt9kq5SwiixFDLym_UPG51aXag1nVVay0pzofQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc: dt: bindings: usb: dwc3: Update entries for
 disabling SS instances in park mode
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Tim <elatllat@gmail.com>, Felipe Balbi <balbi@kernel.org>,
        khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
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

This bug exists on all current versions per information I got from Synopsys=
.
+ Thinh Nguyen <thinhn@synopsys.com>.

Li Jun

Neil Armstrong <narmstrong@baylibre.com> =E4=BA=8E2019=E5=B9=B411=E6=9C=881=
2=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:00=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Hi Li,
>
> On 11/11/2019 02:58, Jun Li wrote:
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
>
> I don't have any opinion on this, I think the USB & DWC3 maintainers shou=
ld decide
> how to handle this.
>
> Did Synopsys specified a range of affected IP version ?
>
> Neil
>
> >
> > Li Jun
> >
> > Tim <elatllat@gmail.com> =E4=BA=8E2019=E5=B9=B411=E6=9C=8811=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=888:42=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Thanks for working on this Neil,
> >> Is there something that needs doing for this patch to make it into 5.3=
 or 5.4?
> >> As previously mentioned the patch set fixes the issue on affected hard=
ware;
> >>     https://patchwork.kernel.org/patch/11164515/
> >>
> >>
> >>
> >> On Wed, Oct 23, 2019 at 4:11 PM Rob Herring <robh@kernel.org> wrote:
> >>>
> >>> On Mon, Oct 14, 2019 at 04:17:16PM +0200, Neil Armstrong wrote:
> >>>> This patch updates the documentation with the information related
> >>>> to the quirks that needs to be added for disabling all SuperSpeed XH=
Ci
> >>>> instances in park mode.
> >>>>
> >>>> CC: Dongjin Kim <tobetter@gmail.com>
> >>>> Cc: Jianxin Pan <jianxin.pan@amlogic.com>
> >>>> Reported-by: Tim <elatllat@gmail.com>
> >>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>
> >>> Sigh, what's one more to the never ending list of quirks...
> >>>
> >>> Acked-by: Rob Herring <robh@kernel.org>
>

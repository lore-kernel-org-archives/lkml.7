Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2DFC2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95E9206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSQi9449"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLKAqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 19:46:07 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44229 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLKAqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 19:46:07 -0500
Received: by mail-ot1-f65.google.com with SMTP id x3so17245625oto.11;
        Tue, 10 Dec 2019 16:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dNo8gQB2Lns6lssefACZcuCEFfgXMn9otoHM3Ump6ZU=;
        b=MSQi9449EbBVtE8SBD/GOeFr9lc1VEeadwIPv0OUHQIqzCemeFd7M/BqaTHJH2HbFC
         VyC2WdGAJ0Oy7BMvm6c+VXsJmVA9T5O44nKl/i7bv6PirSOnQbfzSRo6tWVFKd5w1Tzp
         EM+9Ny2MRBFb5NHvtnHw5Dye3NOTdNk7MqGkiIxyjoSL4Fv19pYxLtPnlF66mlPaY0BU
         ccadh1t27sktMAwSiei7ID54Jtbum+31GKoG2tV0xt3XzxvvBIYyHzo1sRSy99F1emGF
         BpQeZnZqYUN6v+/AO5QZoW5U5JqSERSUYzkuCLqTi/DD2JIqIxn8V8guYI5nTfJyhAcF
         Toaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dNo8gQB2Lns6lssefACZcuCEFfgXMn9otoHM3Ump6ZU=;
        b=YqcGZO+Ni9INFPO5Azmc4aJmV13XVhoWEiC/RLvx8iXp/UOL+6IZl20XkuvlbrEpeg
         79jnf94A4odAphi3f064Scrw3z3YsUEIdGjeGb9ucQfjcDPsQnwayJdY4+h35GdBNdGL
         S6gbCiNMmeVQuhTEfjLfF03DS9MioAggST7JUy9QLW2O1e36bHDFVxLGNJF3N7VA7OpE
         mqzM/RBSIj+MPgk/ov9CGw5GJR9STCKmVo/UUT86JjEx4kgmDY7NKcT+1PzOGNngmtYT
         gpLvJZCnENsg0mPEs0xWWh1Bv/D8u6uW8fYX7m/3LDSGSsFfA7OCGmW+M11Nz3iUz0cF
         9fkA==
X-Gm-Message-State: APjAAAXz1o4+FH5gPoIocJXydWYmteqp6s24sLCAuVdjliXSdsyZDxu4
        yvFPKKmjQ1vC08WISTm8wDvEuXO1yUU7lYgA8Co=
X-Google-Smtp-Source: APXvYqxlHTr1UZyzC6aCajvAM4W2Nsg3YlT+KI7UUGo3jxS4zv5rW02mvvBuzLyLP3MDtSmh3sJHzcCwjpOwaw6OzaY=
X-Received: by 2002:a9d:4f0e:: with SMTP id d14mr452420otl.90.1576025165539;
 Tue, 10 Dec 2019 16:46:05 -0800 (PST)
MIME-Version: 1.0
References: <20191014141718.22603-1-narmstrong@baylibre.com>
 <20191014141718.22603-2-narmstrong@baylibre.com> <20191023201141.GA21235@bogus>
 <CA+3zgmsJPsvXgsjDQKKrSG+UNdY3SK+hKCTD2X3hGG+OXejHig@mail.gmail.com>
 <CAKgpwJWU3jB0DWEKE09TOV+YLceBFJ75ZirAXQbuhj8v3FwjXg@mail.gmail.com>
 <c32007f5-88b9-45c5-b542-b1dc4dbc76ea@baylibre.com> <CAKgpwJVHF6Ytdt9kq5SwiixFDLym_UPG51aXag1nVVay0pzofQ@mail.gmail.com>
 <45212db9-e366-2669-5c0a-3c5bd06287f6@synopsys.com> <ce35b6d2-7ed1-be2d-6e38-4c6e89340a40@baylibre.com>
In-Reply-To: <ce35b6d2-7ed1-be2d-6e38-4c6e89340a40@baylibre.com>
From:   Tim <elatllat@gmail.com>
Date:   Tue, 10 Dec 2019 19:45:54 -0500
Message-ID: <CA+3zgmtWQwdJG5NT-t7__Mqt5u_U3m4+HEL6p4PWxx5NES7_AQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc: dt: bindings: usb: dwc3: Update entries for
 disabling SS instances in park mode
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dongjin Kim <tobetter@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just writing to say;
this patch is still performing well on 5.5.0-rc1, and
there is no speed improvement by adding DWC3_GUCTL_NAK_PER_ENH_HS BIT(17)
    I get up to 3890 ms second lag with "ping -s 5120 $IP" when
copying between USB HDDs either way, but at least this patch stops the
crashing.


On Tue, Dec 10, 2019 at 3:55 AM Neil Armstrong <narmstrong@baylibre.com> wr=
ote:
>
> Hi,
>
> On 12/11/2019 21:03, Thinh Nguyen wrote:
> > Hi,
> >
> > Jun Li wrote:
> >> This bug exists on all current versions per information I got from Syn=
opsys.
> >> + Thinh Nguyen <thinhn@synopsys.com>.
> >>
> >> Li Jun
> >
> > The GUCTL1.PARKMODE_DISABLE_SS is only available in dwc_usb3 controller
> > running in host mode. This should not be set for other IPs.
> >
> > This can be disabled by default based on IP, but I recommend to have a
> > property to enable this feature for devices that need this.
>
> Thanks, so this patchset is the right way to solve this.
>
> Felipe, would it be possible to have it merged for next release ?
> Should I resend it ?
>
> Thanks,
> Neil
>
> >
> >
> >>
> >> Neil Armstrong <narmstrong@baylibre.com> =E4=BA=8E2019=E5=B9=B411=E6=
=9C=8812=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:00=E5=86=99=E9=81=
=93=EF=BC=9A
> >>> Hi Li,
> >>>
> >>> On 11/11/2019 02:58, Jun Li wrote:
> >>>> Hi Neil
> >>>>
> >>>> As I got the information from Synopsys, this bug exists on current I=
P versions,
> >>>> and per my tests with external USB3 hub + 2 Super speed udisks on da=
ta
> >>>> read by dd, I can reproduce this issue with different kernel version=
s, also I
> >>>> didn't see obvious performance drop by dd tests after disable park m=
ode for
> >>>> super speed, so should we just disable it by default so no need a qu=
irk?
> >>> I don't have any opinion on this, I think the USB & DWC3 maintainers =
should decide
> >>> how to handle this.
> >>>
> >>> Did Synopsys specified a range of affected IP version ?
> >>>
> >>> Neil
> >>>
> >>>> Li Jun
> >>>>
> >>>> Tim <elatllat@gmail.com> =E4=BA=8E2019=E5=B9=B411=E6=9C=8811=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=888:42=E5=86=99=E9=81=93=EF=BC=9A
> >>>>> Thanks for working on this Neil,
> >>>>> Is there something that needs doing for this patch to make it into =
5.3 or 5.4?
> >>>>> As previously mentioned the patch set fixes the issue on affected h=
ardware;
> >>>>>      https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__patchwo=
rk.kernel.org_patch_11164515_&d=3DDwIFaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3Du9F=
YoxKtyhjrGFcyixFYqTjw1ZX0VsG2d8FCmzkTY-w&m=3DBCfRHM9e86039Su0-QvK_yUjNnYrnl=
_BcvxTtViypT8&s=3DaV5u7uxNX6oTLB3_-qNuzrNvyiqx_rPC6P9TMqG-LNE&e=3D
> >>>>>
> >>>>>
> >>>>>
> >>>>> On Wed, Oct 23, 2019 at 4:11 PM Rob Herring <robh@kernel.org> wrote=
:
> >>>>>> On Mon, Oct 14, 2019 at 04:17:16PM +0200, Neil Armstrong wrote:
> >>>>>>> This patch updates the documentation with the information related
> >>>>>>> to the quirks that needs to be added for disabling all SuperSpeed=
 XHCi
> >>>>>>> instances in park mode.
> >>>>>>>
> >>>>>>> CC: Dongjin Kim <tobetter@gmail.com>
> >>>>>>> Cc: Jianxin Pan <jianxin.pan@amlogic.com>
> >>>>>>> Reported-by: Tim <elatllat@gmail.com>
> >>>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >>>>>>> ---
> >>>>>>>   Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
> >>>>>>>   1 file changed, 2 insertions(+)
> >>>>>> Sigh, what's one more to the never ending list of quirks...
> >>>>>>
> >>>>>> Acked-by: Rob Herring <robh@kernel.org>
> >
> > BR,
> > Thinh
> >
>

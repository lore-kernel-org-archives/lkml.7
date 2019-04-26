Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F43FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BE0214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556300728;
	bh=TJ9Ao1gs7rboatKj0SDIWvYfHAvad3BH3lbXj244RBc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MHYcfSMDfmDJzvN+x7CzygKU1b4EUAUHSY09eZgDzbHfeM9ueKyL38VNVTWnLZF+H
	 fRciX+WLA0N6gOthXn8YN3jDuRJ6HiYUX+gjNhkWTMvFm9riC5uk3FsPvLapp+g7TF
	 j7bihnlIyEPzTjx2dk1mp1eZn3eu+48O7kKdTpR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDZRp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfDZRp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:45:26 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FF7D214C6;
        Fri, 26 Apr 2019 17:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556300725;
        bh=TJ9Ao1gs7rboatKj0SDIWvYfHAvad3BH3lbXj244RBc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TbHi5QoWcFd132aTWvqI4L9De/6u1TcQmyhQJqClEs+lkH4xfLZfMCYDyTVQ6qJC8
         syKGdl5O1Rute4fTl9abClJc/Y5E+i8bi35zDZ4WHmLA//DUMSpYn+YTB6aWM+htxn
         1jgmXT3n+bhhqDahRW7WPusoYbfofTucCYJKJ+Uo=
Received: by mail-qt1-f181.google.com with SMTP id b3so4981928qtc.12;
        Fri, 26 Apr 2019 10:45:25 -0700 (PDT)
X-Gm-Message-State: APjAAAUKRqAh5iADCyB5pDspIhzgj1c+MVREmMVncJH+CYHRIFadLvJZ
        H2fxydm585e55eJHOz+OrIau1KUIoQ3QHLnCsA==
X-Google-Smtp-Source: APXvYqykkGdyDAIhYDVs+O8Z15OaGvMDo5X0PHkNH1tYzfoRLO6wxp8WXJMZ66oEHyunou7CmZc9FFKXd/4T/E4LEBk=
X-Received: by 2002:a0c:fe65:: with SMTP id b5mr11141066qvv.106.1556300724826;
 Fri, 26 Apr 2019 10:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <1554368908-22017-2-git-send-email-rjliao@codeaurora.org>
 <1554888476-17560-1-git-send-email-rjliao@codeaurora.org> <A85D7982-E000-4A5F-9927-CA36E0BA60F2@holtmann.org>
 <7e0cf9ba98260309c43d9d6e63dead6c@codeaurora.org>
In-Reply-To: <7e0cf9ba98260309c43d9d6e63dead6c@codeaurora.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 26 Apr 2019 12:45:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLnM4XqQTCT7VTUSmukujz0VHJoCbXMF2--RmTEx_LZww@mail.gmail.com>
Message-ID: <CAL_JsqLnM4XqQTCT7VTUSmukujz0VHJoCbXMF2--RmTEx_LZww@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: net: bluetooth: Add device property
 firmware-name for QCA6174
To:     Rocky Liao <rjliao@codeaurora.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Thierry Escande <thierry.escande@linaro.org>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 1:19 AM Rocky Liao <rjliao@codeaurora.org> wrote:
>
> On 2019-04-24 01:06, Marcel Holtmann wrote:
> > Hi Rocky,
> >
> >> This patch adds an optional device property "firmware-name" to allow
> >> the
> >> driver to load customized nvm firmware file based on this property.
> >>
> >> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
> >> ---
> >> Changes in v3:
> >>  * added firmware-name instead of nvm-postfix to specify full firmware
> >> name
> >> ---
> >> Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 2 ++
> >> 1 file changed, 2 insertions(+)
> >>
> >> diff --git
> >> a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> >> b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> >> index 824c0e2..2bcea50 100644
> >> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> >> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> >> @@ -16,6 +16,7 @@ Optional properties for compatible string
> >> qcom,qca6174-bt:
> >>
> >>  - enable-gpios: gpio specifier used to enable chip
> >>  - clocks: clock provided to the controller (SUSCLK_32KHZ)
> >> + - firmware-name: specify the name of nvm firmware to load
> >>
> >> Required properties for compatible string qcom,wcn3990-bt:
> >>
> >> @@ -39,6 +40,7 @@ serial@7570000 {
> >>
> >>              enable-gpios =3D <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
> >>              clocks =3D <&divclk4>;
> >> +            firmware-name =3D "nvm_00440302.bin";
> >>      };
> >
> > and how is this a firmware-name property. Wouldn=E2=80=99t this be more=
 like
> > nvm-file or something along these lines. This really needs to be
> > cleared with Rob to pick the right property name.
> >
> > Regards
> >
> > Marcel
>
> Hi Rob,
>
> Are you OK to use a property name "nvm-file" or "firmware-nvm-file"?
> Actually we have two firmware files, one is the patch file which is
> common to all of the products, the other is the nvm file which is
> customized. Using a "nvm-file" or "firmware-nvm-file" property name
> would be more clear.

'firmware-name' is the standard name for specifying firmware file names.

Rob

Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14100C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 19:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FDB216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 19:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="WN7NuAaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfIJTzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 15:55:50 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:23045 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfIJTzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 15:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1568145347;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=WxqDhzcq2Vhf3INWGftclzNNw6AbVzaPRM8d+dqsysw=;
        b=WN7NuAaAyjHYq6QBQCWizQgc/QQp1fP3rGswpQMl+8LIxoYIB1luZC5JHPZZtlBbYn
        J0qovQmTGJ+w3yYEB1XWSLEnZDQrDl2AEVFD5klkzZlz1+oTzsZHjQNomclYZMSTu6gy
        vmDXmD/NJSaybRH6o+5PFz0jTmFZQ3rLhe1rHt2RSqJQ01IMZ/OwtPiLkRnmc3Ljcr37
        4N/XIKfWu0UdhdGdGntLqsGLNX+S5GjEoU6sLpd09vM7IrGpNpw6reqwr98Xnai7nq+1
        O7l7Z5WPIXUAU3blvt9KKhMp433ZCCjIlMxv02PteUsDIgbDoBId6dR4rhuHWnAj/lXv
        QK9Q==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/PhwDWsEw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v8AJtX3b6
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 10 Sep 2019 21:55:33 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] [RFC PATCH 0/3] Enable 1GHz support on omap36xx
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <56482888-DBD3-4658-8DB9-FB57653B5AA8@goldelico.com>
Date:   Tue, 10 Sep 2019 21:55:32 +0200
Cc:     Tony Lindgren <tony@atomide.com>,
        =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Nishanth Menon <nm@ti.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2DC3BCD1-BD61-4109-9AF3-04FBD980FFB8@goldelico.com>
References: <C04F49BA-1229-4E96-9FCF-4FC662D1DB11@goldelico.com> <CAHCN7x+Ye6sB_YqO0sAX1OJDw64B-qGS3pL545v3Xk5z914cwQ@mail.gmail.com> <0C1EF64E-B33C-4BFA-A7D3-471DD1B9EE86@goldelico.com> <515048DE-138D-4400-8168-F2B7D61F1005@goldelico.com> <CAHCN7xLPCX9rZ0+7KVBiA_bgZ6tg6VeCXqD-UXu+6iwpFMPVrA@mail.gmail.com> <7B3D1D77-3E8C-444F-90B9-6DF2641178B8@goldelico.com> <CAHCN7xLW58ggx3CpVL=HdCVHWo6D-MCTB91A_9rtSRoZQ+xJuQ@mail.gmail.com> <FA2920FE-B76A-4D44-A264-862A1CCBF7FC@goldelico.com> <CAHCN7xJsPa0i+Z+qpCkWcdAh9+udmGT0RPNchdDsfB=8ptd3Nw@mail.gmail.com> <87420DBD-770F-4C32-9499-A3AEA5876E8A@goldelico.com> <20190909163236.GP52127@atomide.com> <E001F74D-724E-4C50-9265-CBD33C4F2918@goldelico.com> <F8F08882-8011-441C-9581-ECCE9772EC21@goldelico.com> <CAHCN7x+fgtMHMNYU2W7BRQwd-d2g_Tb8-L5QNcnZjCF=VzRXJg@mail.gmail.com> <3663B13C-1AAB-4BE3-8CAD-F821B70393FA@goldelico.com> <CAHCN7x+mLCNq4evwGZfk6Ka=3o6EzhL=s38aNdukyLwKB1xO7A@mail.gmail.com> <56482888-DBD3-4658-8DB9-FB57653B5AA8@goldelico.com>
To:     Adam Ford <aford173@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,

> Am 10.09.2019 um 20:51 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
>>>> it, but then I got some nasty errors and crashes.
>>>=20
>>> I have done the same but not (yet) seen a crash or error. Maybe you =
had
>>> a typo?
>>=20
>> Can you send me an updated patch?  I'd like to try to get where you
>> are that doesn't crash.
>=20
> Yes, as soon as I have access.

it turns out that my patch breaks cpufreq completely...
So it looks as if *I* have a typo :)

Hence I am likely running at constant speed and the
VDD1 regulator is fixed a 1.200V.

root@letux:~# dmesg|fgrep opp
[    2.426208] cpu cpu0: opp_parse_supplies: Invalid number of elements =
in opp-microvolt property (6) with supplies (1)
[    2.438140] cpu cpu0: _of_add_opp_table_v2: Failed to add OPP, -22
root@letux:~# cat /sys/class/regulator/regulator.8/microvolts=20
1200000
root@letux:~#=20

The error message looks as if we have to enable multi_regulator.
And that may need to rename cpu0-supply to vdd-supply (unless the
names can be configured).

BR,
Nikolaus


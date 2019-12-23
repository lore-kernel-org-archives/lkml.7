Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9240AC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 12:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A98920709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 12:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="OQN4lxiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfLWMoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 07:44:12 -0500
Received: from mout.web.de ([212.227.17.12]:45661 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfLWMoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 07:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1577105025;
        bh=uEz+xJ+1PnkNaQn/rWPFbwbuIFzvyLJLoC+/RZkWt/M=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=OQN4lxiC+Ba0uUSjbbZXPbEuXgpqHhs0leMCyc+nUMChpc07VeiOz8RZy8cBLTdAy
         hyPYjMSxQFZrm5ituAxHaekZdbr1rmaDYcc1+Xbn+rw5XnyqtDxDOiHdw85XXalerm
         X8/OEvhH38TaL0BctjfPNe0fRIjsZwWf8ebuo97M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.136.132]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lba7D-1jUEDC0Z8l-00lHak; Mon, 23
 Dec 2019 13:43:45 +0100
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20191220000923.9924-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH] clocksource/drivers: Fix something in
 ttc_setup_clockevent and ttc_setup_clocksource
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Message-ID: <7c19ab65-9d11-0e5b-ab53-b4e968d1ae95@web.de>
Date:   Mon, 23 Dec 2019 13:43:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191220000923.9924-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uMsES8HUB/234qTw9RBTqbYwaZOVC9JdX1rYS6W2AdTI6/hS+TF
 RkEI59/ov2c9SrRrdV0eoIgaV+HTaCXtaNwmx7NmnIqoMjIyq6/wZnLA53xzWC3Sq14XVM4
 yIVujQBKwrqvGAe408eyFmgUz2HSFcCYBQqOPDeAkipG+WX14Xwj6bP95N0lKactkWaJjlT
 ATNWeiFDPSTgGNEQqJsKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RKcnp1yU5Mg=:fhoOUHUPdh83S8JGuB0Hx+
 drP+a27WBLLaiXMpBZhLlaoOkARYTai3FxaGR7kDEnIps2/wfLXJVAjOZwzd9lu5caFWOTiED
 oYER3eNfHLrvi323KS4QN0bcQebnYGlpCrYVN6heXY9h9dA+JaMfZ4dVOEtlz0W96JXS1xHEy
 FteH9XJgQLpZZLontGuG7p/6vdosXLBeGtNOetYL/A9zcrF15MmEEaenVjCqnyEcifMp9S3pB
 b7f4x3Au/iTii/TApe+R53uaRjE+0kFrzPEl4g12QAb+xT/68KYzUTUGETkdo17wETUOX3ryx
 +mpHr4riypC9WpMksB31ymyhCJMtbKna53576704urvXkoAQcSUqnmhvmAMpbu5HAN5QF3m8O
 KbMJCcQGa6pS70qsS45RYfW4Mv7eTbJ+LQGrG19j08HfkUFGmMqG47JnDnkFoyMkjRLVpWPzR
 KP/k8Eh3OdJRHyzql5fOBhuAQwVZnfOZM9W5jQS3j8v16gOcF8yjQ5Sp5P6XYJcEWlsatTnSj
 7P0qYBL9DL+w+gzDf27GaIyxJhtJon13vTAS1lmdB9f9z0g2oBHhn9BeeTA4Vd+xoEtMY/B2R
 L/yhdqjt1aEg5phAtwIzlGx1O+DRiKpb2DXzZUS6B7cY3VphmP5TdIRR5oAcFIUEJtvkMYumU
 i4K2MzCeDqAfbfsPdpDSzQU47davJuH0zQrovyk6XpfJweH3NPv5nciQe+oxYD0GflSTFy8XN
 sSh10bAayaFmxHwsTj0mnzz03mx57TcLI9o6krvLJ1jQkQLSjV6rLE6Sc+HRFY5kDlfwkiaHy
 rbNFqhlpBPCv8seQHFlOIwNvWTmc7x9GXCg0ZMbs/8VRoAE4KB/Zb1jIU56wGbtFVeLmwuGww
 VcSnRQXM4NLqJVtBycqmvsIeoJ+gQqAyX91EpMMPZSDcaBadUsuyEHQ6xH0F0j9BucVMUIgQ4
 j8CtGxQL64JVRpnZzKo1dVch4U66tGwiJA3xEHca7SmGFAOVYuIXkWtrtAhd5hgh9S2TzLacX
 jt67RtKEYoY0RDy7Z64YNQ8jIu/lVvRh31rcA7pO05DxohQeb4Xz2z+xCc0Xr3tU137tjneZ7
 eUOvbfBgyUkWJovWOflVY3pIGXjPFOPB+sBL9SWAcsIUJlIE85jWMhb2exmNphLPgbJ7oiu8X
 G4tahy6EYZahACVTfZLxilNn+d9BVqlG/F9JTpOwUDqlPdPZwN+ISwFWDpNtO+IspuVT5RI6A
 z7RA/kuehKu3djW4s6oasxoMHesTvdRs3Ut0NvJuFECTwb4SOjcJrttolQKo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In the implementation of ttc_setup_clockevent() and
> ttc_setup_clocksource(), the allocated memory for ttccs is leaked when
> clk_notifier_register() fails.

I suggest to correct your commit message.


> Use goto to direct the execution into error handling path.

* Should the desired completion of the exception handling be described
  by an other wording?

* Will it be better to improve the affected functions by
  separate update steps?

* How do you think about to add the tag =E2=80=9CReported-by=E2=80=9D for =
Michal Simek?
  https://lore.kernel.org/linux-arm-kernel/2a6cdb63-397b-280a-7379-740e8f4=
3ddf6@xilinx.com/


=E2=80=A6
> +++ b/drivers/clocksource/timer-cadence-ttc.c
=E2=80=A6
> @@ -363,16 +363,20 @@  static int __init ttc_setup_clocksource(struct cl=
k *clk, void __iomem *base,
=E2=80=A6
>  	return 0;
> +
> +release_ttcce:
> +
> +	kfree(ttcce);
> +	return err;
=E2=80=A6

* Please omit a blank line after the label.

* Is there a need to call the function =E2=80=9Cclk_disable_unprepare=E2=
=80=9D
  by another jump target?

Regards,
Markus

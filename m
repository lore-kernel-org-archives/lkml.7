Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEF8C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6632F2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560265040;
	bh=PDMT40Esdo8UkFki3UsNcPeLwMVn2sjMM5JVniOL9yM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uj+1/0fVMOnal0DhYx3DaMwIu3svQ8CE+RKOzdDbTh1KT2T6DMnuadRGmIdz4vBCo
	 K/pXf9r6jgfdD3rRg4XSsNaSum3nNxKEZkQCVKO8hNYlc6za4lm9lnes8osHkR6982
	 vIK2lMAw05xm4rbVd08Oyn/aBuAYuLC3IjhoHqCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfFKO5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbfFKO5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:57:19 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6658F21744;
        Tue, 11 Jun 2019 14:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560265037;
        bh=PDMT40Esdo8UkFki3UsNcPeLwMVn2sjMM5JVniOL9yM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nu5wxM+HHrfkCtF1x7Or3Pfim08FfQSDgXG4CQD+Rc2l6fNTBFaPzIY/2oXtvKbaN
         Xd2X+N0unRik84mrPZ5Wsm9KbLaZ3hB029Qef3sj2yLkRboL3jfNPIyy7ePHxgCGaw
         lNfiD7EMj7AL+FTtGDAmI6iFUX19qQ1GOmATJvOo=
Received: by mail-qt1-f181.google.com with SMTP id p15so7473511qtl.3;
        Tue, 11 Jun 2019 07:57:17 -0700 (PDT)
X-Gm-Message-State: APjAAAV1uWddM6YE7IIgAHlYvUIi6DxNUlLJ44rKVli56JkJB+vkQ3fo
        9phEQQ6MCLddcQWH5s1yFFxs1alJFWo5+9Lhyw==
X-Google-Smtp-Source: APXvYqwKXudcUIloIxvnM9Z3TUTq2TYTbIEqBlR3HwB9Ltpy5J5xKf3f0bzDLgxra6FePQCRpDyY/kcLrLWZl6w7kAo=
X-Received: by 2002:a0c:acef:: with SMTP id n44mr5105568qvc.39.1560265036455;
 Tue, 11 Jun 2019 07:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190521145141.9813-1-paul@crapouillou.net> <20190521145141.9813-4-paul@crapouillou.net>
 <20190524202103.GA15650@bogus> <1558811596.2016.1@crapouillou.net>
In-Reply-To: <1558811596.2016.1@crapouillou.net>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Jun 2019 08:57:04 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+ZhoW9xM_7-7CcCm2RKRbMRzmXD-oEMfoVkvcaAFxGug@mail.gmail.com>
Message-ID: <CAL_Jsq+ZhoW9xM_7-7CcCm2RKRbMRzmXD-oEMfoVkvcaAFxGug@mail.gmail.com>
Subject: Re: [PATCH v12 03/13] dt-bindings: Add doc for the Ingenic TCU drivers
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, od@zcrc.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 1:13 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
>
>
> Le ven. 24 mai 2019 =C3=A0 22:21, Rob Herring <robh@kernel.org> a =C3=A9c=
rit :
> > On Tue, May 21, 2019 at 04:51:31PM +0200, Paul Cercueil wrote:
> >>  Add documentation about how to properly use the Ingenic TCU
> >>  (Timer/Counter Unit) drivers from devicetree.
> >>
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  ---
> >>
> >>  Notes:
> >>      v4: New patch in this series. Corresponds to V2 patches 3-4-5
> >> with
> >>       added content.
> >>
> >>      v5: - Edited PWM/watchdog DT bindings documentation to point to
> >> the new
> >>         document.
> >>       - Moved main document to
> >>         Documentation/devicetree/bindings/timer/ingenic,tcu.txt
> >>       - Updated documentation to reflect the new devicetree bindings.
> >>
> >>      v6: - Removed PWM/watchdog documentation files as asked by
> >> upstream
> >>       - Removed doc about properties that should be implicit
> >>       - Removed doc about ingenic,timer-channel /
> >>         ingenic,clocksource-channel as they are gone
> >>       - Fix WDT clock name in the binding doc
> >>       - Fix lengths of register areas in watchdog/pwm nodes
> >>
> >>      v7: No change
> >>
> >>      v8: - Fix address of the PWM node
> >>       - Added doc about system timer and clocksource children nodes
> >>
> >>      v9: - Remove doc about system timer and clocksource children
> >>         nodes...
> >>      - Add doc about ingenic,pwm-channels-mask property
> >>
> >>      v10: No change
> >>
> >>      v11: Fix info about default value of ingenic,pwm-channels-mask
> >>
> >>      v12: Drop sub-nodes for now; they will be introduced in a
> >> follow-up
> >>               patchset.
> >
> > Why? I believe I acked them.
>
> The patchset was too big, and I've already been trying to get it
> upstream for
> more than one year now. So I cut it in half in hope that it'll be
> easier to
> upstream it that way.

You can drop the driver part and keep the binding. Unlike drivers, we
don't want bindings to needlessly evolve, and you don't have to wait
til a driver implements some functionality to add that to the binding.

Rob

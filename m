Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE4FC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6DA2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbfHONRV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:17:21 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:4217 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731747AbfHONRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:17:21 -0400
IronPort-SDR: CZqAmgBqt90rwvWsRi5vb1fTTKYZGxvJ8oRExRKJmAhQ5naPKaZRbd3x2eRSL8ttmHc9JNHtWf
 cMeQrgsoDf1/NfvWXi4sJYwoAUJFAtafVEyG06KKfrj6xa2B/6YJrhgMffLzO0DAZfOeC4QsKZ
 0N4dDOjx9lcDlyFNP2Nb5/k8AtQOve2z93CvUJzBpuMmNZgPZZU5f7tduxfoZEsrrC4qS0ykW/
 snBWW7ge4GdPY+vGRBDfBFHkyt1ZgycdoWEZ8+huNq949KuAhVaPPwY6fz9XsOeD9VsLu8yg8B
 oNI=
X-IronPort-AV: E=Sophos;i="5.64,389,1559548800"; 
   d="scan'208";a="40459753"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 15 Aug 2019 05:17:07 -0800
IronPort-SDR: SpxPcx9utDYLec0NRy33av/mbpCMPViEgzxb2qwobB+PebuBH/m1zx6KKp/ZKyjsHqT7Z1DNMi
 fpTU6iUVS3viYdAGY/2fbxzVRQnnfp60Wbl2Up/BHwV5c3HpF361gDMv9YJ6JJdypjliG6O/Sq
 uWjLV7NKvapZ8aiO0GFyqzC1KJx7RPLGrqC1OSoMQzv6wh/QnWNWZxna3Kb7NRKSvLVmAFnIMs
 4F9xPfYCrx8JSnjT9eyBRie9IyRBkW9c8zXJHPeV/fH6Ts57T2xWCxRAg3lPHmnaFWYeFxDh3Z
 HpI=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     Wei Yang <richard.weiyang@gmail.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "richardw.yang@linux.intel.com" <richardw.yang@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: AW: [PATCH v2] kernel/resource.c: invalidate parent when freed
 resource has childs
Thread-Topic: [PATCH v2] kernel/resource.c: invalidate parent when freed
 resource has childs
Thread-Index: AQHVUq5kcb5Ex7JpNUSktSjVjdFue6b6xMYAgAEUHnCAAESkAIAAERsQ
Date:   Thu, 15 Aug 2019 13:17:01 +0000
Message-ID: <ff78412f81494678bb7685dc2604002e@SVR-IES-MBX-03.mgc.mentorg.com>
References: <1565278859475.1962@mentor.com> <1565358624103.3694@mentor.com>
 <20190809223831.fk4uyrzscr366syr@master>
 <CAHk-=wi_9sdMxurjZ1MbNnxt-pA=dqoyf8Fdn9aYc8xvjjnTBg@mail.gmail.com>
 <1565794104204.54092@mentor.com> <20190814162932.alwo7g4664c2dtp3@master>
 <c925c7d1041f478c99863da56c24b8a7@SVR-IES-MBX-03.mgc.mentorg.com>
 <20190815130328.yk4cybuuqnzb7xrx@master>
In-Reply-To: <20190815130328.yk4cybuuqnzb7xrx@master>
Accept-Language: de-DE, en-IE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> My gut feeling is this is the problem from mal-functional driver, e.g.
> xhci-hcd. We do our best to protect core kernel from it instead of do the
> cleanup for it.
Agree.
My intention wasn't to fix mal-functional driver, but to give it a hint
that it's doing something wrong.
(In the xhci-hcd case the patch indirectly avoids the later use-after-free in driver,
 a nice side effect here)

I think the same what Linus meant with
> I'm less interested in the xhci-hcd case - which I certainly *hope* is
> fixed already? - than in "if this happens somewhere else".
What about giving only a WARN_ONCE?
Wouldn't hurt but notice developers and ease bug hunting.
Would be fine for me too.
Finally, i also could put the patch in a private branch named "useful_patches" ;-)
but then the community won't benefit.

> 
> So my suggestion is to look into why xhci-hcd behave like this and fix that.
> 
xhci-hcd fix proposal @ Hans de Goede already.

Best regards
Carsten

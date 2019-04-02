Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265F5C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C692E2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="jeTwV6Yd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfDBFFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:05:53 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:27828 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfDBFFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 01:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554181547;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=FNYwP7Zv7y+3500OsnlC6XAhjEzCy7DHrALkRcEE/18=;
        b=jeTwV6Yd8BOYBvyyHy3A5nuRJczJ5vTVK8UvgkVkOdjEFf3vvi54VfUcyuaBHxzYbU
        hnQvOw0Wq5w1O7Fe8oyIbK7KFWFHLfHGm+1O+G0cVWTXkLX7aWs5pjrW2mhEwOGMtV+e
        RZH7PZKk9iaLgDUprnqpo8XQ46CEsEDAORg2Ejgoo29IPEFKCDaMT87N46ccIIwODHj2
        tgE/a8/ax2XBXaE8pOYFE8GqZtgn1Oqfk0q1hmodnMc0wlkJT18qI3rpRty4qx+HUamj
        BJFkDJDZIRcL0ATy+5D1rirAhBnwsKBE3bWgvtlVEbqjizS1dJx3HMfOON1JH5XWYe3G
        GRZQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDVCUXA0Jq+U="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id K07648v3255ZfMB
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 2 Apr 2019 07:05:35 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [BUG] gpiolib: spi chip select legacy support breaks modern chip select and whitens the GTA04 LCD panel
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CACRpkda4k_Vaoo1qEaZ3nv8bA4tcrPEN6oT-v+n9HRdA6=5Xvg@mail.gmail.com>
Date:   Tue, 2 Apr 2019 07:05:35 +0200
Cc:     Kumar Gala <galak@codeaurora.org>,
        Wolfgang Ocker <weo@reccoware.de>,
        Jan Kotas <jank@cadence.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2D2D13C2-0D3E-47CD-946B-81DBBF3C43E6@goldelico.com>
References: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com> <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com> <CACRpkdb4URKcdZ-=3aG_np86Bp=1ahs+qztM-7yQkSP18ZkE6A@mail.gmail.com> <2286C331-4AFC-46A9-B8C4-8A8BA9CD33C2@goldelico.com> <CACRpkda4k_Vaoo1qEaZ3nv8bA4tcrPEN6oT-v+n9HRdA6=5Xvg@mail.gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

> Am 02.04.2019 um 06:02 schrieb Linus Walleij =
<linus.walleij@linaro.org>:
>=20
> (CC Kumar and Wolfgang who came up with spi-active-low, I think.)
>=20
> On Sun, Mar 24, 2019 at 1:56 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>> Am 24.03.2019 um 05:15 schrieb Linus Walleij =
<linus.walleij@linaro.org>:
>=20
>>> But I fixed it in that case by introducing a spi-cs-high into the =
DTS file:
>>> https://marc.info/?l=3Dlinux-arm-kernel&m=3D155292310015309&w=3D2
>>=20
>> Yes, that of course works and is our temporary solution.
>>=20
>> And I see that you also have it on the controller node and not the =
slave node.
>=20
> Yes I git it wrong, the slave should have it and another bug of mine
> made it look at the controller not (some days I should not write
> code in paths that do not get executed).
>=20
>>> I'm sorry about that, however if you look at the DT binding =
document:
>>> Documentation/devicetree/bindings/spi/spi-bus.txt
>>=20
>> Shouldn't it be a property of the slave node and not the controller =
node?
>=20
> Indeed.
>=20
>>> You will see that spi-cs-high is mandatory. So these DTS files are
>>> incorrect.
>>=20
>> How do you read that it is mandatory from
>>=20
>> "All slave nodes can contain the following optional properties:
>> - spi-cs-high     - Empty property indicating device requires chip =
select
>>                    active high."
>>=20
>> I read it as optional and indicative. Equal priority to cs-gpios.
>=20
> The basic problem is that spi-cs-high is defined negatively,
> so by default a CS GPIO is active low. This clashes with the
> default GPIO flag, as GPIO_ACTIVE_HIGH is zero, no flag,
> and thus the default if nothing is specified, so if the GPIO flag is
> zero it should be active high, but if "spi-active-high" is not on the
> slave node it should be active low, so one of them have
> to win, they can't both win.
>=20
> I'd say that spi-cs-high existed before we standardized the GPIO
> flags in the DT bindings. So people were relying on it for years =
before
> we came up with the ACTIVE_HIGH/LOW flags.
>=20
> commit f618ebfcbf9616a0fa9a78f5ecb69762f0fa3c59
> Author: Wolfgang Ocker <weo@reccoware.de>
> Date:   Wed Oct 15 15:00:47 2008 +0200
>=20
>    of/spi: Support specifying chip select as active high via device =
tree
>=20
>    The patch allows to specify that an SPI device needs an active high =
chip
>    select.
>=20
>    Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
>    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>=20
> While the GPIO binding turns up 5 years later:
>=20
> commit 71fab21fee07fd6d5f1a984db387cc5e4596f3fa
> Author: Stephen Warren <swarren@nvidia.com>
> Date:   Tue Feb 12 17:22:36 2013 -0700
>=20
>    ARM: dt: add header to define GPIO flags
>=20
>    Many GPIO device tree bindings use the same flags. Create a header =
to
>    define those.
>=20
>    Signed-off-by: Stephen Warren <swarren@nvidia.com>
>    Acked-by: Rob Herring <rob.herring@calxeda.com>
>=20
> And then this guy think it is a good idea to standardize this for
> all GPIO phandles two years later:
>=20
> commit 69d301fdd19635a39cb2b78e53fdd625b7a27924
> Author: Linus Walleij <linus.walleij@linaro.org>
> Date:   Thu Sep 24 15:05:45 2015 -0700
>=20
>    gpio: add DT bindings for existing consumer flags
>=20
>    It is customary for GPIO controllers to support open =
drain/collector
>    and open source/emitter configurations. Add standard GPIO line =
flags
>    to account for this and augment the documentation to say that these
>    are the most generic bindings.
>=20
>    Several people approached me to add new flags to the lines, and =
this
>    makes sense, but let's first bind up the most common cases before =
we
>    start to add exotic stuff.
>=20
>    Thanks to H. Nikolaus Schaller for ideas on how to encode =
single-ended
>    wiring such as open drain/source and open collector/emitter.
>=20
>    Cc: Tony Lindgren <tony@atomide.com>
>    Cc: Grygorii Strashko <grygorii.strashko@ti.com>
>    Cc: H. Nikolaus Schaller <hns@goldelico.com>

Yes, I remember to help with the open drain/collector definition :)

>    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

>=20
>>> This does not work because there are devices that requires =
spi-cs-high to be
>>> respected and the DTS second cell GPIO flag to be ignored.
>>=20
>> Then, those should be fixed...
>=20
> This can't be done because some old systems (mostly powerpc)
> added between 2008-2013 do not know about GPIO flags and
> have DTBs deployed in firmware that need to keep working.
> They cannot be fixed.


The question is if it is even possible to deploy a new kernel
for such devices and if anyone wants to do...

This also gives another idea: make it depend on "powerpc".

>=20
>>> They might have deployed DTB binaries that need to keep working,
>>=20
>> Well, that is a weak argument. What if the GTA04 would have the DTB =
in FLASH
>> and would need it working (fortunately we always reflash kernel + =
dtbs)?
>=20
> Usually the definition I use for "deployed DTB" is not
> "deployed on my desk" but "deployed by a factory" i.e. someone
> producing millions of TV sets or something. For example my monitor
> is using a PowerPC CPU and has one of these DTBs in flash,
> and expect it to keep working if I upgrade the kernel separately.

Ok, I see.

We basically have the same (devices deployed to unknown users), but
we can and do flash kernel + dtb in parallel so it is easier in our
case.

>=20
>> BTW, on which node do these invariable DTBs have the spi-cs-high =
flag?
>> In the controller node (IMHO wrong) or the slave node (according to =
bindings doc)?
>=20
> Slave node I hope, the controller thing was just one of my stupid
> mistakes.
>=20
>> I have checked with randomly picked imx51-babbage.dts and it has it =
in the
>> slave node (pmic: mc13892@0). It also seems to be an example where =
different
>> CS lines want different settings.
>=20
> I'm afraid the consumers of the old powerpc DTS files are not even
> maintained inside the Linux kernel, as we sometimes assume. Those
> were created and dispersed by vendors at a time when it was assumed
> it was OK to maintain your DTS files somewhere out there on the
> side (some people still hold this opinion, I don't).
>=20
>>> I think in this case the oldest binding wins.
>>=20
>> Ok, it is the question when such deprecated things are really =
removed.
>> There is no clear answer...
>=20
> I think the DT bindings people would say never. They are deprecated
> but they can never stop working. I guess in theory you could try to
> figure out when the last piece of equipment using the old binding and
> ever wanting a FW update stops working. That seems hard, but I don't
> know much about these powerpc systems.

>=20
> That is the reason why I try to contain these weirdness things inside
> gpiolib-of.c rather than out amongst the different subsystems, so I =
can
> have it under control.

>=20
>>> I think you simply have to patch these GTA04 DTS files to use
>>> spi-cs-high.
>>=20
>> Ugly... Well, if DTS maintainers accept that?
>=20
> I suppose.
>=20
>> What about a CONFIG to explicitly enable/disable this legacy support?
>>=20
>> IMHO it will need to be enabled for les than 1% of the kernel builds =
and
>> therefore also keeps the zImage smaller for all others. And avoids =
DTB
>> changes where the gpio flags are already correct.

First of all, the new patch checking for presence of cs-gpios works for =
us!

So we are fine with upstream v5.1-rc3 on our devices and do not need to
"fix" the DTS.

>=20
> Dunno about this, it looks fragile, I would prefer to keep all =
working.
> But I will listen to reason.

Reason why I propose a CONFIG option is:

if someone is able to compile and deploy a v5.1 kernel for some device =
which
has (old) and problematic DTB in ROM he/she must have access to the =
.config.
So it is easy to modify it to enable legacy handling of spi-cs-high. And =
keep
it disabled for all others.

That is the idea I have casted into my

	"[BUG/PATCH 3/4] gpiolib: make legacy handling for spi-cs-high =
optional"

sent separately. Maybe there is a better solution (e.g. replace =
SPI_MASTER
by SPI_LEGACY_MASTER or similar).

>=20
> I have thought about using of_machine_is_compatible("vendor,foo")
> in gpiolib-of.h to whitelist some systems that will just use the
> new way, or reversely blacklist some old systems that have to use the
> old syntax. What do you think about this?

This would just automate modifying .config for a specific board. By =
adding
runtime code for everybody.

And it gives you the burden to collect all new "vendor,foo" strings =
every
now and then, instead of having "vendor" change some .config when =
building
a kernel image for "foo", especially for out-of-tree devices.

Since it requires help from vendors anyways (those would have to supply =
the
"vendor,foo" to you, you can maybe easier ask them to change their =
CONFIG.

For DTS of In-tree devices you could IMHO simply replace spi-cs-high by =
the
correct gpio flags so that there is no use of it in kernel.org any more
and nobody is tempted to use it as an example...

BR and thanks,
Nikolaus


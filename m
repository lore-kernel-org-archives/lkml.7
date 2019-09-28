Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2482C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 09:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825A720862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 09:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfI1JXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 05:23:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48209 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfI1JXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 05:23:42 -0400
Received: from p200300d06f16eff20347f9711eb7065e.dip0.t-ipconnect.de ([2003:d0:6f16:eff2:347:f971:1eb7:65e] helo=linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt.kanzenbach@linutronix.de>)
        id 1iE8wy-0006UX-Qb; Sat, 28 Sep 2019 11:23:36 +0200
Date:   Sat, 28 Sep 2019 11:23:31 +0200
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] dt/bindings: Add bindings for Layerscape external
 irqs
Message-ID: <20190928092331.GB1894@linutronix.de>
References: <20190923101513.32719-1-kurt@linutronix.de>
 <20190923101513.32719-3-kurt@linutronix.de>
 <20190927161118.GA19333@bogus>
 <f63da257-95b4-bcb8-9ba4-9786645caf26@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <f63da257-95b4-bcb8-9ba4-9786645caf26@prevas.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2019 at 09:16:50PM +0000, Rasmus Villemoes wrote:
> On 27/09/2019 18.11, Rob Herring wrote:
> > On Mon, Sep 23, 2019 at 12:15:13PM +0200, Kurt Kanzenbach wrote:
> >> +Required properties:
> >> +- compatible: should be "fsl,<soc-name>-extirq", e.g. "fsl,ls1021a-extirq".
> >> +- interrupt-controller: Identifies the node as an interrupt controller
> >> +- #interrupt-cells: Must be 2. The first element is the index of the
> >> +  external interrupt line. The second element is the trigger type.
> >> +- interrupt-parent: phandle of GIC.
> >> +- reg: Specifies the Interrupt Polarity Control Register (INTPCR) in the SCFG.
> >> +- fsl,extirq-map: Specifies the mapping to interrupt numbers in the parent
> >> +  interrupt controller. Interrupts are mapped one-to-one to parent
> >> +  interrupts.
> >
> > This should be an 'interrupt-map' instead.
>
> Rob, thanks for your review comments. I know you said the same thing at
> v5, and it might seem like they are ignored.

Well, I didn't ignore them. It just wasn't clear to me from the previous
discussions which way you want to go.

> However, I asked a couple of followup questions
> (https://lore.kernel.org/lkml/0bb4533d-c749-d8ff-e1f2-4b08eb724713@prevas.dk/).
> I'd really appreciate it if you could (a) point to some documentation
> on how to write that interrupt-map and (b) explain how this is
> different from the Qualcomm PDC case I tried to copy and which had
> your Reviewed-By.

I guess, we can have a look at other interrupt controllers and how they
handle the interrupt-map property. For example:

 https://www.kernel.org/doc/Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.txt

I need to send a v7 anyway, because I forgot to include the SOC_LS1021A
in the build process.

>
> >> +
> >> +Optional properties:
> >> +- fsl,bit-reverse: This boolean property should be set on the LS1021A
> >> +  if the SCFGREVCR register has been set to all-ones (which is usually
> >> +  the case), meaning that all reads and writes of SCFG registers are
> >> +  implicitly bit-reversed. Other compatible platforms do not have such
> >> +  a register.
> >
> > Couldn't you just read that register and tell?
>
> In theory, yes, but as far as I understand (and as I wrote) it's
> specific to the ls1021a. Of course one can decide whether it's
> necessary/possible to read it based on the compatible string, but one
> would also need an extra reg property to have its address - but that
> register is not really part of the extirq "device" we're trying to
> describe. So would it need to be represented as its own subnode of scfg?

Keep in mind, that not all Layerscapes have that feature and the
corresponding register. As you said that may be handled via compatible
string. However, the bit-reverse property looks like the simplest
solution to me.

>
> If it is set at all, it's done within the first few instructions after
> reset (before control is even handed to the bootloader), so I see it as
> a kind of quirk of the hardware. The data sheet says "SCFG bit reverse
> (SCFG_SCFGREVCR) must be written 0xFFFF_FFFF as a part of initialization
> sequence before writing to any other SCFG register." which, taken
> literally, means we don't need the property at all and can just assume
> it for the ls1021a (i.e., do it based on compatible string alone) - but
> I think it should be read as "if you're going to write this register, it
> must be done first thing".
>
> > Does this apply to only the extirq register or all of scfg?
>
> All of scfg. It really seems like some accident/bad joke coming out of a
> discussion between a hardware and software engineer on the enumeration
> of bits, with the hardware guy ending up saying "alright, have it
> whichever way you want it", causing even more pain :(
>
> >> +
> >> +Example:
> >> +	scfg: scfg@1570000 {
> >> +		compatible = "fsl,ls1021a-scfg", "syscon";
> >> +		#address-cells = <1>;
> >> +		#size-cells = <0>;
> >
> > As the child node(s) are memory mapped, this should not be 0. And you
> > need 'ranges'.
>
> Indeed - I think I understand this a little better now than I did back then.
>

Okay.

> Thanks,
> Rasmus

Thanks,
Kurt

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAl2PJpIACgkQeSpbgcuY
8Kajvg//UY/iWpJ5yvrHwwEiYOH2DbJAxGiyGQVXkHjCReroDWbMPXfY6rxMfz3G
SesspSgDF0yD2JTfOjvEX343oB+iWJYT+/RWLrfaNQRWcGp3iDp3ZCopXvzMPFpA
qLpZogd2ttYHSu4gkw4sc6jZcLJ+39Wk5rIO08AyufvPIjPjr8TROfJJgNcEYoyp
g6DUEheatnqhlk6rGqAlzr+/pLnJocu9gYkeV0IOG07v/HaIfPKzuhYX3yQF+1Vj
l9t/r+DXfOZLkr4Hq9kItxtlSb498lAb1QE8dbu1LC7Oz155ihujSoPh9Twf6e9b
h8Ys9ljYH3W+TteL6iqznefoqgz18hE/F6d6GxKx9EmOy2Il/c2c5AtsLMlZEYtf
pT5iYe+rkToYUofURWi6BhH+kQPLqUTl9p5IORavL26S8lIKmWbaJa9QNRBxV6rc
HBJSKMd7BB9P8ztqTiXoGyl73JIPWBmIp8knjFnojiHFLYfv6ydt67RpxozB8oU7
FX+oheQ0r2xh85BAlSdX8seFI73yMigaVIZ8AyUkIm7rlhhtqeB/APf53tJurz3n
4a2Bmpx42e576fQlyHRsOODk4O596ACqUVYBvg11G/aREsK7luZLilfuzBZ4cybc
Nlyl7Lx5ksVGO9iZVTKUftFZ4cZIt1xTT6Z37jerdYQ5OyFTk18=
=3dnz
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--

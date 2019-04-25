Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C32C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F252206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hmh.eng.br header.i=@hmh.eng.br header.b="O3oQomhO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zJDxsPsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfDYBDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:03:51 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:41627 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbfDYBDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 21:03:50 -0400
X-Greylist: delayed 520 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Apr 2019 21:03:50 EDT
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1ED91582;
        Wed, 24 Apr 2019 20:55:10 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute5.internal (MEProxy); Wed, 24 Apr 2019 20:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmh.eng.br; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=BoGUe
        OmcupB5CGWOvw4RlhZwKG16xghgj+q6p6zm6Rg=; b=O3oQomhOfa3JQOd6Z87rN
        fOS98TVXzyww0nhPsKpXt4BvopiAyrDi5g1mA+xV865RHQjy61UHvs5zahLMlwhU
        YddXVgui6w0qG0ISUIxFglxPA1PaCCqqz6PcRPr/k1oQaF/J6/DQb2H5IljSPSKA
        xmhHevhL/uUxqFA7kiff38EeRaTdGWwDbYyKiQLGa2IpHjVRbggkreAju2QQ0+u2
        iHMgHHEOFz6GwcIbLmLmYnixZqciZWHMy7xnZtUM5T55yiNXl0N3WieSgNBbjthz
        0ItMVB9K2e1EtCDuarmBLzA7X2l4eTfAwr5QS8qcP777JoV2oFut+RA5oUnRTXIu
        Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=BoGUeOmcupB5CGWOvw4RlhZwKG16xghgj+q6p6zm6
        Rg=; b=zJDxsPsanZuaxLfFE8auKteAjiLfIp6k5Kz4GtejjBUEMyziadGBrtako
        //aReyQ18uOEXfKm7OfNzNpHcZoVnH2t7EEdPDQMiJGes5EoTAg+A4n9xZ0iXomi
        BdNbzqfwiR9VYRjMYyUofdfy1eq2tlbwvYFUkLu7RDiyJh4YzK6tLFNZ4vwaSdRm
        weDVt5sBVMwANWjVo6nFzPUw6gX+rhOzZnNLlP1vIroBi0UriYQmeNMQl+3FlFRq
        Wt9qI4BH+yU+gAP/njEfuQCpzmkwoZeUdVnJ/5WVT5cVAcLWqc50WAJVx05zMySi
        6fmVS8FTkGtcyA8I8G35ntW131ntg==
X-ME-Sender: <xms:bAXBXDxhfMusLGt8Bwyk-az-eqElgz6bCpmvcNKy055i2b-fEph7Fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrheefgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepihgsmhdq
    rggtphhisehhmhhhrdgvnhhgrdgsrhenucfrrghrrghmpehmrghilhhfrhhomhepihgsmh
    dqrggtphhisehhmhhhrdgvnhhgrdgsrhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:bAXBXAJC8hBpuoFVKYvm-Dd0RxConjTR8IPz8iLcOv1VQ5ZA2TPaug>
    <xmx:bAXBXK73d8w3D4Xz_b0XihTTe_nT3KNGJLMdPSL07IeDBi7OaSNLqg>
    <xmx:bAXBXPmYpRyw1t-u13Q5L1F7SJron_Nz0RrzB6PFagqQfdUDJ7Q8Jg>
    <xmx:bQXBXMgUYVbMgS1asqz1o7rBzW3n5lz4vggvgSrrow3YINOororn8Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 59BA97C199; Wed, 24 Apr 2019 20:55:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-444-g755619f-fmstable-20190423v1
Mime-Version: 1.0
Message-Id: <13ba6003-ff33-4e5b-b88e-ef93bc68dc48@www.fastmail.com>
In-Reply-To: <CAGXu5jKRO45m1TRDPA09sv0j+cZCC8e1w+oQty4YfOttKP3FYA@mail.gmail.com>
References: <20190424181543.GA31200@embeddedor>
 <CAGXu5jKRO45m1TRDPA09sv0j+cZCC8e1w+oQty4YfOttKP3FYA@mail.gmail.com>
Date:   Wed, 24 Apr 2019 20:55:05 -0400
From:   ibm-acpi@hmh.eng.br
To:     "Kees Cook" <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Darren Hart" <dvhart@infradead.org>,
        "Andy Shevchenko" <andy@infradead.org>,
        "Thinkpad-acpi devel ML" <ibm-acpi-devel@lists.sourceforge.net>,
        "Platform Driver" <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?Re:_[PATCH]_platform/x86:_thinkpad=5Facpi:_Mark_expected_switc?=
 =?UTF-8?Q?h_fall-throughs?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019, at 16:05, Kees Cook wrote:
> On Wed, Apr 24, 2019 at 11:15 AM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
> >
> > In preparation to enabling -Wimplicit-fallthrough, mark switch
> > cases where we are expecting to fall through.
> >
> > This patch fixes the following warnings:
> >
> > drivers/platform/x86/thinkpad_acpi.c: In function =E2=80=98thermal_g=
et_sensor=E2=80=99:
> > drivers/platform/x86/thinkpad_acpi.c:6316:6: warning: this statement=
 may fall through [-Wimplicit-fallthrough=3D]
> >    if (idx >=3D 8 && idx <=3D 15) {
> >       ^
> > drivers/platform/x86/thinkpad_acpi.c:6322:2: note: here
> >   case TPACPI_THERMAL_TPEC_8:
> >   ^~~~
> > drivers/platform/x86/thinkpad_acpi.c: In function =E2=80=98hotkey_no=
tify=E2=80=99:
> > drivers/platform/x86/thinkpad_acpi.c:4208:7: warning: this statement=
 may fall through [-Wimplicit-fallthrough=3D]
> >     if (tp_features.hotkey_wlsw &&
> >        ^
> > drivers/platform/x86/thinkpad_acpi.c:4216:3: note: here
> >    default:
> >    ^~~~~~~
> >
> > Warning level 3 was used: -Wimplicit-fallthrough=3D3
> >
> > Notice that, in this particular case, the code comments are modified=

> > in accordance with what GCC is expecting to find.
> >
> > This patch is part of the ongoing efforts to enable
> > -Wimplicit-fallthrough.
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>

Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

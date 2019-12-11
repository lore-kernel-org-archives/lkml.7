Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B724C2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68ED2073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="WZnsst5W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MW8Wdj/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfLKAkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 19:40:31 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45425 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726062AbfLKAkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 19:40:31 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2672022106;
        Tue, 10 Dec 2019 19:40:30 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 10 Dec 2019 19:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=FonVZHXm8ET8/Gd2BoHglmFqWNBAnF8
        7T7Cuu6NkJxM=; b=WZnsst5WSd/jJyPa8/DKQT+rO94VEGhBhocBz6rMrY+rZiR
        X2exBJKINOYOkgLaGGdJbgH0tRy69OB9Gzq8LZ/AOOCrVVGFu6ItOb6NnXcVCVaP
        enPh68VBSbVd4qzIlw/4pnWmICrRW3QT9s2645nygYAxThTCB9eZh/74LN+5N5Sg
        einCMwZPVfRh44ne74vztBzfuNNtkYZaDYgFI3y9laVsPzKRbF4zw4HhAL3n78qm
        nivvSIwRd2oXq+fHH0eHmaatKRMpgBNW9b6FNuIQHqqCQLrXOsTKRSyDSOVu+rCX
        73ct1SxmkLWWmQ7Oh6BAKzU0fX0zn6swES6YgbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=FonVZH
        Xm8ET8/Gd2BoHglmFqWNBAnF87T7Cuu6NkJxM=; b=MW8Wdj/qJosAgt/7LYRH3X
        sDG15s5apG0eiHVuPdF1Kn1ugcXcdloyQF7lhPhA+DEGzZk1KTR+CT/fBo/wl1qs
        jX6GGk5dbm+NAhccxT9SdRIBarJgxVI1pIbh6+eFpXpm8TYpPAnSNblkk1YCUGpK
        sypOjl5J2/48EjbTBi5DCqOaqi6KoT5AVxXtk9JdmGlaCZjZaA654KytbPFofUHf
        cIepUtIDdr0Hgbh5QfIfkb0L2H7WgemK/N5/uX4KmQdCzPZYNYmvBv4jRtcYt8kE
        9IaZ3M4qfGrV2MU7ILUuzDKrRndH+blcTP3Dm1ggkET4T3JcGhnhCf+eLFrNOHYg
        ==
X-ME-Sender: <xms:_TrwXRXgVuKbUZ4tpqgPLTF6OlqMIUu8toDF00sZl3R8TdWbnBUDuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:_TrwXYoTPre5R7lC-A2jPAjUH52SLlHALdX9qeVfVSO_T_aLaEtFWg>
    <xmx:_TrwXVaWacl2QMmPyAnToUc2NkFCuwPJY6Xi7l0ZGJIOCPMV5MSKVw>
    <xmx:_TrwXWBTrkqAEvq1Ct9QQNC9gOsOiLnrVk_Zz-sqxpv5yDnq0VV6Pg>
    <xmx:_jrwXU4ELyPyFWcRUfAGSXU06FxcXxQzOEXLNNaHOYxm1AADXShTTA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4050AE00A2; Tue, 10 Dec 2019 19:40:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-679-g1f7ccac-fmstable-20191210v1
Mime-Version: 1.0
Message-Id: <9a4b8714-f188-4ff7-b028-92f1379cbe30@www.fastmail.com>
In-Reply-To: <1575566112-11658-5-git-send-email-eajames@linux.ibm.com>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
 <1575566112-11658-5-git-send-email-eajames@linux.ibm.com>
Date:   Wed, 11 Dec 2019 11:12:08 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, "Jason Cooper" <jason@lakedaemon.net>,
        linux-aspeed@lists.ozlabs.org, "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        mark.rutland@arm.com, "Joel Stanley" <joel@jms.id.au>
Subject: =?UTF-8?Q?Re:_[PATCH_v2_04/12]_ARM:_dts:_aspeed:_ast2600:_Add_SCU_interr?=
 =?UTF-8?Q?upt_controllers?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Dec 2019, at 03:45, Eddie James wrote:
> Add nodes for the interrupt controllers provided by the SCU.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

You should split out the DT changes and send them as their own
series to Joel.

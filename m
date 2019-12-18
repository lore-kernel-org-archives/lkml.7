Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC585C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906CC21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="LKFB3dzL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qG15kzio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfLRWc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:32:59 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45035 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbfLRWc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:32:59 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9A48921AD0;
        Wed, 18 Dec 2019 17:32:58 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 18 Dec 2019 17:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=KbRgkj4TkHzAHUnUGVVnrmTrRsfMkSe
        N/TrcHi5KQlg=; b=LKFB3dzLTBhECvq4wBW7ZueCueXtEGOPSsZ2fBPEmscbwZn
        /6Ikl0ifFWYllxu+LjFInwq0SLVrp/w4WVZBKJrexxmYREH+UHQu6Fe/im8sNqIU
        c80vlOxC8HqrxiYJ0Yn/vlVTYcvznwTxf0+lD3ulM/1BPURFNxcl5Cml3WspK3Sn
        Zjvr8XXAxa5s24lNFDcu/C/eTEJzQdiscPkcVOYSE1+ztUScseF1FN5MyijBvtMF
        NRiJJVu0d1A/yjrh1OV9cLqsy4KzLQ86kVv5Z/dZZp3C5S0AweqONfQ1QDDSZjTO
        sNheorDaHpObCHQYGAtdEgvxxC0tsCu6/zqfX3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=KbRgkj
        4TkHzAHUnUGVVnrmTrRsfMkSeN/TrcHi5KQlg=; b=qG15kzio99DV0br68gOrSj
        +lPKBUlBiMTKkSGxykb4R90Ym++mw9jiHMFE/LMbQnPoTBUg62kS6o8hvpvyarQw
        gB86CAHgTr8pRDJL2XH2HFMKYzl+KJimvnai51zeUBkazcExreAuSwQgVlLoCFO9
        +WkJDYsXv6cuShydMQe8Egw6wQkiNr2hpWCepKnFiB9a3bvonVHPNfX+WZvnCmvr
        qEO8DgdomGCVwhR7tS/qtRlw8w7rz9+Rol0tYrEmqV7OaoNKG7YNHyuh/22eAhrI
        aT5vroFofGcR92dr39ugZW/UqzXQILY50MO6b+T4hnfVkcA6By6X6vwBo+46+sJA
        ==
X-ME-Sender: <xms:Gan6Xe64RnW4gsCYfFCBO9Gat9Tl2DemPrzOKL_nzmAO_COh0aK6bA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtledgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrg
    hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:Gan6XZXjmQrnq3qzS9iWotN8ehcCSpUwCIG-bEfgJWs_xTss0YhTVg>
    <xmx:Gan6XY38D-68WH430VjqlmjVpokqs4kC7V7sCAZzC1jQjiwKKxhL3w>
    <xmx:Gan6XYMqEOy21nwnJHlB0SZQRRIFes2xsTR7kPGB5EQ8TXe9ni2Kew>
    <xmx:Gqn6XR1hby6xlc5ihkkrvdcwsJeylpbQe404LUfaLv27iNosmqrKdQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 77DACE00A2; Wed, 18 Dec 2019 17:32:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-694-gd5bab98-fmstable-20191218v1
Mime-Version: 1.0
Message-Id: <1a43e1cf-e723-40e2-a871-0cfb1b86a164@www.fastmail.com>
In-Reply-To: <1576681778-18737-4-git-send-email-eajames@linux.ibm.com>
References: <1576681778-18737-1-git-send-email-eajames@linux.ibm.com>
 <1576681778-18737-4-git-send-email-eajames@linux.ibm.com>
Date:   Thu, 19 Dec 2019 09:04:41 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        "Joel Stanley" <joel@jms.id.au>
Subject: =?UTF-8?Q?Re:_[PATCH_v3_03/12]_ARM:_dts:_aspeed:_ast2500:_Add_SCU_interr?=
 =?UTF-8?Q?upt_controller?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Dec 2019, at 01:39, Eddie James wrote:
> Add a node for the interrupt controller provided by the SCU.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776BFC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4782240A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="edouY/yf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ariIa8DS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfKTGHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 01:07:10 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:47521 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbfKTGHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 01:07:09 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 867435870;
        Wed, 20 Nov 2019 01:07:08 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 20 Nov 2019 01:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=TGFoOR8k4c4tdXLrnHIT+DIILptA4jZ
        EVoNDESk6+yw=; b=edouY/yf5Ltb2h4tveU+VBLDqigm6a+1o88WqNYbDlnHSuY
        NBdl3gWfrhkds2iRT7jM3shb6CLSHf0fy6Oob5Vv/fm8cHXsf+Lauk1vF2SFesqI
        DNinzU6/eCcVHcmCORlwu2A3KBQF61/VdvU3QlrI8kcCUlr1TokQgz55E8JkiZs2
        WKyQyLY2kdh7CPFL6RhyuXX87PhdPh+uKfsFioJBxWLmUkWI0SrkS4FL2TMPncRZ
        Qv7kaNH0kB9ELX31uGZDL/mXVhS66ynXtF0nl7mDo3MQCM5AYuMmDTBGUMYskln8
        NeYoZgIHkcNwqrZS3f68eOaVDkGtBTc8eiFBkOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=TGFoOR
        8k4c4tdXLrnHIT+DIILptA4jZEVoNDESk6+yw=; b=ariIa8DSRjxdXYdh8Z5Lro
        DB+BCB4mf3iRxK7QxOA0RgQ8uVPrJ/4XOrFwysxaZYZvtVC0XGqBi0a9KM08R1VZ
        xm+vvuxDR2X5LFe4PohbZ1Dew5/jXxQWhuX3CtmzEGJFsUzf112wv4wiZ4tuXXu8
        187pdMVL/LB9txSCIbpJ+9HuE0sOYvv2RZgmP959W5su918V2mLCmVsBY+0qb9md
        5war8QCBhkRlbCB4tetpXLAXn44wDQzJerFHdk6HrZt1pV2h5a4i/tf+h+ZDvyy1
        PnJxolhBvXl1nnDjet9V/d2kL+B4BgtS/HbgGW+m7niln0yYiTZ423UPretPb5Uw
        ==
X-ME-Sender: <xms:DNjUXRYMKacsLTHV0VrBYTs7OAVFK5z3O6F0DRECwlISpOLCvx-QPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudegledgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgepud
X-ME-Proxy: <xmx:DNjUXUOJZPIWiblwnQxzM3JsDfovVhv1VV0EMZfwN2Fyi_21oNEegw>
    <xmx:DNjUXabHS0fhLPD9p1WVOx8WakeGSKcVzb2e5OpjGdro-hw6ChiH8A>
    <xmx:DNjUXcUq1gW5LvqJNwgeoskUiwgzvWqExEzZleeaRe4cAwEqRQ8MQg>
    <xmx:DNjUXaKBqLPDutNNhrlKe1gwGe_K4mBpHPBswL1Ow9qg9zF-IKU7Tg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 14E75E00A3; Wed, 20 Nov 2019 01:07:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-578-g826f590-fmstable-20191119v1
Mime-Version: 1.0
Message-Id: <794a7661-b4c1-46eb-bc78-79e7358ff999@www.fastmail.com>
In-Reply-To: <20191118104646.3838-3-i.mikhaylov@yadro.com>
References: <20191118104646.3838-1-i.mikhaylov@yadro.com>
 <20191118104646.3838-3-i.mikhaylov@yadro.com>
Date:   Wed, 20 Nov 2019 16:38:32 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Ivan Mikhaylov" <i.mikhaylov@yadro.com>
Cc:     "Joel Stanley" <joel@jms.id.au>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>, openbmc@lists.ozlabs.org
Subject: =?UTF-8?Q?Re:_[PATCH_v3_2/3]_mmc:_sdhci-of-aspeed:_enable_CONFIG=5FMMC=5F?=
 =?UTF-8?Q?SDHCI=5FIO=5FACCESSORS?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Nov 2019, at 21:16, Ivan Mikhaylov wrote:
> Enable CONFIG_MMC_SDHCI_IO_ACCESSORS on the aspeed board. 

s/on the aspeed board/for the ASPEED MMC driver/

but otherwise:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

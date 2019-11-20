Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDD2C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DF22244A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Fd0L4n9g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wSfHHMIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfKTGIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 01:08:02 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:56287 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbfKTGIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 01:08:01 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8120168AD;
        Wed, 20 Nov 2019 01:08:00 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 20 Nov 2019 01:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=DsuQsdMCwuKKG1c6E9zMMunZDORO9yG
        MRO643pGAkco=; b=Fd0L4n9gK6ybYYBcSg1jQ+1Anq3REZ7jgGzCovtPqAE/Qf7
        nibUPdKv3eDWgqvMYN2XxG0LYtAm7iqdLElZ2SU2EcuQDU97upof3y5/rKu7J0qj
        4wd+UsSZoz5ns+jTk6oFghvBCuGKVESjgCqmLYDqvvMIi8+7PGqQ97iXDXslWWB/
        hNys4hZmVfu9EB1q9yAK+U3HRuFeXrqidnlTdgVLOoMhdzR+kWFII8B2uTCkRJ/i
        H3DuC4ThZzInqSom3lkAxl6YHjictrV9Ubn3izRoEoA3rng2VGb8fEoG5XienYtR
        FIIk6KuzAAevM6ygdCWFFcjQDifODP/tQjoe5Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=DsuQsd
        MCwuKKG1c6E9zMMunZDORO9yGMRO643pGAkco=; b=wSfHHMIqeIxz7uUn2d14w+
        RVJjFGK++vJnIvk+WVWo+2LhVPANmImCx1DFfogwrz0w4+XWbNfJ5f6BIeoQeW+q
        yV+f3UxVN3dKbrGFNSp5QtlhwEgHbMsXh5PgNmZ1pfC7bxvF9YAWORWMzKNGpCtK
        uYBODeLR5kopolY3BPcOKPzqLljOVF5GUaZ0PAW/nvvKFjlYXqihy0iUl14pKLlS
        99bgQBQ82BSvwtROesF3tUuZu085Htvrm59DQiGUOyMOGmIDZWK5MpS4x3GHFP3g
        IfM6Frwfacx1N8JxtCfmqswSgX0v2QgQUqvzplK5741QIJTyzljQcbEJKTc3SXvQ
        ==
X-ME-Sender: <xms:QNjUXWJ2ujlBAKIfuc9xx6W73U9KNM57P4vef5G9WMlmfLGd-1iX0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudegledgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:QNjUXV626hPjxjiHuOLWBVDS-F3NZe_zGbxRynf3AD9D_lPoK1etCw>
    <xmx:QNjUXbuJg1QQvHvrn9xtjvmCsDQSdZkBc2ntB7i2C9AJEZqIqAGP8w>
    <xmx:QNjUXTZh-E3-mu7lCLDC6Av9Czb4yjJMXjLnR-9fqX_lO6ChGEgxVw>
    <xmx:QNjUXTZvhspj1tktg1bwvQlCwqHwSasFZ_W2ijcrQRSSGu_GuGIyrQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 49FE6E00A3; Wed, 20 Nov 2019 01:08:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-578-g826f590-fmstable-20191119v1
Mime-Version: 1.0
Message-Id: <ebe4c175-a1a0-47d3-9c01-1dfeeffc97e5@www.fastmail.com>
In-Reply-To: <20191118104646.3838-2-i.mikhaylov@yadro.com>
References: <20191118104646.3838-1-i.mikhaylov@yadro.com>
 <20191118104646.3838-2-i.mikhaylov@yadro.com>
Date:   Wed, 20 Nov 2019 16:39:25 +1030
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
Subject: Re: [PATCH v3 1/3] aspeed: dts: add sd card for vesnin
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Nov 2019, at 21:16, Ivan Mikhaylov wrote:
> Presence signal is inverted for vesnin boards, 'cd-inverted' added
> for invertion signal enablement. Vesnin BMC uses microSD, there is
> no WP switch, 'disable-wp' is used for this purpose.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

Acked-by: Andrew Jeffery <andrew@aj.id.au>

Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7AEC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 05:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703E524249
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 05:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="XkSFWnrs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mFtuhQSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfLEFNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 00:13:45 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:52337 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725822AbfLEFNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 00:13:45 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 171566DFB;
        Thu,  5 Dec 2019 00:13:44 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 05 Dec 2019 00:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=HmY629d09ljX49+gWihMYnlLvvddw8y
        blf8rUOR5/wE=; b=XkSFWnrsqIZKGLVdudWqOUsdB5YtNlYfu/WzJNmOnyi7Za9
        38ORxDINALsurrmH9koTMeFOuAMZbEdt3jb4NKuSHz1kx+lTQ8xaqEa4ARhDGT4D
        KGfLIlPrgABX0jjuH+qOBWgYSBYhf6XN2TcuNhLmzc4lnObgmWWgUqILS/RSwONj
        0dok7lVopN++sUQMDj6CcDhMfaGf0RO0rzOcHeFJbECCjlfWyZ7zpQLUflU2t4m3
        O7cOUNTC2iCsFkjBQw5iJqeVUyG/bvlRsBcI+ziZDSYuCJO8AJnT2xLVipUkEmKk
        5GsqpC7va97/ZkAtZQnZUb+3UJAwaK2HhNrJftA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=HmY629
        d09ljX49+gWihMYnlLvvddw8yblf8rUOR5/wE=; b=mFtuhQSUTGXR6RwrC/ZSqy
        DHtQ5sfJ72Gp+Fl14rqpI8A7opsv9ESRgx9plv2EalC4IRNebJZFDPAbVXGAep4o
        JgsZPzXUfI67INU1Q5h0MO2IeaIdp6pYZXaSdxxkzCukfnYYRgBMl9Kp3NEkQDy3
        +yrfq21UcepbK7ueIDsO974jcDYOwBURh8RF6li/Ko2371GVJkEpfgnv1Y5Bpt6U
        CyfG3o8gCDE3M6qGOD9nLeUR4TIAqzun6+KU/Vaonbonc6Z35lZTYQnrWIFEeK0p
        ukSchr2VVYPg9URotj309OcD4EQh8jjd10uwGTVxU9jR+ABqlVslmU+WCOHbl8aw
        ==
X-ME-Sender: <xms:BpLoXT9uaXVa-DTA9FwW7wiy_GJt_465bqEkFIhziNC9gaP8vGHyUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudektddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:BpLoXZ_D9ZZbPr1lny9cZzaTeUS9m8tXYUZA2MppI0yZIXZnp_X2Xg>
    <xmx:BpLoXf_QPUo2GeX0u2WvSXm8b7gNwGJfzBKKQ1G_f6wAJAtDi7mWuw>
    <xmx:BpLoXXE1ahEGOo08cwQHVS1JRmlO5DhCD36h38YcnnRuHi-6wckWRg>
    <xmx:CJLoXbQbKnADxn_5wl7Byr_5lJFU-G_lsmG9VHhHT4bPdTbtQ1IPNg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AE0DEE00A2; Thu,  5 Dec 2019 00:13:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-612-g13027cc-fmstable-20191203v1
Mime-Version: 1.0
Message-Id: <cd76d709-683b-44c0-b29f-d31c9dddc75e@www.fastmail.com>
In-Reply-To: <20191203134026.GI18165@minyard.net>
References: <cover.5630f63168ad5cddf02e9796106f8e086c196907.1575376664.git-series.andrew@aj.id.au>
 <84315a29b453068373c096c03433e3a326731988.1575376664.git-series.andrew@aj.id.au>
 <20191203134026.GI18165@minyard.net>
Date:   Thu, 05 Dec 2019 15:45:17 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Corey Minyard" <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        "Rob Herring" <robh+dt@kernel.org>, mark.rutland@arm.com,
        "Joel Stanley" <joel@jms.id.au>, "Arnd Bergmann" <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Haiyue Wang" <haiyue.wang@linux.intel.com>
Subject: =?UTF-8?Q?Re:_[PATCH_2/3]_ipmi:_kcs:_Finish_configuring_ASPEED_KCS_devic?=
 =?UTF-8?Q?e_before_enable?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Dec 2019, at 00:10, Corey Minyard wrote:
> On Tue, Dec 03, 2019 at 11:08:24PM +1030, Andrew Jeffery wrote:
> > The currently interrupts are configured after the channel was enabled.
> 
> How about:
> 
> The interrupts were configured after the channel was enabled, configure
> them before so they will work.

Hah, yes, that commit message did get a bit mangled. I'll update it.

Thanks,

Andrew

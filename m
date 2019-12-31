Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14CAC2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 00:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DF4206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 00:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l80O9So2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfLaAgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 19:36:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbfLaAgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 19:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uUpQtXEM4z6Ypnlq7iQ3VVz6U4Twpg3kBkbLZl2kbEo=; b=l80O9So2abIGf49ULGRQJuNtm
        I+vdOBgJQQ0GoAwwTGm9LwGAKYFsFaEpgFARhI5guBAuLgMeT0CK9t0LpNOfsyBlOnxQBl9FPi8nK
        VReEBa1lKBK0dFlBSP8FMEnlnIGe1eYjkAxsQqyS/lRuvELiPZipbRjAr9TdU0hGM0dStCaRLtoBm
        2ns38SkHhzMN22H+mqJEZ+1T27+XH2UFhmrffS8B7qxnL6Kv4oyhZjwGouIQgrdJeoLguxIpja2FP
        8MTS70+BDD4/i+GoPwteFN5ymF+DF40w8j6k2TSYv4lU+/oiFH2e++we222lYTA9ajW2fEhVbjDKF
        irVHuH16g==;
Received: from [2601:1c0:6280:3f0::34d9]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1im5WJ-0004x0-6p; Tue, 31 Dec 2019 00:36:23 +0000
Subject: Re: Why is CONFIG_VT forced on?
To:     Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
References: <9b79fb95-f20c-f299-f568-0ffb60305f04@landley.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b3cf8faf-ef04-2f55-3ccb-772e18a57d7b@infradead.org>
Date:   Mon, 30 Dec 2019 16:36:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <9b79fb95-f20c-f299-f568-0ffb60305f04@landley.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/19 4:30 PM, Rob Landley wrote:
> On x86-64 menuconfig, CONFIG_VT is forced on (in drivers->char devices->virtual
> terminal), but the help doesn't mention a "selects", and I didn't spot anything
> obvious in "find . -name 'Kconfig*' | xargs grep -rw VT".
> 
> Congratulations, you've reinvented "come from". I'm mostly familiar with the
> kconfig plumbing from _before_ you made it turing complete: how do I navigate this?
> 
> I'm guessing "stick printfs into the menuconfig binary" is the recommended next
> step for investigating this? Or is there a trick I'm missing?

I've never had to resort to that trick.

> Rob
> 

config VT
	bool "Virtual terminal" if EXPERT
	depends on !UML
	select INPUT
	default y
	^^^^^^^^^^^^^^^^^^^

That's all it takes ^^^^^^^^^^^^^^^^.

Does that explain it?  Maybe I don't understand the problem.

-- 
~Randy


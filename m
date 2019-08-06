Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_A1,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CC4C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2B520880
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b="gxA/jrN0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DoFZ/4BD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfHFTnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 15:43:46 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44515 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbfHFTnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 15:43:45 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id ACAB521C7D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2019 15:43:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 06 Aug 2019 15:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=to:from:subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=fm3; bh=ggnd4JMvzeolbg7dt8XtO6kAbn
        qVqIMDta4BC9xY/IU=; b=gxA/jrN0McRxMq1bFcxe01DnqXah+xNKrSbsBHOo7A
        EtQF0U7V8xzftR64eSf9rSqChPZSySE7n89eGp0+3Z0G956y+3F4KtsU82KEGxGe
        rJWeO9XNhhjaoaF8f3/E+FuUHAG+D/LsJc+eXa46cbZtzGykeLA78xIbR1FO4zcy
        K/gL99kpWjb0zR8yye7uCCIvjxeurNgyJjy8SiMEoGwVbnZ7sDT4ZnUCZdNKvhs4
        pM330A0GqL4XDdC1pESCh6LYM3QRfgB5rjApvL8YCrLfZXDtTQJhUpj2o12QCUgG
        aEAI+qk3MEkt4dGVDSK/8caatOx143BFgloP24QaB+gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ggnd4J
        Mvzeolbg7dt8XtO6kAbnqVqIMDta4BC9xY/IU=; b=DoFZ/4BDBsNVV6uo28xBHg
        bz/4Kj3ntzQu1JpSOY0U2pEIvUjf18WgLIE/RmXglPp9qZPeo4ftQ6Nay2/TPrlO
        Gi9KW16WLkgzMpm685BR7OWnJTmCZDjznBqTg1Kwb6v4V8aCDPz7fZIqkIBmZJhA
        Fyt03JNPpMblmrF+quWcgZeXoz3k7C14otDxbGfUk0CFM5pPT/epnFyXHV0SulUU
        ogSfPOTAc1RUVRrdPcJyHBuaONBK8JOL95bNhiwW376YSto1GrMzZuDKD4RU5Z/d
        o5pAXnHuUo1Dy+tAwMNfnAuJtl9+hA+UjV2iKAb1bhnAqyWIH59SSllw9lzBKD6Q
        ==
X-ME-Sender: <xms:cNhJXb4CoJ0WjyJ1hqkAix9_7ZivecPVX-PljK1v-bhPpQeXdRX2jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddutddgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefvhffukffffgggtgfgsehtjeertddtfeejnecuhfhrohhmpeftvghmihcu
    ifgruhhvihhnuceolhhkmhhlsehgvghorhhgihgrnhhithdrtghomheqnecukfhppedufe
    ehrddvfedrvdegiedrudefudenucfrrghrrghmpehmrghilhhfrhhomheplhhkmhhlsehg
    vghorhhgihgrnhhithdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:cNhJXQd2Z8oE2OFXBdJT7b8GzbC0c2noQk7HNoUgZmqKUyTva-NSww>
    <xmx:cNhJXY7bC7LM-xhofiPffFjL0Un00jYVQeXBEzkl_utdhWbGaDmlRQ>
    <xmx:cNhJXbvdAYNApcKoq1UC5me7rEvnaTEkT6LiPQXe5lvTkMgzxHy1GA>
    <xmx:cNhJXV__Jza1Aeojpi1qgU4xFJa1U4CUtNWByOYCOqwEAZsKrnm0rQ>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id 42F3E8005C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2019 15:43:44 -0400 (EDT)
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Remi Gauvin <lkml@georgianit.com>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-ID: <ed477e7f-e159-6bf7-efa9-5d82cea3da96@georgianit.com>
Date:   Tue, 6 Aug 2019 15:43:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I don't have the original message to reply to.. But to those
interested, I have found a solution to the kernel's complete inability
to allocate more memory when it needs to swap out.

Increase the /proc/sys/vm/watermark_scale_factor from the default 10 to 500

It will make a huge difference, especially with swap on SSD, the kernel
will swap out gracefully to allocate more memory, and you can get a few
GB more memory in use before really noticing performance problems.

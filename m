Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BF0C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AA62147A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gPOXauLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfD1GJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 02:09:07 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50905 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbfD1GJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 02:09:06 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 753A621FF3;
        Sun, 28 Apr 2019 02:09:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 28 Apr 2019 02:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=6wTH00IEcec2nG40s34dkAdJONtpHNStLOW3P3TBn
        8g=; b=gPOXauLn3oavCa/+fi1mRLO3lBkOSJOxjAIjBVPq1SXu4Ma/pqCufZ0Yh
        lkD6VrSfaL+8phzGc/KpgoZ2c4fmukeJT3f2gE2hoAgraB69ky3vF3z00dsTgRsv
        EYqNp2nYv3yorE1n4FXWr7x4CX9lYIzG+kHpRa8E2WHYgq4cJj+SkJTGsoYxemVp
        ZMLjSuAaHhHLjJ0+DaHgQdQwEbnNJILvSUsnqPoHiHAYdX6RYy7NOe8EewPF+5e+
        025PXeYmwnUlx+84e7Q6RrNL+OBYA2qg2S39uMMBlvaO9CWpmRUIzigH6oH2xuqO
        UUcHwtqMMKZlYzVQlDV4UVw8uYLkg==
X-ME-Sender: <xms:fkPFXIx7NW-XzKazSd1QLI64oaA1yjeaxy9BlGm0WBA4e_7C8Fa4GQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrheelgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheprfgvkhhk
    rgcugfhnsggvrhhguceophgvnhgsvghrghesihhkihdrfhhiqeenucfkphepkeelrddvje
    drfeefrddujeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpvghnsggvrhhgsehikhhi
    rdhfihenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:fkPFXCQCaYwTgbW5nvDmuzfzyW6zd0XMhFeVbsdEwdZYZX0yQ1HqTg>
    <xmx:fkPFXH83G4alTfK5pCpAxFrD6JAv9fQsalCluIoc2NPE7ZsZtK-1ew>
    <xmx:fkPFXBoEYQACrpvjPcmdhNirX7B10AaxCymvGBVyRUaoAmuLeTai0Q>
    <xmx:f0PFXL71nyLUzjHpQdx5tv-cvxZYOnUeac5Sp7Qpi8K8pFr2Z0ZJXQ>
Received: from Pekka-MacBook.local (89-27-33-173.bb.dnainternet.fi [89.27.33.173])
        by mail.messagingengine.com (Postfix) with ESMTPA id B477C103DC;
        Sun, 28 Apr 2019 02:08:59 -0400 (EDT)
Subject: Re: [PATCH] mm: Fix kobject memleak in SLUB
To:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190427234000.32749-1-tobin@kernel.org>
From:   Pekka Enberg <penberg@iki.fi>
Message-ID: <82b2272a-1d42-81e4-f033-8483d47bde22@iki.fi>
Date:   Sun, 28 Apr 2019 09:08:56 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190427234000.32749-1-tobin@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/04/2019 2.40, Tobin C. Harding wrote:
> Currently error return from kobject_init_and_add() is not followed by a
> call to kobject_put().  This means there is a memory leak.
> 
> Add call to kobject_put() in error path of kobject_init_and_add().
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Reviewed-by: Pekka Enberg <penberg@kernel.org>

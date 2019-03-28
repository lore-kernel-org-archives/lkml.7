Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBBFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E3421773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z/PJ0bvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfC1GPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:15:22 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59937 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbfC1GPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:15:22 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Mar 2019 02:15:21 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B8EF92106A;
        Thu, 28 Mar 2019 02:05:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 28 Mar 2019 02:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=jqtazJHsx+b9ct1DOtMFjfvs6F8nSs4P+e+seowAw
        TM=; b=z/PJ0bvMjNqjIRFMSifCfyHzH4pwkBOj+fX7DVLxdUaCOxD3o3cpxDRTU
        TRIBku+dtNMhmuuDTsJZyE98dZWQtKmh6upJVYkQuC/PYNZ88jAOpdwJox5DBg4T
        awNU+jHqh92Enu/+aAZu0g4M48fuCumuGVGkbqlhw67MkLWYBLQli03Aq3RiTc+E
        9BnomWRH0LnvQSeF6xTr/dEUpA1H3zqvL0knmozMCbfYjFxifMUethwluvXr+9/E
        ptaAaEoCnHnbpZvRjF08qSRxYZX1G2mQArmnInOut1SXQWT+18itpmE5GSyVL3iY
        X5zzyDmyu3NxX41Sq6JLSSHiXMGlQ==
X-ME-Sender: <xms:MWScXFLNbNKbGACaNhtY5UStBfFOaAAxZJ2pqIio7nT-xyQxD9daCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkeefgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtje
    ertddtfeejnecuhfhrohhmpefrvghkkhgrucfgnhgsvghrghcuoehpvghnsggvrhhgsehi
    khhirdhfiheqnecukfhppeekledrvdejrdeffedrudejfeenucfrrghrrghmpehmrghilh
    hfrhhomhepphgvnhgsvghrghesihhkihdrfhhinecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:MWScXGoOwmTOW2dtGsnspGGLTM5WNmfYafpzfQwRxUwzKVoMP9JHIA>
    <xmx:MWScXAbJzY-VsjNDId0KEq-dNAKP8z67g82-SVvUt95KQqJlwzMgiw>
    <xmx:MWScXDx78KJoHhRBnnl9M5t2PeOP0lOuVN2oerYnmln0dQFEK-VCRg>
    <xmx:M2ScXCgc2C_dn1hu1072izvJdboWuKCbli32GmHWAscee-WN5tNI9A>
Received: from Pekka-MacBook.local (89-27-33-173.bb.dnainternet.fi [89.27.33.173])
        by mail.messagingengine.com (Postfix) with ESMTPA id 039F9E442F;
        Thu, 28 Mar 2019 02:05:34 -0400 (EDT)
Subject: Re: [PATCH v4] kmemleak: survive in a low-memory situation
To:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org
Cc:     catalin.marinas@arm.com, cl@linux.com, mhocko@kernel.org,
        willy@infradead.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190327005948.24263-1-cai@lca.pw>
From:   Pekka Enberg <penberg@iki.fi>
Message-ID: <c49208bf-b658-1d4e-a57e-8ca58c69afb1@iki.fi>
Date:   Thu, 28 Mar 2019 08:05:31 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190327005948.24263-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/03/2019 2.59, Qian Cai wrote:
> Unless there is a brave soul to reimplement the kmemleak to embed it's
> metadata into the tracked memory itself in a foreseeable future, this
> provides a good balance between enabling kmemleak in a low-memory
> situation and not introducing too much hackiness into the existing
> code for now.

Unfortunately I am not that brave soul, but I'm wondering what the 
complication here is? It shouldn't be too hard to teach 
calculate_sizes() in SLUB about a new SLAB_KMEMLEAK flag that reserves 
spaces for the metadata.

- Pekka

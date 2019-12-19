Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C4EC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B643B222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="ji6ukp7g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U8piGZ34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfLSVOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:14:39 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43121 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726908AbfLSVOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 16:14:38 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 42FF32263C;
        Thu, 19 Dec 2019 16:14:37 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 19 Dec 2019 16:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=V2Hao+J1GkYhnxb5ys8W85uWd1oQYMD
        NDs9XruetUIo=; b=ji6ukp7gQRqpBg28UjFL7cM6qfmkQkdTmM85YWc7NeAvZfm
        xoUkiIvFjEw37nLotwu1J7IR8Z4DCUS6W7Xcan33XMhP3lyh00zRzP7z8gg0nx4N
        2y+tuyxjJ3Mn5ujOuGVF/uFplRP97k18eg0dLIpv5DgGDB8OGsx1mXhfukR+wRel
        +dIWdlMF4+zoKUZEIrBo5YmfEyQvVBn14X+4jZ74U0PL/PM9H7QjJNFTMytrTcqe
        +7/uQg57T3S2+/mLLvPkh2DGB6OBY+WX/aV647gUkRWPlgC2ZM7JqAIiIQz76WOx
        nHWx9awvNa9+HJtQ1fETalNMQES9tVdsmCr5MCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=V2Hao+
        J1GkYhnxb5ys8W85uWd1oQYMDNDs9XruetUIo=; b=U8piGZ34pLofpF3dhgwphE
        YMEE3v+6/8++EL56tNDbqsZBhWsnEQL7LULEJRufdn42g4sUs9ykPn23fR95orgI
        IuGcyeKVFxM7ffYrXFme18FDqVrEKqXPrJRtTeUUvzIE+swZ49yfubPMlhD4eDOb
        d+AdRo/30NBzsNVEpww94VnX1AhgKB9lC+3QKPUG9n0IxrBUwjMeMu6h8/WEti+r
        fRFpOXMGCz3nN13COw7kk+N91nurDyyqsLd1BH+kQj2N/uFsVrRfpNm/z4NPKPFn
        TqPTvzC7lkkL9TW20mmxwtEiTDpluFVK5WbqSsJx5gsa9JMPgTRnJmo0Z/2Kw1hA
        ==
X-ME-Sender: <xms:POj7XQSs8PEyrN35x56zFmpGE9XQkWVDbP168vKI86Q4tE_E_0128g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdduuddgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrg
    hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:POj7XWJu-bP77Z7xse4CUZpn75WQRSBoseaqkpMgw97yfBLvgxRJGA>
    <xmx:POj7XQBkfKM-bVRq7XbLHgu8iU6kpzK67wpHvwBlZdgZZFUIvXDgaQ>
    <xmx:POj7Xb3FLH-F69pOjcPYREL3NrHN8jmOE2XkLFXdoEQMqhv1VQZ0Qw>
    <xmx:Pej7XdCieO_953Hn21694gMM0U8q7obfXRLXIM2K93mypOIMZPZmng>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 089F4E00A3; Thu, 19 Dec 2019 16:14:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-694-gd5bab98-fmstable-20191218v1
Mime-Version: 1.0
Message-Id: <700f857c-0d99-4e7e-a969-191c5afd10f8@www.fastmail.com>
In-Reply-To: <22d81b7d-4f1c-30b9-e895-1f38a862462e@linux.ibm.com>
References: <1576681778-18737-1-git-send-email-eajames@linux.ibm.com>
 <1576681778-18737-8-git-send-email-eajames@linux.ibm.com>
 <de68ff11-0942-422a-b233-ff578b06eefc@www.fastmail.com>
 <22d81b7d-4f1c-30b9-e895-1f38a862462e@linux.ibm.com>
Date:   Fri, 20 Dec 2019 07:46:18 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v3 07/12] soc: aspeed: xdma: Add user interface
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Dec 2019, at 02:30, Eddie James wrote:
> 
> On 12/18/19 7:19 PM, Andrew Jeffery wrote:
> >
> > On Thu, 19 Dec 2019, at 01:39, Eddie James wrote:
> >> +			mutex_unlock(&ctx->file_lock);
> >> +			return -EBUSY;
> >> +		}
> >> +	} else {
> >> +		mutex_lock(&ctx->file_lock);
> >> +
> >> +		rc = wait_event_interruptible(ctx->wait, !ctx->current_client);
> >> +		if (rc) {
> >> +			mutex_unlock(&ctx->file_lock);
> >> +			return -EINTR;
> >> +		}
> >> +	}
> >> +
> >> +	aspeed_xdma_start(ctx, &op, client->phys, client);
> >> +
> >> +	mutex_unlock(&ctx->file_lock);
> > Shouldn't we lift start_lock out of aspeed_xdma_start() use that here
> > instead of file_lock? I think that would mean that we could remove
> > file_lock.
> 
> 
> That wouldn't work with the reset though. The reset should hold 
> start_lock as well, but if a client is waiting here with start_lock, 
> we'd never get to the reset if the transfer doesn't complete. I think 
> file_lock is necessary.

Hmm, let me think about this some more.

Andrew

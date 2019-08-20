Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3B7C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 18:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589E320644
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 18:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OOYPrFZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfHTSOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 14:14:03 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:46919 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbfHTSOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 14:14:03 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5CF3B453;
        Tue, 20 Aug 2019 14:14:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 20 Aug 2019 14:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=bzFEbE
        3zPRKGTss5iOe9FhhVrD9tlDk1wxCn5IziSho=; b=OOYPrFZrlBuqz27Kw+3+N+
        +Z1V8VHNbQbirV3oUuDSe36MNCPVmpT/L7DFLjEP76N0cX/weGtJDrhPt9XwiaHs
        /3THk9vyG3caFmw5r18taectCZa6m6z+tg4A7yUgGSCOlPnqIt7Tw2uVODAiLiSY
        1BSfdY1TIhtsXxfL8bxv9/Tr+TYLmj1UN2abkDnyEVuBz4CxEv6HACUNVAzyRfx8
        TcnG/LhJowDq9oleEpZx0Kfkf59IBcwVvPgfq8ZIt1lla1yVlTR95h68YcqBLSyy
        CG8Nj0T6QEd+qoLwoeZqrIHQ8HLxrPIooO2/C54fOp4BJ24Up0wpc2K0b8sZ/fyQ
        ==
X-ME-Sender: <xms:ZzhcXa0bmcie3mvdQSngVB7aAChdh40LAipOEKZ0OPhzcrDyGVn7cQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeguddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucffohhmrg
    hinhepohiilhgrsghsrdhorhhgnecukfhppeejjedrudefkedrvdegledrvddtleenucfr
    rghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghenucevlh
    hushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:ZzhcXRUsryJznDeGIjLOdeZxPKrtUN_naRv6HtJSo1yvYt1PfCbuBA>
    <xmx:ZzhcXd6PN8GXxXOY7bCWu4YFAhJjeTuxR7Zvfvc1a4HMNaWDgpT3UQ>
    <xmx:ZzhcXQK_kGOsMZj9daD5OdTS9Qp26mspMnRHRC6_9qEQxn3ynr6zFw>
    <xmx:aDhcXVmfQp9HHy0DbWAI5HQnmO2gaKFQdi16su5nNKy5zwBYFXSVvQ>
Received: from localhost (unknown [77.138.249.209])
        by mail.messagingengine.com (Postfix) with ESMTPA id BDDB080060;
        Tue, 20 Aug 2019 14:13:58 -0400 (EDT)
Date:   Tue, 20 Aug 2019 21:13:48 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: linux-next: Tree for Aug 19 (drivers/net/netdevsim/dev.o)
Message-ID: <20190820181348.GB6054@splinter>
References: <20190819191832.03f1a579@canb.auug.org.au>
 <92ef45a5-c933-0493-b2ff-50352fa8bf3f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92ef45a5-c933-0493-b2ff-50352fa8bf3f@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 09:16:13PM -0700, Randy Dunlap wrote:
> On 8/19/19 2:18 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20190816:
> > 
> 
> on x86_64:
> # CONFIG_INET is not set
> 
> ld: drivers/net/netdevsim/dev.o: in function `nsim_dev_trap_report_work':
> dev.c:(.text+0x52f): undefined reference to `ip_send_check'
> 
> 
> Full randconfig file is attached.

Randy,

YueHaibing sent a v2 which is available here [1]. Successfully tested
it with your config.

[1] https://patchwork.ozlabs.org/patch/1150183/

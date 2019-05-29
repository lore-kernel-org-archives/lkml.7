Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA76C04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 02:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F343020B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 02:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="p6dl5bzD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JqcyNamq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfE2CAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 22:00:17 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43707 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbfE2CAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 22:00:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5CA0921FB5;
        Tue, 28 May 2019 22:00:15 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 28 May 2019 22:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=dlc53IBOkSiD1cNJTaXRxiWXEJHrTor
        ic23hUYCRqC0=; b=p6dl5bzDLh/yjgsl38thCiHBTu1NiTa3FnUSaE1rxt84EDN
        X8C6yph+Vylp+eI3uA6FGMp+Id8ZiZCLYYNwJxOAAiXnorcjUcJye3GdMWZAOKVj
        9mBoMtBBpGdKkTt2rdwATOmj/sQkAaNT/Ti/j8TVJKvCghAOnO0uS42iL1INindJ
        rR5vNkH+k4+rMYgiFJUC/U6IJwAoopzEa4UmnWcC4MGsvKXGz8ih7vT/8s/dSnqL
        iI6cFELlsddpaMx0/n8Eto+Q2/RZvknA6pJ851yq+dmWgYXHVRr5I3+IRUfICO/K
        PtH50uo+wlRtJGzzvVJHw5cKU5n+ZaWUpk9cgqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dlc53I
        BOkSiD1cNJTaXRxiWXEJHrToric23hUYCRqC0=; b=JqcyNamqu7tP9cvJUmavXh
        JAXe6my8TQxMp8lHwKBxJTh7rbp77nDcjOCdfC4vyeRT2OaF1BTCXnVmIjb3NVbP
        j+/MG9bhYzc4hB/ogykl8y52BF1Cw4oTNelOT/5XSCiSPszdkDG5PselJhw3jGkZ
        5CAKX16kbOmzqlcOHUFLmkykurEIKHqbelLAXn9HJ0SEixgXFkEGgv0OAs4pFi2K
        eo08tBPmuRJmrIh/q2UQ7OQA0/etMX7Srg3x7EP4ehMHwuvl2P3TBGlliAfljXLt
        YfKgcsNVG9sARt7fNGMp4VnFcB9KUSv0Twy58LfqdIBZNxC7KlBhm+Ru7yqRQzoQ
        ==
X-ME-Sender: <xms:reftXMl0FnaCAIeRS5CR9IlAZ8ZJ5tUK1AdeZQK3Y0M8kN7Qkhciug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddviedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:reftXEqMiHbJhE5i2NZ-mXeKl-NK0iqTAVjymI2tVf2OWyod0PNm4A>
    <xmx:reftXA-AzznNp4LLTdNivUODgvf3QYAOf8KIxPIFIgzDqEdcKh5YuQ>
    <xmx:reftXPN1xwsbGYOVYulxBphHCVE2FCHmOqXGmVFqr-uXFSAg0nXUsA>
    <xmx:r-ftXPzJlzd3uKn9wPg23LmkCQmUPdda0Y5brmsm8GXAHfHiIf0Ktw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 49A3CE00A1; Tue, 28 May 2019 22:00:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-555-g49357e1-fmstable-20190528v2
Mime-Version: 1.0
Message-Id: <39ca244a-1243-4039-9dcb-7eb2183908d4@www.fastmail.com>
In-Reply-To: <687e4a77-0df1-4982-1edd-9d0559c489fe@linux.vnet.ibm.com>
References: <1558383565-11821-1-git-send-email-eajames@linux.ibm.com>
 <1558383565-11821-3-git-send-email-eajames@linux.ibm.com>
 <CAK8P3a2HSOsw33VhAk4Z8ARiYn4jG68Ec7fynKbrFWUNDo37Wg@mail.gmail.com>
 <687e4a77-0df1-4982-1edd-9d0559c489fe@linux.vnet.ibm.com>
Date:   Wed, 29 May 2019 11:29:35 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.vnet.ibm.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Eddie James" <eajames@linux.ibm.com>
Cc:     linux-aspeed@lists.ozlabs.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v2 2/7] drivers/soc: Add Aspeed XDMA Engine Driver
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 May 2019, at 01:39, Eddie James wrote:
> 
> On 5/21/19 7:02 AM, Arnd Bergmann wrote:
> > On Mon, May 20, 2019 at 10:19 PM Eddie James <eajames@linux.ibm.com> wrote:
> >> diff --git a/include/uapi/linux/aspeed-xdma.h b/include/uapi/linux/aspeed-xdma.h
> >> new file mode 100644
> >> index 0000000..2a4bd13
> >> --- /dev/null
> >> +++ b/include/uapi/linux/aspeed-xdma.h
> >> @@ -0,0 +1,26 @@
> >> +/* SPDX-License-Identifier: GPL-2.0+ */
> >> +/* Copyright IBM Corp 2019 */
> >> +
> >> +#ifndef _UAPI_LINUX_ASPEED_XDMA_H_
> >> +#define _UAPI_LINUX_ASPEED_XDMA_H_
> >> +
> >> +#include <linux/types.h>
> >> +
> >> +/*
> >> + * aspeed_xdma_op
> >> + *
> >> + * upstream: boolean indicating the direction of the DMA operation; upstream
> >> + *           means a transfer from the BMC to the host
> >> + *
> >> + * host_addr: the DMA address on the host side, typically configured by PCI
> >> + *            subsystem
> >> + *
> >> + * len: the size of the transfer in bytes; it should be a multiple of 16 bytes
> >> + */
> >> +struct aspeed_xdma_op {
> >> +       __u32 upstream;
> >> +       __u64 host_addr;
> >> +       __u32 len;
> >> +};
> >> +
> >> +#endif /* _UAPI_LINUX_ASPEED_XDMA_H_ */
> > If this is a user space interface, please remove the holes in the
> > data structure.
> 
> 
> Surely it's 4-byte aligned and there won't be holes??

__u64 is 8-byte aligned, so you have a hole after upstream.

Easiest just to put upstream after len?

Andrew

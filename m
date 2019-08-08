Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FA4C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D872173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ba5wD/BC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EDP/Uh9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbfHHJEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:04:11 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41135 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731038AbfHHJEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:04:10 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0EA5821FB7;
        Thu,  8 Aug 2019 05:04:09 -0400 (EDT)
Received: from imap5 ([10.202.2.55])
  by compute1.internal (MEProxy); Thu, 08 Aug 2019 05:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=UDxY0biEKiJkV/eKq0+tBQBLPV9S
        8cgzUqiVh5nUXFg=; b=ba5wD/BCWuz96s1vBnUw02p43fsiVJqc9YiKZHXlKyXT
        jhvCdrJE6pWbvtHiXtLsQOCH98bkZa7ZOVT9j3TP6h34tRGYBHn68g7JZ3hp8uwI
        mczBVUM1FLlSWv9XMGES3MT4Gqp3lB273sAUkkrwBEe8fjcgBy9OVB+51ClJTFGp
        ehY2fyuZhEPRsvfC8xZs7V+UF4N2kEKW9znbWzXE7zstfGVQIZULspIr126Vftvk
        AqlAECJ5BNQFieCwAepTdcdexWZPccyH2vU52E7TNMOtEa1OCKA/iCPltMy5o7As
        oQD/rBm/IpxaeJLYEvQVWbnscZhl93o+I2qNXiVg8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=UDxY0b
        iEKiJkV/eKq0+tBQBLPV9S8cgzUqiVh5nUXFg=; b=EDP/Uh9dw/lSheM3sSOAmP
        HJLsLx02h9jie8yk25vTAWmYiM2MDTi+gSYrBt1JIWdZ5CLyFgO6/9m+TWZrNeAP
        wlhoZowI+nghIOUHn3lvtwbBGyrlEOMyR5ivC+taAGZs5w53RTgm3jYhIMOKRjJk
        mO1gD+fYmiyyaZMB4lBR6m/OATJ0973MfI/BjNTeu/UgXZYPO3l02MjiTWvLhdWD
        VgJ0SSglAZRSRPrX6mG34WZCNq9+G0MmA4D9LBGpN5bT5uLhz/mOKGyuVJFQ7EHg
        Uw2oMOO++zbGeUbOOcoUStW/bgr8BUvMTYIe9CO89QOGDHnIPV0ik0lAn1OJk+HA
        ==
X-ME-Sender: <xms:iOVLXcG7rA_7M_zbi7RPGRYVs7GxU1Vyo5FFfo5Ewm2ggeRKeMGlRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfvrghk
    rghshhhiucfurghkrghmohhtohdfuceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthh
    hirdhjpheqnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghk
    rghmohgttghhihdrjhhpnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:iOVLXcxO-QKzYQu_bfF8Wvp_KxmO9L0qkNpsMYGI16PQOoRj9AYu4w>
    <xmx:iOVLXTjdfwG_pxjoP4g4CPrhI-PDb8cqedn0cNZcD2fjjRHwMGm6qg>
    <xmx:iOVLXXwEnOwruQjMo3b9l0Yy4gZ1yMeeuHBn_Yqa1lcLeUT1AfMS7w>
    <xmx:ieVLXd4qCunCQt9EOheq6iVPOAiHbBhvLs7D9QSGGG3K6MxTe3TchA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 413805C0099; Thu,  8 Aug 2019 05:04:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-808-g930a1a1-fmstable-20190805v2
Mime-Version: 1.0
Message-Id: <ce36089b-7061-4cd1-8262-eb3393c753af@www.fastmail.com>
In-Reply-To: <1565243458-2771-1-git-send-email-wenwen@cs.uga.edu>
References: <1565243458-2771-1-git-send-email-wenwen@cs.uga.edu>
Date:   Thu, 08 Aug 2019 18:04:03 +0900
From:   "Takashi Sakamoto" <o-takashi@sakamocchi.jp>
To:     "Wenwen Wang" <wenwen@cs.uga.edu>
Cc:     "open list" <linux-kernel@vger.kernel.org>,
        "moderated list:FIREWIRE AUDIO DRIVERS" <alsa-devel@alsa-project.org>,
        "Clemens Ladisch" <clemens@ladisch.de>,
        "Takashi Iwai" <tiwai@suse.com>
Subject: Re: [alsa-devel] [PATCH] ALSA: firewire: fix a memory leak bug
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 8, 2019, at 14:53, Wenwen Wang wrote:
> In iso_packets_buffer_init(), 'b->packets' is allocated through
> kmalloc_array(). Then, the aligned packet size is checked. If it is
> larger than PAGE_SIZE, -EINVAL will be returned to indicate the error.
> However, the allocated 'b->packets' is not deallocated on this path,
> leading to a memory leak.
> 
> To fix the above issue, free 'b->packets' before returning the error code.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---
>  sound/firewire/packets-buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

And this bug exists till its first commit for v2.6.39.

Fixes: 31ef9134eb52 ("ALSA: add LaCie FireWire Speakers/Griffin FireWave Surround driver")
Cc: <stable@vger.kernel.org> # v2.6.39+


Thanks

Takashi Sakamoto

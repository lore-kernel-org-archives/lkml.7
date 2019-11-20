Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F6EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 05:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893792244A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 05:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="o3qGQUUe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RnqnHsG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfKTFmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 00:42:53 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:54467 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbfKTFmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 00:42:52 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DCCF544D;
        Wed, 20 Nov 2019 00:42:49 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 20 Nov 2019 00:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=Lnorfs1rp+zeMCoeD57/2AmXPyjOL0H
        a6BaQrOFchsU=; b=o3qGQUUe6InpOAYfXy8pZ4Aqs4r7RB1G35quGiCXZDIklgV
        45j60gck2g/zQszAqi8c5Za9uuFa5OToie9TG5wKf3NeoRnlvwagMRfc//Pk0rYF
        Kp0HVwjVqIUqToU3xq5+rXif9s6UpACLMZAkRRCmwD5Si7rJP0tbTT2QE/WFQrE7
        7VuKvrMKtD2juGIk6FP0krdUfbgTJezKfvtUjqvYGxLAtovkGV5Fv0pyKDa660Cj
        Ydmasn6PPM9s6FrItrawAHkv4na+e4PssTrh1Gw5Rd4NjOJbUIlskIlSnVJTjx/H
        VKAqBkMlAYYu2/hW2uhZSv5Mfm4ySiVTzwVC4hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Lnorfs
        1rp+zeMCoeD57/2AmXPyjOL0Ha6BaQrOFchsU=; b=RnqnHsG5F6inIIh5Q4zjgm
        jhT8HWunrIhBUgPDBTzdY+IWPi5/RIUCil/IMKaxvwJStupYTq2x4Nfai/529Ew/
        CbSkQXByeHdM9Zn9jr6Aak2WeoWvz+zCIOzdEPis/Pj43NpTZUhzrAU2LCvEg5At
        Ob90D1o6vVMxq6i6iLhSYOClZhVI0j7bZhnyhTpVnypYpe18cS/iSanEk2EGNsZU
        AFX9JbHLDzBuSM31HA/uwhdD+4JNEcbxRUFMZCSRKl1zORz/LfrqUMtZ3Wzhm/Zk
        MBlSniBn3RO6TNRZe4c4wMYGd6vAKtX7P7U6oQ8s2CnSsm20lmILh0INSbO5RmPw
        ==
X-ME-Sender: <xms:WNLUXd5dG-U05OpUaPC8cDUivrbL-UkP-j5oBZigZG7yxrksdLol1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudegledgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:WNLUXYdH6Bp1flxoNbpZ8YDkEmHnwesdNblqUanSOJZ-bRbxk1gwqA>
    <xmx:WNLUXa4sTbaCEh-VU67y0PE8UnuxPOeusrNXs3iPMY6JbKmDg61jvQ>
    <xmx:WNLUXXsuHVHcWuFeLHbTN3Gi0uEOdZYdoqVQiWJ_vZauzx_GrbfTuA>
    <xmx:WdLUXagf4JLSbPkH13VJVF-BQk5VeeoCdyLYgpw_B1BF0InArSF1gQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C89EFE00A3; Wed, 20 Nov 2019 00:42:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-578-g826f590-fmstable-20191119v1
Mime-Version: 1.0
Message-Id: <787e54c2-2fe3-4afc-a69b-94771726194b@www.fastmail.com>
In-Reply-To: <20191120000647.30551-1-luc.vanoostenryck@gmail.com>
References: <20191120000647.30551-1-luc.vanoostenryck@gmail.com>
Date:   Wed, 20 Nov 2019 16:14:12 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Luc Van Oostenryck" <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Robert Lippert" <rlippert@google.com>,
        "Patrick Venture" <venture@google.com>
Cc:     "Joel Stanley" <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] aspeed: fix snoop_file_poll()'s return type
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019, at 10:36, Luc Van Oostenryck wrote:
> snoop_file_poll() is defined as returning 'unsigned int' but the
> .poll method is declared as returning '__poll_t', a bitwise type.
> 
> Fix this by using the proper return type and using the EPOLL
> constants instead of the POLL ones, as required for __poll_t.
> 
> CC: Joel Stanley <joel@jms.id.au>
> CC: Andrew Jeffery <andrew@aj.id.au>
> CC: linux-aspeed@lists.ozlabs.org
> CC: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c 
> b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> index 48f7ac238861..f3d8d53ab84d 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -97,13 +97,13 @@ static ssize_t snoop_file_read(struct file *file, 
> char __user *buffer,
>  	return ret ? ret : copied;
>  }
>  
> -static unsigned int snoop_file_poll(struct file *file,
> +static __poll_t snoop_file_poll(struct file *file,
>  				    struct poll_table_struct *pt)
>  {
>  	struct aspeed_lpc_snoop_channel *chan = snoop_file_to_chan(file);
>  
>  	poll_wait(file, &chan->wq, pt);
> -	return !kfifo_is_empty(&chan->fifo) ? POLLIN : 0;
> +	return !kfifo_is_empty(&chan->fifo) ? EPOLLIN : 0;

Looks fine to me as POLLIN and EPOLLIN evaluate to the same value despite
the type difference.

Patrick, Rob: can you take a look / test?

Andrew

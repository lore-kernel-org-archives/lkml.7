Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DFFC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 06:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBFE2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 06:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="HvbUBX9f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gZ3fJUS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfEBGzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 02:55:35 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:42469 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbfEBGze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 02:55:34 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 May 2019 02:55:34 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 5AD236A1;
        Thu,  2 May 2019 02:49:34 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 02 May 2019 02:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=1tWIqDm306vX6iBn4rFWeYUqrrvzuMc
        oJyS82ojMYzo=; b=HvbUBX9fPj2FZfqyzF3t/KWM8PUFELCat3msyWb3W6EaR4p
        NIP+uqNoxXmFOvIANSg6O2NIgTy5bYPWNz++QCLGTdXmFnMFIX+1K/xIKEdCLjdA
        jvPqyTDa1jSoAtjFNevf/lYcxTswhp7zSs5FukCqO7tM/ANWoaad7ibA+LgY3pag
        1lvb/+6ZNwOhcTnbuCrz6Q8+u1QVwSWr35OQr9NPxzrMlocVqVWrjOE3hkgg/0T2
        NfwCEZaXcAwYvhKwJ55OkpkxOm2Oovp603i8e94MpDexuMuUMBAin+sbYk+5q09C
        /dpYKeYNn6BK2yFCtbOoCegErkpPWJ2OKIMskPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=1tWIqD
        m306vX6iBn4rFWeYUqrrvzuMcoJyS82ojMYzo=; b=gZ3fJUS5nSD17n7aojoHnY
        TnjAGXUg2r+xab/A6WJtUDbVEVzeStOBhjnSTRJM3Ak/+qrctyvJ7vfoDH3m+XZY
        XBeUwl0DJCui9MuZ+aHearg1FGZPuOXC1D9V63Sh3zpk5NPx8hbKpN0zahTDkgdY
        kPuN2Hnfmycjv6ZGAxs4+psw9Lh7yEGs1kzTticQxRv23Xzn+gT5Ow0hsQvngtuX
        EE5hQ8jibl7g/JRRe7eCy7e+dKi1O9cQAuIUUdFIquLNWZlF8wDpwvm4Om2H8mds
        pgWNmjN1tc4vlCXKWnZdt8bPmxrM5CmpwZGy91t5xfiBRKR3lfIFtjTzCLmW7sOA
        ==
X-ME-Sender: <xms:_JLKXK9KgEtGXQWO9AmYCHtdN-ztZEEkB_ZSfKsSXt2C36acqsaS7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieekgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:_JLKXEWKWIB-BjyKW81S-YFYD-DG08J8J1TUBSS0R0MdkSoBJlXMQQ>
    <xmx:_JLKXDdF7qu_CB90gOBQbYc0cfxRHtOIrg3f9g3_qXcw8ngcIM1Wcw>
    <xmx:_JLKXJXCXjX_5wmGVoxgu6HdUnks4D-soxf2oLT11k3x9RBxGP9Wiw>
    <xmx:_ZLKXJbHnD7LzyDpiZxOBdPI_dtDvZTUIbieq6F3zQWesxi8E1yDKg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A1D3C7C6D9; Thu,  2 May 2019 02:49:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-449-gfb3fc5a-fmstable-20190430v1
Mime-Version: 1.0
Message-Id: <6defa7bc-ec29-4418-b05c-fb96c03621f6@www.fastmail.com>
In-Reply-To: <20190502064021.GA14911@kroah.com>
References: <20190501223836.1670096-1-vijaykhemka@fb.com>
 <20190502064021.GA14911@kroah.com>
Date:   Thu, 02 May 2019 02:49:32 -0400
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Vijay Khemka" <vijaykhemka@fb.com>
Cc:     "Arnd Bergmann" <arnd@arndb.de>, "Joel Stanley" <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sdasari@fb.com
Subject: Re: [PATCH] misc: aspeed-lpc-ctrl: Correct return values
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 May 2019, at 16:10, Greg Kroah-Hartman wrote:
> On Wed, May 01, 2019 at 03:38:36PM -0700, Vijay Khemka wrote:
> > Corrected some of return values with appropriate meanings.
> > 
> > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> > ---
> >  drivers/misc/aspeed-lpc-ctrl.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
> > index 332210e06e98..97ae341109d5 100644
> > --- a/drivers/misc/aspeed-lpc-ctrl.c
> > +++ b/drivers/misc/aspeed-lpc-ctrl.c
> > @@ -68,7 +68,6 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
> >  		unsigned long param)
> >  {
> >  	struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(file);
> > -	struct device *dev = file->private_data;
> >  	void __user *p = (void __user *)param;
> >  	struct aspeed_lpc_ctrl_mapping map;
> >  	u32 addr;
> 
> This change is not reflected in your changelog text :(
> 
> Please fix up, or break this up into multiple patches.

The return value fixes should also be squashed into the patch that introduced those lines
given it hasn't yet been applied.

Further, IIRC I previously suggested removing the dev_err()s entirely, not just switching
them to pr_err(). Returning an error code is enough IMO, there's no need to pollute the
kernel logs with application-level errors. Or make them dev_dbg().

Andrew

> 
> greg k-h
>

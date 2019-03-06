Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D34C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E8C20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="hkGpfIRw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LBWIqIvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfCFVt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:49:58 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40819 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbfCFVt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:49:58 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C888724539;
        Wed,  6 Mar 2019 16:49:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 06 Mar 2019 16:49:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=U6Mzn5zmmi/RZCnEuGaG3vqz1fW
        gi9ayODANZ8PR6xQ=; b=hkGpfIRw+sjzylR2uKL6kbS6XdcK6mDBwgGx95TsGQM
        MLZpmaOeNyEXgnug3yMK/LNETzK34D/nBNh6BTVRvl2FnzxxPXNC0L2I/YE7zP2y
        GPuBSy0p+vgtrTGdykynXolb4Au3BQvAQZ04hPNr5bDwbhDcsKEr5EbSel083XFA
        sdx/VDQz+rY41sqOs1VM+ny7BwZF9eC1+EZQ1jLCummTqGeM2DzZFn1YwROHQO2O
        fbDn6TjAy4z41Aqj/U4lVYnFkxktHaEoBBwV3Yd7lM192p0Onu5hreILl1PtWay4
        R/E+dLMn2MjYzZFQbdsGfI+svek8ycSYLWDR8oFyadg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=U6Mzn5
        zmmi/RZCnEuGaG3vqz1fWgi9ayODANZ8PR6xQ=; b=LBWIqIvsY2/hDKeX/lyG5L
        ZY974DPt6DatjXxiHfWUlB8m9dGAeMsqr7Axj0aGZo3YWGzqzizg04bJATWhd/If
        DERWK5D3+rtWrAzU8TtkFJ4npWP2Pi8HYPuy0TO2cc0nILwTVKP6G9Og+ggUGIJB
        eePNgeKn+SxWvGuiCtR7e5afdLiW3sFIvYVcLwrNqD8C/BKgKTQji1b1b4AXz2UD
        Ox4bLPS5juT2Tt3XlGvRjMUdUxyflth138C89HoLY1EoOQ0j2C+3bsJ03Jl/ovs/
        d/sGOnz6UeS4tO67jWImMYct1vuDja9xDPPb6e54F6aHLXujExESS7tAoa/0OJXA
        ==
X-ME-Sender: <xms:gkCAXPmYCRRj5E4FyuQvOj2Df0FTiimhNYiq_xg7D5YNVOf3ketOkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeeigdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvgedrudeiledrhedrudehkeenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:gkCAXKTP48w46JOBUxBmeYEGEWYt6RrMVmcpMqU-rLi-_-evn2z-8Q>
    <xmx:gkCAXDDJOsFatt5Re9WybrGGtm7nfWYTR5Qzasx65HdD5lXEdJNrmg>
    <xmx:gkCAXBRN0xdC-IFPkaJUEQx-BDm6HiA6cAFRfrMq5wiexMgrIJjh4w>
    <xmx:hECAXKykRM0S-9IxF-lsQSFoQuaFpI37IY7f15vtUVQFrZaPCNduIQ>
Received: from localhost (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id 39B43E4752;
        Wed,  6 Mar 2019 16:49:52 -0500 (EST)
Date:   Thu, 7 Mar 2019 08:49:34 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] lib/string: Add strscpy_pad() function
Message-ID: <20190306214934.GA16461@eros.localdomain>
References: <20190306214226.14598-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306214226.14598-1-tobin@kernel.org>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 08:42:19AM +1100, Tobin C. Harding wrote:
> Hi,

Man, I didn't see the merge window was open, I thought rc8 only came out
on Sunday.

Sorry, please ignore this.  Will re-send again later in the cycle.

thanks,
Tobin.

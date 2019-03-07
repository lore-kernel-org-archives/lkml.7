Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D90C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E7220675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="r1Fl/OLN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pJVAD6Oc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfCGVTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:19:25 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:44603 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726186AbfCGVTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:19:24 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 846133748;
        Thu,  7 Mar 2019 16:19:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 07 Mar 2019 16:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=5u3tnfCqOLKiIxkQeqOOrQiW94J
        B/BT6R1pNe0f9fTY=; b=r1Fl/OLNx/uzj8sNDcuDq9xlVGdwWJm49ui8NmCJlDV
        6yAm+YX8sm4Ona3SPzSDzARTtcDFVFnQ0i33XGzi/+actzhav5gBwY0S2czfUVJx
        UDTnywyG5ay+5eDYFfEd8xL/5P+4WDRfUlBLfEVAznDyTXrxQJME7HPxUxyvtZS+
        8Kzbsi0ASgIARNP1J414KWm3BHleWC2pGT0hhw1wtcMK55EDe0CyjZ6l+ZyuhzF9
        v35OL8KvSdjRmwCh2OI6KC4ORlLjfe+jwhIQ7hqO428Q5dc/YlcRqtzjIL+e8crn
        VXnDN9yu4U530VyMpWCJKPEuW5vNnVl/vLrXU/Pvx1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=5u3tnf
        CqOLKiIxkQeqOOrQiW94JB/BT6R1pNe0f9fTY=; b=pJVAD6Ocj1q+kpHHe+PHDn
        nUvnXxuk/+SV416TLMQdEW8Zdkn7Zz8ior43EyhACFc/zCOd7j7mxs90WAhbEnVP
        TSd/JjupM2XGGPZLDXEo+fSZP5DllVfFPwLe/yW+grFUxYYWRdOmLJMR3jg1So4S
        T6zy0346B4gU9klCWUcIkMoiFrzknmoX7v2PIrBKaBIe2GP6dru9T4/8xrwlYuXY
        oJe4ZB6p5kjtGOYDFR/yLK9iL47dDhW6pMB9ElSm9dNGW6OmdeKUNKs9Rnw7VpSj
        0aniHtMtfPvF2lIwd/qP37tpeJjpj5lwBQdYiQ9GD6A9uom5osGMUquSO3AOtXTg
        ==
X-ME-Sender: <xms:14qBXH0cUIe0XqJEW7RlYJgCjAKJVGu541pL7QmjxYx8TZH6On4gjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeekgdduheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvdegrdduieelrdehrdduheeknecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:14qBXA3lqYk4zqDmNcbTvkAfgaiQdl55GJcbByhAi5nsNvhcKAsi7A>
    <xmx:14qBXBMfUTtg7M49_bO7qcMgdO-cHxFxYIMJY1j5CP52BqyoQnaSBg>
    <xmx:14qBXLmdVD2TcAeG5F6SBRW1BtfF6jnTSUqVqlBGaFEGZQmo8DF3jQ>
    <xmx:2oqBXMFPGbNkJNgy-ho-SF1JHvZMYXcqPrWJQh9_9dxX0wdqGLvD1A>
Received: from localhost (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id E4595E4383;
        Thu,  7 Mar 2019 16:19:17 -0500 (EST)
Date:   Fri, 8 Mar 2019 08:18:58 +1100
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
Message-ID: <20190307211858.GA28495@eros.localdomain>
References: <20190306214226.14598-1-tobin@kernel.org>
 <20190306214934.GA16461@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306214934.GA16461@eros.localdomain>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 08:49:34AM +1100, Tobin C. Harding wrote:
> On Thu, Mar 07, 2019 at 08:42:19AM +1100, Tobin C. Harding wrote:
> > Hi,
> 
> Man, I didn't see the merge window was open, I thought rc8 only came out
> on Sunday.
> 
> Sorry, please ignore this.  Will re-send again later in the cycle.

Multiple people have suggested to me (offlist) that it is fine to go
right ahead and send patches whenever.

Shuah, do you take patches to kselftest at any stage of the dev cycle?

Kees, same question please?

thanks,
Tobin.

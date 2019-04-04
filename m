Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBD3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FDA206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="Kc4/J7PZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V0JWr6x6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbfDDXQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 19:16:48 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37195 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730972AbfDDXQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 19:16:46 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5D7D123026;
        Thu,  4 Apr 2019 19:16:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 04 Apr 2019 19:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=cab/mfR3eYkfx/wkUXwP354wz5D
        kZMO8skXhItzJXSc=; b=Kc4/J7PZbqnek7GNn8lhXziS2YhynBlymeV56xzA+jY
        VAohOgGu9iLbSMyASsZ9He1Q+TEai15efMqfB7gGm8DdaaYvp+o21vHnTXadsrt2
        lH7zA6m3iVyNp6jMQjcp0i51W6CRo9j2DtC+LEhovZfn3VMQbUpEMPHQ17sJwUlM
        co6JxedHpWnKWaGvt62colNIgpV87FVsKw/oVI5qKBAwlss3xo/g4tIpYZ1/Zcvw
        hfQ2tWWSTmRmm8BAY+hBYBXhEtXA4SXetLA/6M+DQWEqMJ1SV0SrRHcxrPzROUhP
        BeY8MS/wOibff5AcjyF/6h5t1oMi1JetHc5cE9ld4jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=cab/mf
        R3eYkfx/wkUXwP354wz5DkZMO8skXhItzJXSc=; b=V0JWr6x6W1I9PI0r/eIuc+
        wObR4r1BgZQkN3/DxhZ2E8ydy21SP7NKkp9SR6Fa2n0+R7Q3lIlBP7UzRMIrj2c1
        rsLdWbG/uiQh3YJXJw54wwtWKeZ81T1X2AQtqiwIxnw00PxrNCdnbX9ukMRuoL6f
        GNuzMAQj+A0lSVKKfvo8M0FmHByY2nrNVhUIWJDhEZo30/0cryq4u+JGMhIM0rlZ
        BiiyTN0/kY7ciNHooJDOvkQlCC9twMc3Y5ckqAxUEj0RiWb9x3VZEWAsaSnlxNft
        P+ZUZ60bk0aeYTkdBGoQo3k+feRHelR/+wjOfiAG69tFM+Xce3riBVRUvhTZ8/rQ
        ==
X-ME-Sender: <xms:W5CmXOmAVjQZMB5mhtZKEkONTgnvuCt6v1KGjL7PoZrcKV4IaMX2AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeigddujeculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhf
    gggtuggjofgfsehttdertdforedvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrug
    hinhhgfdcuoehmvgesthhosghinhdrtggtqeenucfkphepuddvgedrudegledruddugedr
    keeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluh
    hsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:XJCmXKEul4b1RJpiRcbeLn8USFg9Ap6gkMiIXLfUzcj_iotVyKR7wA>
    <xmx:XJCmXHptWn5u_OuMa2OWougqcWWRNXW0M7cmZTUf6mm1aLqD4Kiy5w>
    <xmx:XJCmXG5CU9Jzw4i4IpY9Xe_0btayuYEgdQt9xS6UY1JLWPOl-AJ44w>
    <xmx:XZCmXEeTj3n848WzFdgXGPO6fO_xEfRJ12vqKw8ygk3FLbT2hgR-VA>
Received: from localhost (124-149-114-86.dyn.iinet.net.au [124.149.114.86])
        by mail.messagingengine.com (Postfix) with ESMTPA id 73C3D100E5;
        Thu,  4 Apr 2019 19:16:42 -0400 (EDT)
Date:   Fri, 5 Apr 2019 10:16:13 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/7] kselftest: Add test runner creation script
Message-ID: <20190404231613.GA30424@eros.localdomain>
References: <20190306214226.14598-1-tobin@kernel.org>
 <20190306214226.14598-3-tobin@kernel.org>
 <CAGXu5j+=O3C6z7H5j93Z4mQkpS3f0ea_7T+LRQEnRCZCoKX8zw@mail.gmail.com>
 <32a2dca5-d3cd-e7d3-e73b-406d897ae174@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32a2dca5-d3cd-e7d3-e73b-406d897ae174@infradead.org>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 02:33:12PM -0700, Randy Dunlap wrote:
> Hi,
> 
> nits/typos below:

Hey thanks for reviewing this Randy, first time I read it I got mixed up
and thought the nits were against Kees' additions but I was wrong,
thanks again.

	Tobin

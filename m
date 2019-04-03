Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8663C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B52206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="vF2Td1PZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5hG0UCwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfDCAYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 20:24:43 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45077 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbfDCAYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 20:24:43 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DC39421FD3;
        Tue,  2 Apr 2019 20:24:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 02 Apr 2019 20:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=LqrPwreEhQW2o7wMDwPxrwAVDt6
        UAhrtd1oi8LwyhSM=; b=vF2Td1PZH1kHdjbA9EhBy4fDW5LEN6mVIoOpCNJMx0R
        OWn6DIzALeu+gQcGKeDnMhxedZlrDeMAsHx8IIGD/eicQI7Ec1TbpBslKZ4rirRG
        HxGhvqt0NdAPFcxnhd7ZZS9iXd1n9m9mcBT8d8nz3lqTtoSDLpKSqI9116qTOfmA
        2uc380NFHd0uDT7eo8tkC1C0IdPXAmVgjlmWQMBkUuGfo66AyR50CP3ylPKe2lsn
        hMc0jdaKDwlrGj5lWL8aq7mNrxCbctO+NuNNT3n1DvyvNFe59XozBURCvR9qgmZh
        Ra34w4+WV8xpQc8bFUEwrCXd2vq6p+8p62TQwt3ueCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=LqrPwr
        eEhQW2o7wMDwPxrwAVDt6UAhrtd1oi8LwyhSM=; b=5hG0UCwA4kNiJeD9VYP+Nq
        35uNghqu+hCp0LOZSioZmOmbQ4RCvHP4Ks1kyd+5jqb0PaYVQwqFXQXYxIoWXUxl
        z1PoXcrFlSUSrPZo9IqNTM1ZE+tlp0b3v+lwMfFhlP+RBVb1amdKeiD4+netFS1O
        +irHX9Blq0Po20Q5n6/U3sH4wVqptSbGFM4okd06vjUrzlYVbL/e62hNyBvyJw8L
        CbJZNRyxJQNlIx9RPzBjQQSKlpEt9V9KYenToeC7Xq23ScGDpvecri/Jlboh6MgV
        i81RSRTUY82jDZlZl/5E3XqF6qTY8/vDxh8QRoDvAEt6ZRxrw8mygXauag03SnUw
        ==
X-ME-Sender: <xms:Sf2jXIm8K9zGInYGK9xLhEu4po1ZHrnj1AEIySdXug8GxekBEdIwQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddugdefvdculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdduhedmnecujfgurhepfffhvffukfhf
    gggtuggjofgfsehttdertdforedvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrug
    hinhhgfdcuoehmvgesthhosghinhdrtggtqeenucfkphepuddvgedrudeiledrvdejrddv
    tdeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluh
    hsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Sf2jXNV77fDkxuyv8St-Bf5mK3cfdqyA2PW61mmAkhY9NTJdLwnSow>
    <xmx:Sf2jXO-u1TKfX9QYS4o6j31G7diWqsf5IKhurykPydhwzaD-vqsWew>
    <xmx:Sf2jXCr1MMLaYFvsUsAxuZ7PQ9v7RjefAUQBZAH_CauD-UzLrKCyaQ>
    <xmx:Sf2jXERipD-84XfB-Uk3a2dm20GXlIzTIWVRirD31DBKCdrFokTQHg>
Received: from localhost (124-169-27-208.dyn.iinet.net.au [124.169.27.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 86FFFE408B;
        Tue,  2 Apr 2019 20:24:40 -0400 (EDT)
Date:   Wed, 3 Apr 2019 11:23:55 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3.1] selftests: Clean up module testing shell script
Message-ID: <20190403002355.GA29296@eros.localdomain>
References: <20190402222610.GA15100@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402222610.GA15100@beast>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 03:26:10PM -0700, Kees Cook wrote:
> This adjusts kselftest_module.sh to take an option "args" argument for
> modprobe arguments, removes bash-isms (since some system's /bin/sh may
> not be bash), and refactors the lib/ scripts into a shorter calling
> convention.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This is my suggested clean-up for the module testing script for the
> strscpy_pad() series...

You are seriously at risk of being the most awesome code reviewer on
LKML.  Beer is on me next time I see you.

I will roll this into a v4 for the strscpy_pad() set.  Would you like a
Co-developed-by tag or just a mention in the commit log?

thanks,
Tobin.

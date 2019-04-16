Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBD7C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9510B20857
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="S2+V0OQs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F4iiQH24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfDPKiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:38:46 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44335 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726682AbfDPKiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:38:46 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BBA2C21C28;
        Tue, 16 Apr 2019 06:38:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 16 Apr 2019 06:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=zN/ZIYi/aq5qbuo+6eh0bUkCq5/
        s9b24BluyNPa+8YM=; b=S2+V0OQsJ4x6RUe1kv8M22NZjYQ3NAiBYop/5IXuLKF
        5Sbdl1/QoreF/PJ0/Yi60Omooauu++Mbm1FnbAsopu6nvpFnbS5/aOj/MojvpNoA
        zX9FB076o2KgXr/eyWmrGe2LHMz2SJ9Q1d3kmTlrPnFQ3hQyemU8fmD8A3vDF4dC
        +DR+dX1LRatOkRi832RO1rqUq67bcc7M3Ojb13V0uh7zKY0SmNvSzYf+RZ8FYZ+v
        fWeVAUy251vokdbcggUIF3hOKcMG2Xc0e4BbUZqICfliVNlzlLXTDFFfxUln0du8
        60coOFy0SU0PZ6toSvgHEsJ/h+wtZ0lQehZIlLO/lww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=zN/ZIY
        i/aq5qbuo+6eh0bUkCq5/s9b24BluyNPa+8YM=; b=F4iiQH24dOyz5yXPf/IlLT
        6LHhRhgcULDLXVXIe9Imid1T1tufuFfCGTV3LoZyrT5FZXdwH8eqIsUWSCCHV0K5
        rajV61BVWY/FtlAaqqTLQjqq352OVzPCBMgnu8H2sacK1IxEBOB60D1RJgeMVfbB
        Bf5xhoZLE4BxHL6dq3Ei5iddsVkT1kxQPAfmDRlY5yg26HHqvhU/A+3eBw+11A1U
        6zYfAa1Yio3S9nQRQ99cdXO/hmNRM8Niq0qZhdhps0vyXIwYieCVCIe+4E08NYC3
        S/BLGNROxSvOrAMU+18XNmKxviDZELUVbxl5vyw7Sp5aPaRl7rfR5XI0nyLqjMJA
        ==
X-ME-Sender: <xms:s7C1XGxoscY4NefXiOLtCS5OjLJiHZ0JTaUtO2uOR6KoZ1plNTb-Mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrfedugdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:s7C1XL9gd8Z75kmCEwBZ60mPnOF5qufR5M-Gz3_C0K0WmXgZ7MeQ0Q>
    <xmx:s7C1XHoMNZP7XO3XDBLSW41u8997ilrS0nF4Jc9vztQrwEp-Z_4ZeA>
    <xmx:s7C1XEkKRbOwZHarjZDbLonzf18u2HxvfO72cqF6ASLfJIlXR7FpIg>
    <xmx:tLC1XN8x0T-bg5Satsr4Lvv2ZMCKRLEMKwVWntX0YDskFwjgM3Ir2A>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 144CFE4AD3;
        Tue, 16 Apr 2019 06:38:42 -0400 (EDT)
Date:   Tue, 16 Apr 2019 12:06:56 +0200
From:   Greg KH <greg@kroah.com>
To:     Yang Xiao <92siuyang@gmail.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-usb@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Kees Cook <keescook@chromium.org>, hans.verkuil@cisco.com,
        Young Xiao <YangX92@hotmail.com>
Subject: Re: [PATCH] USB: s2255 & stkwebcam: fix oops with malicious USB
 descriptors
Message-ID: <20190416100656.GG896@kroah.com>
References: <1554958452-29794-1-git-send-email-92siuyang@gmail.com>
 <201904112252.HfZVFACR%lkp@intel.com>
 <CAKgHYH27TtpbUKJin+WyTRUvqgpTSBRWBTp6YhsUCpVTnKfNPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgHYH27TtpbUKJin+WyTRUvqgpTSBRWBTp6YhsUCpVTnKfNPA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 10:14:50AM +0800, Yang Xiao wrote:
> Sorry for my mistake.
> 
> I have fixed the mistake. And the attachment is the changed patch.

I can not apply attachments, please fix up and resend as documented.

thanks,

greg k-h

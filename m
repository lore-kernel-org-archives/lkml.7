Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029F9C4CEC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B5720830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Mwr57xLN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="egQWtmzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391123AbfIMPJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 11:09:43 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:48093 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390046AbfIMPJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:09:42 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5BAE420E7;
        Fri, 13 Sep 2019 11:09:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 13 Sep 2019 11:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=78Q8OlRfap8fz5xWN2Z89uJar03
        qpqVETxGfaTCfDgc=; b=Mwr57xLNKNl5KVc9AAC4AXlZg7SFqmeWA9w5FAcuU7C
        NO5np33AL2z8HZ+2M+ocGoN5yCEfw4ZfdeX3Wl2r5OPdouks+6s9Mzn++Gyn4T4P
        6HdZ9vSZEaLF0ueq40ExW3oSixgOTspsk+Lebn6O57gZZJ7aoYqCq7aMSl7hYwX2
        WPmDyFfYK4dtFMOiIM3Gy8Lk2UY4/hcCGALME2BpINbFKEpqV+NaR+X47qqYIa6x
        YubAjnYSJY+Qi9CnW7jdEmzVN7IsKV+LxsGMCApf1XRYliesQld0fJcpOXkbmE6S
        ZcTLrnScDlvpxGsTiYwDwS7ig9F7VwEG0U7NhkrK6Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=78Q8Ol
        Rfap8fz5xWN2Z89uJar03qpqVETxGfaTCfDgc=; b=egQWtmzBrxtMs78VfqVbOf
        Ks2/KL/qe7yk2+GFtdsZ9pjkWWDbRFFos4cvKCb6RLRN+NYC0cnqwuvdrEFvXzYY
        GiES11wnhQ3/b/AVDEfUsfFl18KE7zSgQrZKNoyarrwQQ47P++eeMZFIsiB+9y/1
        mDFP7d/owYmlmqhBgzhWxBorzNQ7V6Z/iWj90607rt6x184SBzyswtjvRdazDEkb
        uC3JxMY0FbB7Tbz/Y28NMfwasjsS3sU+1lRN9gxq7CYbXAujncwX/AQjH3vqHAkU
        rz3VRQG2+pDpaqAcF5B9kMkUGR0s87bjdwhD78p4edcNUVlp3y/eBSgZsXU4JR1g
        ==
X-ME-Sender: <xms:NLF7XT-36XisQUcNFLz0hEhw-swy3XGEK0Eni2Hu41m2G19LOJfLmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrtdejgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuphgrmhfkphdqohhuthculdehtddtmdenucfjughrpeffhffvuffkfhggtggujggfseht
    tdertddtredvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtoh
    hmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedutdegrddufedvrdeg
    hedrleelnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
    enucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:NLF7XfSJ9Ooz9_csxLNvxttrNjFFi64zT0IPNylTo8TkzG0T-jQX3w>
    <xmx:NLF7XaZ4S__HpxZrT9LO-Ar_UWJ86BCZhMs3l5kTf1Xp0Dx0j2XAww>
    <xmx:NLF7XYTq9NrMOcdDErH17JIVx8CQYeIoEa7dQ1e1jwPJu7x5Yj5URg>
    <xmx:NbF7XT3s0hH11zDnxyvyv2dNjYcIZgFhlvZ--rg3g808f2eccdLoqA>
Received: from localhost (unknown [104.132.45.99])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8E6C78005A;
        Fri, 13 Sep 2019 11:09:40 -0400 (EDT)
Date:   Fri, 13 Sep 2019 16:09:39 +0100
From:   Greg KH <greg@kroah.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: [Ksummit-discuss] New list for people to share maintainer
 workflows
Message-ID: <20190913150939.GA458191@kroah.com>
References: <20190913073849.GA15965@mit.edu>
 <29b46dfe-173b-7022-8676-f3c4000a8375@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29b46dfe-173b-7022-8676-f3c4000a8375@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 08:04:07AM -0700, Randy Dunlap wrote:
> On 9/13/19 12:38 AM, Theodore Y. Ts'o wrote:
> 
> > Let's continue the discussion on workflows@vger.kernel.org.
> 
> Hi,
> Will this be archived on lore.kernel.org?

It is already there:
	https://lore.kernel.org/workflows/

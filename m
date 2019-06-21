Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBEDC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4514E20652
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="pB7XJPRx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cFKxi/Ss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfFUPEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:04:50 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33953 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbfFUPEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:04:50 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 554112211E;
        Fri, 21 Jun 2019 11:04:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 21 Jun 2019 11:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=zG55VncHkz6LJ59AozPYl8biJeb
        XBi2KCs6/rgVfSUI=; b=pB7XJPRxOuCrgkrA4gKktitowy4ilexVihUO8gYZKjZ
        0FMVgDfF44jO5GGI67EIFJSvOFViE6HU7p0zzq/X3E58c1ycQ74yEwpx3t6yu0i3
        JasXbBEt1KuHU7L1SMpHHENWw49FaVmZweCSZ5Q2me/PC7x/WAS4FWoo62+BDZDS
        ZibN35CqIvrVaV9w/yyL+Q0U9QZIhf/jCZqLs24LRoagtR4Qk3BIFwU145LKXY1t
        p+kWYpX5Kv/EKjvKZymn90NriXIEn7vplDlsNFsU3oKPwViNbprQ26IKQQzRfmcg
        jxfE/FrZWkOJJhRn7OXJOPBVfd+mCuM8OKzEeWAxNfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=zG55Vn
        cHkz6LJ59AozPYl8biJebXBi2KCs6/rgVfSUI=; b=cFKxi/SsePJ2Zk5WaOBwLi
        PFxr+F1UR8S1woEvVHDH4mUuoIjGSRu+l2UGvPJMV38S20S9nlJ5t2ZD5V4C8dp9
        3xqseobd4GqHVhlIJGAmfCr/+CfPkB12EoIou0Ux+WfRBVhmaKyBtDKjZUbIBcEl
        2De/o8o47dNQP3ZJ6hWlOd1il1nFr6HZMFjqvTGKHNfnz/tPu0KLdtOoicQnne0A
        fnBs8u+DPjomTq8UFAoLC8MHwkQg8t7LMN5WugSDdm5pX6fBY/mYIashruwB/Yj3
        fTZkMZ1HNTpVeSpf99duETsr/jvCdYC8/3Vp55lEi0GG5/6sjjAGsuKDgF8Jr+OQ
        ==
X-ME-Sender: <xms:D_IMXWLtzizZ4kAMdsroUXg1NmlavFC3OY2qfqTfO3MnW9oYuLbCUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrtdeigdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:D_IMXbv6_LqrDv8f1EyQvwPzBAPsi9xVwwwjTibGTsbjwE5gjjMmMQ>
    <xmx:D_IMXdIxDsQcsZa3HEAPObVcIgsA0sVOfMw8mAyAkodxK6B4QvOrNQ>
    <xmx:D_IMXc-2GozhEI2wpFb8kiwARuVPPwwxrT422ZG8b4l5hVVfq1Zegw>
    <xmx:EfIMXXlB-6azIiAyDHE555Xzc8YU51uP8p4z1f94K7yRGoO6GGkt9Q>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1A1EE380085;
        Fri, 21 Jun 2019 11:04:46 -0400 (EDT)
Date:   Fri, 21 Jun 2019 17:04:45 +0200
From:   Greg KH <greg@kroah.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2 00/22] Add ABI and features docs to the Kernel
 documentation
Message-ID: <20190621150445.GA11015@kroah.com>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1561050806.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 02:22:52PM -0300, Mauro Carvalho Chehab wrote:
> This is a rebased version of the scripts with parse
> Documentation/ABI and Documentation/feature files
> and produce a ReST output. Those scripts are added to the
> Kernel building system, in order to output their contents
> inside the Kernel documentation.
> 
> Please notice that, as discussed, I added support at get_abi.pl
> to handle ABI files as if they're compatible with ReST. Right
> now, this feature can't be enabled for normal builds, as it will
> cause Sphinx crashes. After getting the offending ABI files fixed,
> a single line change will be enough to make it default.
> 
> a version "0" was sent back on 2017.

Ok, I added the first chunk of these patches to my tree, that add the
get_abi.pl file to the tree.  I didn't touch the others that touched the
documentation build or other scripts just yet, as I wanted to get others
to agree with them before accepting them.

Or we can just wait until after 5.3-rc1 is out and then the rest can go
through the documentation tree.

thanks,

greg k-h

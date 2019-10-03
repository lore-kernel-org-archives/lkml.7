Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4893C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9255F21D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="MFhGXU9Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="loBHoB59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfJCHuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 03:50:11 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44159 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726214AbfJCHuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 03:50:11 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 509CD21EFE;
        Thu,  3 Oct 2019 03:50:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 03 Oct 2019 03:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=rMKJevVXXNvxbY0zhn4kydkHM2a
        tlZyHaBcKanrBFRg=; b=MFhGXU9QCG0J9en+wrXkGslKPIBdLFQiX4NlRdkqhQN
        pMFKMVCft2SQU+wHUbKeUY3tHm8Kn4SIumZrA3a6S2TbahC8NqNu9+5zUV1MR/7s
        U1WstqnWPKAu25djjZPa6Wf+Z0LxkAtoZfoHUWRP6pgJ3d+fXtPgY7dAX8SrOodW
        r7AKj6DkZo2mW7q58TpgqWGzrwYVp4+Zmadw1L0CXYW6UsoAo9c7TNTxX+kD9aD6
        M1FBRye/CZfZ+N4gnUpUXD3mlvozPbnqqlBYXfXr4EaiU4vUW1xXBfe4P0h2vsMf
        KqMbx93ccIjkWpVQMXk5ff4XvkrTIXV07RZh0o/IU3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rMKJev
        VXXNvxbY0zhn4kydkHM2atlZyHaBcKanrBFRg=; b=loBHoB59x6U6402AapGrSc
        X2myYX+R4OtcAe/LhKlSKCEK+kqIwifX/wBNlwG8KKpV161IKA3TW34AImajzLl9
        ykbBBUKaMaWPYGR788KhSUIdq8k+flomZbMDCWR9ugQ4hNoFDUq90uMu2ctnUSjj
        /5HF/Qw2roc7+axBz93Z5nLIKIzeE00XheL5HAAsXctNISmn5k13ih0flB7krt2r
        PvpNE7XDQ3Tjz77kt5hc0Ph5JsjeEPLGycNCKe//HlAIsqaJcTqRvHO2ooT9g7DO
        MkAAsHj4qPpIGHg7DV/QyBG/98YU+memdveo+2OKW2Cugf94Jqmu9c7zBSoY66iQ
        ==
X-ME-Sender: <xms:MaiVXTr8iwSftKnICl7NU6iYl4xNAX0eb4_KFHANfbOHdmJlexcI2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrgeejgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
    ertddtredvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:MqiVXYHP7rj8Yw0B2QFTApjMWuJJ6WhKBnfmmhbNthSIA_UEzPeTLQ>
    <xmx:MqiVXQpuMZYc1zxLLo6p3FN7Bnie5q6gd52z9wHog1_LPAmi0Gzs5w>
    <xmx:MqiVXZGQaa2dhGTA6KlJFjtxw1yslNhqsHnNRIeoNqyLAT9F-HorZg>
    <xmx:MqiVXbwRPDvCHU2KQWR3VrchkcT6VUinIYqYEppR8hjXsP4Z_YU77g>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id A1995D6005E;
        Thu,  3 Oct 2019 03:50:09 -0400 (EDT)
Date:   Thu, 3 Oct 2019 09:50:06 +0200
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     ilubashe@akamai.com, stable-commits@vger.kernel.org
Subject: Re: Patch "perf ftrace: Use CAP_SYS_ADMIN instead of euid==0" has
 been added to the 5.3-stable tree
Message-ID: <20191003075006.GA1830608@kroah.com>
References: <20191001171555.9CBC6205C9@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001171555.9CBC6205C9@mail.kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 01:15:54PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     perf ftrace: Use CAP_SYS_ADMIN instead of euid==0
> 
> to the 5.3-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      perf-ftrace-use-cap_sys_admin-instead-of-euid-0.patch
> and it can be found in the queue-5.3 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 54a277c389061fc501624f51a13426d7b797f5f7
> Author: Igor Lubashev <ilubashe@akamai.com>
> Date:   Wed Aug 7 10:44:17 2019 -0400
> 
>     perf ftrace: Use CAP_SYS_ADMIN instead of euid==0
>     
>     [ Upstream commit c766f3df635de14295e410c6dd5410bc416c24a0 ]


Sasha, this patch is breaking the build of perf in the stable branches.
Can you fix it up, or drop it?

thanks,

greg k-h

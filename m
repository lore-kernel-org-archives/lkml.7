Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8E2C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08ACA20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="xd/DsTsL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5/EYj7kV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfCGMZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:25:52 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:40317 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726166AbfCGMZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:25:52 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3355336BD;
        Thu,  7 Mar 2019 07:25:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 07 Mar 2019 07:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=s3EHRvYRJs3aN58r1D5o8joH0W4
        vG6ehZ6LxekRzi0w=; b=xd/DsTsLoCEUrg9M8v7xbNG7GdgJDDHGeYtr+NvtXBD
        pnNObz/g6hodR/EIcSK09SARkoGyxDXaWAEb+MfZyGzXY6fZirkOlAAkJgRdaUi2
        DL5MHTacu2l1cqdpwAN6h+O/BGP64Mg9Ny0EVRnclhCcv5tDcj4PkSI02GFUaoeB
        uFg9XtFbmVOWKTqfv/teAT+4L6mzR3EGVrXxpIqEqtCS8X54+3RfScflKLR9lAa4
        GmYmVg39qFTEvWa4MwMBztELbt3OHrcBTvAm2KXHHDhSU0Xt3dqSfyulcgxuMg0O
        WbiEu9In0szM5ZSsyht4TbaxwVyTMvmtQc2O05VDATQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=s3EHRv
        YRJs3aN58r1D5o8joH0W4vG6ehZ6LxekRzi0w=; b=5/EYj7kVihEbK13VbwEwZk
        o/igNe9upN0IeNAFG77Gopic19FCQL4KAdVU74MG6K/5ckYV8z2ZGWOgtVGIjuAZ
        GD3H9sGpQjEUYxxVeYcLIyMQkfkIZc0f4S+quxAtGUipQ+2auoVsOdZV4wXHfHH+
        LUXALSyIRR7D9qYUhbAZWl7hwZkz1noTxmFk76LUDic+vKfqqrZT9QI7xv6LcXeq
        p/BtY9VAiZ3a9cUGwNCfC5skQ9hcd+3p6GKxwfXFU98pjM3O4ofNOp7zn+5qfW3m
        Zr04ATHBbW+6sb1VTFqkiTJVOCBu+vEJMLGU6TUdLB/IckUd5jS7XFnlg8NQL4AA
        ==
X-ME-Sender: <xms:zg2BXKU7rpHb1t-CijPeKhFcpC0diDojMzO3P5QrVQclQ7oop2UrlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeekgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:zg2BXEepthtjMKix8NPHzOeTkUelj7SDqXrFu4NMJ3Y0arikfT2piA>
    <xmx:zg2BXHdRJTT1arNgiYs7N1_9nibLHmKKZZFZew7dvxmANYmHnOeYbg>
    <xmx:zg2BXCn32qGM70egU87Y-LarbHomZfakLRhNFbyeOeUc4krva6Ol7Q>
    <xmx:zg2BXCvDD0ckV09o4k44pzoma834sV_MNN6vbBioE1RfMdDIIewd8Q>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id A5A8CE408B;
        Thu,  7 Mar 2019 07:25:49 -0500 (EST)
Date:   Thu, 7 Mar 2019 13:25:39 +0100
From:   Greg KH <greg@kroah.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Sasha Levin <sashal@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, stable@vger.kernel.org
Subject: Re: [PATCH for-4.19] staging: erofs: fix mis-acted TAIL merging
 behavior
Message-ID: <20190307122539.GD21325@kroah.com>
References: <20190301212203.5FE0C2084F@mail.kernel.org>
 <20190307053404.29108-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307053404.29108-1-gaoxiang25@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 01:34:04PM +0800, Gao Xiang wrote:
> commit a112152f6f3a2a88caa6f414d540bd49e406af60 upstream.
> 
> EROFS has an optimized path called TAIL merging, which is designed
> to merge multiple reads and the corresponding decompressions into
> one if these requests read continuous pages almost at the same time.
> 
> In general, it behaves as follows:
>  ________________________________________________________________
>   ... |  TAIL  .  HEAD  |  PAGE  |  PAGE  |  TAIL    . HEAD | ...
>  _____|_combined page A_|________|________|_combined page B_|____
>         1  ]  ->  [  2                          ]  ->  [ 3
> If the above three reads are requested in the order 1-2-3, it will
> generate a large work chain rather than 3 individual work chains
> to reduce scheduling overhead and boost up sequential read.
> 
> However, if Read 2 is processed slightly earlier than Read 1,
> currently it still generates 2 individual work chains (chain 1, 2)
> but it does in-place decompression for combined page A, moreover,
> if chain 2 decompresses ahead of chain 1, it will be a race and
> lead to corrupted decompressed page. This patch fixes it.
> 
> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
> Cc: <stable@vger.kernel.org> # 4.19+
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> ---
>  drivers/staging/erofs/unzip_vle.c | 69 +++++++++++++++++++++++++--------------
>  1 file changed, 44 insertions(+), 25 deletions(-)
> 

thanks for the backport, now applied.

greg k-h

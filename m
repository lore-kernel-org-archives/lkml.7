Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BDAC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 00:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4D020730
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 00:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="sgnkTUOE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dq8Ooen9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfKRAB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 19:01:27 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:37421 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbfKRAB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 19:01:26 -0500
X-Greylist: delayed 670 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Nov 2019 19:01:26 EST
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id A4A5B58A0;
        Sun, 17 Nov 2019 18:50:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 17 Nov 2019 18:50:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        0DjwSwNuuCOp/OVQlpsoTSIJMgZBoS/7Z1vmhjDwt88=; b=sgnkTUOEhsKBKU2Q
        gjSRtuiccaNpAL1BC2O70eveU06JEYJwX9NfN2o6/zZjttsM0YXC9qySPFDxgVrq
        kLVW2Sr64Etb5+thTcm/NKTs4S6XrbnGL4hvm4e/0v/cA8lbvVVVtMn9lSJ32I2a
        ONukdCXJiHUEh9AzJtSqJZgjVadd9dEf/v6zytXehAWxRQdrhkQWP92oBZFDHril
        Q3AMW+hGUGEqTZQHPHXb+6Gk4iBy4mNZpxqwVXfYiEjZDJMOPzYYAoR8t0+Ctb/F
        Q7e+KzGrA2bMqiZUirDdkJURGeAh3HDiBSwr2Q0jfO8SnE4kXssOQACWjbjq6RxJ
        i0BYQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=0DjwSwNuuCOp/OVQlpsoTSIJMgZBoS/7Z1vmhjDwt
        88=; b=Dq8Ooen9yYhuVCb5lEIsv59dJ9phV36/YmypYdeivu4bcsXV62dsea9Lx
        WJBLLi+l+VwOGt6MhHI1N8c+1Mtu+lNSbyJ2krLJtjOTWF+/IfzfdBMocNg5nDbd
        8a1Hfpjkm5nNF0kg8HjffuBmX6XoWsVQ6VUs15JWQc48XkOCpg+mj3RIzgKJKg/r
        jHAH2egLD1SjSWu31m8T4CA1TPl9gDgfrbVkimn8RelG1ysNZIavU1q87TvXu0HQ
        Gdr7tfjGNGKRM3p4N/EN/TT55yb3FcC95LzZumpkoKnYskvDn/mQUqd7nXO5KwZg
        YfoLvMrf68z8sS780MMipoO3ttluA==
X-ME-Sender: <xms:ttzRXf1s3EVTLsHWM8UBPBSxcQSkH46gE8g8aMID0dmt9CqynNrycA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeggedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucfkphepuddukedrvddtle
    drudekiedrudekjeenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghm
    rgifrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ttzRXSWrJkmI7JeaYDMQFhNtz4vSeXiZLmyFLDHg5QodLVYZoiGgZA>
    <xmx:ttzRXa4JAYHcWI8_pmevLcvWXCb2pKBgYss9ymvillD0DVsYXOGCGg>
    <xmx:ttzRXZJ8iruzVRcZjifRg7misJE76fjRlibLXSNY5CxenWNsDj-wyA>
    <xmx:t9zRXVQx4CNoqQ65CSdZFFgq_d43TfN_dMhIW5DBEnWezZ1x_GnFAA>
Received: from mickey.themaw.net (unknown [118.209.186.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id B758C8005B;
        Sun, 17 Nov 2019 18:50:09 -0500 (EST)
Message-ID: <a5b17c43fbd2b186240252b5a7fbef9c6a0ad54d.camel@themaw.net>
Subject: Re: [PATCH v2 3/3] docs: filesystems: Add mount map description in
 Content
From:   Ian Kent <raven@themaw.net>
To:     Jaskaran Singh <jaskaransingh7654321@gmail.com>, corbet@lwn.net
Cc:     akpm@linux-foundation.org, mchehab+samsung@kernel.org,
        neilb@suse.com, christian@brauner.io, mszeredi@redhat.com,
        ebiggers@google.com, tobin@kernel.org, stefanha@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Date:   Mon, 18 Nov 2019 07:50:06 +0800
In-Reply-To: <20191117172436.8831-4-jaskaransingh7654321@gmail.com>
References: <20191117172436.8831-1-jaskaransingh7654321@gmail.com>
         <20191117172436.8831-4-jaskaransingh7654321@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-11-17 at 22:54 +0530, Jaskaran Singh wrote:
> The second paragraph of the content section does not properly
> describe how mount points are determined by autofs.
> 
> Replace the lines detailing how the determination of these mount
> points is "ad hoc" by a short description of the mount map syntax
> used by autofs.
> 
> Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> ---
>  Documentation/filesystems/autofs.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/autofs.rst
> b/Documentation/filesystems/autofs.rst
> index 2f704e9c5dc0..c17f6bf0eb5d 100644
> --- a/Documentation/filesystems/autofs.rst
> +++ b/Documentation/filesystems/autofs.rst
> @@ -49,9 +49,10 @@ extra properties as described in the next section.
>  Objects can only be created by the automount daemon: symlinks are
>  created with a regular `symlink` system call, while directories and
>  mount traps are created with `mkdir`.  The determination of whether
> a
> -directory should be a mount trap or not is quite ad hoc, largely for
> -historical reasons, and is determined in part by the
> -*direct*/*indirect*/*offset* mount options, and the *maxproto* mount
> option.
> +directory should be a mount trap is based on a master map. This
> master
> +map is consulted by autofs to determine which directories are mount
> +points. Mount points can be *direct*/*indirect*/*offset*.
> +On most systems, the default master map is located at
> */etc/auto.master*.

Ok, lets just use this for now since it's better than what was
originally there and I'll put together an update after these
changes are merged.

What happens is actually a bit more complicated, the opening
sentence above this is talking about what happens with maps
associated with autofs mount points given in the master map,
not so much master map entries themselves.

>  
>  If neither the *direct* or *offset* mount options are given (so the
>  mount is considered to be *indirect*), then the root directory is


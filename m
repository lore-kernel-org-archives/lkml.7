Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705FAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 19:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3441720872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 19:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/8AobwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbfCaTIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 15:08:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56043 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfCaTIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 15:08:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so7913007wmf.5;
        Sun, 31 Mar 2019 12:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VTTXS5b4qi19XcUyZsq2vaz0+PswNOn5O+lQ5+Oay/k=;
        b=O/8AobwBmeRKV3O6OJL+0YlwynY/CEwuJQr5jnhhgYUPKcWNRUj2rT/RAD4qKCtufn
         DAVEVw0KdYgZNVfkpb2S9r2YEHnnLBA3Hrj6DiAewc2pnqVYEl+LJCKdtjT2/S718O71
         YyLtmgjrwoDmZPVWUSEylQsu3iZqaE8t5SDjAzNhN9Ni5JFrFuzRgX0wlXjLcKuBkfbQ
         7u+zK4JfgrL+k0TMqDi81wEpwGcLKhFi/o0JnzzcuFS5YhqVDz00wnkEC068gJjcOBuY
         rnVkxT7WY3Vcj7l6f6mIqkNVMiZtWeK37ueGGECtAD0zwDbpkmxdxxYSjMe7Itpu7mSN
         +11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VTTXS5b4qi19XcUyZsq2vaz0+PswNOn5O+lQ5+Oay/k=;
        b=CxdXTzpr0MR+uyiAyrdtJ0CL5mN5SvavyWjFSUIhDLIhubvsjL9dKqvG/H6R6yF5qy
         o+45E7rwjyRQS24/Sou8VWrai+PuC3d6vJVQ8jlNog5tZGzDhbLdFVyg38LCt6Ay6x31
         JXjV2usFf+LLdmZ1/ggI2VXYkfc2ZLLXz+9Voj8UZ61IZn77U/n5cT5ztkHRgWc24PRM
         P8LPj5UcLOYfHbOpyy3eMW17PP3R4i5vp2zjo8S/bivj4Y+w4958CKTFwi9AE/K/adOs
         FAQKHY5foydoeYfvEg4JB9uRb0lgQ9HyUqB2PqrfMyYb1gxA/0DAsF7/8OeSRoruN/Mu
         fwzQ==
X-Gm-Message-State: APjAAAUwodU6cvZs/A3dZE+ELkM67o3DTpPcr9wp4TGuG3fs/dXNHwRk
        veMB1QmdZRgOoi7OyaPQv14=
X-Google-Smtp-Source: APXvYqzjiY6l7LL/9aDnBXRrZJzRxCJ+2FIzLsGLkn/syUPO+PtVoqgKdCImzkNJtWq0G3wtEdNrvA==
X-Received: by 2002:a1c:7901:: with SMTP id l1mr10986189wme.144.1554059284670;
        Sun, 31 Mar 2019 12:08:04 -0700 (PDT)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id v190sm22745575wme.18.2019.03.31.12.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 12:08:03 -0700 (PDT)
Date:   Sun, 31 Mar 2019 20:08:01 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 7/7] MAINTAINERS: sm712fb: list myself as one
 maintainer.
Message-ID: <20190331190801.hxl57om56jskku5s@debian>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-8-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322051759.15007-8-tomli@tomli.me>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 01:17:59PM +0800, Yifeng Li wrote:
> I have working on the sm712fb driver for a while and have some familiarity
> with this hardware, I'll be helping working on and testing problems of this
> driver, so add myself to the MAINTAINERS file.

Technically I donot have any problem with this, you seem to know more
about SM712 than I know. But Teddy Wang is also an existing maintainer
and I think there should be an ack from him before this is accepted.

> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dce5c099f43c..3f6686f0f020 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13871,6 +13871,7 @@ F:	drivers/input/touchscreen/silead.c
>  F:	drivers/platform/x86/touchscreen_dmi.c
>  
>  SILICON MOTION SM712 FRAME BUFFER DRIVER
> +M:	Tom Li <tomli@tomli.me>

Sorry, I am confused. Is your name "Tom Li"? Then why is your
Signed-off-by: and From: name different?

--
Regards
Sudip

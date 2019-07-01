Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B91C06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA6F206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHbxGEkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfGASjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 14:39:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41399 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfGASjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:39:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id p15so24705860eds.8;
        Mon, 01 Jul 2019 11:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hu0HTmKIn4QBUbDeu1PJZMoa50Wx+eTeneXb2QI48Sg=;
        b=DHbxGEkq7PH+aNGvyJgwbs0vSW72Zcv76OLhOdPOSXO/w5ZOYGHZULrOP6Oh7TuKrs
         bA/G0TkOMYAJRUCUOaeg3eOcBk59pSK2lwuAWTVgJXfWDqfHGcZf7hFjGn1S8TGvIhO9
         hfg96WFsYBRtNf1Ax+vzg/r2iFHWTnRMbH+k3HUuZKwSWA4wAr+OkICZzIiM00dY/osi
         INBRA89XyI65Z/vsePFmbz2zX2/24whUP3zNFPZU+9Tp8pFu9VXkXzy96FftxH4RMrnn
         /Dxw55SpE54T+OWTk53pRcPizf9nZUFocIImLBpm/III601f+J5r3p36fSGB4oAN7Dxo
         B3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hu0HTmKIn4QBUbDeu1PJZMoa50Wx+eTeneXb2QI48Sg=;
        b=fnqRHSa2LuRheUzPX9HppR3wnil0d6+ZQPxDsiiLeVthklu0NPPPZV2ZpBE7Lbxlfb
         BO3BZ6DXuw9mWRnXgKVgttg7Z6Pf4ElAZ4MfsNN3PDrCRybpL4+phJHeFnxaJrYfRHnx
         AL1lPpmptaZfWigkLyKKcclMl1aHZSsVb1GVN3vRjsEmJR6vo/nL5rHFQY9dslZYImLm
         eS2pFYfx3VuEp2D1O1r8Ew9bw1pncBw4ihwQ5p6lFb+MkiEolmB7e6EL8bv9bAuQnTaZ
         ll8H80LdOv3amX/vvhXpi3y6pz8fFxTM1AwNykSWdk2Q6UDa+pMqAI8T6aHNdFr2W/t/
         f45g==
X-Gm-Message-State: APjAAAU26yHogdy2e3M+nNh3mAjYtjc2EWyiMHQ0s8Pht4aEjDp0FOow
        EtW0etYZk3K06u/vJqMqZkA=
X-Google-Smtp-Source: APXvYqz0Rw7BldmAKuQMbC4OUAMYhRMUbs+3f7CurTumUuaQ4EqRIy8VprbmnZWA7UwiUNZ3jqh0/w==
X-Received: by 2002:a50:9263:: with SMTP id j32mr30732951eda.121.1562006383316;
        Mon, 01 Jul 2019 11:39:43 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id r12sm3907610eda.39.2019.07.01.11.39.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 11:39:42 -0700 (PDT)
Date:   Mon, 1 Jul 2019 11:39:40 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Message-ID: <20190701183940.GA67767@archlinux-epyc>
References: <20190701190940.7f23ac15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20190701190940.7f23ac15@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 01, 2019 at 07:09:40PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>   drivers/hwtracing/coresight/of_coresight.c
> 
> between commit:
> 
>   418e3ea157ef ("bus_find_device: Unify the match callback with class_find_device")
> 
> from the driver-core tree and commits:
> 
>   22aa495a6477 ("coresight: Rename of_coresight to coresight-platform")
>   20961aea982e ("coresight: platform: Use fwnode handle for device search")
> 
> from the char-misc tree.
> 
> I fixed it up (I removed the file and added the following merge fix patch)
> and can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 1 Jul 2019 19:07:20 +1000
> Subject: [PATCH] coresight: fix for "bus_find_device: Unify the match callback
>  with class_find_device"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 3c5ceda8db24..fc67f6ae0b3e 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -37,7 +37,7 @@ static int coresight_alloc_conns(struct device *dev,
>  	return 0;
>  }
>  
> -int coresight_device_fwnode_match(struct device *dev, void *fwnode)
> +int coresight_device_fwnode_match(struct device *dev, const void *fwnode)
>  {
>  	return dev_fwnode(dev) == fwnode;
>  }
> -- 
> 2.20.1
> 
> -- 
> Cheers,
> Stephen Rothwell

Hi Stephen,

The attached patch is needed in addition to this to avoid a build error
about incompatible pointer types (in the commit message).

Cheers,
Nathan

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-coresight-Make-the-coresight_device_fwnode_match-dec.patch"

From 2b2dd836a7370d9b33fb0f70515ecd7bc8462c0a Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <natechancellor@gmail.com>
Date: Mon, 1 Jul 2019 11:28:08 -0700
Subject: [PATCH] coresight: Make the coresight_device_fwnode_match
 declaration's fwnode parameter const

drivers/hwtracing/coresight/coresight.c:1051:11: error: incompatible
pointer types passing 'int (struct device *, void *)' to parameter of
type 'int (*)(struct device *, const void *)'
[-Werror,-Wincompatible-pointer-types]
                                      coresight_device_fwnode_match);
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/device.h:173:17: note: passing argument to parameter 'match' here
                               int (*match)(struct device *dev, const void *data));
                                     ^
1 error generated.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/hwtracing/coresight/coresight-priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 8b07fe55395a..7d401790dd7e 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -202,6 +202,6 @@ static inline void *coresight_get_uci_data(const struct amba_id *id)
 
 void coresight_release_platform_data(struct coresight_platform_data *pdata);
 
-int coresight_device_fwnode_match(struct device *dev, void *fwnode);
+int coresight_device_fwnode_match(struct device *dev, const void *fwnode);
 
 #endif
-- 
2.22.0


--1yeeQ81UyVL57Vl7--

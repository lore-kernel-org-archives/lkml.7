Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91DCC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC47F20656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Za72r1rs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfF1EUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 00:20:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35495 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF1EUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:20:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so2484323plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 21:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QMVsVsENIq5jFVBrHyEsaAKaZZYq8Ei7fMqMQWtvxsQ=;
        b=Za72r1rsgL7lhP8DM+xELMGe9NVDyDZjOKOxNxxq6eF8WPJ8VtTJmdiYTGT50kO17c
         keHsNLt1GVHL+lmFKoqnzHVNSH8HO7aSpHAeYX2c2rqzXZl36P0TTkcvQQA0OKqdNsHH
         VYNS/pktmMUG04o5AOQUBXaoWKPDZAogTLZMzd+HUZump9i3dxq24i2bnNM7HzoX55FK
         i7IGNtitAzGdKdZiLK0ZH/OXqArRHCNMmLoi6LRJPvG1Yo0XFM5JDWKt6lJJjkerHnU0
         izBhA47ziV/l+hyyNnUZdttQhcRSOOkZwK+pFrqpnxkp+14h2RsEltdhx+8i7if6W8V+
         Lqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QMVsVsENIq5jFVBrHyEsaAKaZZYq8Ei7fMqMQWtvxsQ=;
        b=czRBkdDvXCLzli0+hcLU3wPP7zZg9a68arazEL+gkCmgwq82Hoqrl+k3hojhtqcXX2
         kx+oE7Pi46YxoR+gbvjARgn7CFf+Q9g1b0zcO8hXDUlG0F5LGScW815uQkzGw4mBVOav
         Js3aURSZtrDa1n0hrCy1xPhGBOtEA02wG4xFRqN3uhRmqjKDbNSVYtQaBRAGXb7YGgO+
         Nxnwl/gky43yw1DGWSG5621Hjd7dpuWcDInb7KhC9K3jIaBQ3Oj67dru9fFujc7ajFkr
         y/mrsWPqkqT7IjOwMZ/d4W7MdoGKUYpkaeTb2RGTRGIml/BOyQdorRHFqkuN5qvm8JoI
         NJTg==
X-Gm-Message-State: APjAAAXpMxokycFYfS1n9AmDpk/GMio21nJHUQmcoh+FR+jfv8n+PYP0
        cKBhAc0Jy0ogu4IyF6DDlGAZqv3sGxM=
X-Google-Smtp-Source: APXvYqzAfadCUE/mQqcPjchTjuq2EteuY+sMRrt9vCSdBvZRoQaSoVSh7CehrfYUOzkMJ8HsHtc+Tg==
X-Received: by 2002:a17:902:8546:: with SMTP id d6mr8801004plo.207.1561695604386;
        Thu, 27 Jun 2019 21:20:04 -0700 (PDT)
Received: from localhost ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id f10sm546776pgq.73.2019.06.27.21.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 21:20:04 -0700 (PDT)
Date:   Fri, 28 Jun 2019 12:19:52 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     <yuchao0@huawei.com>, <gregkh@linuxfoundation.org>,
        <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <huyue2@yulong.com>,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH] staging: erofs: don't check special inode layout
Message-ID: <20190628121952.000028fc.zbestahu@gmail.com>
In-Reply-To: <276837dc-b18a-6f20-fc33-d988dff5ae9f@huawei.com>
References: <20190628034234.8832-1-zbestahu@gmail.com>
        <276837dc-b18a-6f20-fc33-d988dff5ae9f@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2019 11:50:21 +0800
Gao Xiang <gaoxiang25@huawei.com> wrote:

> Hi Yue,
> 
> On 2019/6/28 11:42, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Currently, we will check if inode layout is compression or inline if
> > the inode is special in fill_inode(). Also set ->i_mapping->a_ops for
> > it. That is pointless since the both modes won't be set for special
> > inode when creating EROFS filesystem image. So, let's avoid it.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>  
> 
> Have you test this patch with some actual image with legacy mkfs since
> new mkfs framework have not supported special inode...

Hi Xiang,

I'm studying the testing :)

However, already check the code handling for special inode in leagcy mkfs as below:

```c
                break;
        case EROFS_FT_BLKDEV:
        case EROFS_FT_CHRDEV:
        case EROFS_FT_FIFO:
        case EROFS_FT_SOCK:
                mkfs_rank_inode(d);
                break;

        default:
                erofs_err("inode[%s] file_type error =%d",
                          d->i_fullpath,
```

No special inode layout operations, so this change should be fine.

Thx.

> 
> I think that is fine in priciple, however, in case to introduce some potential
> issues, I will test this patch later. I will give a Reviewed-by tag after I tested
> this patch.

Thanks.

> 
> Thanks,
> Gao Xiang
> 
> > ---
> >  drivers/staging/erofs/inode.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> > index 1433f25..2fe0f6d 100644
> > --- a/drivers/staging/erofs/inode.c
> > +++ b/drivers/staging/erofs/inode.c
> > @@ -205,6 +205,7 @@ static int fill_inode(struct inode *inode, int isdir)
> >  			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
> >  			inode->i_op = &erofs_generic_iops;
> >  			init_special_inode(inode, inode->i_mode, inode->i_rdev);
> > +			goto out_unlock;
> >  		} else {
> >  			err = -EIO;
> >  			goto out_unlock;
> >   


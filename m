Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05FBC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 18:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5ED20869
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 18:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vghoN5vo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfDTSF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 14:05:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41745 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfDTSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 14:05:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id c12so4553503wrt.8;
        Sat, 20 Apr 2019 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ChcLUZZsz/yaFTkNTw6HWAElPPukpHuHd2zHMyxvp7g=;
        b=vghoN5vofaUuDkoSyWreymu8+Rt/Voj0hfqKfo/hQCW10c5N4pQ/ljiD5NnA0Os/O8
         p4VGahf6Wt/f/UddyIOLk0zyLmH2NPs0serytrQpAp9qd7arGDMGpGfZorzRg3q8Mee4
         4NyrumNKwT3rBQoDj+fn1F6puzXeX3WaAiri81GW7r9wK0npXnDLGZAGkh4ouCfPWGqL
         HCrDQHgwDXNj/74wT3NddjzZXHGUtdld46Xge/ho8Z0nwNpAAQg55XX/b/r39CLQbDvT
         BAnLwroJ/LtZaFwxCndgMjZI5pmAaMtYuuX5WGMygjRkNdARYFsbvmUKMZtk+0SjDQdJ
         bmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ChcLUZZsz/yaFTkNTw6HWAElPPukpHuHd2zHMyxvp7g=;
        b=ScG/X6UXaEVYpQ2cgsU7tgiMBe3j6iCTI5KvZExSNFgRRDlbxjRQb4wK9dhaT/qz+a
         LluqzKp5+KmJ7axgg3NwcXWkk7Sdx9cEb3QlyNLKhuio0277/wF6CymACnZNswuJ6A50
         sFiYoaSd3zTsgm6v4Xo/h+Dtm8OSdLxdCAsxwuntccBa/uQ0hf+i9FklpX7g4BBhdmvM
         wTf4kOGEdfz/DvRufATl0rv5uJxzih5AhqlMf4R1IIzYHOgPavy2Il4JKd06qEXzbwud
         RgO7Ah+afii0df9Or6PfS9N1Wx9i6MZck17f5rRlPHpGknMhkhKWNMf+LjBelQ4CrQPS
         gj+A==
X-Gm-Message-State: APjAAAU/xIZ9XLA56xfIDe4A67e1QM6qiQBsQocwyDQ7rq1slZeywJ/N
        Mkc7stExGTI9RHP48N6A4bR13fp4
X-Google-Smtp-Source: APXvYqxgUXE/obbUb95FhtpnGF/ZBuwD+YykPQm2dPtjoROJ4Pkl/MSZ1NCuhQyD/C0yFxfbF8jtcQ==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr7064195wrq.79.1555783525059;
        Sat, 20 Apr 2019 11:05:25 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id w12sm19768787wrg.29.2019.04.20.11.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 11:05:24 -0700 (PDT)
Date:   Sat, 20 Apr 2019 20:05:22 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: remove unneeded linux/miscdevice.h include
Message-ID: <20190420180522.GC19319@Red>
References: <20170918165854.23408-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918165854.23408-1-clabbe.montjoie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2017 at 06:58:54PM +0200, Corentin Labbe wrote:
> drivers/vhost/vhost.c does not use any miscdevice, so this patch
> remove this unnecessary inclusion.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  drivers/vhost/vhost.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 33ac2b186b85..33ab839696f9 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -16,7 +16,6 @@
>  #include <linux/uio.h>
>  #include <linux/mm.h>
>  #include <linux/mmu_context.h>
> -#include <linux/miscdevice.h>
>  #include <linux/mutex.h>
>  #include <linux/poll.h>
>  #include <linux/file.h>
> -- 
> 2.13.5
> 

Hello

gentle ping

Regards

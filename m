Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AAAC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C868A2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCO/Lu8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbfGOKkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:40:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38845 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbfGOKkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:40:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so14670477wmj.3;
        Mon, 15 Jul 2019 03:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9uBhlIU2szBotflkNdAmaBH8KE8ZJQBhkw7CUx5y0fo=;
        b=hCO/Lu8LiB+cld8yeqGPNjY7w/9KgXng4ECiHyBd4FH2qOmfuaXjOcQfltENZAr+qo
         oJlvvcT4zEi5rJxL042/5zXaDQVxjbcRXsXzl9CMMdA5PQAf0wpmwZZDva7D6x7WmukC
         aeRDA/uRTNi4e3CVtqpPwKwBzPfAzsHlJSKimLAsKtI7pAHNP2E9TU0igyzie5m4637o
         MNecrY2M6akN1QTJwEq1VHO43Z0WevQQ1RtQvvxLPZgKR3buFiS2QzLstC+AJwbqPzvF
         Klm4ks1OWpTP3gvUVM3U0ypTbRbZGkry/YOkDr6Iz1CWDXkcLpBfKIkO4HLcf39LepYK
         6XEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9uBhlIU2szBotflkNdAmaBH8KE8ZJQBhkw7CUx5y0fo=;
        b=U4/uo3FDppybpgULJjybwtxEgitqY+ZN9nEffoT7bp5KLQ7yoLmzqRwDVLXWc0vRNT
         lReK60fhOaMuQMhLZjNIZEQM3e/qo+wn3brAPFr7uG712t+/AomOoEVfq9ku2zpRu5n9
         txMmekiDrD8mIrJ7AnP/4OML83OD2leUkOhIcKAPZTSrKLvgxC5B9qh8U0WFLXdTMZv0
         wHaCKf1+tFB/S60kJKzLd+h4USjdgeciWw86shFRMVvm0V8zbwHh9tBLIBr4OOrjc+cA
         ps6jzGpK77m8pptrF4OX71nVqhkcUvO6sUMmSdMQfObkiF/pPxR2G55WB6JBROGCJ6mc
         MEFg==
X-Gm-Message-State: APjAAAXEhYME7EzcrJr9j3XnaA7psr9ZmNXeB+iv8VsDVGDLHIepr8X+
        mCxof4820wRvF+nHVZzq3uSzt7Ay
X-Google-Smtp-Source: APXvYqyob/S8uNsVUwjk6Ce53GygAkmpira++H3AiLt8ALVqVysp39ciacNI0RAf3DgVc9jeNDkegQ==
X-Received: by 2002:a7b:ce01:: with SMTP id m1mr23986491wmc.1.1563187251053;
        Mon, 15 Jul 2019 03:40:51 -0700 (PDT)
Received: from arch-x1c3 ([2a00:5f00:102:0:9665:9cff:feee:aa4d])
        by smtp.gmail.com with ESMTPSA id f17sm14917117wmf.27.2019.07.15.03.40.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 03:40:50 -0700 (PDT)
Date:   Mon, 15 Jul 2019 11:40:49 +0100
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 24/24] video: fbdev-MMP: Remove call to memset after
 dma_alloc_coherent
Message-ID: <20190715104049.GC20839@arch-x1c3>
References: <20190715032017.7311-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715032017.7311-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/07/15, Fuqian Huang wrote:
> In commit 518a2f1925c3
> ("dma-mapping: zero memory returned from dma_alloc_*"),
> dma_alloc_coherent has already zeroed the memory.
> So memset is not needed.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
> Changes in v3:
>   - Use actual commit rather than the merge commit in the commit message
> 
>  drivers/video/fbdev/mmp/fb/mmpfb.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil


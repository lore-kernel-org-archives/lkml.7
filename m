Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCA5C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7C5208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="is1HU+gg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfF0Twt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 15:52:49 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38254 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfF0Twt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 15:52:49 -0400
Received: by mail-qk1-f193.google.com with SMTP id a27so2842672qkk.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 12:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qQvtIolaIhbEj7zQCdzCY/FMnc1dfYBybIqVXd3KZ8Y=;
        b=is1HU+ggY8nhSOnAQI/VX7rUG8dfJ3gGIIegNI9BVXfIesWy5VLF4zh7WUrsqCOnqB
         ikg5x6cEt2YFLNh/o/vy+ITlF970QkFbOx5kYJ5Z7Oe3G8liFvatPNcmmKMbn4+QUov6
         mbKPoj0t4y6YqqcAsVb3+2XEPtY2R/tcXkptmHCU83/GJucXehVUt+CwKgySB8sMGzc9
         Q3HhHPkn99sdp+xZlnDk85aR87UlQvBs+PhhwF4J/o60rrixXxSEpjxs0CSGMdVD30bK
         FV9EwDfNdcXpK1Dfv86SaUzx5gx7GW2c6ZCWEZgScTBygh+A5ccUyjt6kI8KAOsBypOQ
         1GsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qQvtIolaIhbEj7zQCdzCY/FMnc1dfYBybIqVXd3KZ8Y=;
        b=OdAwNz6z0biTJFGGi5OI7h1vuIFtv2LX2pXVPo2LrYFExz6WkeQeo4hE5hUvtsi677
         NW3uRMSO4hYzC2uGMnfcSASEJ4AAJk4hW8WocauwRYcEy5Gq3W+Q142BVLeyManIvza5
         MqeXuEJl9dIH4gfD5sGn+2OFB81jYQQqgwz0+yawfx4h4l1t1nDWRJ5PGMozuwJismJX
         PVOQ6/F+hhoeyLFMgHnu//phcfL0IfSF5YWNhAeUqpiBHwH5Fr2/pBebMYxy53nXqne/
         PjZnrqpYiokRCrd34g1v+ZUppWCbVjvkS9mUrzXc+T978eUo/pLtTXiruCx0iBepGx4I
         tuAQ==
X-Gm-Message-State: APjAAAUygt2eQV6blKRBwnSsnsNK0HmKoWtJtyzGUMrODQ2WghEsbfO2
        msJVmFhxWWxqNpJzBdjkhrV5Ew==
X-Google-Smtp-Source: APXvYqwqsUW/Hfuw+7OIqqajGDQc9UBxmD94kwLGNZOhmicRCyFC0z+2aPwr1Mw8fSs39S+PHsN01g==
X-Received: by 2002:a37:a2cc:: with SMTP id l195mr5019652qke.362.1561665168691;
        Thu, 27 Jun 2019 12:52:48 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a15sm63894qtb.43.2019.06.27.12.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 12:52:48 -0700 (PDT)
Message-ID: <1561665166.5154.90.camel@lca.pw>
Subject: Re: [PATCH v2] powerpc/setup_64: fix -Wempty-body warnings
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     paulus@samba.org, benh@kernel.crashing.org,
        tyreld@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 27 Jun 2019 15:52:46 -0400
In-Reply-To: <1559768018-7665-1-git-send-email-cai@lca.pw>
References: <1559768018-7665-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

On Wed, 2019-06-05 at 16:53 -0400, Qian Cai wrote:
> At the beginning of setup_64.c, it has,
> 
>   #ifdef DEBUG
>   #define DBG(fmt...) udbg_printf(fmt)
>   #else
>   #define DBG(fmt...)
>   #endif
> 
> where DBG() could be compiled away, and generate warnings,
> 
> arch/powerpc/kernel/setup_64.c: In function 'initialize_cache_info':
> arch/powerpc/kernel/setup_64.c:579:49: warning: suggest braces around
> empty body in an 'if' statement [-Wempty-body]
>     DBG("Argh, can't find dcache properties !\n");
>                                                  ^
> arch/powerpc/kernel/setup_64.c:582:49: warning: suggest braces around
> empty body in an 'if' statement [-Wempty-body]
>     DBG("Argh, can't find icache properties !\n");
> 
> Suggested-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: fix it by using a NOP while loop.
> 
>  arch/powerpc/kernel/setup_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 44b4c432a273..bed4ae8d338c 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -71,7 +71,7 @@
>  #ifdef DEBUG
>  #define DBG(fmt...) udbg_printf(fmt)
>  #else
> -#define DBG(fmt...)
> +#define DBG(fmt...) do { } while (0)
>  #endif
>  
>  int spinning_secondaries;

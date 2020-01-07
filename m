Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A446BC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CF4222D9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ctDnGIsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgAGO3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:29:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37120 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgAGO3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:29:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so19632061wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 06:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WCQIUAjaOQTa2KrlqSfFCAmYRoieddvlLsL8IMP8Pjk=;
        b=ctDnGIsMiCNNhvUHfP9jXRyusrt/EtZ/5xP1IFIlknU99Bdw4Z0fMEXuurCwTT/viI
         x2oOicB6H2UXays7DmTqhmvNUqDN855TwCRMcbgR8thz32PbHzZMkLv2kLUjEiVoMyO4
         aelu6ObaD3tvDK90w1+k6f9CqRTsfeSJaxdETRa878Kr+fimOoN50j8QO5DMc/ykZEFZ
         5YVsiTndhyyYZqBfr2oYmf31KKLmFxTeLzL0dU8g+aPdZjluEzliBnchCSJ8B4Mm0Sbq
         kbOJ44Rq9JePY28/zbL/7PxLxrXCqR/QWRiyfJUHqwhlFcAUs0o3B15GMuUwTvz5CpCJ
         hBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WCQIUAjaOQTa2KrlqSfFCAmYRoieddvlLsL8IMP8Pjk=;
        b=MssyDCi7wLYEtBbLirLsXiXR0cWdvQHgO4cLKfdRKw1CxBqibCB1vKzvZYaXkKz/3Q
         EbcoPedYotjTgQs/Rr+J9M5/u5DmBavhktZAWzj22YbQeKCLxjOvLuH/hxTeUrmSQvM9
         uxYb6+RzfOug8+69fcc4LmRYLUVbku3qk0LIYszPV/IAmUdFVRyaw/UStqbDhBqN3W5R
         DKa46M8w5rVj17ydk9LXrlQQFFYsGwiCRDyluUuzr3Pdyx9JbHm6FqI+EROpRPep5Ne4
         +GKNjWg0BoR5nt2ogTVxLfktKMVBp8HmJ/fzdC23oPv7NVZyhIcwDDAww6mYl+JTvCGP
         irCQ==
X-Gm-Message-State: APjAAAX2EWwP9fjH7Y4vcnpCpcIwCwYP7C+90W9n2Umps83/JMgpqDn5
        a/QQaOE/uBVoH/ELvVSjwODdlCaOE6U=
X-Google-Smtp-Source: APXvYqyVnSHPvZ4ExC4CJd4Ab0lYUXtlJ4xQ+ka+GVnoV9U85XICix4B3mT3sET442QG++2RwcNTcg==
X-Received: by 2002:a1c:a543:: with SMTP id o64mr38680106wme.73.1578407374134;
        Tue, 07 Jan 2020 06:29:34 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id f207sm29320212wme.9.2020.01.07.06.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 06:29:33 -0800 (PST)
Date:   Tue, 7 Jan 2020 14:29:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] mfd: madera: Wait for boot done before accessing any
 other registers
Message-ID: <20200107142942.GO14821@dell>
References: <20200106102834.31301-1-ckeepax@opensource.cirrus.com>
 <20200106102834.31301-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200106102834.31301-2-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Jan 2020, Charles Keepax wrote:

> It is advised to wait for the boot done bit to be set before reading
> any other register, update the driver to respect this.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/madera-core.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

I'm assuming this patch is orthogonal to the last?

Can I take it on its own?

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

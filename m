Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DA3C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2284320674
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDgGLjDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfKWSBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 13:01:34 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45222 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfKWSBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 13:01:33 -0500
Received: by mail-oi1-f194.google.com with SMTP id 14so9437092oir.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 10:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pY1pNPrl1tG+NPM43+xxPuU3zVU/KXwcJU4pMYDbF1s=;
        b=GDgGLjDx/B4eFVfhHnqDUh7639DBqdOxdS+t432Ke+hW48ABfvfqqk5zQDoWq7+96h
         vZSpq6UwRxbbMf8Zww0kSm29XMikUijeUIF1S/aigDcjCuKRdfug1XTLOlv6R8GWDWSv
         zETKqF+n3z/2ybx8lN7vadFKOP/8nh13yroAM325dqC99UklUTQMtXLtg8oDDLWu0ucS
         BhX3++26ieAJGr/pa7E+QwLarGrP9WEKpsFozSU/PQPPygqEoFJnHM3SzAQ9hVobDRlo
         J0PZJ0eOmYMj1PvWZIx82Hdob3qNqMCleqVqgE0/KTQdH2Bz6v+QcTw/1Hxl8U5fGYrI
         dUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pY1pNPrl1tG+NPM43+xxPuU3zVU/KXwcJU4pMYDbF1s=;
        b=foZ1tIoPBkYD+70ko2ZrNR6DpGFDX/dVuGKfJ9qx3u7o5ZadytLyzcAXupI4Zbv2kt
         8yexGwZtiFceoo62UMhc0r37yMafZApcT3ssFy9in4Yt0n1m7tTpMVXJBsFLm61MMIv2
         fbKpO06oaAHrbEWi9OLN9ifYuzQ1uwx1b28jaj2h+dPPWVksUggliG7uSBV8FGj+1kJ3
         I67j+ksUzhUsqVjD0fyz/OyqCZb206/SLEMcHshIzKd00g7tgwbY9b/HmhJbUHVKT+7N
         RW3mFpeG38dHlrREq9aFEV2eExP50/l+MfAhuQXQ4X/bc4qZ4CfEjylp+6oEFGwxd77W
         Ci+w==
X-Gm-Message-State: APjAAAUenZdc2nEw0BNLHTddu0S6QjBgyCs54qSxrykiU4jXHNyGxiJO
        XWRtXRXaF9VvVq/zZYHpe9smhzqC
X-Google-Smtp-Source: APXvYqwE5t/YbYPtPqDl9R/KNDkv6EO1KpDV7j2x803g3C/CZ9d2tQm2QO1UKu30ptZKrdTKY9XCBw==
X-Received: by 2002:aca:ed85:: with SMTP id l127mr17566781oih.75.1574532092813;
        Sat, 23 Nov 2019 10:01:32 -0800 (PST)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 18sm654600oip.57.2019.11.23.10.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2019 10:01:32 -0800 (PST)
Subject: Re: [PATCH 3/3] staging: rtl8188eu: remove return variable from
 rtw_pwr_unassociated_idle
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20191123151635.155138-1-straube.linux@gmail.com>
 <20191123151635.155138-3-straube.linux@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <bd1b91e8-1f55-fe3b-a2f0-8ea62de919aa@lwfinger.net>
Date:   Sat, 23 Nov 2019 12:01:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191123151635.155138-3-straube.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/19 9:16 AM, Michael Straube wrote:
> Function rtw_pwr_unassociated_idle returns boolean values.
> Remove the return variable ret and the exit label to simplify the
> function a little bit. Return true or false directly instead.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/rtl8188eu/core/rtw_pwrctrl.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks,

Larry


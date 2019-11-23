Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D47C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 17:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D272C20674
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 17:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Au+ll1GN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfKWR73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 12:59:29 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44417 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfKWR73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 12:59:29 -0500
Received: by mail-oi1-f193.google.com with SMTP id s71so9442492oih.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 09:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tiHa8wg0xKw8eHEQWFxtmRKRM2wgS5M3VjCm3UfWPpQ=;
        b=Au+ll1GNHOI0ui+2SH8xUU7Q2fUqX7N7w7z3ix1gDEngW+8K0ZQthLlqvfVLVJpigs
         S7uKjAIuy574UxD6tTtoMT7XeLnlYYUnvKf263VAGkNHavJb/7NknVkof2kMvTnOzATy
         wndR772MlAAdJRaYmDUTBx9Rl2Jfy7KreAfNSnkzKnDRmii6zc2aw0gmhLP9mqXTGH1e
         AhW7K5A2P3PQa2fHK+ClbeUvy7Zr3edrb5/pxEa0aIbD+zgj345zSaOUHk8YBALuMeK4
         oDJEXF0FUOjbrLOCWHOcRgcblBXJ2JWxEjUuy1AGuUSGvBJGR4wzXYFtD5bguxyyG4WX
         tVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tiHa8wg0xKw8eHEQWFxtmRKRM2wgS5M3VjCm3UfWPpQ=;
        b=YXu4uDvtDQWWw9SoHzgHRM0bYp2htmDzeIMlNz2AeNEW7tYjPg1xE8w/hb+7aSsYc1
         9uekzFvGRI/DcaFTSZGLtHKtsqpn8Z7udzEtuzCDbxS/kEL1pJw917qjaFtOYY5kjtNF
         UbxMGAxHclD8+mCREkrjy6UO+YDI/XaypYWZLnj2MKGQBYyll8n9+QCB/rv+pAt4g8vW
         HXSk0f0mcC4G2LKTTOhYLMIqER1R3pYTPrcRCjczwbDxBetNScJ1f7eEG9lTGl8CQcmr
         3MBlARcGXKiPA6hffL6f+dpko0in75HEo/wpCb4XTm/1mNikXiCqU/o9Xv3WFj53ZC3S
         aL6Q==
X-Gm-Message-State: APjAAAUoBaGwHTY78fAZbtNduuSWRzq5UDRSSQtCSRslkKEU1L1//wRT
        m7BgQaJZ+mk3e5U9tmN/tPEgxzDl
X-Google-Smtp-Source: APXvYqxWn+kG92vxuUPUBaYTcvrqHSIX0vD5Lb7dUjrtna43YdZpa7ZiaF9Eaqj2meDo3GhdR4Zt+w==
X-Received: by 2002:aca:f495:: with SMTP id s143mr1892013oih.118.1574531968172;
        Sat, 23 Nov 2019 09:59:28 -0800 (PST)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id u22sm664113oiv.36.2019.11.23.09.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2019 09:59:27 -0800 (PST)
Subject: Re: [PATCH 1/3] staging: rtl8188eu: remove unnecessary parentheses in
 rtw_pwrctrl.c
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20191123151635.155138-1-straube.linux@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <fdfb10ff-b9e1-d5e0-e5ae-484847570a27@lwfinger.net>
Date:   Sat, 23 Nov 2019 11:59:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191123151635.155138-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/19 9:16 AM, Michael Straube wrote:
> Remove unnecessary parentheses reported by checkpatch.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/rtl8188eu/core/rtw_pwrctrl.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks,

Larry


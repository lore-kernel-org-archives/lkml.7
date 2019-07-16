Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E5CC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EAD20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsNV4dua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbfGPSTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:19:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45893 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388277AbfGPSTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:19:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so21957479wre.12;
        Tue, 16 Jul 2019 11:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=76U4Hcux604hTRXcPQApvKoQJ0LrG41HHfk4rrMj+pQ=;
        b=WsNV4duaurgfdQcPLEEHYi80uoHiH6kgPixTt/5PB7SEtc8dDm3CmdV5Lo3yX9FkZs
         aPN+9PO5enkOBflZ8cdSHbl63uexYrhIR5zspN/Thnbef455UBc0YsEC+osi+2MjlYw+
         JN80Afh65z3SkF26IKT0ewYc6HJYuFe0NPuxMHNcLqf1fwtP9R/uqIRHgacj/6Bb6Z7o
         bFQ694BCS8CEVmYyLP91Hvfv4xKGVjBX+zLUTXgHdnuc52s9SFaNbCmEgDWck9+O/sG9
         1JrIXl9p+Z87BgtQ03H3TKa6JQQnir+hwbGAN6jHWAzx/P1mODiA5UxX7Nt0MZ4Ektjs
         u59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=76U4Hcux604hTRXcPQApvKoQJ0LrG41HHfk4rrMj+pQ=;
        b=qkVFxpdUKivWJ8Ait/4K6B6nL7Jmbj/No1yr9u+eLLNo6OYd7f6NvHlYcTwgwtzRX1
         XAv6Pn6IVtx7fBbj4Hsyk0u2xpuJCEfw/DIWDPB/6xu2hepleJYBy5QZ+LHIvfb49B0n
         /2N3oePbS9PoRYrbahP1OlJ1TixUQbkVCUMSEHpAMBLwGpkuOImoYsLrHactmUtcDL9z
         HZe1+/hy09/RUwkLQJGGxV28J5mEpL4T14MaiTdNrKaXixXpRxu/V7zUGFokEyzLboBe
         hcFNSossGMp5BhyoDUEHxfKNl+TtPdR64kYQweLEI6VthWgEO9sJemUoRsHCMZslCHhp
         PAvQ==
X-Gm-Message-State: APjAAAUiSczMIYjbmEM0Q3WUtwf1aVsqMNl9aoyPm8WCc5IJiQQsaN6t
        WbXtPeZ8sta1OaHKz/eBAic=
X-Google-Smtp-Source: APXvYqwOInU76CNDBm3+Pvoq3ZNmpPzGgiGzIzn0sDNPUXwqxGKo5HTbQ4gAEYdgQeUMLsjNmSxf1Q==
X-Received: by 2002:adf:a299:: with SMTP id s25mr30044808wra.74.1563301147356;
        Tue, 16 Jul 2019 11:19:07 -0700 (PDT)
Received: from localhost (smb-adpcdg1-05.hotspot.hub-one.net. [213.174.99.133])
        by smtp.gmail.com with ESMTPSA id r123sm20111923wme.7.2019.07.16.11.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jul 2019 11:19:06 -0700 (PDT)
Date:   Tue, 16 Jul 2019 20:19:04 +0200
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     allison@lohutok.net, tglx@linutronix.de, info@metux.net,
        dilinger@debian.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: psmouse - Fix build error of multiple definition
Message-ID: <20190716181904.GB1140@penguin>
References: <20190716065411.56780-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716065411.56780-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 02:54:11PM +0800, YueHaibing wrote:
> trackpoint_detect() should be static inline while
> CONFIG_MOUSE_PS2_TRACKPOINT is not set. otherwire,we
> got building fails:
> 
> drivers/input/mouse/alps.o: In function `trackpoint_detect':
> alps.c:(.text+0x8e00): multiple definition of `trackpoint_detect'
> drivers/input/mouse/psmouse-base.o:psmouse-base.c:(.text+0x1b50): first defined here
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 55e3d9224b60 ("Input: psmouse - allow disabing certain protocol extensions")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thank you.

> ---
>  drivers/input/mouse/trackpoint.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/trackpoint.h b/drivers/input/mouse/trackpoint.h
> index 0afffe8..77110f3 100644
> --- a/drivers/input/mouse/trackpoint.h
> +++ b/drivers/input/mouse/trackpoint.h
> @@ -158,7 +158,8 @@ struct trackpoint_data {
>  #ifdef CONFIG_MOUSE_PS2_TRACKPOINT
>  int trackpoint_detect(struct psmouse *psmouse, bool set_properties);
>  #else
> -inline int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
> +static inline int trackpoint_detect(struct psmouse *psmouse,
> +				    bool set_properties)
>  {
>  	return -ENOSYS;
>  }
> -- 
> 2.7.4
> 
> 

-- 
Dmitry

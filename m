Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BD0C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BF9206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="mCEYHaik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbfILKAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 06:00:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39143 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbfILKAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:00:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id u26so1112287lfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 03:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dgRHe0c0zALMw2TSjbVcveDJfiRQV5j8z+Nv6bZbiTU=;
        b=mCEYHaiknSmh86XK9e03fuskcmgH8JP35BlF2mnj8P4vGddGJJgDkO/Str6PuZEhFJ
         d1fle7Bp5qw0FZd+YOjt95a0BFr8sjKu/UFAH71NB9BQCF4OHxyjt/l4GlrD0mLiyCKi
         EJQMNGKGNGxIjoUeqvg1dQE42v79xFegUa/urL4rV/iW82qETF9ASs4Ccy2vZ6ZnZfHP
         j/E78UGKbUBPikmsnuhGu5RTZvizM6pCJWCRHTW2/TADq0WVYYtam+IVUg5vuoiRH5wR
         yNMqSxXHLuxHo+ZVGVanOpH2wvBnUYyKzJAE6AE508a5anSURDrhzQ/6wEZMghOXdXtF
         owNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dgRHe0c0zALMw2TSjbVcveDJfiRQV5j8z+Nv6bZbiTU=;
        b=saUvQCob2dQk+A/x/t7DaqRLdXvymvtBEtoFXKO16YL3KBusQQ6EgJfAyIvW1BrOFo
         OxD8OuSrlElx3vOvZbR9nhmhMtIJQAp4HS0hAdqIBBfQVqCv2Sv9fbKftIHwtN0oZUIA
         WrkApQYdvP1Dgyr/Waiy1gUExa6oCpQSDfY+iSliWRRB7yeHdRz9TfUvgeiMUCjnUgXL
         tgQtIvLKGdrFGW0V2T6t0BMb8IJaL2qoKoKS9R/fwt2s78UEi0BgbVGeJDtZdnuEpjAQ
         RUNczeW02qEQ1Af9TvQP96svGe787Tq9bI7gHFg4SejWFLg5S4kzOaW8Duip8L4RV9uG
         /6og==
X-Gm-Message-State: APjAAAXMJgW36x3GOieYf0rVtHVzsv6r0Vk5buowjgv5yuKzohagjSgx
        bV3uV/OtH1FyfeJhR7p5xcakq1c08JTbdQ==
X-Google-Smtp-Source: APXvYqxc4YkOSQULHhzw8UnouJkwyCr3fFXRTqlNg0o1TvAscvTc+8yVIN44zsSWfVizJCzuqCdaKg==
X-Received: by 2002:a19:8017:: with SMTP id b23mr26387068lfd.132.1568282451053;
        Thu, 12 Sep 2019 03:00:51 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:4458:7c96:687f:e13:db32:8101? ([2a00:1fa0:4458:7c96:687f:e13:db32:8101])
        by smtp.gmail.com with ESMTPSA id l3sm6122626lfc.31.2019.09.12.03.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 03:00:49 -0700 (PDT)
Subject: Re: [PATCH] drm: rcar-du: Add r8a77980 support
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS FOR RENESAS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190911192502.16609-1-kieran.bingham+renesas@ideasonboard.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <70b94265-69f3-d18f-1b67-b5b814723b1b@cogentembedded.com>
Date:   Thu, 12 Sep 2019 13:00:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190911192502.16609-1-kieran.bingham+renesas@ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11.09.2019 22:25, Kieran Bingham wrote:

> Add direct support for the r8a77980 (V3H).
> 
> The V3H shares a common, compatible configuration with the r8a77970
> (V3M) so that device info structure is reused.

    Do we really need to add yet another compatible in this case?
I just added r8a77970 to the compatible prop in the r8a77980 DT. That's why
a patch like this one didn't get posted by me.

> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
[...]

MBR, Sergei

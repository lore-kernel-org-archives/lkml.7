Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FCBC28D1A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E281D206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfFFIEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:04:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46207 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfFFIEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:04:36 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hYnNy-0005Z5-Ds
        for linux-kernel@vger.kernel.org; Thu, 06 Jun 2019 08:04:34 +0000
Received: by mail-pf1-f200.google.com with SMTP id u7so1285067pfh.17
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 01:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AiCZ+eWnELxsFCfkNHpZ8uErbdptfu0aYCu6DgRNOow=;
        b=XGIfu2RMoAlTm+Tpb4yGnszlUl+Zr4nUG2K+Jb7h50Cf5fNJfVU2OvSg+OsrwagLok
         5sV2tF7GeRLL8x9d0JmXeO+h+uFGCwt8QCztjI6d1Ihp4IJ9Xomvd0Z7iK97Awf6uYSM
         Tk6c5qrzLs1NnArqnIQDdT0T9Gc77TW1GDYnQ/rznZh929LSdt/3IR0WGPFxHL8Tgbpb
         ZFUUTkYe90xGWK+zX20HwFyrXmW8Thi/Z9nNWHoa349PVrZEPBjiXW4YZReiGBUTQAvU
         wFhYfmxGZig7JVaC4rKlqtxn/BxVJXciabNl8wFKgilBV78qa9uQyHGIT7XZ6dX73qeX
         X8Sw==
X-Gm-Message-State: APjAAAWpqQ+IiiRfBqEc+d15YyzyQYFqug0hSR4TVe/szq8bKd+iNvUG
        m77F0F4DTVV+J7vtU18Y10xWtzeny6B7g/PFC+L+HCGLgRO9NFhrTmD5FCnFcEHjHO1iqPJ2z9e
        UqM2gHvpKKnwZXrMGPmbc0dSAZWo3RHR8PXQPCC+8Tw==
X-Received: by 2002:a17:902:3fa5:: with SMTP id a34mr47447528pld.317.1559808273091;
        Thu, 06 Jun 2019 01:04:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzSL9CxDGC2OiUM9isEnbmxV2GSn8dHls2aVW2WpOdz4AmFmP6Zv/jGob/jsAUodbFR9junzg==
X-Received: by 2002:a17:902:3fa5:: with SMTP id a34mr47447510pld.317.1559808272766;
        Thu, 06 Jun 2019 01:04:32 -0700 (PDT)
Received: from 2001-b011-380f-115a-4031-dc0c-76c4-a6d1.dynamic-ip6.hinet.net (2001-b011-380f-115a-4031-dc0c-76c4-a6d1.dynamic-ip6.hinet.net. [2001:b011:380f:115a:4031:dc0c:76c4:a6d1])
        by smtp.gmail.com with ESMTPSA id n70sm1047794pjb.4.2019.06.06.01.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 01:04:32 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] drm/edid: Add 6 bpc quirk for SDC panel in Lenovo G50
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190402033037.21877-1-kai.heng.feng@canonical.com>
Date:   Thu, 6 Jun 2019 16:04:29 +0800
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <54557F79-6DE1-4AA4-895A-C0F014926590@canonical.com>
References: <20190402033037.21877-1-kai.heng.feng@canonical.com>
To:     maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

at 11:30, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> Another panel that needs 6BPC quirk.

Please include this patch if possible.

Kai-Heng

>
> BugLink: https://bugs.launchpad.net/bugs/1819968
> Cc: <stable@vger.kernel.org> # v4.8+
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 990b1909f9d7..1cb4d0052efe 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -166,6 +166,9 @@ static const struct edid_quirk {
>  	/* Medion MD 30217 PG */
>  	{ "MED", 0x7b8, EDID_QUIRK_PREFER_LARGE_75 },
>
> +	/* Lenovo G50 */
> +	{ "SDC", 18514, EDID_QUIRK_FORCE_6BPC },
> +
>  	/* Panel in Samsung NP700G7A-S01PL notebook reports 6bpc */
>  	{ "SEC", 0xd033, EDID_QUIRK_FORCE_8BPC },
>
> -- 
> 2.17.1



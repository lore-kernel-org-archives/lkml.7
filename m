Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F164CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B5220856
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w56mXCzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfKKJZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:25:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35808 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfKKJZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:25:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id 8so12435573wmo.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 01:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EAGdmecmIYQMbogASNQhQtQecAe8bZ2za4Rdh2+08ME=;
        b=w56mXCzCV0zuIKf5UgKd73iw22KzOjcm/ewjieo905GNM8iSDbjgrHD9m2hsv4+N/p
         w3Mrdp0iqj4WQ1ftEYaBeJpjglqxWWNcz+udxPTk7EkuKxVsG1VrLYriVu2Qy/zPxpYf
         zdpT9yI5Ck0J21noqDhFuBPAhKcW2CzERSW7Yghx7OUbF/hN1Ns78XszQtXvGzy6T39t
         mC6KK5ZBZpkR3k8WPvTegUKeDltIcVUzVyd7IJnqcBRvH74F3hh3QEv9b+DmzXEqnXQr
         6RzPTXp4Pp6QzLoHKgzOsZotTPAXj+8X6qaPo+b4Mg473QAe284G+Ntxo8Xhv2Kh6x86
         Bfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EAGdmecmIYQMbogASNQhQtQecAe8bZ2za4Rdh2+08ME=;
        b=gsULx0100NSMNSVIKsjJZL+pcldgQBa718ufKkYXN6gcxdFPBhAlx7rHhS9Og5hu99
         5rZr5kO9b5IwQDrH04c/rPYN9J4DPOnutq64fpqxqwTWPptthw07pNeRI0vyZvPdDaWg
         QGd7rwBVcpp2gaU/itN8khh63+bHg8CedgwJcWerTPMqnVQUOMVN7ui57hRZ4P5sQ6Wc
         MMhj0OFgD9JTOIfo6YgHyN1bU57iuM5yd+c0dwWCLGGcePl3hJC1bj7QCd62jGqdue+o
         JRAVBNhNteYN5p4VSAO4EIjy0qhFC6EGwxH2AMz77M0qvkMTDlkUDl+MosQH9Q4UTr3S
         sYTg==
X-Gm-Message-State: APjAAAXrwZp1tD9x5ZGjCQvPbRHp/1SHfIWtLE69hgKQhYBCPoHXMvvv
        Hgm9STE+veLPOKfMU6GcdKQ+fA==
X-Google-Smtp-Source: APXvYqxsuEZoMa82YymohR63zheNj31pQiSiawLEKigrwQP7JSqSDgwgZGuFELRxkBAXjKVnTla1UA==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr20598305wml.41.1573464329856;
        Mon, 11 Nov 2019 01:25:29 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id c144sm17688300wmd.1.2019.11.11.01.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 01:25:29 -0800 (PST)
Date:   Mon, 11 Nov 2019 09:25:21 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH V10 5/8] backlight: qcom-wled: Restructure the driver for
 WLED3.
Message-ID: <20191111092521.GS18902@dell>
References: <1572589624-6095-1-git-send-email-kgunda@codeaurora.org>
 <1572589624-6095-6-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1572589624-6095-6-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Nov 2019, Kiran Gunda wrote:

> Restructure the driver to add the support for new WLED
> peripherals.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 373 ++++++++++++++++++++++--------------
>  1 file changed, 234 insertions(+), 139 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

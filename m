Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FE2C2D0D1
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA96227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/K3+TWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfLRJjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:39:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32832 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfLRJjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:39:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so1517316wrq.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 01:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nFPcr6Vhf/vTUjnzKn/DgVDi3KeDiuALX41REntGwaE=;
        b=V/K3+TWVGK3j3wHm/pvunVZKgm/4sFvM7qY+23Kd9QQibFKlW5umPl8RNbE5nVx+Zf
         FjdOYqcyo2HvBpD66JePTkC7aVAbWrqNs05VBqdqU6+fcIUBt2ETMv7Fpd/qkJEhq3iS
         sAwPgriUz/aXUOpMmjLz43xPTxgNaYw/jiYA62sRfCcpiIHWnp7GHqV/KnAjjahsa7sG
         ilpdIqsAjAKAhkzESCyACJcpbuwlAs8L10eHvbzv73PWG4WL3DGVhRk85SqnD0tEBiYr
         Kg0qBelmU+Mk1Xpz8QrN6cz/EDoRUSalKERhbQhc7RzPYvn1PKpec21zQlt/TdmHW41z
         pkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nFPcr6Vhf/vTUjnzKn/DgVDi3KeDiuALX41REntGwaE=;
        b=WahORYnJxoTHfynuRSTYWWKraRCKEzEbYBPlpOXYGfp8N0QWA2t/+oEHr1Dn9p6SaT
         iJR66Uo54Pg1RwuxvLPTB2gsNFaxDXapnkedgB/hfCYEeoxv+3JRfJu8mDyXfMyhKwSk
         ytMBTCXhlW61qmHJhOrCx0NsWtVafHT7+tTDrbudAQfmY8ca3qsiATjOd8wV4eHlKr/K
         UG7KDWSlQN1zdLlEH4o5Iu+oPg5yEb14L/ZsPYHjALOiRWl7r48QL6Uf8W9mZbP9AHpM
         r4TEW21wEm49m/msKlnOsiaJmFh0VykznLNuLSCbW39XhyONh4ONwaqxl9c/ELYWfho8
         m1Iw==
X-Gm-Message-State: APjAAAUT8KKozB2PytyLOeefLqM2N9hFJqkUCJsaF/7D7zaEo+N+DGqb
        e/5mKidhLK8sTQzeEbHXWKJCFA==
X-Google-Smtp-Source: APXvYqzSJKUl+4Mp9mXUnWGBYdOx1N4C65CovJGXTy3EzFZSQQGVRwoIgvyZ3eGDW5jE2Jo022hASQ==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr1743769wrh.121.1576661940179;
        Wed, 18 Dec 2019 01:39:00 -0800 (PST)
Received: from dell ([2.27.35.132])
        by smtp.gmail.com with ESMTPSA id k8sm1975793wrl.3.2019.12.18.01.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 01:38:59 -0800 (PST)
Date:   Wed, 18 Dec 2019 09:38:59 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mfd: intel_soc_pmic: Rename pwm_backlight pwm-lookup
 to pwm_pmic_backlight
Message-ID: <20191218093859.GO18955@dell>
References: <20191212155209.GC3468@dell>
 <4d07445d-98b1-f23c-0aac-07709b45df78@redhat.com>
 <20191213082734.GE3468@dell>
 <d648794d-4c76-cfa1-dcbd-16c34d409c51@redhat.com>
 <20191216093016.GE3648@dell>
 <fc3c29da-528d-a6b6-d13b-92e6469eadea@redhat.com>
 <20191217081127.GI18955@dell>
 <87immfyth2.fsf@intel.com>
 <20191217135140.GL18955@dell>
 <87a77q14wo.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a77q14wo.fsf@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019, Jani Nikula wrote:

> On Tue, 17 Dec 2019, Lee Jones <lee.jones@linaro.org> wrote:
> > Hans was making the case that this was impractical for DRM, due to the
> > amount of churn you guys receive, hence the discussion.  I'm very
> > pleased that this is not the case.
> 
> Heh, well, it is the case, but the point is that should be our problem,
> not yours. ;)

:)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

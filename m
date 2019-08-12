Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4EAC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191942087B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCssN2Mf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfHLH1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:27:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35362 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfHLH1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:27:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so10843357wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=M9aJanqtIEPRe49BYJn3ZlUDfjhOGnev4rwCRAKzpuI=;
        b=NCssN2MfGtJrqnNivNeFSF7IU3Q+kpv/TfUnp+O+h3BQHOZevQpLaboskIBdmUBXNw
         earjH2zTGMvFyzDsTLyhjkQEL9ATmpJyrgbcnZqT2DyKSDx9tczfygKIqT6kE5Kh/w9h
         hwvz9EBl+hFaht6O+MXtt6OHjXoSBYDtjLsd4RhPAfsSQZXQQakv+T1t31atOCPLI2t7
         4TuwrF4fol7M7vF8Fk7w6Zxe7VmHQ17SotYVRspfc00KatgEG7NiUEo+S6plm2gNZmLS
         WH952l+k9z+b8/R10i6OH0duyH5F/AYZfNxtVraXR+xGvjAeA5H8k8mN3EfiT9KKrNQm
         113Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M9aJanqtIEPRe49BYJn3ZlUDfjhOGnev4rwCRAKzpuI=;
        b=hxzZWGHo/M8erGN2pRKjApOcad/p9jLsRkwf2Pc9Cut0e9JBbFKlqoWjzsmtOZIIiQ
         vbbRWKJUZI1CWZljDeu219VXHa7SZT0tVyV+PrsBC6QqgpxhyR5LjrVKD6Pjqe4h0Bq+
         8keNnMmGhop6ndshHfG64QcRaIFxQjdoCZZ6PgEzXSW4IrNOVFryh4sj6SUTFGvZBKWh
         pegKEwbyeWvABcO+w/FUaZYAaLG7PKUyYpHOE3Xcg0wVb5MPYpfZ6EdvI8tySZxXX0ug
         xK6XnvSBGE611X/ufebgdt1QydgRQXkaiqdTx6cbP14c1l2OAoS3/DzRa7lv60d8ASD0
         fdaw==
X-Gm-Message-State: APjAAAXdaPKYMzJryAlSiPVriw//Y434lilq+NOo374yZZDojY81EtiJ
        J01+a2jFKVj3QiX5CdbLQpRGtw==
X-Google-Smtp-Source: APXvYqzvxWLmImaji3yWxmQhoWun2ICYBCT7ibAPbknfBmC82PEDKS9vrDveZZXvIKRGjOqeYBBlyg==
X-Received: by 2002:a7b:c155:: with SMTP id z21mr18839780wmi.137.1565594864613;
        Mon, 12 Aug 2019 00:27:44 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id 2sm1597486wmz.16.2019.08.12.00.27.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:27:44 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:27:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Yicheng Li <yichengli@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, enric.balletbo@collabora.com,
        gwendal@chromium.org, bleung@chromium.org,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] mfd: cros_ec: Update cros_ec_commands.h
Message-ID: <20190812072742.GN4594@dell>
References: <20190708181536.2125-1-yichengli@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190708181536.2125-1-yichengli@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Jul 2019, Yicheng Li wrote:

> Update cros_ec_commands.h to match the fingerprint MCU section in
> the current ec_commands.h
> 
> Signed-off-by: Yicheng Li <yichengli@chromium.org>
> ---
> 
>  include/linux/mfd/cros_ec_commands.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

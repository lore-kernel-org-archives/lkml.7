Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6183FC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22150214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l3NCm5H4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfFZNLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:11:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52035 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfFZNLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:11:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so2057861wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 06:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0BxJ+Et84mPqQCPlcRRqFO49HrU/Wl5dGiJ4XIT0srA=;
        b=l3NCm5H4tbfery//KbsUFHMndj0l1nT2VDggsAmcddTHTKF6XNw6S9L76DCEs/yObZ
         vgQByEe/2kOqhH2MqHyFsCzGh1yJPOqhfmW00VU2LjfsdxsbVxbrtcVc6Lb0vw6i5mPl
         wu/fnm/+Vx0Cu9UzjluQSNP/D+48uf14r43/3W4Cu180OS35U69W6rHuKwbfcJr78j9b
         VfDB77+nBoWK02S/2jyC7VviDgwcGIZRq67mvz+sSrVV2BMTmJhYyxC8ZT2A041w2i9q
         OL09P3dqKGIgahAGhNIrlFxfgG56MiSs4JO2npYHVgtdbUtJmNx5an/3I0YLssUDu9hn
         78dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0BxJ+Et84mPqQCPlcRRqFO49HrU/Wl5dGiJ4XIT0srA=;
        b=Seyfs5qzDm+b2iRVtMQZLOjJ7pbJtTsrlDqPa/X9ptjtHUtDh+3O9PJCB/VncKuS7Y
         9NlkjCQoHRCpudaBfvhcDyx60A9r6xQLbzY8QToxHwNQHezZ4FEnk/VU6V6ImjnfDqYc
         NVKzFirOgYujW85Mb7WhmV+iD+R6bd1hL1vQ8GeI+YmznT5LErNonAVtTrkuEGQfCDv1
         YCZ41g0JM21eOP6+UFAbxhFDkhMqq/clK9RNIrYXfe/fmaOaPs3mglijpmn4VHKXcrLl
         mh+++ecwUScL6iL3Sw1XD8vq8sGx3Vt3PuDRJXrP2V48I7izsV+xfidKtOneTh7D21XV
         qo1g==
X-Gm-Message-State: APjAAAV3O37UDIBkFNUzXpgQTMvMVgReXzEsAdwVRqr1tidUSUqv/AFJ
        k5v9q7EjQ7SOi9n5Q42tdgEmpQ==
X-Google-Smtp-Source: APXvYqxJfHtONYZRNR9PfEDNceCnYKEVQ419kiG24mhpT3Qw7BDHt1Zd+ioR8YJAoIN8Ai0hGB1dFQ==
X-Received: by 2002:a1c:7a15:: with SMTP id v21mr2719079wmc.82.1561554670292;
        Wed, 26 Jun 2019 06:11:10 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id n125sm3033987wmf.6.2019.06.26.06.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 06:11:09 -0700 (PDT)
Date:   Wed, 26 Jun 2019 14:11:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: intel-lpss: Add Intel Elkhart Lake PCH PCI IDs
Message-ID: <20190626131108.GU21119@dell>
References: <20190621125807.37181-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190621125807.37181-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019, Andy Shevchenko wrote:

> Intel Elkhart Lake has the same LPSS than Intel Broxton.
> Add the new IDs to the list of supported devices.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

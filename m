Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21836C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A4F20850
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCuJzdA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfEMP5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:57:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46691 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfEMP5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:57:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id r18so1929032pls.13;
        Mon, 13 May 2019 08:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j2wzXAkeOJsbguPzhOmjwuMK8y0Jvfoc457XeYL4o8Q=;
        b=GCuJzdA3RdBDfWUWlGh22lIZ35XxndDicYtRND1QyHkB99/+QdnDwC3nAEMZKvRzQe
         mC5CbbfR0RFFiQrG4/vNUqG9VbnrlZWISUZdtTiGxMm6L3H/DtQeaj2tN3Mu0capLxZc
         q+IvzdqSzATvqPa7Ry8/t5orwlZ3cGugy+i7ZEtwQPRvMrSNWwjvCwJBK7z6B33hHRbX
         F3wjT1UKx9txWgFctUNXvdcU9kLyO8cLcixAJWlrAtqvh1dRQTaZo1L21ZxsLzRUNCsN
         LdohbLbnMOr2+uka0TuuvcU9UR8jhckdm4QIeohzLBpOukgjSl9Ppmuleu8HzFHbtzY1
         jiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=j2wzXAkeOJsbguPzhOmjwuMK8y0Jvfoc457XeYL4o8Q=;
        b=njceUaeSym+Z5MWJaXCA+bitHrcZ9mmi/DpfCez2L4cp/ZKeWmePib+HUUtyISH926
         dPe3Rz2U0+d6KmbNw3G/e6PaxG0BHlV+CE7Ujk5PPcKRZJjzTICGawzapz5HzdbrdZcR
         WnfntiLp5eEqzfGJ6zshBw+l+0hDFT1OzpeyUS9yWyCKf5YUk8jmlBEd5IRFc5x4iZM3
         p9y1d8YSj50rBeZ/VI7TTg8gv0OyaWCxN+GgGfkWZW/d7PLTKizjiTiHDrceYIczdgLf
         eP8COX4Hxc/QGJz3uNHBBr8RGtjzUrQEQosKCx9DhBI3ykgcRLFfY0nBqGCLQBqpYYRs
         WOLA==
X-Gm-Message-State: APjAAAXqf4WFObNbXSpTmWyZCZiuBySYyMAHYDp5FwjXYj2i4jrNJj8l
        qwFKm0aGhvd4FN85fDXoNPY=
X-Google-Smtp-Source: APXvYqzv8PG3czWnmYiSe6VV1ZTPVoon1wkzDiNWCOD9j27OuhQGtzCcckDWG5cSv4n66LrF+SFB9g==
X-Received: by 2002:a17:902:2ae6:: with SMTP id j93mr8288103plb.130.1557763043741;
        Mon, 13 May 2019 08:57:23 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 125sm5961563pge.45.2019.05.13.08.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 08:57:22 -0700 (PDT)
Date:   Mon, 13 May 2019 08:57:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the thermal-soc tree
Message-ID: <20190513155721.GA26559@roeck-us.net>
References: <20190513110244.0a0dc431@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513110244.0a0dc431@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 11:02:44AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the thermal-soc tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> ld: drivers/infiniband/hw/cxgb4/cm.o: in function `.devm_thermal_of_cooling_device_register':
> (.text+0x23f0): multiple definition of `.devm_thermal_of_cooling_device_register'; drivers/infiniband/hw/cxgb4/device.o:(.text+0x28c0): first defined here
> ld: drivers/infiniband/hw/cxgb4/cm.o:(.opd+0x2e8): multiple definition of `devm_thermal_of_cooling_device_register'; drivers/infiniband/hw/cxgb4/device.o:(.opd+0x198): first defined here

[...]

> @@ -508,7 +508,7 @@ static inline struct thermal_cooling_device *
>  thermal_of_cooling_device_register(struct device_node *np,
>  	char *type, void *devdata, const struct thermal_cooling_device_ops *ops)
>  { return ERR_PTR(-ENODEV); }
> -struct thermal_cooling_device *
> +static inline struct thermal_cooling_device *
>  devm_thermal_of_cooling_device_register(struct device *dev,
>  				struct device_node *np,
>  				char *type, void *devdata,

Ah, I had wondered where that was coming from. Eduardo, can you pick up the
fix, or even better merge it into the original patch ?

Thanks,
Guenter

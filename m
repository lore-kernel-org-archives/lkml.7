Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9205CC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0C02171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQuoOAnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfDSTju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:39:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40356 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfDSTjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:39:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so3001749plr.7;
        Fri, 19 Apr 2019 12:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U2Q0nFQ+HJR/Ek1/RdnkOZ6wrXABlVdEopStnI60in4=;
        b=DQuoOAnpS6Zcg3bCE/dmvBUXznSZn/vQDybFZVyFn09ToNq5sL+UgI/12sYJ1Cl6KH
         sZZnVr2WI5WAhq/Ldflj/ZvP47iHSxq1QUZVd0AEh4GriCnOXRpY7xcFbDFWV7/0UPru
         GVjW3x188IF1mHX3KIjHOa5dOt8rp153Wh7QTApBIFNUq08jxbAXuU/BOBlhKuqgCVxW
         b4khTnnuqmJuoPoJ29bLw/86HrQR+ElvXD7imu6amnHU0zU3+6pUGipYrUr2CdmjWPqw
         zu8CEv+dmuLT5aqe9bnC+ppVAqLJBQick05KMXtYXI8/2k3+u+/28VMcRrpIqYOscXhj
         MHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=U2Q0nFQ+HJR/Ek1/RdnkOZ6wrXABlVdEopStnI60in4=;
        b=Rp8jzQVuy1Bf/pfZAKEALmWoWhJ9zPL9P4+dexpx6Bx/Kdw0uzJqts91HU1Dx6Nkbf
         MpkwhrPcq7zDNMMEL9U0wIsE/nZ10k9ggSVcwWkl+pi6WmsBn9fVPLZa921Xl91Ztl7O
         paPBf5ev8Fj7enV33rfIkictvRsRDdvUL5f5js/PepV8wjU8hN3Ez018voyKh24VNa4r
         rhekdnKb1MtE+7TGSPHGDWbA2mMu++iWlODOUKBkHrGrGdBYEYkePE2k3Dg+G9j2dvg7
         td1P11rgT03dDwQ1qDwxVK3cU0U8/qAT3W1KDRLlQgijUGeXh3cWBC9YaDqwEgdoMN/s
         lcsw==
X-Gm-Message-State: APjAAAWhSmfuORQC20Vlzi/fPOLl/5kN1ful6htwmZmtYYKUOFXCUVmI
        vrbVMiiHNW35vzKv5ZG1OZo=
X-Google-Smtp-Source: APXvYqwCdRDEXG/cMbBCSYD5rcfUsF6QivZzggyD9XYqQReAz7ef3Sfgtm29dr7RrdXEAdF6n4pR8g==
X-Received: by 2002:a17:902:2a2b:: with SMTP id i40mr5699012plb.80.1555702788896;
        Fri, 19 Apr 2019 12:39:48 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s187sm6053277pgb.13.2019.04.19.12.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 12:39:48 -0700 (PDT)
Date:   Fri, 19 Apr 2019 12:39:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/92] 4.14.113-stable review
Message-ID: <20190419193947.GB10320@roeck-us.net>
References: <20190418160430.325165109@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 07:56:18PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.113 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Apr 20 16:03:26 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 333 pass: 333 fail: 0

Guenter

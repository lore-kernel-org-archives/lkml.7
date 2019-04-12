Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988E3C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AFD2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tO79s0XM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfDLRgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:36:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40783 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLRgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:36:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id d31so5520414pgl.7;
        Fri, 12 Apr 2019 10:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/fU2XOZlNfHgVmFdbXsPhfVHyMpsWO0SNIj8so6yhYQ=;
        b=tO79s0XMi16tqB7riO3zcRb+4oxmBi6bI5lS/DBM7NcAFcstfBEQXw9OQtL/ksIGI3
         qa9NbsAwvwq4mr/HHr1G2qWzJ/5RnizxIJ2u22jqTaq7ATDCfBX3J4dpzugNAYL7r/zU
         8a5Qg84plf7EKtL6PySs+ondyIc0M11m5OdYwgFtExa75MfZBp6Xcm36x4rc9oUEKlF1
         siHt3BxKJBLsr6JQGu1bB1LRrzyEhka4sjbFqqZuZLzTJE9fct572SBvlHMI0yqPXatk
         p9HEhnQRhwQHPhOMQz6xYTs4zGX497ejGCLLSiX3VmjXQITK0Y1eZhKIGbLDyIOQtE4L
         g4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/fU2XOZlNfHgVmFdbXsPhfVHyMpsWO0SNIj8so6yhYQ=;
        b=DePJ1pVCgH4Sq33UV1qnfmbz11w1+rpVs0XPPX3YDZx6YiXM7RQsAorv+rsqkqFzs0
         5nQxTE83qM24jhXVWttsXMs2CbYnMTX1yFeIGyQ1ukh5qBNGaMXvye4qv94crGNcyUg6
         GRoMYQVxikzTUmGWhha7szJdLmsY1pchyM24TyN9C35zEwUBncTFoyYSVJxMphV9TboD
         o+RxtvQntTQHmXVHsa0qiExUz1Risa1IG6l1Yj4zoMvSD9+38TLRacGnmYZUFGrxDx/f
         zjtNRQLfDnJQQaiKW4VJwP9eyWa6pknB8BF/IvcwG6m/GX6FhJffTxdgK7sUeh6fApfL
         omEQ==
X-Gm-Message-State: APjAAAVUItwEv8XQzatiNUZDgrFOXFvsZqcoMmCur0IVY7k7QLzo++pi
        JYUNch1HgAc14kxVxCv4J6JjEXuF
X-Google-Smtp-Source: APXvYqw0H9iGy+AND1qK7663RML7ro32Z6uvPomZpBUodig3Y9Ky3GiWUV0sxWja4ggjkjZRfgDiuA==
X-Received: by 2002:a62:4815:: with SMTP id v21mr39907163pfa.224.1555090583020;
        Fri, 12 Apr 2019 10:36:23 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 6sm28337047pfp.143.2019.04.12.10.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 10:36:22 -0700 (PDT)
Date:   Fri, 12 Apr 2019 10:36:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     kamil@wypas.org, b.zolnierkie@samsung.com, jdelvare@suse.com,
        stefan.wahren@i2se.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] hwmon: pwm-fan: Report probe errors consistently
Message-ID: <20190412173621.GA1477@roeck-us.net>
References: <69fabb7ca6c9d4a8f9c18bcf298d2ce9502a9547.1555069101.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69fabb7ca6c9d4a8f9c18bcf298d2ce9502a9547.1555069101.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 03:05:23PM +0100, Robin Murphy wrote:
> Printing the error code for a failure provides a head-start for
> debugging, since it's often sufficient to pinpoint the origin of the
> failure. We already do this for some probe-failure messages, so let's
> make the rest of them consistent.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Applied to hwmon-next.

Thanks,
Guenter

Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0629C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB61213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJbFqT4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfCMUff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:35:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43900 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfCMUff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:35:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id l11so2321188pgq.10;
        Wed, 13 Mar 2019 13:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HKWvsnJYRZ0UW/cKwWgGJHcLgD0hHHceOYKg/We8Qlw=;
        b=uJbFqT4OpGR2Tuj68ChTzzoB7fY9p5w+wkMiBBM+4TQqXN/xiBeXYhMWmni13YnRY9
         RVSff5iH/5BspUxHhIFWx1eSFzTsQlf2d9tCsLz1xy4PFtDJdY/0Y91W+rDRb7RbkKsZ
         3vLtDblDVgj8KVszo/jMRch5OK8ec5uqyiOjahZlj8uAw6oBTBjOEnvYRbCttjW4H5CJ
         pdIFBzw/MIH4+xi8XDpUfhahXN8nNH2/yc99255EfuFBqpFsKED35cS0F7mf7U8KJ2GY
         ugfpL6Xgp99n1Uioj7NWPnQUbeGaLZVLZxkA2N+brwo4pd+ZNwuks1xB7MMLrdtb0Y6Y
         vDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HKWvsnJYRZ0UW/cKwWgGJHcLgD0hHHceOYKg/We8Qlw=;
        b=iDJQFbBXlwZ6kEEw4/oLwOEhiv4WB4stJlSia+d2L/0optH7E6d0EubvQDtdW9nLBJ
         jR7PoFcNPpKCP4L1JqoXWK4G8elzadg8rWzuYZy0ugkXEwECE9nzz2XlNGToKHPKr+mQ
         KKF+ygTOjY4yiQa8U/E7MpLgvlWezDHtidY2tMtZ9NAukVyvnLiEKK5G1vYZ9IyGEnZy
         xFfKTuM+tmY+ttlD30kdNeavku4iACKAgPczSfPlfRq0A0u5gmgb2LrylnSs9XvW57Ui
         R69lNBEhnBob5YhVqC/wPCpiCMuaRUdgWPE7PZTRO5qLBnoc9PGc7lrQf2HqQ6gVsjTS
         EZ1w==
X-Gm-Message-State: APjAAAWt3TyNPustlvYH0ePznp+vIzDa7W5vwXKhrBlDeEcyjUQVhjoh
        4N0RDWv1z6yqzyaF7jwoCG4=
X-Google-Smtp-Source: APXvYqz5Tc5hgZcAGDc2R0ZPAK6ZyQRK4zg6YNcRQTT3EjAopaq2BDwzroJVoZpbgm5z5NildRL0vw==
X-Received: by 2002:a17:902:2f:: with SMTP id 44mr42399077pla.139.1552509334388;
        Wed, 13 Mar 2019 13:35:34 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m64sm29736653pfi.149.2019.03.13.13.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 13:35:33 -0700 (PDT)
Date:   Wed, 13 Mar 2019 13:35:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/149] 4.19.29-stable review
Message-ID: <20190313203532.GC26634@roeck-us.net>
References: <20190312170349.421581206@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:06:58AM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.29 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 14 17:02:30 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 345 pass: 345 fail: 0

Guenter

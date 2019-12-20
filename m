Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20586C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEED3206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnfRqcND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfLTSsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:48:42 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38446 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfLTSsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:48:41 -0500
Received: by mail-pj1-f67.google.com with SMTP id l35so4517593pje.3;
        Fri, 20 Dec 2019 10:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z4q2YkCocWViwl0Q0lX5F9stqCQzi2FqPg37qqEoFkg=;
        b=WnfRqcNDMmneDUYeph3fqTFul6hDjm2/GdzJ/i1hsg6hME8Tikfk2E7xnS4Y59loTw
         74iwSJEQAmBrVRvPtgbiWAZsahwAEXah33qkI/EdBrubkT4jZXPVm0t6OKljsXxLAJdt
         7vzkJkMrs40TEUrN1hdr6NIOFyJJTIGMqR0kIQrJODvaXgyKgcJOQ/9LXG7BsAZU9N4n
         yBkwlFlK2h2O1SY+f+WRNa94//kdhw+XihKnYych75LoU2bL5BHqQQMb1QdKohgX+ubT
         CXhxCgrHl3lKYbssKslQm9N8ov/mE3Om6bGvrPPexlOsLTPCltSV3zsqU7imPb4IWMNL
         MCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z4q2YkCocWViwl0Q0lX5F9stqCQzi2FqPg37qqEoFkg=;
        b=lwDiuJI5bYju58FPZXYMdg7PONfn6VW2iyZdwX13xT43zzsjsbOdNWsG8W4k6LQy1Y
         OFWjJXgOozUoJ1xbwXyrkTiPPvpKmsz9rkSf23UjuAmiiYeb8GNB6X0wibPBdSQHeKOc
         cXn4RXGiFtNqLJ7WFpO4gs+kNEVvOiUIEnxmgfzz1etQbzB92iZjGaUEU2qNNHg0R+y3
         zw4qz+fQVnt2J+7Uuzd65CDN6jYKq/VT6QqfiQkNhHPqiNdTI6bXDemJaLeGK5js266+
         cTCnkHGI/Ci1swb4sjs3hTSVx11R+5z+gqLgHa3KVglzpqwPGJ3aN09fZ+lN5U3B9hCy
         65XQ==
X-Gm-Message-State: APjAAAUFpSqwr0lp/IU81hZ9rBMGBbh1L6EZCjtPD75vRG8yp8hE5EJH
        vYoUkxLj5cRHdSDheWlWxVY=
X-Google-Smtp-Source: APXvYqzQnkJud3R5ZTHRybIpAHJ4pGYkHJCYBRAQQcQwO8PwM3+Cc/uCphVfwu3iYqiphj6RwCfPUQ==
X-Received: by 2002:a17:90a:d807:: with SMTP id a7mr18303818pjv.15.1576867720726;
        Fri, 20 Dec 2019 10:48:40 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s18sm14050414pfs.20.2019.12.20.10.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Dec 2019 10:48:40 -0800 (PST)
Date:   Fri, 20 Dec 2019 10:48:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/36] 4.14.160-stable review
Message-ID: <20191220184839.GC26293@roeck-us.net>
References: <20191219182848.708141124@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219182848.708141124@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 07:34:17PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.160 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 21 Dec 2019 18:24:44 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 375 pass: 375 fail: 0

Guenter

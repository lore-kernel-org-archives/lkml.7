Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707ECC742A2
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 05:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488132064A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 05:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKhIKO3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfGNFg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 01:36:27 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34340 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfGNFg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 01:36:27 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so28937421iot.1;
        Sat, 13 Jul 2019 22:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H3NCUuthwZlGfvPIO5V9FL2U1MvpvK5vVlqEP37yZbo=;
        b=FKhIKO3O4vCU7mgJbbWE2HA5dXn+tzlzMb3C4G7jJa8nCgXg5wAMzhe2QfSBdZLaqZ
         iJR50zzXmQeAD6DctZzOqAXi9uSmXOmJHV5/+PD0b+fc2k+aYUlfpwotyCX0lxSc1Sdn
         d4A0oaLOKcf8xS+ufEFExDZyAXkJlCrZ5zCyWQ+PiY/GXJWzqR+94D30jUY9lA0P5GzB
         Y6isfTLaybHoej9s921qm6FCvlCMjhc0X5MKxPe3lCsHqhahbLe93DQ//GMoATlSiMJq
         /PytiMeFtqp8jZhJxSqNNbYW3VTopUuQBQC00zulEz0QuZBsuvIvr+5EoMgwlMHIHOyT
         +KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H3NCUuthwZlGfvPIO5V9FL2U1MvpvK5vVlqEP37yZbo=;
        b=dSn3kMMv7g+nDWls5bBeLExq21O/gQxuF0AXCuTWDs+irPpzWkiqHrr/KmF/s/TjdK
         prPXy3n4GmcFoNEjahapxBYzVu8inm5qUU4ZT/CQdwWVHS/4f/hZ05tTsoHxe9dQF2go
         zsU0JD0nBYvk13uVQwh6Rouvuq/R4M3gD1MqVTS2rsrWJPrkJbgsxccy4MGYJHxNuJi9
         4bKK0tEq07L6RSBXIfiqq/imiA6D/W9MyrRYevbiTJMclmo7XPLHMLSsMxeXgGO1BY3b
         gT3IFEf3CQp7TFWPaaG0wSfFmWaoZsRKneyCPMBQVb9JZBgsRHS7SNfdQCud6J2qHpjZ
         jOAw==
X-Gm-Message-State: APjAAAUsmD8w97nosLeVEN4piHkgwfHlzoj9T8m+eKu6pbENT8A7H9OD
        sd8o2i8nErAEv/lRhN28eIdNexrLcG4Qcw==
X-Google-Smtp-Source: APXvYqysUMRVf3mJ3xgg4bQ0FrFyJYN9OqlVmvHqil4S6boRo8us1GRwKb7GLxqcUhYBAwvCifhoPw==
X-Received: by 2002:a5e:9304:: with SMTP id k4mr19385821iom.206.1563082586270;
        Sat, 13 Jul 2019 22:36:26 -0700 (PDT)
Received: from JATN (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id b3sm10803885iot.23.2019.07.13.22.36.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 13 Jul 2019 22:36:25 -0700 (PDT)
Date:   Sat, 13 Jul 2019 23:36:24 -0600
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.1 000/138] 5.1.18-stable review
Message-ID: <20190714053624.GD2385@JATN>
References: <20190712121628.731888964@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 02:17:44PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.1.18 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun 14 Jul 2019 12:14:36 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1.18-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 


Compiled and booted with no regressions on my system.

Cheers,
Kelsey


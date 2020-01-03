Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8E5C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 13:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DF2222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 13:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="hgeeX6Dp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgACN3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 08:29:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36855 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgACN3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 08:29:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id x184so23578643pfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 05:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9PDoDHTv+akQfxBnieWWtMmxOAv8OLNpwPLZ2uZv8S8=;
        b=hgeeX6Dp4+3iH//Ux/hUj/VZVth6IxQ6WgawPMCE2hJGon1hfy+luMyIROkqDbMJVA
         bVCB6Jhsj/EpEuTaIMDVN3DyQiz7vDttLW8xxkIgDHACeWUtO8zRML3DBsJnB4Wn2HZQ
         3HJlRyFjYNCNIAKJAxwvOlTKuJ0L8u8jzfomOwiMGVFOdxueTS8E5JYSIXO0dnbfbWHC
         enhI4D4Cm0pv3NlLv1u5hiNQ7KKjXyuRnTdvW+UiFs9svIcqE02H90aYvVnv1/jA5VL0
         Vr4OSAfaeezX+rW/rAMqdA/C1pLgJRaOOvHnJnF6TyaTP67yheT4ce9pdl4AiuL3Q1f5
         SXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9PDoDHTv+akQfxBnieWWtMmxOAv8OLNpwPLZ2uZv8S8=;
        b=bIgtbPZQ84zm2z+RtjQZFzwKKjS9ThJaS0bCRgcRWjRHY4Q/j8aip2QKGm9q+UDCmj
         1UGfgvy/sGHx9M1WYpqw2p0PIu5XSUq6MusNdwj4Pb5FMHS7BiGmG20FXcsymOxUZWEk
         eiGGvi0AMUGj9UKIBlg8Zgzb5hZhg0jk36a1EIS68Y3TRqMckwkURt2RN+PUsdLFO31s
         1DwLCUWjk6ptYRQljNp50CHbnq1MiU5a7lykSO7CjD8lTP2+VwVhey9t72RAhOWEHgig
         6gz+UqvOa62cWp4Oc+EKMIEhJll28R5lulJ0brO55YMGCJCoQ8vazI1g5bCgbNBM1bg0
         K6yw==
X-Gm-Message-State: APjAAAWMG6AaY4Gs1+UXRTmMSB7x17eRYp0Y0aRhO3Iuk0IlZrTmkOAj
        JyE4jt1bKroangHnxC3tHZYE0w==
X-Google-Smtp-Source: APXvYqzloO6lU1/X64uJ/4dfnoD/ocWE+7Rv18qaZfW6WHZn15AboeSrG1wkxTVNoHW7zJnY0XhW8A==
X-Received: by 2002:a65:55cd:: with SMTP id k13mr92550692pgs.197.1578058158331;
        Fri, 03 Jan 2020 05:29:18 -0800 (PST)
Received: from debian ([122.178.22.49])
        by smtp.gmail.com with ESMTPSA id w131sm69647124pfc.16.2020.01.03.05.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 05:29:17 -0800 (PST)
Date:   Fri, 3 Jan 2020 18:59:10 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PATCH 5.4 000/191] 5.4.8-stable review
Message-ID: <20200103132910.GA6212@debian>
References: <20200102215829.911231638@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 11:04:42PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.8 release.
> There are 191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 04 Jan 2020 21:55:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 

hello ,

compiled and booted 5.4.8-rc1+ on my laptop. No Regressions according to "sudo dmesg -l err".

--
software engineer
rajagiri school of engineering and technology

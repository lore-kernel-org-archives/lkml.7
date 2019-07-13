Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC30C73C66
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 20:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7701B2063F
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 20:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eng.ucsd.edu header.i=@eng.ucsd.edu header.b="QNH1Svge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfGMUjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 16:39:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38936 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfGMUjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 16:39:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id v18so12484331ljh.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 13:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2hudEQHjzIIDaJX8IJzCoFevInejCk4mA2bRnNn7T+k=;
        b=QNH1SvgeDg0zOoNZErxPYHilcak6XtpCI9Wi+buNDLZzSAz2g4u/+52gWwsoJHk4Tk
         ioNhHHx7WbasGljUsDxPcN+4Cn22i75NuVF+EFAyLNiVJa2T+lbWALvIO3ecrwFGw6Fk
         EcY0LfbNX8wYOW37/VAOuW1FG0lv6GQBfVTkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2hudEQHjzIIDaJX8IJzCoFevInejCk4mA2bRnNn7T+k=;
        b=dsSU3lAOu84OML9k7qDdhhp2FK7g1w6rZ3eYt2mn/NMv+C8CU/cqrHkgR5cXfZoU0H
         4wYUQQlsjIrIXnkn0j9ecywZF8voSFkvuByQwXP9o4rQ+gxyxzFIdb4eTRHFDHN1JK4Y
         VpSxWka4uPfQU/iR/qxEMUkALJLPLNwcyP0B1ORh6IfOUP28p//qy74YewNbaey8IJo6
         yu2dU664kq8Ilp+6eOQkTFx5Wj5Pp7O1kBpY0/uwH+vy+c+3GlDAnVudAWM54tjdsBcS
         6WuJaWi/4z1a9Hi20WvfaFb7O+80vQkuS4a8LQ1+69G8z9Lw+f1xyvwcr7GP6QjokzLG
         /92A==
X-Gm-Message-State: APjAAAVIsULRbDtxB46fnt9GL4x3hrCNbPNOv4/vBsDOqF0OWVL+hnmf
        S7qTg18NT9CHMxa/TDpime5ktQ==
X-Google-Smtp-Source: APXvYqwyGbIK3PhfUJQ5rl2x2n1obAKiJkF5X364rlmrIWZbaJjQXawlTHxJtnHSLeokJWLKhYsC6A==
X-Received: by 2002:a2e:301a:: with SMTP id w26mr9321620ljw.76.1563050348306;
        Sat, 13 Jul 2019 13:39:08 -0700 (PDT)
Received: from luke-XPS-13 ([213.146.33.133])
        by smtp.gmail.com with ESMTPSA id d16sm2149165ljc.96.2019.07.13.13.39.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 13 Jul 2019 13:39:07 -0700 (PDT)
Date:   Sat, 13 Jul 2019 13:39:01 -0700
From:   Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/91] 4.19.59-stable review
Message-ID: <20190713203901.GB14762@luke-XPS-13>
References: <20190712121621.422224300@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712121621.422224300@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 02:18:03PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.59 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun 14 Jul 2019 12:14:36 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.59-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my x86_64 system. No dmesg regressions. 

Thanks,

Luke

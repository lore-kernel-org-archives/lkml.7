Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055F9C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 23:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BE120863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 23:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcSOX8Mu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfFRX1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:27:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39742 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRX1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 19:27:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id r21so14407421otq.6;
        Tue, 18 Jun 2019 16:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q4kPRWYHYHjdTHQi+BuH9rZBEiPrjwElzrl/VSKZd5g=;
        b=JcSOX8Mu7ozpTDACthKmo/MuHf8h+d3xAEf5HhYucienONi5b2kT4TQM/AcGGP1Y4g
         tl+MGizAOHSsOI/i7JcnlgOempZmIZ2+SZRz+HkzxyypK13PH7tNjayIK9UUfieNAOz5
         5GaJ014pWE22gQbd+lEJr2m+Ip408UUGuVQeX+FXevXQiqDrX1i3wi+nm1W3Xdqo5Y0s
         7wg45jM2WaT3ZugHCtihThem50VXgG9ycBwD6+hwLKAMX2+4ZEvL2BGf8WiaWUY+UUUd
         fZGZeq2CbxWz4ISBj2eNcGgwy13Po6lLyP+ZKVjsdEXn+ChllacNhIHDTJc1tZsk+spL
         31sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q4kPRWYHYHjdTHQi+BuH9rZBEiPrjwElzrl/VSKZd5g=;
        b=Pyx+ApFAipDT1sZ3n5x5V8LWCEJG4YqJnE9C+5PEqeS64txDjkYctRQuojK9Veq7zB
         Os+t3n/fzOc3FLeowYpYCIOkpquNoACVfKTUoTKspqkzt3j8BTA16k9zjjXWRdnNCVck
         GiEErksOqM5UaHKMAaHO7cmd4KHSZYi/sYR0RcvjbdnPcxsY3ufgLEHx6IBiQxngfySK
         tAE58ZVxiRpo/wR0T4qH8RFc9mdVXw/yEQ7+41SIY/qm8GMZLoZiCr1wl3Re301N8knQ
         JX1uiAM1KJicY5/GQ1GvtkI8rjIcKGAGKFeYU2I+FdBuG+mN5i8a80Z0sgjsDJwhKpdj
         X+Yw==
X-Gm-Message-State: APjAAAX+oVv5AmJ+6518wn+h6hD2tFw48N+2gHMEbt4w9wGsyrIkomvO
        89Ndgm38r1WodX8lMLXDFLYJh8p3
X-Google-Smtp-Source: APXvYqxs37AWfZmn7zIye9xgRom2dzsvir883Gz+cJz1yCzg7qB1etyrACrRBsNOBmG5mbUQn/fhvQ==
X-Received: by 2002:a9d:eab:: with SMTP id 40mr28068647otj.316.1560900424067;
        Tue, 18 Jun 2019 16:27:04 -0700 (PDT)
Received: from rYz3n ([2600:1700:210:3790::48])
        by smtp.gmail.com with ESMTPSA id y7sm6106378oix.47.2019.06.18.16.27.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 16:27:03 -0700 (PDT)
Date:   Tue, 18 Jun 2019 18:27:02 -0500
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.1 000/115] 5.1.12-stable review
Message-ID: <20190618232701.uqjdck5fzaggk3r5@rYz3n>
References: <20190617210759.929316339@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:08:20PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.1.12 release.
> There are 115 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 19 Jun 2019 09:06:21 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------

Compiled and booted.  No regressions x86_64.

THX

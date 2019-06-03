Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D475C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA70827616
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYu4mZ8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfFCRRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:17:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43027 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfFCRRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:17:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id cl9so2123528plb.10;
        Mon, 03 Jun 2019 10:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CZCmX5Gw7Jm3ORw8Ds38wtPtfFdSNPInYbIw2TLqNuY=;
        b=sYu4mZ8w0W9qNdzwG/5trW9qE75HXSHxzBwcePCbY3wylwYZaqQBu1GCp6GScfzmPd
         1Usy9pdFw9h4Wmq4OXCB9AB6oJ/FSURiHzN6tMGaFiO5BfXek+sCG+4eac1MAlORr3Yc
         4nrxPfsJRBdT3o54K1qnix+w7fDZ5u+PlhAKjiExUiVqJM6jZdadiCwFR8suYsEvBOS4
         +EwVGc2D3ptX+YEwl9/eYYigLsn7CR4QcoO1RVxmllx9owTprvYXSCW4RRhpBetPHbfG
         jF0Wh48mvZPZXAhyFjUlq0tBesMTTMprdGe7wYvsSEfJUcweKJCG0orgInAhC8nns4vs
         PifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CZCmX5Gw7Jm3ORw8Ds38wtPtfFdSNPInYbIw2TLqNuY=;
        b=i7qQ6Mfe7o+Ohs0UelFiI+5psSyWDBFfDkt41jpgmWN5FzzVU2UJNO4B+fXIyidQ26
         jjltW9fqf7VAMiVX+X7cYJMdRMpOwrUG/IzMswk01tSyowmh025EEM5w1qLv7PscamUw
         lpp7uopek4ipUo/0t70GYk6FcSwVclZu5Xw/954pWDRHGOkW14HVTxFxI9CyoNiwM84x
         FO1HbxETwo7Kl3Pe8on/MbHuikbw4kI2kbyOblzRDvCiu7vfll3I+fYKkJYUmCXWTbm6
         56CsYAUStzDsLVckBA6dlWBRUWVI1AD4QfMmzTvr8Fh2mmp5LB+/z1zKvJsapWAHsIQV
         AM1g==
X-Gm-Message-State: APjAAAXKiWWlIc+gD0wQxciAXR3C4h85WFdba4AR1xky8i1jeyv8W414
        5UlGCXUhIiTJ8c6/oLt3HkcoidY+
X-Google-Smtp-Source: APXvYqxCqN6g8YS80TrheU7SeOLluDtvL+cdynEjv5XA6QspUes+LdhQyStyeDdcduRfT15u4gyx5A==
X-Received: by 2002:a17:902:ac81:: with SMTP id h1mr25696220plr.129.1559582223898;
        Mon, 03 Jun 2019 10:17:03 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k8sm15880303pfi.168.2019.06.03.10.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 10:17:03 -0700 (PDT)
Date:   Mon, 3 Jun 2019 10:17:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 00/36] 5.0.21-stable review
Message-ID: <20190603171702.GB4704@roeck-us.net>
References: <20190603090520.998342694@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603090520.998342694@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 11:08:48AM +0200, Greg Kroah-Hartman wrote:
> Note, this is going to be the LAST 5.0.y kernel release.  After this one, it is
> end-of-life, please move to 5.1.y at this point in time.  If there is anything
> wrong with the 5.1.y tree, preventing you from moving to 5.1.y, please let me
> know.
> 
> This is the start of the stable review cycle for the 5.0.21 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 349 pass: 349 fail: 0

Guenter

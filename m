Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB76C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 20:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72792173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 20:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqf4OFvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391349AbfGRU4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 16:56:46 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36175 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbfGRU4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 16:56:46 -0400
Received: by mail-io1-f66.google.com with SMTP id o9so53958741iom.3;
        Thu, 18 Jul 2019 13:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=19a3siz/ZPBEvWIpsLPmT3Kw4HNPiyfK84q7Gx21QJA=;
        b=qqf4OFvOxJ3+xjjyXV4FDZXkpiHeWtyr3D9j2mLcdW0O2U+NHwTP2evPROTB/xlhHa
         deEKoOLeWx9TWJglN5QSCONr9Oz/EUhEyJO6eP+GjaBA3k6ZzGan5Ftcxl70WP+buDUE
         CCuCpA3P2D0HW8PO4KcLyjShFvTR9cvzsmv38t15sI1vxQYGdQQKbE4npKxySdI0LhvK
         4coL9T0vqZpCx9URPFaRGyJtJ3E84Mr2vtz0HY9CNAnjl0Fp0Ha6MVUiDS7BB48JnYkZ
         r7vKihUaorNuK589OMqRL6fMf7D6T4ECP2YTchJV7++qKE+2ypKlL9YhwaGC7hH1Atwr
         I+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=19a3siz/ZPBEvWIpsLPmT3Kw4HNPiyfK84q7Gx21QJA=;
        b=Jpb/Uot4k5+6ODgjKZit6xVylHSbtftQ8cHeltGfDa8QB/FXBPvgIRttWIR1gYu7h7
         XC2PaevlOhLT7EFRRCij9inumh32zS+/CM+XDJ/iRPNGMiPur17mgdqe19DMrmp9fF/e
         0z5xXQ9bT/U0dSTOqPUduTbpw1YVq0P/xsCf3V+M4ieRV0oCm1WeMOJCA0ervV7B9hZw
         KZmVLghLhwx1zfI+gHOAdVhBcgC9efQzmT/WfeEXaC/k3KZ9ZRl9gTSbNpqoJBto3qOg
         k/zVNyp1pvRAmL3r0OcPtkKIOZnhJJCYSma5yYel7ISE2FddbYOOmZ5hnr232R1D5jKD
         SWyg==
X-Gm-Message-State: APjAAAUl0GnZKRbmDtJz01mKNjsLOvxIhum7QUW4xcLMk49E6w13aMFd
        LRiJTaeEqw2/pzYkXFMSFjosn6X+Zy7BeA==
X-Google-Smtp-Source: APXvYqy0DGPE8ChqEcxUrAAZp5wXxzvDWsGaeNTiJCqjNymvCyjWrlOzP7O7PuxDgBYwlGgOCyjfqA==
X-Received: by 2002:a6b:6001:: with SMTP id r1mr41798952iog.229.1563483405711;
        Thu, 18 Jul 2019 13:56:45 -0700 (PDT)
Received: from JATN (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id z19sm33807819ioh.12.2019.07.18.13.56.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 13:56:45 -0700 (PDT)
Date:   Thu, 18 Jul 2019 14:56:43 -0600
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/40] 4.4.186-stable review
Message-ID: <20190718205643.GC6020@JATN>
References: <20190718030039.676518610@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718030039.676518610@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 12:01:56PM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.186 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 20 Jul 2019 02:59:27 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.186-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted with no regressions on my system.

-Kelsey
 

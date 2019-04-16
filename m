Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AACCC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C1920821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ow3fDGej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfDPQ3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:29:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43579 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDPQ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:29:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so10582351pgu.10;
        Tue, 16 Apr 2019 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hgFYklw2TGDFvnverHPzjBdOQf6BRZOEe/8qklBeLi0=;
        b=ow3fDGejLOfPvU8gaKx5guiGJySuwufFTWdUJIGT+aT2qKI+DyqrwhMzR7EudcA5E/
         UcaFzJjPWhQZtR9ENKPaCEIdxiWjfZ2F1JL3fs1XZd/TLWnBrBqzR93X3kNNi8ebJbjo
         A2enh6BJurcrOcX35fQZbiA5PchhphDKLFaVs3xUpDNJGCHZc9VpehU45o0V3iMnucDB
         wl2UdRtQ9iop0QXGgAJdfmayBHFTJVltz5nHPCnXTBcbskY4egdyASXYDI0UCnjbsUot
         nKj2phNr31EZJqWxC8C614foBuSBWmJmXwS6M1D1rKQFtTd3mq1uazUO3J7A4RjJtGqM
         rDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hgFYklw2TGDFvnverHPzjBdOQf6BRZOEe/8qklBeLi0=;
        b=amGEQJm8QoGU6TuFkzITNXyDc2rC8pkVJdeIJ2CY04Iu5zpWUX2k7KCTeH2rrlvAVD
         hss2UAfWddRlx0qIM1q9ACIAWcmkUarS8hwdVPmahO8GcIyEy1lirohHO/d52+8skyaa
         sVDDlzlEBt8f+FIpObazFaxxAsO42SB58YujvuH+9FnRFYdOK1qe0XDsfYUfFqpMVAfE
         V+MlB0Q/p62zPFejXc1i2EKZndMondNTxg3rf/MtufD4tMBWCe55I1Hfwa+jxWbixeVV
         +HGNt7UQ+NkqSfTCGSlfjZ66PCRWjv8vFwzBNDCnwt+vkwBn8juRcLCpTHIYg1qYxlcF
         Lvqw==
X-Gm-Message-State: APjAAAWfIezsFCB0DRlZooJKRs3kz4LuCKwEeMpX6hFEtU3ZaGB7N7go
        /yE9t+r3YMw37Tm/ni7vgmw=
X-Google-Smtp-Source: APXvYqyfmzwPqOV7+fqZgCjo3U1+1tNoMCk09uCGi4vdY7Ag5K5B7M871H7rihvIKxrZORrVKC3hRA==
X-Received: by 2002:a63:cf:: with SMTP id 198mr25195632pga.228.1555432178093;
        Tue, 16 Apr 2019 09:29:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x128sm77609870pfx.103.2019.04.16.09.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 09:29:37 -0700 (PDT)
Date:   Tue, 16 Apr 2019 09:29:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/76] 4.9.169-stable review
Message-ID: <20190416162935.GA22656@roeck-us.net>
References: <20190415183707.712011689@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 08:43:24PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.169 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Apr 17 18:36:37 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 165 fail: 7
Failed builds: 
	<all parisc>
Qemu test results:
	total: 320 pass: 304 fail: 16
Failed tests: 
	<all parisc>

Build failures as already reported.

Thanks,
Guenter

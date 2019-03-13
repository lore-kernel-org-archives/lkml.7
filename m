Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E18C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52673213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVd8p2Y0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfCMUep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:34:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40486 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCMUeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:34:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id u9so2331790pgo.7;
        Wed, 13 Mar 2019 13:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H+oeoI15yRVnBZDYCM+QCa84QyRWEU+ZniMBcWSY5YU=;
        b=SVd8p2Y0McMNOEUZDXaUgpIta8z/hmYgPRJUCPyxeimhJddgYCs8IB30MKeUoLzjcA
         TDNosC4ybRrstjo20SDIV54lBvwHDlpv3lrFz5D4r+b8MmkjEViUV3pgDbPJ/oiTqvRo
         rfqAcBrGzTHSFH+JyD1fZeIZP8sjeeYloxvksg3AQc78XKbGmF98zowehFsZmxfmewMk
         RzT9GPMkF7oNhGCbuXMiFhOF2BtdOntjLfv1Mc9cnB1EHWlJH+99OaN5AGiT/ftiW8HA
         fnPztaTAFIEfSa8JbqBgV0mP4BOZM2cJ5ibopzvCMCHsTxmpjYfQixcFSwJssTOpCDew
         hFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=H+oeoI15yRVnBZDYCM+QCa84QyRWEU+ZniMBcWSY5YU=;
        b=AGBUVqUabHz6Tznfi3HTSMcS/q3dHdh/AKeSzT+pvxgVycy/vul4Hg7/vjbrwMR5se
         fWKyBiNCDwziKVUyRCZNBwpIfoqui/VfM+opeovle+gisu6yUU5Xswnzdj5fMFhc0M6E
         8fNQ52pfnZNppV/tErEdIqxqbiBpXXmUnhHFTX9CjFq25ovATA7+Y9sgzqF0nayXNIm/
         7huNncj6jHJhmQpU5bBm3PKMfkBL0kmug4oK9vU1EyOdgJMFGIrfhtfySfuc/z6IoZ88
         D4Hzu7lvfL+LJXa9/nZQ9doN9Ux+hJkZJkc5yp93ugpzX9FiGFzXbRU8gVSJgyEzhEz9
         9DGg==
X-Gm-Message-State: APjAAAU1cRiPZNiAfnEZNhLUxFhjvHHm0Kk3NjqH3LrOuJjxKZGM/mki
        ovIsu8Kxhwp7VFwu1jQ6804=
X-Google-Smtp-Source: APXvYqwCSMXyDaBcmDLrhDlYg6v2GC6Euu7e2eX0yxrBpaanZoHeBl3TN8EOWLV/8NTk6qSd+l7KTQ==
X-Received: by 2002:aa7:928d:: with SMTP id j13mr46334366pfa.112.1552509284069;
        Wed, 13 Mar 2019 13:34:44 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k189sm11248502pgk.21.2019.03.13.13.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 13:34:42 -0700 (PDT)
Date:   Wed, 13 Mar 2019 13:34:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/96] 4.9.163-stable review
Message-ID: <20190313203441.GA26634@roeck-us.net>
References: <20190312171034.530434962@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:09:18AM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.163 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 14 17:10:06 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 170 fail: 2
Failed builds: 
	i386:tools/perf 
	x86_64:tools/perf 
Qemu test results:
	total: 316 pass: 316 fail: 0

Culprit is commit 386ca5754fad ("perf trace: Support multiple "vfs_getname"
probes"), which introduces a call to strstarts() but not the necessary
include file or declaration. Unfortunately, fixing that is quite complex
(commit 8e99b6d4533c ("tools include: Adopt strstarts() from the kernel")
doesn't apply).

Guenter

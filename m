Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F2CC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A96A20657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNHt2qlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfCMOoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:44:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46152 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfCMOoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:44:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id s23so1514272pfe.13;
        Wed, 13 Mar 2019 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pb8Ukn3x4UHgNJuV1iguvhCXesetEK3gfTBsu6j8XGw=;
        b=hNHt2qlhPKXC2GNNa70WGBukHQa9et7m+7il/u176tOJTc/FHJEGYhmk5B63Bfbpd5
         zbhyzVobt+K6k9zRPFNwQLL2JOMbU9fV5YPurIvtV9e6TrJUj6WPm5ubsof2I7+q7uqC
         XPrGU7scDCCVh4T6qsGMSGGF86ZSvJ5kua0RVO1IKTfz6LXPqrUIMVLfR2R7xD/+vndr
         BaP8YSiRF1GjPtKeuSlOTRvVccRSb5vNr/8sMPwKiao4P7yCexmXd8Y65wuYYmy/+uDg
         ja0l87QNrEiiv91KowU3q0macP7DSqLN+uqcOmogEAzirwjT5pE6cDIRzT2rQP3f7jYz
         fj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=pb8Ukn3x4UHgNJuV1iguvhCXesetEK3gfTBsu6j8XGw=;
        b=BdiMh8bdrwsmhKCCGwRXvnRzlICqO8LCKOXLfpNC+zFLEe1FEOP0Ykk4ltlobRcUC9
         HkHu9wzUJvDcrO+q0YletGNNcYl0KYaLufnTiPnkAeR/QHxeBibfpNcovfL8U6P/yOYq
         IS/czyyuwKGERtZkE4lkjWks64LD0E4WuOKGDH6gOaH2OrIt79tqvzKNXaYp3fCcsGuH
         2tWUyQAXkmQhjw0Sb/I/qGGDWxlZJI/HESB8qHfHGLsph+fltLKdM5OjX3M3kKFZ0boV
         Gu8/t7Yc7niVzkP+66YG6zXYujnDxRA/7taLTNgoxAhL7rB8CvXGdUYAMhAG8cPatuTe
         UXkw==
X-Gm-Message-State: APjAAAWE4kAaYTIjfr/DtJDs+CXhP3Tt3QHweESy582M0iK00hOInOFm
        K+Q/nCGkx2f2kUVKYM/7BRU=
X-Google-Smtp-Source: APXvYqzDs5yjW9R6FhGTpeFs/kieFGX5WrU61e2kyUpPOA9hoL3KTLzxcAsyeu6zvff8EZ47w9t0Hw==
X-Received: by 2002:a63:234c:: with SMTP id u12mr41264116pgm.282.1552488277730;
        Wed, 13 Mar 2019 07:44:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 17sm17369639pfj.80.2019.03.13.07.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 07:44:36 -0700 (PDT)
Date:   Wed, 13 Mar 2019 07:44:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/96] 4.9.163-stable review
Message-ID: <20190313144434.GA11117@roeck-us.net>
References: <20190312171034.530434962@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Early results:

Building x86_64:tools/perf ... failed
--------------
Error log:
Warning: arch/x86/include/asm/cpufeatures.h differs from kernel
Warning: arch/x86/include/uapi/asm/kvm.h differs from kernel
  PERF_VERSION = 4.9.162.g605129
builtin-trace.c: In function ‘perf_evlist__add_vfs_getname’:
builtin-trace.c:2071:8: error: implicit declaration of function ‘strstarts’ [-Werror=implicit-function-declaration]
builtin-trace.c:2071:3: error: nested extern declaration of ‘strstarts’ [-Werror=nested-externs]

Also affects v4.4.y-queue.

Guenter

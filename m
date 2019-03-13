Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202A9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70502087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsjSBzTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfCMQdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:33:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37179 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfCMQdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:33:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so1903895pgq.4;
        Wed, 13 Mar 2019 09:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NEVD3LxZ0XY5VCtKl3rjIcWwwq4X3avTTOHtLNiLHt4=;
        b=bsjSBzTRBfa8Ow2ZP65tKLx+0GP/UK7PZw8yBpXvqTD9AZL98EFkn142tAFFv6hPnp
         ZhXuCgcknhDYFkH/3OZGI2TcMoYrwtNTn4VoXN2eOwiCaaafMkpkxQlFaKWPFZ12p2Qa
         SK7J7DvCAZy6nzKxUc+OC7GABE3dFupUESZB5FgN+CNFh1vhMfTgnAAP9sb7UFlHw2jw
         DdT24ns+JD5f7afM7DAbbPLxVZVvgIKOMTOK2EJi/9+K/bHcvgbwfSbQ5da9umelSocH
         f85W5uerrbSDWfopFukPO2l23O3NBFx1lLuIZYssmtt7veQ0UCAYPZpW9J/grOE3M9qc
         CQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=NEVD3LxZ0XY5VCtKl3rjIcWwwq4X3avTTOHtLNiLHt4=;
        b=rdO0PVjZW5TMfoM/fXh0jy5MsUvFBUAFMQb/kgpvPOUJemclJxno9LEAlKJr6XoCcT
         MbR9e8m/xSsf22LqH5ssx3AuiECUmBdD1+LLd3EkJHhuUqLDriENLSysUw9lh6tBMAAa
         oHFuC5qkcsqeN6FNdQS9dmdHLXzk2YnRT6cI9O/Lcx7kypK0KIswxzPA3heYg8wGXidd
         gjmxiClORiP4r6Jxn0Vdcx69ITo24AgCEMwqSqNgPTW5qulUOweoeiMyb3jftKnFG6qD
         JOZM2yPtWnCAJm56dEwPtFTe7nmwGgTPyhOKRCIhOb/q53pIIorcp6EdrZ9Tl9ugA4++
         4lUA==
X-Gm-Message-State: APjAAAVBeQI9CRbdbQPhKpwFMf5f0owA9GBNVAxKCjahaK41k9Rly/tS
        w2SUxwMIeLyIOL6mSTk0LrFVv/Uh
X-Google-Smtp-Source: APXvYqyfCFNuwza3N+hbSYoViS1AQ/MGZ8xccbipdYdcDj53Ajc3l6mW3M+bAZfF/WeBgM5YpBFbXQ==
X-Received: by 2002:aa7:85cc:: with SMTP id z12mr45072215pfn.196.1552494781228;
        Wed, 13 Mar 2019 09:33:01 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b15sm26957599pfj.167.2019.03.13.09.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 09:33:00 -0700 (PDT)
Date:   Wed, 13 Mar 2019 09:32:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/96] 4.9.163-stable review
Message-ID: <20190313163259.GC15451@roeck-us.net>
References: <20190312171034.530434962@linuxfoundation.org>
 <20190313144434.GA11117@roeck-us.net>
 <20190313151429.GB9719@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190313151429.GB9719@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 08:14:29AM -0700, Greg Kroah-Hartman wrote:
> On Wed, Mar 13, 2019 at 07:44:34AM -0700, Guenter Roeck wrote:
> > On Tue, Mar 12, 2019 at 10:09:18AM -0700, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.9.163 release.
> > > There are 96 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Thu Mar 14 17:10:06 UTC 2019.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Early results:
> > 
> > Building x86_64:tools/perf ... failed
> > --------------
> > Error log:
> > Warning: arch/x86/include/asm/cpufeatures.h differs from kernel
> > Warning: arch/x86/include/uapi/asm/kvm.h differs from kernel
> >   PERF_VERSION = 4.9.162.g605129
> > builtin-trace.c: In function ‘perf_evlist__add_vfs_getname’:
> > builtin-trace.c:2071:8: error: implicit declaration of function ‘strstarts’ [-Werror=implicit-function-declaration]
> > builtin-trace.c:2071:3: error: nested extern declaration of ‘strstarts’ [-Werror=nested-externs]
> > 
> > Also affects v4.4.y-queue.
> 
> Hm, at first I was worried about my backport, but if it hit 4.4 as well,
> that's not my fault :)
> 
Actually, it turns out the build failure in 4.4.y is different:

Building x86_64:tools/perf ... failed
--------------
Error log:
  PERF_VERSION = 4.4.176.gbd5033
  builtin-trace.c: In function ‘perf_evlist__add_vfs_getname’:
  builtin-trace.c:2414:2: error: implicit declaration of function ‘evlist__for_each_entry_safe’; did you mean ‘hlist_for_each_entry_safe’? 

builtin-trace.c:2414:2: error: nested extern declaration of
‘evlist__for_each_entry_safe’ [-Werror=nested-externs]
builtin-trace.c:2414:50: error: expected ‘;’ before ‘{’ token
  evlist__for_each_entry_safe(evlist, evsel, tmp) {

builtin-trace.c:2406:7: error: unused variable ‘found’ [-Werror=unused-variable]
  bool found = false;
       ^~~~~
builtin-trace.c:2430:1: error: control reaches end of non-void function

so you are not entirely off the hook ...

Guenter

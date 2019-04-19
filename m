Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59235C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225E32171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/uVwY6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfDSTlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:41:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40303 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbfDSTlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:41:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id c207so2946578pfc.7;
        Fri, 19 Apr 2019 12:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rdR1nPEadew/cI3GzjCFjx3nJDZs9St2Z2LmmkPp9Pg=;
        b=Q/uVwY6+7Q3+eKVH7Lg6g2sAe1ilIM2Wyg+qA/AxR+QEcYFcdCXHIpegrI9u2/Mhup
         E3tB4Mm1FifyvIXomED1r/8gmdifbiaMUer+3w7c5IKIULcKAWMHFsnep5k6J9h7c8RH
         UFIcyBZwpncaQ6JYlZSXdobmUyXHpUn1Ai+23TPneaZpDq5QqST2ORja2hyyv6BcCBCG
         7WFIlsQhcfP3DguRT3LeyM6rrzQYmm9PTLx6HBZYdlXrfAQaCeqCzSy2w91U7T76oABR
         QL/Jt7rcyvClkkVqOhG8nqdlSg6JpQ590wlSKUkUkWrYA1nTuoofRgu9wkrlOWPXpFmV
         kkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rdR1nPEadew/cI3GzjCFjx3nJDZs9St2Z2LmmkPp9Pg=;
        b=aE7PchSEeh5nUz9HFCYwVqZ7wU8o2g/ejIHfQA1nDcZcCKBNcziJzctXYk3f/8TIMK
         WxiDeoLoDMSbQ43dariMoyuf6WbgtCKmC7InSeYLYXJbYKjKLE2FwiW8WYBLyXALn+l5
         U3fXTlile0bgWOhGO5j0P6kJWfyaagwOJS4dtY1lf9wkVIkpzsrHlie630Clhi+p5xjU
         a6WdYrLzSkzx33UbyHcG8Pn72rTWenIzs3cBagYJVqh5l50fXGVSayPGfoYzCAlpgJsA
         w/g3Rzd8WaKNZvwlnMCtVuRIxrfjYeJWlicUcWN84t/oT6JcAvk8OgMyBWHq03c0SX2S
         abAw==
X-Gm-Message-State: APjAAAWbXTfvFIIbWSjkGsN9d/SWwVdzIhrjuqTfS8Q+MdtMrxRwihFh
        KroVrF1NMtzJkvCv7OJcM4I=
X-Google-Smtp-Source: APXvYqx5+/l407HUhHPJfJJc8o7+uptgaqG3aSkfDeCU4ZGYZmf551yQL0oD+Ih1WdO95dN5bbsiow==
X-Received: by 2002:a65:6282:: with SMTP id f2mr5609681pgv.152.1555702864217;
        Fri, 19 Apr 2019 12:41:04 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f87sm8965727pff.56.2019.04.19.12.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 12:41:03 -0700 (PDT)
Date:   Fri, 19 Apr 2019 12:41:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 00/93] 5.0.9-stable review
Message-ID: <20190419194102.GD10320@roeck-us.net>
References: <20190418160436.781762249@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 07:56:38PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.9 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Apr 20 16:03:33 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 157 fail: 2
Failed builds: 
	i386:tools/perf 
	x86_64:tools/perf 
Qemu test results:
	total: 349 pass: 349 fail: 0

Guenter

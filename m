Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7FEC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C0B20693
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6mmcREH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbfDYThO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:37:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42018 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfDYThM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:37:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so335262pgh.9;
        Thu, 25 Apr 2019 12:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XYEoF34Q6nh1vOW/rQokAlF0GJy/u+2q0uYWhMwwJ0I=;
        b=T6mmcREHDIiys4Kji7CMu8B26yOgs+UK1Dfdz9c6zSXyIKd/bML5sv0/gWs+Z0R9mo
         5HfjaH5qYKhsb6loxDrFnWDuPp9UbZe4ApnngrkWI3pkiTieSt62Gih+o2g533Dtf0l/
         uG8lHOo1nT/Qxj0c7EjcJjNTbyIK4tF4MvhjANHXasUp7nafgMO0h0UDTqHvmpYHhU1g
         P9M1+4kZIrx4Wat4NPgSDmfj4Hg0wCU8RG53iloUCG9Vkayp+K5lH4C1uv8ZSPpvPpmF
         zXNqr5JCdTXTseKGm3LMVB1qsrVwl2LW2tt79AOmLUiKL3zurxmvJ4UdRw9eR0eZjXtK
         ICCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XYEoF34Q6nh1vOW/rQokAlF0GJy/u+2q0uYWhMwwJ0I=;
        b=j3UM8DKffjTXATAKoFAdduMOaoQBiIQmjigYQ6Vkq6NF2XAHkCJmNHubGMwAIfhKDq
         Agt97AEIaz3sJylv6tRv3GyB5bpx2a1UrcpmlaJtDeqXRpN2DNCRs8a1pvDZeF8QiYmV
         RlS8tg/PlswQXXMdRCFo+DCN7mKl1JtrkZvCZj3m8zr1l2oW8EzXqWj0eThzo65CV9HO
         sftfGUMKeDJ70ZeSl26Jor832XUxnwMzGCON5T3afO+861pmLRgzPr/gPB7WTn5NB0mb
         xSlheN1gZytTmFgqrVuBUwbic2e+Z2n4NcjlVGsfxJO4FuPEUNGhnIHmhIwv1vIYGEWK
         eRwg==
X-Gm-Message-State: APjAAAUL/2NJeLjqKkZQIOYdqMMFAq9kCCNL/rJGySGehw6fPjgBkny5
        9miP2yoBDlvC+l+eXXzo4Qg=
X-Google-Smtp-Source: APXvYqyyd6hHHL+DSvTm5cThPH3mX5OGKhdR+gbV/NfyRfEgXTYhSsux2km2Bo23uxvY6C/J6OwgAQ==
X-Received: by 2002:a65:420b:: with SMTP id c11mr2916277pgq.24.1556221031826;
        Thu, 25 Apr 2019 12:37:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b9sm28103720pfd.32.2019.04.25.12.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:37:11 -0700 (PDT)
Date:   Thu, 25 Apr 2019 12:37:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/168] 4.4.179-stable review
Message-ID: <20190425193710.GC13462@roeck-us.net>
References: <20190424170923.452349382@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 07:07:24PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.179 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 26 Apr 2019 05:07:28 PM UTC.
> Anything received after that time might be too late.
> 

For v4.4.178-170-gc824a7e447d3:

Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 296 pass: 296 fail: 0

Guenter

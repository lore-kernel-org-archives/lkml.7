Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66172C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACB020873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hskVJCSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbfFRQie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:38:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38563 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbfFRQie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:38:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id v11so7985981pgl.5;
        Tue, 18 Jun 2019 09:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/EfAKVzSSLPKC8VVPVL8gdO6/pui4HoD4gSi5/mcpaE=;
        b=hskVJCSf3dPuSpZ9man8x91OJsP9Chxq48WeJBZqEF+M9nanraSBXMuFMXp40VhwCI
         k1drCjcDr9cB4StfhR2uMvt1bQPNGVdwh6cLjTpzgxg84OQNvrKohP/mYE9E4ZpyMYvR
         XS+iduJKKcVBKtCKLc3YuKaPgXIagTVjRQ2xDQn57Q60RfeUsYBpdm/efiygE8bB6q+Z
         yGonZc7Rqjzwjw2BXnqfOiIhRjh+a9QdsXbIkiIhCk5MgFnGuQBsYrOyjzH4lWZYO+RE
         kfbaJQQvxL4NxWmQxIzSCfv8UJEPQZWwztXIuDVhZjwtmWL9cjwhXb/VNAx8cOxUoo5w
         hO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/EfAKVzSSLPKC8VVPVL8gdO6/pui4HoD4gSi5/mcpaE=;
        b=c08JVIWyYZPdrJxzHYejJSLDxydj23A61uP9mfJIR4vEaYpkLz2yHkP+xdVB+1i/Lj
         zttt8xkBDHID6q1keZHhN0xJ8LgchmVqgTPP6ViiYpj0lfRg3C0vtDUR8p40HXJYC+Qi
         63z4yJkdYPf6NY6RW8yPIns0aAlFc1613tfEu9pYeCog/M20wKbiOzFWlmZyxNLauFPe
         K3ZZuwjKGdttFuN+rqh13zJGeRlvHPOWphFYskqyPVhcdbcSSVM8lQZXFU7XjjJ9D0Ar
         YGYyzGFmAisWLOLdM2BeCWIZ5x+CyYbfQKxqdK4OanK0BGK0AXZznjXCmaaWQgD0CN3h
         yMdw==
X-Gm-Message-State: APjAAAU3VWGGQMvlDjPcRknRGqjdM/MH+6Yd+kft1t7cxOFxTUjwlQGV
        qjsd2hHGDDXH1ByL2us0+QA=
X-Google-Smtp-Source: APXvYqzTujjF0Hp+8EaxbYE6ARtau2nKVYu3MJRuCfMNbvqv8w1udyE4gnvd+ea4lSsZcIcy/1m+RA==
X-Received: by 2002:a62:1ac8:: with SMTP id a191mr59423049pfa.164.1560875913559;
        Tue, 18 Jun 2019 09:38:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p68sm15162065pfb.80.2019.06.18.09.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 09:38:33 -0700 (PDT)
Date:   Tue, 18 Jun 2019 09:38:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.1 000/115] 5.1.12-stable review
Message-ID: <20190618163832.GC1718@roeck-us.net>
References: <20190617210759.929316339@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
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

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 366 pass: 366 fail: 0

Guenter

Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DB4C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5955D204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3Uy0hWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbfG3Sm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:42:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45319 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfG3Sm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:42:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so30494363pgp.12;
        Tue, 30 Jul 2019 11:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H6/0rGFSSk9m/tHQBcjoEOXQDXeQBtVWdbTW9wA3CeY=;
        b=L3Uy0hWmdnJU7cpZAiNfu1BmXg9SPWv7spNV62t1ptInxGAWDDRz6n7YiNplnRnhw0
         61NmDAjC2XYpPQt5LwhoHUK/9JwM/ErocwTTysIk0YwOWZUJXpwKy/hFGtwsmFDZXQAq
         1QHh57jS/5esZfXvs85++eCOvK62jaC7GU7u0iXP2hptZEFjhp3gTc7pkfTioxnpxhqk
         Ox4Td7BIeBywojKcVTNQx2ytp3cnNYFReWOT+xxWUh1Q41lvs7ZNkKmc7zSTEUbSprZ2
         rEbpBZKhlUArgGmimuZtuKIPXfUrEWAyYJ5zbBifkFYTAVQMdTw/oyJ2vmGZ/UveOlWz
         H3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=H6/0rGFSSk9m/tHQBcjoEOXQDXeQBtVWdbTW9wA3CeY=;
        b=KAZgQbJc7naJlHS3uFd0Lp44Pwdf2Z9tYWGxqiigsbeQUfLmlG2fkCbEwcTPx7Ic77
         AOqt1spreXy6VYSe+V6dofDwiCBHtHGKP5MBaMA2I4NkCR41uGKg5YwOFdpOI1/CH55N
         ijRtVfTLg3Q2TrYEzEmuRc4SnTvflYkV4OpBcSntJXp7fOAvQRTneJgsOtGqzseLLnOy
         M7cn3ZvK+kSGoFFUmj+PFZyVsU8LII9tCK2ovM/5pO616f3Jq+Hln0bmAkt2xVQVeF1a
         6Hds/K+ZZPk5A012pSuLb+gAojNRIhxVQYDQuAp9C8fLWpS/MXFykSYrIMQ5cH7b8FRT
         MuDg==
X-Gm-Message-State: APjAAAXYa9RQkd9nsg9uXq7CoOqgzo7xfcoyp84XsFa+j3HPXozvOxh0
        UAgvNg1Y389NFAlNix98fxM=
X-Google-Smtp-Source: APXvYqxvSycUvpK+s7oHEiV4tcojf6IMDJqey4PmAieE1AbbVIymAcdeIbijuv5sWRSfGQUj/h5xNA==
X-Received: by 2002:a17:90a:de02:: with SMTP id m2mr117998215pjv.18.1564512145410;
        Tue, 30 Jul 2019 11:42:25 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l26sm70299694pgb.90.2019.07.30.11.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 11:42:24 -0700 (PDT)
Date:   Tue, 30 Jul 2019 11:42:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/293] 4.14.135-stable review
Message-ID: <20190730184224.GB32293@roeck-us.net>
References: <20190729190820.321094988@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 09:18:11PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.135 release.
> There are 293 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 31 Jul 2019 07:05:01 PM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 346 pass: 346 fail: 0

Guenter

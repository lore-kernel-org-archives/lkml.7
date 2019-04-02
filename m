Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ABAC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364162075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJTngmFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfDBTFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:05:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37856 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfDBTFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:05:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id 8so6846206pfr.4;
        Tue, 02 Apr 2019 12:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kUoWafXDAxBoWgMMGVLW7gOeOW/yeXHA63CF77+CL5c=;
        b=iJTngmFUorZJg0CkjmfeIQ3EKkKp9wlsUVZkQGq6duYHIlqxkO12OLzOjwZKfR84Da
         JlwW58zG9BMhy523/ZY0zODikGm1QrOD6Bc6UcNQZJKiWw9X5EAwU6tnC3c00CiBjVi8
         u/ezY9/wrMNdtWXDExVf2XlQsSuKGCqBbflMgQh0FPwX9S17zkSFjJ0EBGpk/8tDt8+R
         5B5GYBbRCLryf2CD6c55esMDyky1jjJQTogrWYBXYEP7jQAVJ7z9Q0+mYjd8SIhE5feK
         TETVCcV4AfGwhTA8qzfHmQ+OcKUsslkavp/q92F4SxpcGz7r5CX+vi3Qk6kzcnvWwwRl
         QmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kUoWafXDAxBoWgMMGVLW7gOeOW/yeXHA63CF77+CL5c=;
        b=QSxTgVEf1/G/Ir9Zi+kiUECavPF9MgjqEwJ+N8TrWt5RdxTrjmCEXGM4DM7f4pJcya
         LdHV7GJ0c7XXxlQ8s+JTpOh9aOE2xtl409G4RInVIKP/p7F6dFO4emvlKBJec/6WPR0q
         Vk5eLDmfTbUmHg5pZUMV70u2aK5vW/3zQSmOs50LOhmI1HpI99RJrpEjFYEI2ZVh6eyE
         sNQya1sHzoXVtdO9CQsMWxQHPbxRhKtWHjOgK/O8r0+CKEe/PEHH5qi4tMuPYkW1jjPT
         Ry/qQPtOCthuBLIkAS3ZqhR49PARx3DjDmQSr98POwWGvyGnqKREtPJCQn8XhBle12Hs
         LtzQ==
X-Gm-Message-State: APjAAAVsKJF62upeOHZymH6hgf8nGAhRh6NqK8Y8JY4G/9rS6t+jp/0J
        lA6uE6Bd2kDbUdHxZMbcxnk=
X-Google-Smtp-Source: APXvYqxdnP1gv/9IYFh6ofzDIWhKLfMQz6AivId8xrwWdeHke5p9AAUh3DbQBe1we3Z5jZ6N5xOcsw==
X-Received: by 2002:a63:fc5a:: with SMTP id r26mr41341740pgk.97.1554231944909;
        Tue, 02 Apr 2019 12:05:44 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r3sm40711991pgb.82.2019.04.02.12.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 12:05:44 -0700 (PDT)
Date:   Tue, 2 Apr 2019 12:05:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/134] 4.19.33-stable review
Message-ID: <20190402190543.GE14232@roeck-us.net>
References: <20190401170044.243719205@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 07:00:36PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.33 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Apr  3 16:59:23 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 345 pass: 345 fail: 0

Guenter

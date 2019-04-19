Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06EBC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66424217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tjhyM2Mf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfDSTj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:39:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42341 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfDSTj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:39:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id cv12so3001603plb.9;
        Fri, 19 Apr 2019 12:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VfDvt0B6ZtvV3cVIl4aWBX91BpGwjs/33R80AABiXFk=;
        b=tjhyM2Mf9PlYYCAxHA5eMwUmyA6W+Z1VVc5d1yxVEslmuzfymhFVyKb34oHyYPmL44
         YhRZbsPRimPuMjezYdZRVUdx2L7GOBQOvRVXrd6rIsWNHNPouEbGRP4oh5NmQvOcdESb
         1xZrhE5oiJYt3Mms+022cBnTWwvtccj8fGNbGCEV0ydasIB/k0YDbBZn3vNcDqTbn+s3
         wBTLPx5+5K6QgGk5Fiq2uNN5A9qCTYSSXib/uQ83g0aRRZOgLtGDkn+ilu+p2KgKtj6C
         kZLs4cA1NbDo9LS3sRonNZ+ITMmL8eoM1B6AA6ibvmp3nupoHoKXDo+QC9wsiiH2mOFC
         IXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VfDvt0B6ZtvV3cVIl4aWBX91BpGwjs/33R80AABiXFk=;
        b=KO8MUALyZgOUm+SuPmsyFWaUq92TEEbvMTDYEWzD8kDBNiK8qrKkGTgW0+6wh/iVHP
         /GDK1ueS6k4Shga23VmOyL0pYBU1Qjhtj3lmpX+VRV6D9LFgw0x+9qs0ZUX1MflJgQqu
         xZYUGjUseu8qdUHs+G5jyunvU8AkDebMFsL7kcKqESMwveNIjGeJrjVEv0WPqhAuXT+S
         c5nytSFgvX53wGdVEcmzAXh8lefdEYIzwzEt1ZmXwzm5hmCzhQr/P1nBscWjcDKPIZOF
         cRfncxKUtV4GptIHmLfKfWNKbNywWzejt7q+UL6dEJCnTX2FM8qa45cX8CSJ/VzmgaoO
         8cjw==
X-Gm-Message-State: APjAAAV3NzQFxr4VkuRma4MarJJqRPxn3yF5D3wFqdodbDbcEq5WVVLD
        0KKBwpP1OzNEI9k0LDsrkGg=
X-Google-Smtp-Source: APXvYqxSw12mz9o24utxhpd9sckTINoAxy/KHcaXsBdE/53Kf4MHIRY9CXBLunzwqorZpXQGnW3AGQ==
X-Received: by 2002:a17:902:7247:: with SMTP id c7mr5615621pll.255.1555702767711;
        Fri, 19 Apr 2019 12:39:27 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h127sm7671629pgc.31.2019.04.19.12.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 12:39:27 -0700 (PDT)
Date:   Fri, 19 Apr 2019 12:39:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/50] 4.9.170-stable review
Message-ID: <20190419193926.GA10320@roeck-us.net>
References: <20190418160422.455656724@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 07:57:11PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.170 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Apr 20 16:03:22 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 172 pass: 170 fail: 2
Failed builds: 
	i386:tools/perf 
	x86_64:tools/perf 
Qemu test results:
	total: 320 pass: 320 fail: 0

Guenter

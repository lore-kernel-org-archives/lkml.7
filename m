Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81D2C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB00A2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVMzqa9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfDBTFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:05:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44256 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfDBTFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:05:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so7011589pgj.11;
        Tue, 02 Apr 2019 12:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6HMVgzizPYc0+hy5W56q6fqUQG3h8F4vDoayaeh6WCk=;
        b=tVMzqa9kVFQhNTvXrMA1mx9bIVjZWDdaHyDopdgz1jig+QM8tT8PwgGDZE4dxz6f67
         yn7mwQ0U2ReGEUEvqzqNZ2iOsYAeVdOBgrbIuMPpRqeiixsp+fP4L1LcvamTB93W/ZCR
         W9y7RXiFNOQ0Vs0zYJKrCcoQsMsMZUZNtpPBrghxvSdPLq5Ul7jfyiyRfDtth0nK+dyX
         H0PZSA+KHwBqwG32pkRzqiPsdJXXI8mYnayzbrcOHgMFuD77eVmUZ1AE9Ha1bq7tfxQe
         aRhibOL2MvVW28AckeosDSUmLVt/t36LFIyZ64x3EAWRofRdyxM9tnFt24IUzGhmcU8n
         0sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6HMVgzizPYc0+hy5W56q6fqUQG3h8F4vDoayaeh6WCk=;
        b=E0endn4ZQurKmyBrqShH5wnRyWbUtmsbY8jAwE8KeeypV+lv98nzjB10igFlMHV5tW
         xd917sJKYevs1mybdBO/dwASVlXxEUIm8tbElfjtKZk9ZK+iDND0AJz7E08tFt9Jel3k
         UBbFXYJddVdKehg4e3ri2g1N/M9SURLxLwxseBpGNqVfy/sxXm57SBl2bvtP6lFEmvUo
         jlUmUhRA52AMnWRgkYjsMfDQqxNiIpqpOJXOIe1IjiAsJXS5j+C/CFPOIUq8G39T/asW
         /86a0oSO53ZdVzyv0KH8lQevZMmSthR2A7pBJIRmUxqY6ajedNnComgevggYgd9W6M+k
         nzOg==
X-Gm-Message-State: APjAAAWY9GB23nOvXISIaOJT9w1U9QF0DllWo2ZsvD91FAZBrL0lHR4X
        6tKdwMXq9PaFseYZG56DzXXqTftU
X-Google-Smtp-Source: APXvYqwUHGrmQZWXQS7XmGzrhtkXQCFqZdiERvdP0ajogrD9bgpKDVqitoCKv3Wfk866ImGF069YfA==
X-Received: by 2002:a62:6985:: with SMTP id e127mr36109148pfc.188.1554231924731;
        Tue, 02 Apr 2019 12:05:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s79sm38976485pfa.31.2019.04.02.12.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 12:05:24 -0700 (PDT)
Date:   Tue, 2 Apr 2019 12:05:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/107] 4.14.110-stable review
Message-ID: <20190402190523.GD14232@roeck-us.net>
References: <20190401170045.246405031@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 07:01:15PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.110 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Apr  3 16:59:25 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 329 pass: 329 fail: 0

Guenter

Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1197AC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1FF2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOs7OMkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbfDBTGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:06:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38216 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfDBTGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:06:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so6843112pfo.5;
        Tue, 02 Apr 2019 12:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s78Iyovg6A+aVfqmDEQaUxeoJvpGobnljoXc6zgcAYo=;
        b=mOs7OMkrmR1VrD/axbxw2oxW8IBxzouR8uWcN3gFEa23R3Af/ZfKm8z0giJxMw+rN0
         2pPMnBlikattLJrmWUjjsrzxojVeKGKZQEtJeuvytwvcs+PCPmAefsWIW0O7hfZSGKQx
         B+M7Pix9vQ9URX/I3m8Vglkt7c8Sc/YKKcS14ro2On5gon0iLaTdBydkbtp8op+Glh+G
         07o3obzhtHSZlAnvcZhaAfYz9bcfdw2B6FaAtx/LTznnKwikLcxS/DdIMZh08nIYO2p5
         oIFVsSTgK+h/BVzwtJGzwzm0K6yK6MtvN1gfyy39ycWR+B1gGh5LAi8O45OAAMyICB2z
         WXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=s78Iyovg6A+aVfqmDEQaUxeoJvpGobnljoXc6zgcAYo=;
        b=m+xnwUO5+QLoX2JbaE1ze/ok0hm8fFp3XcpcifHEqg8GPNrRkUGz1VMJ6XOePrZFuV
         1H96qtuKG/y8S82u6xfk0JpiZ/HUOdmDMOZy3S0vG/sakoEhOOmqpAN8u1fRsRNQlymI
         5xDiVTSd7zak//iKF3ysaE8e8Mq0ez7vzjB5Lc9MdcC7dgbf7FxVr0rJ2y+5Csqu5dLq
         PCS0fgp23wBFSQ+GA7vWxJcxD8OtBKUTfo10gvO9SP2Yp2SGFFvw3OOMI44b+mIP9Cw4
         z1QHyp5lQz/JQ3ZjV26rU4UBRFvsPaucXQZA22XXqRG25oTQZmsaQKtNGb948SV7UpQB
         tTrA==
X-Gm-Message-State: APjAAAUvfP66tiYle2gphAqMyOyXItT6T5cCrxtdrtRtjRqHLbPl5e1i
        J/C1K7Wq9NnsvTXjC7/3KzA=
X-Google-Smtp-Source: APXvYqx7mf5XlTXpSIbfBZek5bs4SnN9z+U6hV57DoPuOKLl2RTKkwKRIJ158/AeRJVAcDihLndNAw==
X-Received: by 2002:a65:6144:: with SMTP id o4mr30947122pgv.247.1554231967471;
        Tue, 02 Apr 2019 12:06:07 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f15sm573590pgf.18.2019.04.02.12.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 12:06:06 -0700 (PDT)
Date:   Tue, 2 Apr 2019 12:06:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 000/146] 5.0.6-stable review
Message-ID: <20190402190606.GF14232@roeck-us.net>
References: <20190401170048.449559024@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 07:00:12PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.6 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Apr  3 16:59:21 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 345 pass: 345 fail: 0

Guenter

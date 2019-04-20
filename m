Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70432C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 12:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B042183F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 12:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHSQypQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfDTM13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 08:27:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42775 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfDTM12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 08:27:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id cv12so3743105plb.9;
        Sat, 20 Apr 2019 05:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AyQ81q4VrLvb1CMAMq75XCsCzSgp1WXhht5ckDhNf2U=;
        b=mHSQypQ75VEPo57mWROJDcGXoCfQGauQvbtuA3/ugoJzLzyfpNLFe2TjsoL3CmMW8B
         cEOAPMrCuVNW/KaZfEeQoBmvZ6r24HFMpPjPSoWiSBWUzsL07Nz8n4HyZ31PBFOsQ6eu
         hgx2ZCQJ5ysIoEWJ9f/vTyQc4lckxygO2+/M3p1mHa42KVlP9ZdqfOE5yZCmZkPcQHoq
         GEBLcvikOCIXnfTcVskgW2lIaKf/AFzRf7MV/pvJnpkIcRJv0LGEugw3tPRGR0n0eeFR
         hMbBUr51N8O6Fps+stVfaSZ8HF4/u096jXCtEZabOyTGxjXjQP53pIzpcCA46E0pVNtx
         X3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AyQ81q4VrLvb1CMAMq75XCsCzSgp1WXhht5ckDhNf2U=;
        b=s4QZMDahXtLIgmFA7RF6lfcscUTBbhozeVaED8Yp4B11clsNDO1ImE4Zk/AmJNhSmN
         /6qE8sP5wdCkAHxZuyShH2bWsyDAhQy0Z2jFh7AHAPhtBKZ+/KJWAnfswpdG1LFer2y5
         5cFlrf+5jM6KWQQX2x/dUOza4UYuTc0bbKzSjBXBO4WXldBgBdq8JEinRntQcN3uO5I0
         elhtEfumV7asQ44m10oYzzOBwag9UlRkJ5tWSEg4ilyOd4TaMBTqXbYqaFNanlAjToiV
         UcUBrqVHgCP3MmovilBLtOXufDd0m+QGNBopDCUBem8TguyozY9NG/BMXXZ9ITmA+t/v
         a8XA==
X-Gm-Message-State: APjAAAU811avnN8uPbtqHBc0TugLIWVyfXbuGFX/NJMdslRvm9H9sIpR
        5HxAe7b335Jz8l3JYfq8Lv4=
X-Google-Smtp-Source: APXvYqx3QkQaGmyBYF4R6qKTUuxe842uYUPokibI+mIpVKaPq1tpmwZMB6lexWtdR97hPVwM6CQmNA==
X-Received: by 2002:a17:902:4c:: with SMTP id 70mr9114141pla.328.1555763247664;
        Sat, 20 Apr 2019 05:27:27 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id n5sm8284736pgp.80.2019.04.20.05.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 05:27:27 -0700 (PDT)
Date:   Sat, 20 Apr 2019 17:57:18 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/50] 4.9.170-stable review
Message-ID: <20190420122718.GA18303@bharath12345-Inspiron-5559>
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

Built and booted the kernel with defconfig on my x86 machine.
Observed no dmesg regressions.

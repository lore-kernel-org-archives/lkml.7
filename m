Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C80C282DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB3321738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2ZCfXzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbfDESc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:32:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33881 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731474AbfDESc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:32:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so3521186pgq.1;
        Fri, 05 Apr 2019 11:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jXvFZ0SlhHp87+oJ35BFo0ceGq4IVNeDiSicKKAlryI=;
        b=r2ZCfXzdM9Czj1d9P0HiAKb5KLuAoBOQnrlTEU4Z7OW8DJ/8VVy6SlqfTj2Uojo5QS
         NkINl0Mo5uy6y1dow+9y0sqPBX0s7uT9zgCadbxZgAVQ+cLawy2BPlTmN5yNSvRK+Ef0
         E+yXKXd9ZaGm5RRJliUh5uIoRV/v6JiK+HIBVC+EBQ+OWgVewy1C8BYSbNXPanJklhlS
         IozICBipwS5UOBTMSnrh0V+4cvCEju8eLa2Qf5p9xd7DBSGQLUMLNcn7TIQaZy1KWOMG
         leAduqovqsYsa3gLmnEKKVriY8dnNz3ueJiLQ+GTYDc0U6rBJXkgSmTVv8kqnyAew9kE
         i2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jXvFZ0SlhHp87+oJ35BFo0ceGq4IVNeDiSicKKAlryI=;
        b=RLUm/d/24bWpyfB4BDjKEckmILgXtJ64aT9atHY4RSsu9YDl50559PTEL51m4pjPnm
         gySgE8hBCWOGz5eKxzlfTG/pkzuf54JBL20bYwLx5NYAitt8v/2DLU8qIzXVdKDmBphl
         ofjBJwgolewg3JD/QFQ1n+Nicw9rdPMmdaT87Mf70TSUJmIULb7jTkxRLAycbix4Zhqm
         lzB5piqoKsnOCX/ZXTcAYh0G+0ELBCIyLJLs4nC3VZsSevZqqX3AavwS/GXCg1k5bt1a
         +EkilkkOU7E7mqAo+P6+X7bs0lpIB1l6V1/I405cOKuYpW/OpZMVMX/YWyonxxq3L5tw
         eE3w==
X-Gm-Message-State: APjAAAUqNNs3TJlbKhbWBUAz49cV/taf/m517uWorK7zaNR5k7xwgGBN
        PAMD9+nYF8o6/Vdo7K+6izQ=
X-Google-Smtp-Source: APXvYqyaw6qu3w+OvGsoZKX0BwLjitUzialmGeTql59WojIOPxVGCfMFaTZpZZG0J4tDrHlbT0e7Dg==
X-Received: by 2002:a62:1e06:: with SMTP id e6mr14201831pfe.168.1554489147452;
        Fri, 05 Apr 2019 11:32:27 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 14sm44901165pft.137.2019.04.05.11.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 11:32:26 -0700 (PDT)
Date:   Fri, 5 Apr 2019 11:32:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 000/246] 5.0.7-stable review
Message-ID: <20190405183225.GE11563@roeck-us.net>
References: <20190404084619.236418459@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 10:45:00AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.7 release.
> There are 246 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Apr  6 08:44:36 UTC 2019.
> Anything received after that time might be too late.
> 

For v5.0.6-248-gc3237e4b7d6e:

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 345 pass: 345 fail: 0

Guenter

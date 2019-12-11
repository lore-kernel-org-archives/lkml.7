Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACC4C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B117206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="QYbpSDQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfLKQQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:16:14 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33072 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbfLKQQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:16:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id c13so1612820pls.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 08:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MXCmGsW8itYCIi8NQSaIAK7ukbEUBNXl9j1T5nEaHGg=;
        b=QYbpSDQ2ua8NL7xqSA7Yua4lzs3qw0Y2LRv5eR4tKEHeqN4y2AIh0DfI3n32mq5Lyk
         K2YcwlgVgXBFIbPN8iKzh6/Av3Tna25NpPxtMXC7tFDJw721dCygn/iS61q3djNkZyni
         mVLji0Q3kWK/tmec/FYAzpUJV4jMCgqQKzUjvlrBvHRJ552N/SWr8lHgG66PyrzCeOjm
         /eAiijUF1AbL6iuzYqF3CxklerZ6ab6pOzFcoHrxQ9UbftOLwmG7VOydxcUMOHJCJgD4
         eZnpEwsESIiZ8RL15o28nzn2cnOzaexYax0e8z8aChBRgec7Cn0PR+351Bh94kFEKvzg
         yh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MXCmGsW8itYCIi8NQSaIAK7ukbEUBNXl9j1T5nEaHGg=;
        b=PfKi3RAvrgV8TFS5HnAdcgEL3ByLv5W49b3/bklOfhqLS7IOsWxAr3TywLxALolkI7
         u9fofV/eFsNxrQqyk+D2DUeo9m/uO2zvcMRNVN2uOMpiAWoqudAYwl0XUGH/gihdbIop
         oz87rSXElG6z9AmR8nuKMTQcON63y71Gzz0HUkgRbw93AYNFbF867iqTP6v0RlyIUQls
         1CZkWRryTcQxf9tfZQoEC8uBFAEdnu0PDOPnza7N1WKvpJue9N9CQTbXV3zkyOW4EtYG
         H6qZIwEcxac4g63v6t96n1NP/+2RYFsp/uAAuziicGIBvyaYDDVhi6R7sGIyhoQZ4aXu
         /7ow==
X-Gm-Message-State: APjAAAVHnlKyl5bvTeNjmvbIsZqx21rstW441IoJUlMLF9GFcJjAcqKY
        UAtuwkXJfvBxg8rTCEbi2rWx7A==
X-Google-Smtp-Source: APXvYqzPX/v+hnR4/KASF/sKEAiVdz7cVmusLRs3j8+NqWPNeiSzXGfmWsd+4qjgjod4f3I2HjMdqw==
X-Received: by 2002:a17:902:64:: with SMTP id 91mr4134443pla.307.1576080972467;
        Wed, 11 Dec 2019 08:16:12 -0800 (PST)
Received: from debian ([122.164.82.31])
        by smtp.gmail.com with ESMTPSA id c19sm3829604pfc.144.2019.12.11.08.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 08:16:11 -0800 (PST)
Date:   Wed, 11 Dec 2019 21:46:05 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PATCH 5.3 000/105] 5.3.16-stable review
Message-ID: <20191211161605.GA4849@debian>
References: <20191211150221.153659747@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211150221.153659747@linuxfoundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 04:04:49PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.3.16 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 13 Dec 2019 14:56:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.3.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

i get the following when i try to compile...

-------------------x--------------------x--------------------x--------------
$sudo make -j4
  DESCEND  objtool
make[4]: *** No rule to make target 'arch/x86/lib/x86-opcode-map.txt', needed by '/home/jeffrin/UP/linux-stable-rc/tools/objtool/arch/x86/lib/inat-tables.c'.  Stop.
make[3]: *** [/home/jeffrin/UP/linux-stable-rc/tools/build/Makefile.build:139: arch/x86] Error 2
make[2]: *** [Makefile:50: /home/jeffrin/UP/linux-stable-rc/tools/objtool/objtool-in.o] Error 2
make[1]: *** [Makefile:67: objtool] Error 2
make: *** [Makefile:1752: tools/objtool] Error 2
make: *** Waiting for unfinished jobs.
------------------x-------------------------x----------------x-----------

the file "x86-opcode-map.txt" has been deleted upstream.


--
software engineer
rajagiri school of engineering and technology


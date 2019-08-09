Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716D7C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 04:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAAA20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 04:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="j3bpd+7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbfHIENX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 00:13:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45042 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfHIENX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 00:13:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so45183024pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 21:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LGK8xAZED47AcxPYpmeVFwakorLRQKz2XkSu4cZUBv8=;
        b=j3bpd+7D3wUCvAEYoV3Y/8lm4FWgAoY76rcVkZtEaoHa+ndQL4NDjQvfepNmY+3WNY
         jJsz5z9vZ80e8wQYtXIup39sYwDWnz9gIJBVWEfQkGlQCpE4luK0aADIBLXy53BdwE7K
         5u6g6AUXj60g7GLdg1TAhk0Hr92wpwr125DTbII51fypY6wfV1gss26UCj5yOoGEhV0s
         +gIAlAss9lj7T01L4j/0EKlpU6xGnCyvcY9BLXuBhwCBnQINlc5slzjpEfNR8F5ktw0q
         zVMHwkTj/rYUJZv3kx597RHnoHfT6F8mNUHymgi3RQzspZko2TtzfRFmyVt8Mhh+sA6E
         /d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LGK8xAZED47AcxPYpmeVFwakorLRQKz2XkSu4cZUBv8=;
        b=ZMHqQCl1i7URmHm0jNVJLrY6MvZIGqN/p4pz7uLPQ1sLvWXZxwTPdaPtPMnpRxUBNl
         VNsYLoZx4hM06AvOj9VazIs68/NG0U11H7Zo4gGoSRhp5Hm3F+XG+yNh00Ow+XGvZ1UC
         Sc+HI+5xQ7SfNbv6fojx90WSDNUL6gto3zBAHs7eDazaj4LX0Cky/BWQ4xbuKqAAt0w/
         QtYvhTVsfGKya4iuf2BkoRD0Mw3J7QR7g1pKqdJXb2WXxbm7x5ZVk1QbyiGFmg54oeTU
         uKx8TXBcbQpNMnGkIMbd/p/BZ7KqiS31DCXsG6o4jfh5VM2VnCU8Tm4RCIUL1EE61L2Z
         ExhQ==
X-Gm-Message-State: APjAAAX39bSCuEwuwISbW3VeNIwOzq2ScAWPF+XNflLVoGxJ5wIaM1Fh
        oefiaVPboaUVHU9/oDd73f87oA==
X-Google-Smtp-Source: APXvYqzh3q7R1YyrpddBNx1XEjBFU2sNbRDmfbQ+qlJzlueqrAl789IfvTUbC97ryEzU8sr1wUlFuw==
X-Received: by 2002:a17:90a:2385:: with SMTP id g5mr7670145pje.12.1565324002505;
        Thu, 08 Aug 2019 21:13:22 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:b4ad:b9cd:bed1:964b? ([2605:e000:100e:83a1:b4ad:b9cd:bed1:964b])
        by smtp.gmail.com with ESMTPSA id q19sm102078242pfc.62.2019.08.08.21.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 21:13:21 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
References: <20190809140035.5b59c31e@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fd42e4e3-a17d-599f-bc95-43f603390cbc@kernel.dk>
Date:   Thu, 8 Aug 2019 21:13:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809140035.5b59c31e@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/19 9:00 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/lightnvm/pblk-read.c: In function 'pblk_submit_read_gc':
> drivers/lightnvm/pblk-read.c:421:18: warning: unused variable 'geo' [-Wunused-variable]
>    struct nvm_geo *geo = &dev->geo;
>                    ^~~
> 
> Introduced by commit
> 
>    ba6f7da99aaf ("lightnvm: remove set but not used variables 'data_len' and 'rq_len'")
> 
> Removing the above line will also remove the last use of the variable
> "dev" ...

Thanks, will fix it up.

-- 
Jens Axboe


Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A37C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61EC2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="XKVl5KlS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbfCAIn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:43:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39760 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfCAIn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 03:43:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id g80so19658254ljg.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 00:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dHgrxAerKH54EZRV7lKiut97ONmA2OZmvWj2BlwqLOY=;
        b=XKVl5KlSMJdjz3CJzWWeLj4dzdU4PtQR3/sfXrzoeTK8wBSGK+ksybq+laZTGF2KhH
         khrHg7ldJmB451J1av30w2FMnjo7+3EOtgkMFVrvwg8SNMFkbsgZdnbsYCZRsUDAyddP
         CUC37IoSuZWUPcPiwvCWiECqRn38c/URe5/8NagxZfiDiHag5lYeop5flUEzZ8zGjzl6
         j0YLJkzCbJNqHJ3wwcsy5ZF+VnKftGSMgMT9JN3Nkft8l8xynp0bqxPEzMzq3IlkkR3V
         0gCwwc7wvM0uxi83HjNBkQAuK9GWy5jGw9PUKglRioOieksQKOwv5PpQLywn+2M77hjQ
         b+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dHgrxAerKH54EZRV7lKiut97ONmA2OZmvWj2BlwqLOY=;
        b=T7Vl0+LK39VN6oze3OlOLJubtcUFixAohXcf5+wYLSrWMmJ0OsZmgtqkJ1gmqiHuxt
         Hm6x+XyOzOHZA+4VNWmTXgyk562N7UOtFLBskZfKBL9Z63Ci4qris9EtgnSA3o5B3VZK
         OUFHYm5r+JVUI2N5Sn9f52n9cuw8fknYIpC28Td8vLvJKMYbVZ8h2MoCGqAe+47gG50d
         8Tz34yhalQ/zQvbR/h+eKHuYlIHZMd9je4WuzwnNF/vHnFdBzSoyJ5gKtkA+lDtEDavX
         lu2crDUqAiNcIYEAk2aqkMBjkMpyQJQgO/i+JxX69eK7rdpd+pDoT3/DWiLZeMGiRdC9
         sing==
X-Gm-Message-State: APjAAAUnIXIFv3MXSMviJcSAhcNU/uldURxgYbaU0nZa2J+G3pHrNXVd
        cYX+Cde+Ifgm/iGY8NmXr5D5TA==
X-Google-Smtp-Source: APXvYqyduSqNJSMaOgFcCE2INrR9e84+FFK4Ti4nhBs1TO68842Ad3eR6RLU8mJ1Ka84XKi4rw4neQ==
X-Received: by 2002:a2e:9117:: with SMTP id m23mr1909761ljg.94.1551429835517;
        Fri, 01 Mar 2019 00:43:55 -0800 (PST)
Received: from [192.168.0.199] ([31.173.84.89])
        by smtp.gmail.com with ESMTPSA id a26sm1322361lfl.45.2019.03.01.00.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 00:43:54 -0800 (PST)
Subject: Re: [PATCH] netfilter: nf_ct_helper: Fix possible panic when
 nf_conntrack_helper_unregister is used in an unloadable module
To:     Su Yanjun <suyanjun218@163.com>, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, davem@davemloft.net,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     suyj.fnst@cn.fujitsu.com
References: <1551419766-1039-1-git-send-email-suyanjun218@163.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <e420b6c0-bebf-a2fc-a2ee-7b3e0023d833@cogentembedded.com>
Date:   Fri, 1 Mar 2019 11:43:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551419766-1039-1-git-send-email-suyanjun218@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 01.03.2019 8:56, Su Yanjun wrote:

> From: Su Yanjun <suyj.fnst@cn.fujitsu.com>
> 
> Because nf_conntrack_helper_unregister maybe used in an unloadable module,
> it uses 'synchronize_rcu' which may cause kernel panic.
> 
> According to the artical:

    Article?

> RCU and Unloadable Modules
> https://lwn.net/Articles/217484/
> 
> When we have a heavy rcu callback load, then some of the callbacks might be
> deferred in order to allow other processing to proceed. sychnorize_rcu does
> not wait rcu callback complete and module may be unloaded before callback
> done.
> 
> This patch uses rcu_barrier instead of synchronize_rcu will prevent this
                                                         ^ that/which missed?

> situation.
> 
> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
[...]

MBR, Sergei

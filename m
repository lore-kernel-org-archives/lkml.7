Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4AFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8E320863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAra5kYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfCRRWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:22:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40190 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfCRRWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:22:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id u10so11214523wmj.5;
        Mon, 18 Mar 2019 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CPXlzC3Qw3vb1vwaN6qwSjYHpa7TmPwsAtN0D0aIOMo=;
        b=mAra5kYkbq2DRq/QHrHQj9tgXw2hKQ+Vdmy4yx+fsBSFv7n7J3l8fwaWmK9zOAC0cP
         HRu92PmKUD8LryYeWDTtcGWRE/iUQI4qSFPuiuib7zxXjIgtmffXnF0z+sOpGDrCbDrk
         5iD82XWF5XJuH3RjPy/4z3ETnn5qUnKXlsdrO5olrf+QXhk95onXStYLT54Wg4ur0trg
         Mhw4WJWbht0PCct81g7yb4oQCO+bOfugPhTeSykzbHcOoKpdTgU2QeApDeinijp62erU
         wFftVKio56kINCYIfgSJgyvDmTIZwyOxhS+hmPC8hwI3PbSAku7kb/3CKJlxC+2bMKWa
         yyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CPXlzC3Qw3vb1vwaN6qwSjYHpa7TmPwsAtN0D0aIOMo=;
        b=etzQyIag62wHrDexwKRaG//ffrRcEjDJgJtmfUfCxFOHpudw8uPpnSnRrN7k1iGhWW
         hlR9+UW++S1mp67wADWaT7+ZX6+JTh67ysSwbUYJsO0RmV9vdoRTxYVaFolN5dYPwlv4
         Pyff27eMVEVfQ2Ij6KkOOiQBP36oOjvC/Z1O6tYc0ExsS0mxknkHYwXUNQXaMSKtXTNY
         0vP8uQY7chn1ANhk0TMYx5lFo/7d9EJw5f5wL6/6uYwGvC/9TB8aUqCvAylPUh9hDPPL
         BMaALBnlHanny+8Y8vWwUAtIRNKKZRdzp9gQYmNIEHX0H2xlkcAF938jHDCGU71m9+9E
         ePcA==
X-Gm-Message-State: APjAAAUeHjyF2WLYBfJYLEuYYarBof3HNSfB+wbtLhiDek9YylRqFwms
        Ik+MAPy7AChxi58TNP2430z7Zoy1
X-Google-Smtp-Source: APXvYqwatZZUTuNOWwUKf/rJAx0ib0fRawf0fh//UqJglg/t2rDQXm3cm4AH9tCzaOVRXY62Xz68OQ==
X-Received: by 2002:a1c:f610:: with SMTP id w16mr3416wmc.42.1552929768645;
        Mon, 18 Mar 2019 10:22:48 -0700 (PDT)
Received: from [172.31.96.190] ([195.39.71.253])
        by smtp.gmail.com with ESMTPSA id w13sm10918961wrr.21.2019.03.18.10.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 10:22:47 -0700 (PDT)
Subject: Re: [PATCH v3] net: xfrm: Add '_rcu' tag for rcu protected pointer in
 netns_xfrm
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Su Yanjun <suyj.fnst@cn.fujitsu.com>
Cc:     davem@davemloft.net, fw@strlen.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1551923648-17656-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190311101006.GK3758@gauss3.secunet.de>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <b2beff03-f789-5c8b-bd69-57ece92372f8@gmail.com>
Date:   Mon, 18 Mar 2019 10:22:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190311101006.GK3758@gauss3.secunet.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/11/2019 03:10 AM, Steffen Klassert wrote:
> On Wed, Mar 06, 2019 at 08:54:08PM -0500, Su Yanjun wrote:
>> For rcu protected pointers, we'd better add '__rcu' for them.
>>
>> Once added '__rcu' tag for rcu protected pointer, the sparse tool reports
>> warnings.
>>
>> net/xfrm/xfrm_user.c:1198:39: sparse:    expected struct sock *sk
>> net/xfrm/xfrm_user.c:1198:39: sparse:    got struct sock [noderef] <asn:4> *nlsk
>> [...]
>>
>> So introduce a new wrapper function of nlmsg_unicast  to handle type
>> conversions.
>>
>> This patch also fixes a direct access of a rcu protected socket.
>>
>> Fixes: be33690d8fcf("[XFRM]: Fix aevent related crash")
>> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
> 
> Patch applied, thanks!
> 

Has this patch ever been tested ?

I do not see the needed rcu_read_lock() / rcu_read_unlock() that are mandated for
rcu_dereference() correctness.

All changes like that should be tested with :

CONFIG_LOCKDEP=y
CONFIG_PROVE_RCU=y


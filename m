Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3851BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED89C20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LqmZqUMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbfCZSRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:17:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33656 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732424AbfCZSRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:17:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id q3so11667600edg.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NuoER88TjogJmel0bb/nMCUmRqawrRmoPl6DoA/n+a8=;
        b=LqmZqUMCgaZLbtj7+b7THviB4fWlSHMV9uOnH0e5u8A7bQUuZSRuDMYNAbvbj+1Lq5
         t3tnPM0iL0+6HlhPPG+yfzw2a9Bo2Ih/p0gVKWCO3Fkn8YyZqCxtiL3lapX8wjJX0Xjl
         5lrnBCNMeCKeyjeWMlPs43asZPbROwO57hu2vnTxNHNekIeZkq8zKETPIA9UvFJeaN8c
         8g0pwRUEeM40Y2tIMwHrNBzHCC1lmQgDf4ZJ1G22PLTsDtdL8gXm141rsHDOSfcrdLj+
         qm5CPIZQvN05sm0+o1NDWikbnytBwTZ2sRTLRjDg7ARtndAuSvdnVmqf4VsAXxGQQFpv
         ZmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NuoER88TjogJmel0bb/nMCUmRqawrRmoPl6DoA/n+a8=;
        b=BO7IDOqoJoHx35+ekPYycxXeyYqHwBED2pBwDpoGgthQ0xkfIQuhSnfZm0lHm2hBli
         n65vUAr+XVDoQD1/4uX+NagKhA3OUz0dgnD+P9jXLS0XW3/ZnQesMeQBHlFBvgy0DG9b
         IAFONpO3Hz4UXea4X8xJGQE1FZwWcV1xBPwmCJhy0FsgHTDl0xvZmZVb1Epu5wDOcWMj
         1adt2j4gls/nB/yduma3U379k1kKlwODpqOwJ9F2tgMkSx5wX9wHrhCOO1hH0YG8TEvB
         1Tfq5ACuTtHdCsbp5GUdBqVNsIikhYnjjSYC2V4ErY8uLMFfPPAAfbCr9UibtjUSkWhW
         Qyxw==
X-Gm-Message-State: APjAAAV5G5zlgyOIe3g29iaqhwLtJj28eppMU8fd/0bF/PfJt42X8mA3
        vloFnoBN+7JwFpDuJDt9q5hiuw==
X-Google-Smtp-Source: APXvYqwA8G7QnkgbfeksMB9bLb5fb+ESOVc/wSv5OCESsP9ELL/6dp63CIXVfeKAc7HqV6ZGL01j7Q==
X-Received: by 2002:a50:94aa:: with SMTP id s39mr21939236eda.191.1553624234830;
        Tue, 26 Mar 2019 11:17:14 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id y4sm3064326edq.53.2019.03.26.11.17.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 11:17:13 -0700 (PDT)
Subject: Re: [RFC 4/4] net/ipv4/fib: Don't synchronise_rcu() every 512Kb
To:     David Ahern <dsahern@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org
References: <20190326153026.24493-1-dima@arista.com>
 <20190326153026.24493-5-dima@arista.com>
 <2f911647-f35f-13c2-8177-2fb93147b0fa@gmail.com>
 <bd638730-e23a-3d08-bd35-9c80af13692b@arista.com>
 <dff0e80c-fa15-c28b-b34f-d80f59162051@gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <dbcd803c-3347-335e-bc5e-299c33f02b9f@arista.com>
Date:   Tue, 26 Mar 2019 18:17:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <dff0e80c-fa15-c28b-b34f-d80f59162051@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/19 5:57 PM, David Ahern wrote:
> On 3/26/19 11:15 AM, Dmitry Safonov wrote:
>> I still wonder if it's good to expose it to userspace rather than
>> shrinker, but this probably should work for me - I'll test it in near days.
> 
> I did not know about the shrinker, so can not comment if it is better or
> not. If so, my patch can always be reverted since it was just applied.

Oh, don't misunderstand me - I didn't mean to say your patch is wrong,
but I wondered what made this preferable for you.
I've sent my patches as RFC, so probably - it's a place to discuss
what's better, rather than running, rushing and reverting you commit.

Initially, I was also thinking about introducing some sysctl like that,
but thought it's a bit "dirty" solution to expose it to userspace for
tuning, rather than make it work automatically in OOM.

On other side with your sysctl, there are some minor bits, those are
not-yet-perfect and asking to be improved if we go this way:

1. I've noticed that the limit is only being increased or set to zero.
   Which in turn can result in more calls to synchronise rcu than
   needed.
2. The memory summed up under the limit is only tnodes in tnode_free(),
   while nodes are not summed there. Also some tnodes are being freed
   with node_free(), if I'm not mistaken.

So please, don't take me wrong, your patch may also work for me, but
probably worth to discuss both ways and I very much value your opinion here.

Thanks,
          Dmitry

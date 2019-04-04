Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154C4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0662206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="n9gqPJUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfDDQd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:33:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34185 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfDDQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:33:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id x14so2853742eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2hndytGoUoqBgymO1uHWgt6ocOekMb3MD90dT3rk3MQ=;
        b=n9gqPJUEgZVRvbEY8FgzUu1/ntSYuK7gXNPSrcCIemP1+uUSwXbMJhfeS031NiSL9R
         Zj2D+IXmbWAZRsW+PnUMy4zxtR7fcqlOohbcGMUWmVZ40j1ngUfE2Lqhq/0S+i5jTSeQ
         STxKcxm36xeID3dnwl1+wlmV7Rh1GLjQ6Gr1tT/MINkED5LBLuycXGSFASHmwnYqZkFK
         0hmEAf2DzHRi/n55RAZM0hezH69OagZI9BRumG/4owKVv0o4DD2lcdbugAwm5VmotfkW
         3AdtnB41tj8CVaS5EYxg1t75xLQK5fUIJD1tXpdOjGF1gLrVuKLy0PikVV7HSNMr9kcF
         9Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2hndytGoUoqBgymO1uHWgt6ocOekMb3MD90dT3rk3MQ=;
        b=lK4/Tl6ASA1shvTEfO846X0BL8hfBAjVVWYcrOgj/ANuRAiFnR6TBfk6m0pbXLXMTa
         7Z2aShp9mIv1adLepfNb3CqDEALdjvOhQ41wHIpKYF9qmhDnnjdr5RHqyjsMold4NdHb
         WYvgmeeOs7rfT+vX3uTQO1HEV50YRm67SJZrzR3FLLY5EWdL0gC4pRh7zpoykUbOjnd6
         naGei1F0FzoZ7CgDGUjTgY+kdqQ+46c8iIQtReojs2qR5IylZdjlNMVatoJJ3WAN/7vI
         6nKtrhPlJ7e9OGMOIGD7BPZeC/WjpxwuWJz52C7WRRty0VFuq218arWqqF1roXufJ04v
         YHeg==
X-Gm-Message-State: APjAAAUt7wR3BQd8BvFVWCDP2Iq1rIMtNrHuAOmF863/ZsETxIO+qVur
        yKMfcezXkjHa9HNcsjppAcYKlg==
X-Google-Smtp-Source: APXvYqy14bFpFFt+392XPIYr1mdvfkPyTgLw1PaezgBQ+9km//noeFBUnjQlmaWYwqJRMMGmEKn4Xg==
X-Received: by 2002:a17:906:1584:: with SMTP id k4mr4179829ejd.226.1554395636245;
        Thu, 04 Apr 2019 09:33:56 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b3sm3677993eje.3.2019.04.04.09.33.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 09:33:55 -0700 (PDT)
Subject: Re: [RFC 1/4] net/ipv4/fib: Remove run-time check in tnode_alloc()
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org
References: <20190326153026.24493-1-dima@arista.com>
 <20190326153026.24493-2-dima@arista.com>
 <5beb631cf0dcc03d5afad3a29671677bdbc7b931.camel@linux.intel.com>
 <c82b92e9-9809-87d2-85dc-67044d4e7632@gmail.com>
 <b3540257a002b944a878096570bc927450662b9c.camel@linux.intel.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <992772b9-3565-c616-614b-303fcc078978@arista.com>
Date:   Thu, 4 Apr 2019 17:33:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <b3540257a002b944a878096570bc927450662b9c.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/19 6:50 PM, Alexander Duyck wrote:
> On Mon, 2019-04-01 at 16:55 +0100, Dmitry Safonov wrote:
> Actually now that I think about it TNODE_VMALLOC_MAX is likely much
> less than 31. The logic that we have to be concerned with is:
> 	size = TNODE_SIZE(1ul << bits);
> 
> If size is a 32b value, and the size of a pointer is 4 bytes, then our
> upper limit is roughly ilog2((4G - 28) / 4), which comes out to 29.
> What we are trying to avoid is overflowing the size variable, not
> actually limiting the vmalloc itself.

Oh yes, I see - managed to forget that size can also overflow inside
TNODE_SIZE().
>> So, I wanted to remove run-time check here on x86_64..
>> I could do it by adding !CONFIG_64BIT around the check.
> 
> I have no problem with that. All I am suggesting is that if at all
> possible we should use TNODE_VMALLOC_MAX instead of BITS_PER_LONG.

Yeah, will rework this part.

Thanks,
          Dmitry

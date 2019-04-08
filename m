Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245D3C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 03:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6AB20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 03:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="V/Lk3DoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfDHDvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 23:51:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39840 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbfDHDvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 23:51:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so3641979pfo.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 20:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tjgz+p51HeiaMbDLnm0drZ9stCL+Kor1sdDvXcft+W4=;
        b=V/Lk3DoVpfFrrekwElZJMduUOvtlLsSXWTpYD+ETl8Gf+ikmUxMbhlDSps4MMbQB7b
         4AEFr59acw0Swxv1tvcO2Dh8BrT0ajbEoVwu3DrYXXnFHfhrNASHKyeD6dkBJlIIEun7
         1pwCB9IDgwtyUhEK3RI4eJ+QgoCKW+dh8bXU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tjgz+p51HeiaMbDLnm0drZ9stCL+Kor1sdDvXcft+W4=;
        b=IplYJTxBCrsVKmQnb6VhmyYqjITj8IjcdCsX0Q3GeeabtAKefMlOF40kNEPaqOtxUz
         QlP4i9TjEwsRDbNikn1MFn2j6rOC9aAn0iArOgDOt+Z8Qom4nhpIqwidiUD7cBBS8wNT
         gCLNx0FBO8ASHMNp88OYLfbxmswxpIP9pJtQo7FZ3TURfSLgerpGtBvFqygmD8Bd790B
         qFqwqUut8Q/FzDElTaOnZYgH3HZIz0dyQOGWYZ8w1iCSsCDi/0ATDfBZiwgQ2YgYzXaO
         MIA+x9lJbRP1xopr1zI3irfzsIFjnszXfRnqewkEkA+TEm3EgTbLlM/JbpKqx1p4KuvW
         dJnA==
X-Gm-Message-State: APjAAAVmWrnoLbdlA+v8GLxRb0HUHO4dCOLSTYLrboiL2dDHPHNKW7Dn
        FbmAL9nBZac1dFRLgIJKOiowiw==
X-Google-Smtp-Source: APXvYqwKajm9AFqif4rrsqoAoX+7h2/4t826lQxcogaHA37nUmnwT2gb5ih5BQ9P0Yv80RET09IyOw==
X-Received: by 2002:a63:6786:: with SMTP id b128mr26367137pgc.318.1554695468526;
        Sun, 07 Apr 2019 20:51:08 -0700 (PDT)
Received: from [172.27.227.131] ([216.129.126.118])
        by smtp.googlemail.com with ESMTPSA id l19sm36108179pff.1.2019.04.07.20.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 20:51:07 -0700 (PDT)
Subject: Re: [PATCH net v3] net: vrf: Fix ping failed when vrf mtu is set to 0
To:     linmiaohe <linmiaohe@huawei.com>, shrijeet@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mingfangsen <mingfangsen@huawei.com>
References: <b32ed160-6c7f-fb8e-aa14-11d935a1cb15@huawei.com>
From:   David Ahern <dsa@cumulusnetworks.com>
Message-ID: <22ff0d05-c1af-ad08-4cae-39dec91eff47@cumulusnetworks.com>
Date:   Sun, 7 Apr 2019 20:51:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b32ed160-6c7f-fb8e-aa14-11d935a1cb15@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/19 7:04 PM, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> When the mtu of a vrf device is set to 0, it would cause ping
> failed. So I think we should limit vrf mtu in a reasonable range
> to solve this problem. I set dev->min_mtu to IPV6_MIN_MTU, so it
> will works for both ipv4 and ipv6. And if dev->max_mtu still be 0
> can be confusing, so I set dev->max_mtu to ETH_MAX_MTU.
> 
> Here is the reproduce step:
> 
> 1.Config vrf interface and set mtu to 0:
> 3: enp4s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
> master vrf1 state UP mode DEFAULT group default qlen 1000
>     link/ether 52:54:00:9e:dd:c1 brd ff:ff:ff:ff:ff:ff
> 
> 2.Ping peer:
> 3: enp4s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
> master vrf1 state UP group default qlen 1000
>     link/ether 52:54:00:9e:dd:c1 brd ff:ff:ff:ff:ff:ff
>     inet 10.0.0.1/16 scope global enp4s0
>        valid_lft forever preferred_lft forever
> connect: Network is unreachable
> 
> 3.Set mtu to default value, ping works:
> PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
> 64 bytes from 10.0.0.2: icmp_seq=1 ttl=64 time=1.88 ms
> 
> Fixes: ad49bc6361ca2 ("net: vrf: remove MTU limits for vrf device")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---

Reviewed-by: David Ahern <dsahern@gmail.com>


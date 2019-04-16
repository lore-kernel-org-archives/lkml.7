Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6004EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1467720674
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="hk09RRut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbfDPPUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:20:55 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:45153 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDPPUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:20:54 -0400
Received: by mail-pl1-f171.google.com with SMTP id bf11so10487527plb.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 08:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wafwPr4pnFlNxyQt1YARUoSodWDIhEBmldevuEHONFE=;
        b=hk09RRutEdGEaqiA/Xxk0sSm2MHlYtdP0JGaoPRq/EFHRsxeAzYFB58ZCqG33AqOvJ
         +d7j8FDze6kDqCAtZVib9zAI6NI6Itmt2HpL7K4bH2Go9qfsWs6yMPXHTT4cZzvY0JlU
         euow+uakqlSvMJ6OgL+CXMrr7vq0qwR+XABdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wafwPr4pnFlNxyQt1YARUoSodWDIhEBmldevuEHONFE=;
        b=RqfRRjfXIQrWyXppZz50DU7SdRfASBniAWLHkZDH1jEVm4Csu09a9dQ28RMGOid44n
         xbuRcJfKPsI9WRyybcrmhwMx4frRBVzJ7FJkZNpjxiXRE0kqR2b82zBMneQxvBTtPX6o
         v5cFTFS3XYSO13cZmajWN4/FHVI5XtfKz1wgYIgOk+qor+p/VVr7EyFsLVvR5RfVat4b
         KCFE5zaHR0hxKMHDICCRo3JW+9crLqKHTQHBNIZeC9jl7gIy02HEy4/Bz8xcODwaGOON
         HgCzv9tsBIBThSVtK0DbigGBbhb3n/8jnUz9ghQWCHbIWyjkhVvSJB9O8qxu+w1G9yWR
         y1aQ==
X-Gm-Message-State: APjAAAWvT/2wnQvaA1ERz1b+BVVvMFq2on3BQlaKdpRRnrhidAWRci+p
        +QRxjpJ0fJy0+n4Cvh6r9JLU+cBOESQ=
X-Google-Smtp-Source: APXvYqyLwu8jVeYweDr/eIECdVKfGdw13T5Zjxdw3Jihi1Pwa43TFezZpQhw7yXP5QojTdei9FdHIQ==
X-Received: by 2002:a17:902:d24:: with SMTP id 33mr84752972plu.246.1555428053846;
        Tue, 16 Apr 2019 08:20:53 -0700 (PDT)
Received: from ?IPv6:2601:282:800:fd80:14a8:cdd5:560c:a7cd? ([2601:282:800:fd80:14a8:cdd5:560c:a7cd])
        by smtp.googlemail.com with ESMTPSA id t64sm117149399pfa.86.2019.04.16.08.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 08:20:53 -0700 (PDT)
Subject: Re: some trouble when using vrf
To:     linmiaohe <linmiaohe@huawei.com>, shrijeet@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mingfangsen <mingfangsen@huawei.com>
References: <15adf635-a74b-e9e3-5dad-b35890f0a746@huawei.com>
From:   David Ahern <dsa@cumulusnetworks.com>
Message-ID: <e4aa6621-8d9b-8d69-0562-610bae347ad3@cumulusnetworks.com>
Date:   Tue, 16 Apr 2019 09:20:51 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <15adf635-a74b-e9e3-5dad-b35890f0a746@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 5:26 AM, linmiaohe wrote:
> Hi all:
>     I meet some trouble when using vrf, it's very nice of you if you
> can help me fix it.
> 
>     1.If I bind a vrf address before I set SO_BINDTODEVICE opts to bind an
> enslaved device, "Cannot assign requested address" will occurs. It's
> because only after we set SO_BINDTODEVICE opts to bind an enslaved device,
> then we can lookup the route in the specified l3mdev domain.
>     I think we couldn't limit the order of bind ip addr and SO_BINDTODEVICE opts
> otherwise many vrf unaware apps many need to change their code.
>     I can't find a convenient way to fix it.Here is an example:
> 
>     ...
>     bind(sock_fd, (struct sockaddr *)&addr_serv, sizeof(addr_serv));
>     ...
>     ret = setsockopt(sock_fd, SOL_SOCKET, SO_BINDTODEVICE, bind_dev, strlen(bind_dev)+1);
>     ...
>     This code snipet doesn't work if the ip address of addr_serv is not in default vrf. And
> "Cannot assign requested address" will occurs.

Applications must bind to the device first and then bind to the local
address. As I recall this applies regardless of whether it is a VRF or
other.


> 
>     2.When I run a udp server in default vrf and set net.ipv4.udp_l3mdev_accept=1,
> it's supposed to work accorss VRFs.
>     But it occurs when udp server received a packet, it sends back with the source
> ip address from default vrf which is supposed to from the specified l3mdev domain.
> And the connection between server and client is broken. It's because udp server
> run in default vrf and doesn't bind the enslaved device, so only the route table in
> default vrf is avaliable.

UDP applications can use cmsg with IP_PKTINFO to send the reply out the
same device as the request was received. An app can also track the
relationship of the enslaved device to a VRF to use a VRF based lookup
to send a response. Choices.


> 
>     For example,I run a udp server in default vrf and set net.ipv4.udp_l3mdev_accept=1:
>     [root@localhost vrf]# sysctl -a | grep l3mdev
>     net.ipv4.raw_l3mdev_accept = 1
>     net.ipv4.tcp_l3mdev_accept = 1
>     net.ipv4.udp_l3mdev_accept = 1
> 
>     Then connect the server and send a udp packet to the specified vrf. Here is tcpdump output:
>     17:28:54.925417 IP 10.0.0.2.43003 > 10.0.0.1.irdmi: UDP, length 17
>     17:28:54.925953 IP 9.85.153.236.irdmi > 10.0.0.2.43003: UDP, length 17
>     ps. 10.0.0.2 is client ip, 10.0.0.1 is specified vrf ip, and 9.85.153.236 is default vrf ip.
>     10.0.0.1 and 9.85.153.236 are in the same host.
> 
> Thanks a lot if you can help me fix these. Have a nice day.
> 
> 
> 


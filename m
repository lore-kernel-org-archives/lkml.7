Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BB1C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F11D206DD
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0GRNG4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfCCQmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 11:42:24 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43603 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfCCQmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 11:42:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id l11so1322825pgq.10;
        Sun, 03 Mar 2019 08:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=s61eGubyBxFLA3ryAqqM7EMWO8TEI3XoBYevidbBmt4=;
        b=N0GRNG4LQXqPfcYYP+Ugfea//v+AAcin1w/J3heVX5yY1L1jslH/8NGG/WT+Wn2nUf
         fGriTgc1lx7k0zIu5SPtO/hkyfOfwTPB0IZbbBn/l6LSck43v3WUT9NQUAHfleNfW6Ex
         FskWq2ntFSW91yDcClr1xBENxunaWTqmVp4izUsAsFWCvyl3P3jGfzbXhjJLEsMboZwr
         HQyETRFeoIN3p9DyfBYuYnEnET8EqK5wNFvluXZZyVRvaDU1uF8lPgYUOZVGV/iRDKHM
         vJD/6KPDp+DgaPgrUIyZJm/YT+enUO4QENcmtCK3N1keiK3J+D22cldrBNpHZyVdhy2p
         Smsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s61eGubyBxFLA3ryAqqM7EMWO8TEI3XoBYevidbBmt4=;
        b=s4WzNGyce4bmhfgK7Fo5x6BAUjgfnK/avkvDS5CUMqWnu9xUZDvM/QLztW9IZjQi3R
         JYcXc7xU5pQzc1vA+X/GSp/p2tejXfXqp29PT3DVRoadmZ6X91EaASFekd5GDLLQyJdt
         b0PqteKQGNeKevwZLOJ3Ps7Qti78BAucfnGqaL48bebf44+XETHBrxSjU+0o1K6UGEsN
         Z1e9HoKdyzVhQfHMgj5t4azjFykbwdLRUMJI7nEryiV9AyTfe1fHuPIz1SsPgB2xNi7G
         Fi+kdv4v9hntJsmTEd8B1EzSXEpOBPiEWcR0cPAvZ4jb9tm4KJjdeToHSMVPo/m7h1X3
         41rg==
X-Gm-Message-State: APjAAAU4vMAJMqCY0LgDPRzy+KrlP2fBxfeDUZlRZeOFRRem6RtDmFPl
        5zHAzNsJMESrTTPH72qh6zlY8Uqw
X-Google-Smtp-Source: APXvYqyth9B/ud2FaD6fXLykuqazQVDIGoCvkbHTR5Rbmwe4AfRN9KswigyQei2qQ425VJz0pcrEQw==
X-Received: by 2002:a63:2d5:: with SMTP id 204mr14171893pgc.407.1551631342623;
        Sun, 03 Mar 2019 08:42:22 -0800 (PST)
Received: from ?IPv6:2601:282:800:fd80:89ab:3257:fcc8:dd7e? ([2601:282:800:fd80:89ab:3257:fcc8:dd7e])
        by smtp.googlemail.com with ESMTPSA id q7sm7323086pfa.119.2019.03.03.08.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 08:42:21 -0800 (PST)
Subject: Re: [PATCH] net: ipv6: add socket option IPV6_ROUTER_ALERT_ISOLATE
To:     Francesco Ruggeri <fruggeri@arista.com>, yoshfuji@linux-ipv6.org,
        kuznet@ms2.inr.ac.ru, davem@davemloft.net, maxim@arista.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20190301233103.B4EE095C2D16@us180.sjc.aristanetworks.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <78f99c4f-ac7b-4569-b3c3-bacc191e6bbd@gmail.com>
Date:   Sun, 3 Mar 2019 09:42:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190301233103.B4EE095C2D16@us180.sjc.aristanetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/19 4:31 PM, Francesco Ruggeri wrote:
> By default IPv6 socket with IPV6_ROUTER_ALERT socket option set will
> receive all IPv6 RA packets from all namespaces.
> IPV6_ROUTER_ALERT_ISOLATE socket option restricts packets received by
> the socket to be only from the socket's namespace.
> 
> Signed-off-by: Maxim Martynov <maxim@arista.com>
> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
> ---
>  include/linux/ipv6.h     |  3 ++-
>  include/uapi/linux/in6.h |  1 +
>  net/ipv6/ip6_output.c    |  6 ++++++
>  net/ipv6/ipv6_sockglue.c | 10 ++++++++++
>  4 files changed, 19 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@gmail.com>



Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3783AC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A6922AED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YctGd6NE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388624AbfGYDWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 23:22:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35873 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387752AbfGYDWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 23:22:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id z4so47752860qtc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 20:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7ShvDC3DRx289o2CON/ZG1R7PVjHyyeC6C/VPB/VWoE=;
        b=YctGd6NEPdOBJvo3F1CLLFeQj0m7HIaBITggi2rmoo558fyoyRuTogrfhp+FUugY+G
         AYa0D/zmlxgpbeUoLkQx4Sw28wwBVVOouaKJACoyg9C6dvsfYsk2zWQiRIBbp9b4VSIQ
         ORmD7aCRJNbmpDJiwzT46X+gpHlYHnPB+qYgkJ1DlIdz/fAO55B9dSW4qQ8lqMkg/bzZ
         Y9GEfdzPUqyKUonLr3PpxKGt5JWfaSPwl9PPTYFF86sV0eoWTBwuoiLLpH4jXVYoIfhU
         tvzVaUDEOmUwMfkn703ghLk4iRNriXPpVRhWCRZP7TP9q8lE/cIrfMpERZzHZr9Azil8
         itGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7ShvDC3DRx289o2CON/ZG1R7PVjHyyeC6C/VPB/VWoE=;
        b=p3funuKsqfoBdGUqEi/JQs+xJGhnb/P9Vrdvz1UcZaCtm+yV2LEfCG70CqI+r6gv2K
         fAucCe8vtwqC7kjOhL2w7Wf2Amxp6JXoMBBlCi+mg9MJYmQ70XhHdIROHIhp5xCCfOeQ
         8AAclHkLaxmmm7ciGhgTNFwO+2LH2Aot4YuGuz3KwUtlVk7zmd+M0WFDeMIXJhqvuNy9
         uKO8CmRVFe/Lg+ws7aw58gpQAd54GPemkKztVu3Vajdfp1us/xEKjyBmxpGbCVhmt4VF
         GW5BRXoHLGISFFZZ9qQmqyVn1Kai9Gby31jkYvEHlZWMQg9hx5yFHPjhm/uW4biM+UET
         6PYA==
X-Gm-Message-State: APjAAAXOOLrD/L/AHf5V56augwYaKd7bdfD/kHuaL78WtqFpytWWdl1Z
        4/3jlF+0dhFsh73/dXPi1RyvAg==
X-Google-Smtp-Source: APXvYqxL2A7Dd39QkyKn10UQ1uUAQP59dYx3GoLGtvNWpCctFtJgncxRvhOaoX4tEqTZwcfh3OSJzg==
X-Received: by 2002:a0c:b159:: with SMTP id r25mr60129104qvc.219.1564024936607;
        Wed, 24 Jul 2019 20:22:16 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r189sm22155341qkc.60.2019.07.24.20.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 20:22:16 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] asm-generic: fix -Wtype-limits compiler warnings
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <14026.1564004959@warthog.procyon.org.uk>
Date:   Wed, 24 Jul 2019 23:22:14 -0400
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jakub Jelinek <jakub@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, morbo@google.com,
        jyknight@google.com, natechancellor@gmail.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <209DCEDB-98B4-4D57-8F2C-0B8F0406B5CB@lca.pw>
References: <1563993952.11067.15.camel@lca.pw>
 <1563914986-26502-1-git-send-email-cai@lca.pw>
 <31573.1563954571@warthog.procyon.org.uk>
 <14026.1564004959@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 24, 2019, at 5:49 PM, David Howells <dhowells@redhat.com> wrote:
> 
> Qian Cai <cai@lca.pw> wrote:
> 
>> I have GCC 8.2.1 which works fine.
> 
> But you need to check the minimum version, i.e. 4.6:
> 
> 	#if GCC_VERSION < 40600
> 

I did check gcc version 4.1.2 20080704 and it works fine.


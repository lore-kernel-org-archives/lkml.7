Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09AAC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C150B214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Noa7Ufr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbfHEQvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:51:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41453 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfHEQva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:51:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so36567138pls.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5zUWHx+LrFV3C0bnUHT30FHcGUBfZsb1VG1F9+ZjuoA=;
        b=Noa7Ufr0hVzoayXF9x6jJGFsbhvr3vPdtarSirGSnvURIOQ51qw48ykBpQ2cMrCaXY
         VGAyV5mJymfsjTnexQ0I5YQc7lUuJv2hLRZWW7MnBIdB6bK0mOG6I4C0jYgrJ1PaPT2t
         9A8GUROtzX1bKw4or1409wz4OFpwoQNfItdOkEZODX6PPxFzLptEVbLdix1h/KrFFmXA
         +VTeWUlGM3p6hkUStIeyrfbS/PSoihlkv25+JmiDDG5Hqe+KIvTSbLV3I4YYrfMTff3X
         IVBiGJpZDLtLsVX37F95PDgym/piSyNhgaLYSHZHjaXykBf+jS4ZyAfg52GMzhrLo9+m
         fe9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=5zUWHx+LrFV3C0bnUHT30FHcGUBfZsb1VG1F9+ZjuoA=;
        b=OM0AtL4foEJYJFh4K7ROT1xNO9uDCOuCG3Ew4vn2dcxpa+kuD6Qva8kmmhcs+YKJ+X
         e5LwZ0cO9P5kMEe63551yuaxAgW91SvcthFDjIS+TjGy5/LbhLhI0u2LJUwGtxD07+pN
         FambsUTz6sO8y86eCaECsMaE7PLwGHLPNZ2OJRhwF+Nq0d/ZAaRO6uZI0hbjJi+NYXhn
         Jj3ocBgg9BG5xRVBskDVDMGM/iagAw4XzbS0qMEx+fzPf6+dSflAj8b0Sjce3oziRo10
         QSnDt2pRbfNfY0zpIU16ji9wSYf4InSBnciQbFQxZRiWGd7eQ+JaDltwbZ3SWm5cf+hL
         LIYA==
X-Gm-Message-State: APjAAAVzFWfVpxYk87mdoDBERZNC2QXDnAklzPDCe5AV4hMs+D32eKlC
        n4K3xan+uGsJETSxcMlvC+YU+phx
X-Google-Smtp-Source: APXvYqzy81fXkuMzGoTo970O0q9C01wGi1nra3HSIGZbYZyP5dPsGPB0G3HBOYoKGbcSB28d1WfAXA==
X-Received: by 2002:a17:902:244:: with SMTP id 62mr50990084plc.243.1565023890066;
        Mon, 05 Aug 2019 09:51:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s24sm85105440pfh.133.2019.08.05.09.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 09:51:29 -0700 (PDT)
Date:   Mon, 5 Aug 2019 09:51:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page flags: prioritize kasan bits over last-cpuid
Message-ID: <20190805165128.GA23762@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 09:49:02PM -0700, Arnd Bergmann wrote:
> ARM64 randdconfig builds regularly run into a build error, especially
> when NUMA_BALANCING and SPARSEMEM are enabled but not SPARSEMEM_VMEMMAP:
> 
>   #error "KASAN: not enough bits in page flags for tag"
> 
> The last-cpuid bits are already contitional on the available space, so
> the result of the calculation is a bit random on whether they were
> already left out or not.
> 
> Adding the kasan tag bits before last-cpuid makes it much more likely to
> end up with a successful build here, and should be reliable for
> randconfig at least, as long as that does not randomize NR_CPUS or
> NODES_SHIFT but uses the defaults.
> 
> In order for the modified check to not trigger in the x86 vdso32 code
> where all constants are wrong (building with -m32), enclose all the
> definitions with an #ifdef.
> 

This results in 

./include/linux/page-flags-layout.h:95:2: error: #error "Not enough bits in page flags"
 #error "Not enough bits in page flags"

when trying to build mipsel64:fuloong2e_defconfig.

Guenter

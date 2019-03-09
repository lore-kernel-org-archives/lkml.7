Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE52C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 09:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEC62081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 09:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTveXR2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfCIJdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 04:33:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42481 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfCIJds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 04:33:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id o9so617330wrv.9;
        Sat, 09 Mar 2019 01:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ZMpvnNRKtD17ogPtlW+/K+fSjIoK61tc4vDBA5gNK8c=;
        b=RTveXR2dpo/g0PbDFZZkXhIyMi+2Nt+7uIfhSH27A4ZEvykMN3lOSCRJA3r67bAUCX
         P8/OknzK6CE3sf/zKz1QRyPZqz724kfviKt8tbxn0fHy5qMMCoE22B5wab+ExwXEa8HQ
         yPuDjUPCt2ptxxUv4Ms8HabhLVTsEcGeu13wGJwjmX89COzm+EhGAGvrm4lsqpr0P1aA
         KsQcWxKCMp/N5GG3su8nZg06v63FpmltUIAjn0tmq/rzu+FhQ28SZ1vyR1UKe77SaZee
         zU+OsrIitf0DPdiPhVbofC3QnXC55IkqJHhpk5KpKsrB22w/udnTIe08haOiPLObVt5n
         UYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZMpvnNRKtD17ogPtlW+/K+fSjIoK61tc4vDBA5gNK8c=;
        b=TjSRtuFHsfJ6S9STxnvdeiaCw2KpD9TSOmQtDxSy7uQCkRj2LEwHEF4bzt7L2mk5cA
         ic9L5kePwowTTKJb/beV/QemCUckyL9HoOoUyI0G8iT7MHog8YlxPq9fbWOTRkDJEZp4
         2CZUnTTeA4HL/qV/c+4FdthSEamsuAOKYMHrQdNZ2fkl7SHijd7GJY6MAXrmNPWGGIke
         GUkGJBkfxK/Knhx0cKWVwxvonW/ahaVRYyrDgrlf55U8CLu8gl9cxvRmfbGlEEXYBCqQ
         F5fmJ+LyyJt5ApmSTSJt7djtn6i+vMneQYVDNtyBfITbz7BmGlz3k9OkoJmHxcLQOLbN
         evPQ==
X-Gm-Message-State: APjAAAVoXaL7yLm1QUihYaki42lOnTndJDmq/zC7qSFAK/GdRUJuFj82
        +eBHGTveGcIM9mG6K7kCfB8XfhzP
X-Google-Smtp-Source: APXvYqxAvYiILZqcz0ylt9D+B1H5fHU5U3yUumf/Aa0024yNEbvC+mRG43pJca1KoTHTHQESVOM5Ow==
X-Received: by 2002:adf:e442:: with SMTP id t2mr1053216wrm.256.1552124026402;
        Sat, 09 Mar 2019 01:33:46 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:e5a9:d663:1bfd:34e5? (p200300EA8BF1E200E5A9D6631BFD34E5.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:e5a9:d663:1bfd:34e5])
        by smtp.googlemail.com with ESMTPSA id s127sm7740630wmf.39.2019.03.09.01.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 01:33:45 -0800 (PST)
Subject: Re: r8169 only works in promisc mode
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1552097324.u2rpi5lxaz.astroid@alex-desktop.none>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <82c0ba0d-c7cb-32fb-8e0b-2191b8678c16@gmail.com>
Date:   Sat, 9 Mar 2019 10:33:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <1552097324.u2rpi5lxaz.astroid@alex-desktop.none>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.2019 03:16, Alex Xu (Hello71) wrote:
> After suspending, my r8169 (not actually 8169, just that driver) only 
> receives packets when in promiscuous mode. I have tried disabling all 
> offload features except highdma [fixed], and it doesn't fix the issue.
> 
> I am using torvalds/linux, compiled about two days ago (not sure which 
> commit). I think this happened after a recent upgrade (some time in the 
> past week). Given the long testing cycle, I don't really want to bisect; 
> I am hoping someone has some idea of where the issue could be.
> 
The provided information isn't enough to say anything. Please create a
bug ticket in bugzilla. Needed information:
- Last working and first failing kernel version (as reported by uname -a)
- Is 5.0 ok?
- Full dmesg log
- lspci -vv output for the network card
- If the issue happens only after resume from suspend, diff of the
  chip registers (ethtool -d) before and after suspend.
- Does removing / reloading the r8169 module fix the issue?

> Please CC me on replies.
> 
> Thanks,
> Alex.
> 
Heiner

Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A381EC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B5A21874
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1Iu4PZ+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfHaCyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 22:54:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39009 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbfHaCyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 22:54:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id az1so3200683plb.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 19:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wAWfdwIa59FDP4d1Sh8DtaH6oUROjcWqQZupPqcqAko=;
        b=1Iu4PZ+xk9yt3s0D5xhvqKUGEHHu9DM1d65KGBVMvEiz9DhyqIyBMcTYJtRcIEm1g3
         lQjhAWj6DbYiG6V+4uoThTxI0JHqKMokBIP6+9QpYRq226/0uo+Ja/pP5LpSqSTPDYWX
         QVEYAPZeCSYenj4l2o52rgSwaxNXGdhF/THZz2hqMJg4hx2oY8NPsoPEFmnK/VJ8ijgX
         m/R8ut11iMO4feH3teYhqmlrFob46xKCNI/aD/dg8B2a9xtQK1rFMYIKVQLNJiEnkDjE
         W1O1K93AvNkjGKO3tJkNz3lcf8lj0IBgxFwxh2yv+4NuZ+UFouITThRT4Vfz75qL/kLG
         9Gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wAWfdwIa59FDP4d1Sh8DtaH6oUROjcWqQZupPqcqAko=;
        b=N8r+4gBrI0g++LdrW/KNe17ifWu5/ray5ktIZF8ltVFNDPP5SVEoS8F9RK+sGD4RdB
         mPRUxewOmYN4c2/KxY47o0UshEhttBKMnN32SwLEvMNI47v+QyoxwYnEh+fqeJg7pEHp
         VKl16062jy/NaO2p0KfpNzttdwfdeskbQYLnzjx0+KI0NmL3hmmfvYXCv08doMnFPYhy
         TXWwfJ9Nukh7GOM7h7rc4xO7tmmIuemp1SoUkHv05qsQkL1G84O6X23oX4o14MJNbg/n
         O2v1OrFvUNu0ECvCZLjecpGOiOnrj0DrwDcmBBIceTF3Nhq9NmxTTV/iIndzD1u8JN6e
         9Vvw==
X-Gm-Message-State: APjAAAUJt247rJLbkCaKVmBux0vr1wTLaIcyyzZbzaZCm2BODvij92Bx
        8zCivSlRIFM7w1Iy3KGrnqYEX+VoJbwtfQ==
X-Google-Smtp-Source: APXvYqzzA4EqNb2ZgfIiSGQbashFjxYR/2tcDPaOc1UoZOOiyiuG70N7dHLix0LHokxF9YEOJ7nNQw==
X-Received: by 2002:a17:902:85:: with SMTP id a5mr19762477pla.213.1567220047902;
        Fri, 30 Aug 2019 19:54:07 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id e2sm8130595pff.49.2019.08.30.19.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 19:54:06 -0700 (PDT)
Subject: Re: [PATCH v3] libata/ahci: Drop PCS quirk for Denverton and beyond
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Stephen Douthit <stephend@silicom-usa.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <156712139395.1614755.3489977733530873708.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <73e48d44-631a-71f9-4437-292c5b480891@kernel.dk>
Date:   Fri, 30 Aug 2019 20:54:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156712139395.1614755.3489977733530873708.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/19 5:30 PM, Dan Williams wrote:
> The Linux ahci driver has historically implemented a configuration fixup
> for platforms / platform-firmware that fails to enable the ports prior
> to OS hand-off at boot. The fixup was originally implemented way back
> before ahci moved from drivers/scsi/ to drivers/ata/, and was updated in
> 2007 via commit 49f290903935 "ahci: update PCS programming". The quirk
> sets a port-enable bitmap in the PCS register at offset 0x92.
> 
> This quirk could be applied generically up until the arrival of the
> Denverton (DNV) platform. The DNV AHCI controller architecture supports
> more than 6 ports and along with that the PCS register location and
> format were updated to allow for more possible ports in the bitmap. DNV
> AHCI expands the register to 32-bits and moves it to offset 0x94.
> 
> As it stands there are no known problem reports with existing Linux
> trying to set bits at offset 0x92 which indicates that the quirk is not
> applicable. Likely it is not applicable on a wider range of platforms,
> but it is difficult to discern which platforms if any still depend on
> the quirk.
> 
> Rather than try to fix the PCS quirk to consider the DNV register layout
> instead require explicit opt-in. The assumption is that the OS driver
> need not touch this register, and platforms can be added with a new
> boad_ahci_pcs7 board-id when / if problematic platforms are found in the
> future. The logic in ahci_intel_pcs_quirk() looks for all Intel AHCI
> instances with "legacy" board-ids and otherwise skips the quirk if the
> board was matched by class-code.

Applied, thanks Dan.

-- 
Jens Axboe


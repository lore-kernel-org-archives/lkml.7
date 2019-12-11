Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C393C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE2020663
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="t7H3sISS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbfLKSWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:22:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42335 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbfLKSWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:22:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so2193497pfz.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 10:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RkNs2t3UEkW3eFHdWggF1KRZU/VQFWaxx2FeTq7CMSA=;
        b=t7H3sISSpXFfclR1GAE/erR/otbe62H4DKa+Y3Sgup7sllKOsyjd3c7iIm6Wi1mrBJ
         yfBFKbEnRGu4I/RgBKfEZLGMoOS6h5A+2m8rPUpgkthZ03Uoy9UyxR6JI7VBr3z/HS2b
         o4OyXoGguGXkCsySmLVaOXGcZLLYy0j90HUGlNx4+OV0lepqjK0XKAyneYz/rxMITkHx
         DjGtKN/G0HS6m0OzzccKJHC3AVJEl0zmkb21XBAp/AGqBtBwS9dGAoH14vDDfzGa84gN
         kxUNAj3u4cWptT8q1G4lGwVGV45w5XDbZlFMGS8ClGGa5cv9lDGD8ibdqtr96QVTevXL
         Jzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RkNs2t3UEkW3eFHdWggF1KRZU/VQFWaxx2FeTq7CMSA=;
        b=kZU12siwUsbp8O9e1RtMG8IwX3BezkDl1IRc/7pDrxUf04ZhHjgk4PsUiXHBihmXcN
         a+FS+Ruuubl54jKhtEAFSnIA8n56ICz+gzFXISiwD3cQX/AbFcsteXFWMdXDmRYlW45W
         LxUubG8tJ36+p5bUplqMg5qw86NzTBl/J3gorokygRFYFqkDFI/jYbktCQxu1auKZMp1
         lSlam5ws5Z4A3JHpbwUNnlqPOMbOzAD+7vtev4P0v/qmO0TFWolvC3UyJpLqQIuFEcvm
         r+1XNezO0cVSIcCshycyDEs6/tGpFmBYo1868oU+1XN176MSU/1kCeDQVRqQY+Htm728
         mqbA==
X-Gm-Message-State: APjAAAVrHweiVVxWzpjp+3DZ4uEcxwnbhEbYHz3ffip+sOb59iNFKigX
        ch3SQqJUaZxV77XqFf232it7fA==
X-Google-Smtp-Source: APXvYqwAVfLzn1Ufb7zEMca9k/Ps1NCNDpmvUl1LS7lV/sPPO0wTldiIigBCQbtSd9Az3j6K8DL9YA==
X-Received: by 2002:a65:6088:: with SMTP id t8mr5702029pgu.329.1576088537967;
        Wed, 11 Dec 2019 10:22:17 -0800 (PST)
Received: from debian ([122.164.82.31])
        by smtp.gmail.com with ESMTPSA id a12sm3482648pga.11.2019.12.11.10.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 10:22:17 -0800 (PST)
Date:   Wed, 11 Dec 2019 23:52:11 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Will Deacon <will@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PROBLEM]:  WARNING: lock held when returning to user space!
 (5.4.1 #16 Tainted: G )
Message-ID: <20191211182211.GB13799@debian>
References: <20191207173420.GA5280@debian>
 <20191209103432.GC3306@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209103432.GC3306@willie-the-truck>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 10:34:32AM +0000, Will Deacon wrote: 
> Was this during boot or during some other operation?

It was during boot.

--
software engineer
rajagiri school of engineering and technology


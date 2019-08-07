Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBCCC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D786F222FC
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JmLeqOSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbfHGQm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:42:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36464 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730010AbfHGQm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:42:29 -0400
Received: by mail-ot1-f66.google.com with SMTP id r6so106837694oti.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 09:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=OgPFf4sieXg6FSqMl/7z/egdCX4CBj1LSh4wy9vZMd0=;
        b=JmLeqOSpk6X4jyeXqVA19M/C3q/EQo3ixua/k4pXgGjJwizYMK6DOHHGeTu2QRx/pi
         Ro6gORNTivgGAzBqKHMOi6pxTU6w9aBJvqX9Fb5Gld/zqQwBjnBNtdJLJLnJ52YmH3h7
         3iMK1Jc5RYXTOjx4i6Sio2583eBQKPfXxxjPxdrEvbSa/sHg4qqiDQOHPqcz1oP0BYmg
         FE3H1oEzL/VB6Aw0e6BRldwbFwDDMlhOYKZfdZhp3xQkRsxDQesVNcoAM4MsHJo6QJvo
         CCQOw2mSAvxoEsAG0/vXJqzqrT6cEzp/+RPkNaviB0duB+yaeTDzaoLHoInsr3WUDZnR
         dmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=OgPFf4sieXg6FSqMl/7z/egdCX4CBj1LSh4wy9vZMd0=;
        b=cIRa5sXf6Md0eMVPDmqj72gTUWlqhfhNZl0ko+PZXDqmwGbLFZHtHro4Neoxoq6qvl
         rlvUD4quBrbnSQ6X4bfh9q6Pk+DtGbUAghjbatrges4ZgT/4GOnVDx1UsUf1aVlmI5mx
         bK/IyuxugDtQl9ItnBbwGDTvXAMY+7X7DPiGUO1ZnA8LSeTvi3DOdsWP6zYxohF+pLMB
         Auanx7i/+DmeiRtHlvV20FvwVtoXD86tNXWC3+YHAqlB/c1pV4gDb5YNK53wVdABpuxd
         WGdNVq8tzV91c3RmuWk10/FYVK0KJ/IuaZDhy5a7lDEOUXLXzSSKMBwokH02ZYq53DaY
         0aRw==
X-Gm-Message-State: APjAAAXYiuqSzTY7RCRpBd/CDG7w4Xv2PDC/iAjvs7YRO89z0YbdFeQz
        GWB/Wo+TcwkENU7pJA+PhVceVnroTDw=
X-Google-Smtp-Source: APXvYqwm/dtouaS2YDkg4nuZf7fonnO8dwiBe2IToY4UY/xI3nlngfUW1dUQIVzDV+FS9qhrZgGcjA==
X-Received: by 2002:a5e:9314:: with SMTP id k20mr10575140iom.235.1565196148444;
        Wed, 07 Aug 2019 09:42:28 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id n26sm66735984ioc.74.2019.08.07.09.42.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 09:42:28 -0700 (PDT)
Date:   Wed, 7 Aug 2019 09:42:27 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Alexandre Ghiti <alex@ghiti.fr>
cc:     Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: kbuild: add virtual memory system selection
In-Reply-To: <c331e389-5f33-634a-f62f-e48251ca4cfe@ghiti.fr>
Message-ID: <alpine.DEB.2.21.9999.1908070940110.13971@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1907261259420.26670@viisi.sifive.com> <20190802084453.GA1410@infradead.org> <alpine.DEB.2.21.9999.1908061648220.13971@viisi.sifive.com> <20190807054246.GB1398@infradead.org> <c331e389-5f33-634a-f62f-e48251ca4cfe@ghiti.fr>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2019, Alexandre Ghiti wrote:

> And FYI my series and your patch are already in linux-next.

Yes, I agree with Christoph that it would be preferable not to break 
randconfig/allyesconfig.  So if you don't mind, could you respin the 
RISC-V patch to drop the Sv48 portion, and simply assume Sv39 for RV64 as 
we do for the rest of the RISC-V kernel code?  We can always add Sv48 
back in later.

If you agree, then once you do that, I'll ask Andrew to drop the RISC-V 
Kbuild patch that he's carrying.


- Paul

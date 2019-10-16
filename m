Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BD1FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D652168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="jw4mP6Ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390425AbfJPKfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:35:40 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36198 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbfJPKfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:35:40 -0400
Received: by mail-lf1-f67.google.com with SMTP id u16so4443235lfq.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 03:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TPx7rPA0Br+et5o6KmRStGO/myFB8ZhOgy82/e79ydg=;
        b=jw4mP6UxdbKOn1Ax/5Lz6J3Yf5tVdATs7EvlFAJS+GhYi7/834ey8w/GvLQpLeZVc7
         7Mb3IXhbnQSlm+QXZ3MZ+nckKcixkU87Dmfefg2Z9rz8pDIfZBDL+OES3N1PpeYo6xU8
         PNyU5vrMcL2T8PAlZ7u7qD0H1U6OF5fCcn7y7a3kIALA9Bqh1plMD2Y9HS6Mm00vbv7v
         xjKALcfBL8p4Z6xSJDAwiS4oeDHxeJA6eDNAP8saYrTaPW6uq2jHilKFYwB8ptI5KkAz
         zT8lgn8Vk55SVZ90xAYBKzEcFI76nh/U52ixpe6wlEk/hmGMD2fliIAFd31J/AcanEeZ
         Jw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TPx7rPA0Br+et5o6KmRStGO/myFB8ZhOgy82/e79ydg=;
        b=b1PQs1ThwZ+YzzIozjBSZOrlqHPK8FET/L9Zy46SEdoActuBrtAICOpx6lxbKJlNtw
         uXEXetjPWSp5KDF2GDKnnXLihCdhGRJY3htzTtFVi3fIk4nDMYfuHQkQfzZiw4PCIYH4
         uevlI40zNJ0vh8BUnYh39r+hjZ45zC1pSn+iXOv0hmfDoZfHIdHGhjkUiCiS02QBLo8W
         QLZ+TANTIY9f+tZH3IcXWkfh5fsTTXR7nz8QrfWf3cDUFQ+7rDeY1hAGXY5gpty3iXCu
         86MzyIAxsVKHAjr2HNQ6FR6BFznsk1r2/+xLAV6kLyO2NnUzGOtXR5uhxt1v1YVEJjG7
         he7Q==
X-Gm-Message-State: APjAAAX8Vps8Avx4pXilhzckv2RsnRxDug2krIi6RLdTuI6LXPacSF4+
        yU4fT9tQo2UiBB4tXwNMv6sCDA==
X-Google-Smtp-Source: APXvYqwEBdxAChMVVBFlmc6eUXtVvNheuH3e0SluP3ca6bXyqt8wHnILm5brTVtYux5zecvFFwwvVw==
X-Received: by 2002:ac2:5dc2:: with SMTP id x2mr24763989lfq.38.1571222137941;
        Wed, 16 Oct 2019 03:35:37 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k7sm5791404lja.19.2019.10.16.03.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 03:35:37 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E4B6C101F90; Wed, 16 Oct 2019 13:35:37 +0300 (+03)
Date:   Wed, 16 Oct 2019 13:35:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 5/5] asm-generic/mm: stub out p{4,d}d_clear_bad() if
 __PAGETABLE_P{4,u}D_FOLDED
Message-ID: <20191016103537.oeanj7nh7u7yhk7l@box>
References: <20191015191926.9281-1-vgupta@synopsys.com>
 <20191015191926.9281-6-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015191926.9281-6-vgupta@synopsys.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is couple of typos in the subject of the patch. It has to be

	[PATCH v2 5/5] asm-generic/mm: stub out p{4,u}d_clear_bad() if __PAGETABLE_P{4,U}D_FOLDED

Otherwise the patchset looks good to me. You can use my ACK for all
patches.

-- 
 Kirill A. Shutemov

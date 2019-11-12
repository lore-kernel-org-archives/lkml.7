Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32FFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBE921925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FI3KbRHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfKLUDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:03:42 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37962 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLUDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:03:42 -0500
Received: by mail-io1-f67.google.com with SMTP id i13so18829458ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 12:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=s6f6V9n9AywCqtlEYD7ABikPaw5vUXYnibhyxVKqtTI=;
        b=FI3KbRHfRf+nC8+rlZL1sJKyQkdQpR3nunm5rzuIx7J/wP4BIidljiEeYtuV1WWy7d
         UuLVXa62DtNgMvtQCO72iPcYczgpnHqzMS+P3qwLaTGi7AakL7QVz824+Z5jGY/z708p
         2Ph16hPTcM5pUj0WHhwKIPGAm64TSfUMdM9MCqc+pzfYxG/vj8EcxElggHobyAGLj1m9
         3Ei9fjty5Ly9YbHY7G/BVq0q9592QFnPARPeWUMUlUgEnSvkey6+8Aw9OKtL8wLZx1n4
         A4tQifg6EFB2Hsi+1TvehPBqk7ytj65+tyhbUKtgXRCUBSHOU9zsmw+EVYfptHS3hRkv
         lyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=s6f6V9n9AywCqtlEYD7ABikPaw5vUXYnibhyxVKqtTI=;
        b=MkTo0EJihvxTRTcKDqaDyS3aDCcOvW5m2nqg3O1aEqkAWkiJuFGEAI82M48El4vCqk
         DLhKmwsTxuZujCuRdtB1J1IQ4NbEc+qZRTxisrJIi6IGDxJFfvARrEVyZ7n/nQw/cV9o
         cfMSX3wDsOFgdBA9aArKYeYLw6tLWPVuwJO2kXjiGXrG5GxGU1ngs8BPSkdkJ0TnVdCq
         DiSNrPTkBUJWMJDoCn2PidAzYPf/ES9wzecCts4kZ7yxB0L0iTLVSMIrZKXCMAY9lCYg
         nlUEH5EFS/CCAnZBtYe5soqbAnJazgKIKY0Kcuq4D2l3QKMcXseXVsDnwFqR6qr40e8t
         iW1A==
X-Gm-Message-State: APjAAAXqEPdLRDq5vG6F5qf7URQcuHXFV4zXB0FsFa5o+K9I65CnA/Da
        puDFJe0aMKgROCXQkIhKl5EA7A==
X-Google-Smtp-Source: APXvYqzq4/vbp3I/o6aATlo+eszztTxJWdwpSjwumuT3pBQU0j8t5mCBgwjzR1iiTJmgS/ieiu5DcA==
X-Received: by 2002:a6b:b2cc:: with SMTP id b195mr986981iof.21.1573589021434;
        Tue, 12 Nov 2019 12:03:41 -0800 (PST)
Received: from localhost ([75.104.69.238])
        by smtp.gmail.com with ESMTPSA id c6sm2713259ilr.24.2019.11.12.12.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 12:03:41 -0800 (PST)
Date:   Tue, 12 Nov 2019 12:03:33 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Zong Li <zong.li@sifive.com>
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, anup@brainfault.org, hch@infradead.org
Subject: Re: [PATCH v3] riscv: Use PMD_SIZE to repalce PTE_PARENT_SIZE
In-Reply-To: <1573203640-6173-1-git-send-email-zong.li@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1911121203150.32590@viisi.sifive.com>
References: <1573203640-6173-1-git-send-email-zong.li@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019, Zong Li wrote:

> The PMD_SIZE is equal to PGDIR_SIZE when __PAGETABLE_PMD_FOLDED is
> defined.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks, dropped v2 and queued this v3 with Christoph's Ack.


- Paul

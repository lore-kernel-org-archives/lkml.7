Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68505C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36930217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eL4lIcmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbfKFTAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:00:09 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41146 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfKFTAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:00:08 -0500
Received: by mail-pf1-f193.google.com with SMTP id p26so19619021pfq.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 11:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rO+IauwMGdgaps0ucduNU3H5J/6BS8Jkm16fDnKR+To=;
        b=eL4lIcmqkWusaAGmp02ncwkbxgTL4yMKeWUr+mzAwtW54bYNR1ni7i+r/J8NYEJVp/
         sK3/+Qjl9hQUHxuzlSj2e4blqI4r+fU2JAjP2husqslwAM/x/XYUYqgEe64pMmEBqilL
         FWbCncRVlx2G3K3tlbg41bwF+eGxOE5vUgJdZZViavo4iGWaEFMqHPzAOJbJOvHtzITt
         sUlEAct93wbBYoY8dT1Y7Kbs3ISnPoR5tPodYkAh1+gFndBmchQUkI5cCqeZwQWpPhtU
         DGyrIr6+Bhh2ybD/I+pEmHE5CkQvNIjG4J82+6xalXHo2r5XOqwSszq+55CHDiEHipxs
         BPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rO+IauwMGdgaps0ucduNU3H5J/6BS8Jkm16fDnKR+To=;
        b=Z8aJv7ZJVCoa9cz/Hrw8ybPP8E+B2/0mgy1yWMyuL9PZ0i0ZYy6jLn4OcKhBf7AdvV
         rs2t0kN6dudbTDmYXIFsp/d6kikVZ0QYcdQ3VMRFbSdJdSEhm6Y75Bu05opvgVWIWtPR
         WQW4AquWGtozdgKO5Ccfzk8rNnsHt5zNgYnPsHvmqO40Ty+7sFsZwxEZtiS57g6kjhIp
         ck2SgcqhuTnpaCe/hsWmRTM2EkEK5IY8o2JD1hi/y6h74To6ydDobc+zOjwj91PVDyBV
         w3WVFFNFutJhdat3DUKCT6fVkPpXaje1nfL3dIgmOjLCvqpGA29YVu2uD2wuW725BG32
         bYdA==
X-Gm-Message-State: APjAAAX0CkFRnSHO2OZ5WtbbWiUTT8zNkH7tvB3sm587gw9Il7IxyS7I
        FgIZdBbkPdFXKB2mhfl2TA91TaEE+9g=
X-Google-Smtp-Source: APXvYqzNSDigwU6xgzfjskX2HjwUGhvaq3NRBRwrZvIRrwf8p+EzTP7vyJq8epLKZN3rqxpyUFm4Og==
X-Received: by 2002:a17:90a:1a52:: with SMTP id 18mr5688274pjl.26.1573066807979;
        Wed, 06 Nov 2019 11:00:07 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id i126sm26724495pfc.29.2019.11.06.11.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:00:07 -0800 (PST)
Date:   Wed, 6 Nov 2019 11:00:05 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Zong Li <zong.li@sifive.com>
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@sifive.com, Anup.Patel@wdc.com
Subject: Re: [PATCH v2] riscv: Use PMD_SIZE to repalce PTE_PARENT_SIZE
In-Reply-To: <1572920412-15661-1-git-send-email-zong.li@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1911061059420.20606@viisi.sifive.com>
References: <1572920412-15661-1-git-send-email-zong.li@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2019, Zong Li wrote:

> The PMD_SIZE is equal to PGDIR_SIZE when __PAGETABLE_PMD_FOLDED is
> defined.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>

Thanks, queued for v5.5-rc1 with Anup's Reviewed-by:.


- Paul

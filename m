Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312A6C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02F82084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAEEIYfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388743AbfHATny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:43:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33245 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388732AbfHATny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:43:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so4384433wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 12:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ip5LJvSWonzgpjcBCxCiwSmzzSy496hPUaAkxCkzgAQ=;
        b=lAEEIYfd7FgFY0bLugCEaeuMOFEgEKfx4fYCE/16KHfc9pkko9MT6Yr0JJK+byJ8fZ
         SPLPveSZifYUIdUpX6TsCgEA2c3D8pvzFQ6ey8/x7plN7y75cGK4Z1lwgDeQhdtzpDKX
         6wVVwmqPx1AbltH8n68I2FGsYL0V/bOoOQFE8/E4VBW+qhcivY4tWYyzC1dXwG+wtos3
         CrzcH1eP53hdfrjwkXed3/TdDwPbfGercCRmEJfM+M8ztKMAFFEW6jQOYnNjTN8sJucV
         mkuyZSl8RM68FdKhu7jMkLRCT07dIX6t9XjshvOvD94J2BWOXqcqs3PbCF9CeSWeI279
         JUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ip5LJvSWonzgpjcBCxCiwSmzzSy496hPUaAkxCkzgAQ=;
        b=FH1WnV7G2pePF9jpmGSBK2xBOM5aURSYZb6eLBWuixYRmDo0yLJhSRtVac0MSt+0qz
         SC8/rrL69XM8S49IA6UreURUl8ldtm5NAlkGbd0mLDZkhici8WtZPx81z+6zqOcLmP+C
         mvYeBWQ8CtxVhcj2FogHCPlUKAQgPaq8oU5RNe+LIUeKHHhFFqNga3SVnGQl27Un0fzz
         c/TS/qrdMYC2u5SpSUrkUW7DQ57VvYx4rfq8cWrus8kWytbHBwFUF0SouxKw0NPxwPjV
         qMeLg9gC5anbMOpL7APqoG2h+mOh/TP8u0z6yTvhgXHpyR8j2vDQOJ4irDt14jUqFfmI
         Or3g==
X-Gm-Message-State: APjAAAXrNCVla7/u5GRFLmSNPGu2YRDIDWHAVAHFTgTuhiZUAXV/LhHr
        fD+IDqwLlQl2/FceH8oMGQjULhA=
X-Google-Smtp-Source: APXvYqy4ScvSCxw5mWV8GWq21/bnYmYyqqSI5rIHg9gkYbqMG0uUEsUvNcqDsr0eUXvi9ZTowl9nJA==
X-Received: by 2002:a7b:cd9a:: with SMTP id y26mr307345wmj.44.1564688631792;
        Thu, 01 Aug 2019 12:43:51 -0700 (PDT)
Received: from avx2 ([46.53.248.54])
        by smtp.gmail.com with ESMTPSA id o26sm143878055wro.53.2019.08.01.12.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 12:43:50 -0700 (PDT)
Date:   Thu, 1 Aug 2019 22:43:48 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     kirill.shutemov@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, jing.lin@intel.com, bp@alien8.de,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH] x86/asm: Add support for MOVDIR64B instruction
Message-ID: <20190801194348.GA6059@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline void movdir64b(void *dst, const void *src)
> +{
> +	/* movdir64b [rdx], rax */
> +	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> +			: "=m" (*(char *)dst)
                               ^^^^^^^^^^

> +			: "d" (src), "a" (dst));
> +}

Probably needs fake 64-byte type, so that compiler knows what is dirty.

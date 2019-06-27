Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF227C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2B82084B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ScGjlMzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfF0WwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:52:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43700 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF0WwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:52:05 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so8375829ios.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 15:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2ZPt3bSuTMo5TIF/X4TIfYbm6lSZkCvj2hiud9mLUwQ=;
        b=ScGjlMzBrt+gzFTzxnwNjm2sfFfhzC5U1erk+Bo3BkENgE6XZjELr+PwRDTfPBCzsz
         ehaou3iZcGGqLV+7nDFCVisiOfrvGrx4Yz74c9bUoVGn4ccWMyrLn/VMfxE/avPCyF9S
         oG4NwYXF0joM8HyaBNyzNiAczn/mAcHXN/EXNTdmv7C0nJJVhoBUrPbPuJfYZy3StFuQ
         TGv57McCloeyh6l6+6K1mRDcmI/Swb9A96L4nwOiaLV3GEIF8/ELbvhsOCkvUkaugtD5
         UqcS1yV7EAMNJRdo3HNWlVuuxSMn1+ewVVrP2KTKdJllZV2j2AWHtMDxnsXXFRT6rvkn
         +ZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2ZPt3bSuTMo5TIF/X4TIfYbm6lSZkCvj2hiud9mLUwQ=;
        b=uHcztzI3eapHXeCKksrAf9952M7NIsb8vK9B8mEejiuiEV80e6uJyNeTnYFs7aLlPv
         2ii+X+jIkaiVSflUPLpDk30i2ot9gcjLFSi1MRO2Xf64abEmWhhGyBNNtwvsoPkJcVlO
         b0+pvIK9gR1y2dsBDvgfLh53H/z69hY7nInB1fkTPyksOYR7plIrd0XkxE90ZUU5rcu7
         Xq/OVdobpXexTcDWuT14Zt3cViKZxLFggedm3T0hzyeMSPSi4Uws6IKBBPI/QLLt10f6
         2RKpp18cU5HZT3qP/kWF3iDHKixghAf7PbKp6xSF/DgGgKDsLLvlMFspwC/bfvlyyFXv
         bdIg==
X-Gm-Message-State: APjAAAWM9IkseJBCAyhUMb29B+ca7PEd0stvd9tgGH69UfONA37GEyzF
        RwXdOPwnc9BN2d67qzc8uPXCsQ==
X-Google-Smtp-Source: APXvYqwxBh4uhyqa5sBroUGYfeGOI31tYES7uPcBuVkWMyy5wkS0Gpzh6UrXExHg2bHhvrz6oqjvQQ==
X-Received: by 2002:a5d:9f4a:: with SMTP id u10mr5618627iot.243.1561675924177;
        Thu, 27 Jun 2019 15:52:04 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id r139sm1200959iod.61.2019.06.27.15.52.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 15:52:03 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:52:03 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Andy Lutomirski <luto@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, x86@kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, hch@infradead.org
Subject: Re: [PATCH] riscv: Remove gate area stubs
In-Reply-To: <d7f5a3b26eb4f7a41a24baf89ad70b3f37894a6e.1561610736.git.luto@kernel.org>
Message-ID: <alpine.DEB.2.21.9999.1906271549160.13860@viisi.sifive.com>
References: <d7f5a3b26eb4f7a41a24baf89ad70b3f37894a6e.1561610736.git.luto@kernel.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019, Andy Lutomirski wrote:

> Since commit a6c19dfe3994 ("arm64,ia64,ppc,s390,sh,tile,um,x86,mm:
> remove default gate area"), which predates riscv's inclusion in
> Linux by almost three years, the default behavior wrt the gate area
> is sane.  Remove riscv's gate area stubs.
> 
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Thanks, queued for v5.3 with Christoph's Reviewed-by:.


- Paul

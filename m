Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D247C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F12F206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555408953;
	bh=oEyM+nNl3stXjX1gRjDUliHszlDtjabA6WwYxx0Y78k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O8Dbv/VLJV1JjmOmKH9WbDwvsVVZZNXx4aMTpJO/Xy+HlBkBBbQmItmBK7UDuRkia
	 8hkqhdl42qpzURgJVP/s+Oo8u0rwC74QTM4q11J7lB4kvcBLMM5svJ6SkCtR70uy+o
	 LLR8iJ29cF7csTQ9eJgvHI/IYIkaEGfRNEm9mnTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfDPKCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:02:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35201 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfDPKCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:02:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so12699224wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 03:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IHFq9Weub1p+P1N8kbjYDQlb3WFyDWhI0+cUaRvsVNk=;
        b=e6wdcpBTUTNKsZbWqHQgdub0tvKvYKBRT0k4swollma8zZ4RCSG4QPd1fjS2InFQKJ
         0CU+/OoH5fKAatOJ1VWI0tINd/BrITex1K2NNFCO9/jo+ZwBR9bM8I0eEAckBVT+X0p4
         rOlLJvJjREv32OTpvpfvI50oqnklbA79w4wMSwVV4TxpZnrxVGFQ+emATRu6o8tRJjW3
         JDTKIw+pS2+Y+PFXnqyiGnQeZogtTlm6PKbsOq7zG2PR1ZHkKizbIwtmwBFlFrYPFNT/
         BiwX5KoNJDjfpMVbGCXVLrluH8Nuu6Rzd64IOQ5b5nDm8YbmJfNj4L6eql2wiXlfcjmY
         tjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IHFq9Weub1p+P1N8kbjYDQlb3WFyDWhI0+cUaRvsVNk=;
        b=csQrVmyCRxeyWfcNQmpjz62uVs/Xr7xk5vNLfRBfFkSBifW84tWZCKtXt00KDxKzjg
         9pXmil8FOSThcSQ4M87DfOeBRsrMV8kyXyiugpCcM5/q2UdiMESgPaP7gOxAl2ZNFyKT
         NEByHEVfVmusQfV25gTx4x+g+jPMxE9JkbxFjvPHT7P3riXwt4cOSpJV0zK9MfKpEZkW
         GQ8ex3xTMfffejtxqIs1sLdu0GcqE8z2iHCEExv5sU9ngQFnLPJDYZgp8OJOWWk9aFEI
         5pCqQYTHlPidvstpYgcXrzb2ZAK579Y4ifAybCgQpUvMWa4nJhJ3T45r37/SB5nAKIVG
         eTIQ==
X-Gm-Message-State: APjAAAVz0ExtxgBJxN6bo9Ho5ctn78DfKn2YPaidFmb1RqbWwGm8dgK/
        9SDC0DvN6RHj6Xn47LEFuDA=
X-Google-Smtp-Source: APXvYqzmHbSpnIcswUanoU/qdQzjPpwK595q1VzOPfTM33/+sLGx3P6Yr0Efxog5NpT+wpzrUEeqDg==
X-Received: by 2002:a1c:1a53:: with SMTP id a80mr25979131wma.15.1555408949889;
        Tue, 16 Apr 2019 03:02:29 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a11sm16450155wmm.35.2019.04.16.03.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 03:02:29 -0700 (PDT)
Date:   Tue, 16 Apr 2019 12:02:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernels
Message-ID: <20190416100226.GA117053@gmail.com>
References: <20190411125822.GE30080@zn.tnic>
 <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
 <20190412084956.GC19808@zn.tnic>
 <20190412133528.GD19808@zn.tnic>
 <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic>
 <20190415102525.GB29317@zn.tnic>
 <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
 <20190416094024.GE27892@zn.tnic>
 <20190416095209.GG27892@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416095209.GG27892@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> I'll queue the below in the next days if there are no more complaints:

Just a minor style nit, this was inherited from existing code:

> +			efi_config_table_64_t *tbl = (efi_config_table_64_t *) config_tables + i;
> +			efi_config_table_32_t *tbl = (efi_config_table_32_t *) config_tables + i;

You might want to update that to the canonical form of:

> +			efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables + i;
> +			efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables + i;

Looks good otherwise.

Thanks,

	Ingo

Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E472CECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB660206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FQOgJj4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbfJIW0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:26:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45185 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731916AbfJIW0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:26:11 -0400
Received: by mail-io1-f65.google.com with SMTP id c25so9003045iot.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 15:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xKOBnu3vyrbYs+yVc1anmwNLgo+Dsz1N+1/T+XrPL3k=;
        b=FQOgJj4V4ewf2GDsATw3jWNrLpUW0sFE/u973EEBTQFtiVoH7SRJCuohbipAkukMqA
         1abiZfwsUvdoSGwvZxMP0BrF49aAk2ouUKil790AKTdMw2kdQX1O2gZjJVoEZ3djXQLz
         8ezx5SkhZkjYUCLkgM5aYkkR6px7oh8GI9kyakzqwUWaoHFbGT9hWISJ//Ft4tpmldtK
         cykpw0VAnicKVVeoL1T03V1tpUdsbHN+nyGADuTnesecO5zMOdh1ANnVdUHLUewEGhXY
         P7iwS51HcCVlyOmJgwXx0Qjb0vrxEvUuCtlb9sWUs3T2fDAIX3raiXKdB8dDVk643P+T
         9R9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xKOBnu3vyrbYs+yVc1anmwNLgo+Dsz1N+1/T+XrPL3k=;
        b=O8WDEhkwHW06Hxxf793Fsy9Qq/4k9KuWEXMkmk7O+iSAgpB2WVYwkByoH0AGVuNEpe
         kk1GqA1wuDFjr6TxNyfIFPVhypbi6WivJirB4B90OY9Lpe2mm/MKZf/Dh114kBzcp7fc
         1HJK06s6VH2xaERpWhIJzy/ITafYIOOvenhBYVwgXUcsB5JUGNAcCRsV1kRHtrUCDqo2
         S4e77e+53aG37n3PmzTceb5WP1S678crhmTo3T7Wk+X2YIRzjKmR88ErSXJkEJAmBPrY
         iUTh3qXN5/SwmTMUNY4ZaMPvXNlE31O2a2/FEbDdoxzH2PaOOTWCsj/Jb1K5eao279SW
         me5Q==
X-Gm-Message-State: APjAAAU2QmtVF1y5cqahScMTy8oaZZ4d5yRECxZkxcb8sLIBcdYupZWC
        sAlj27qzzC0VovrpOSBOuOLi7w==
X-Google-Smtp-Source: APXvYqwWo1rZRGJvvPvWwd6KxxvwdHisWmnYRCVbu8fDLhbDrxEbdGmfv0xWkHUwZxqb9slxmhGw3A==
X-Received: by 2002:a02:cd8e:: with SMTP id l14mr5946947jap.30.1570659970360;
        Wed, 09 Oct 2019 15:26:10 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id d26sm1856581ioc.16.2019.10.09.15.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 15:26:09 -0700 (PDT)
Date:   Wed, 9 Oct 2019 15:26:08 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@infradead.org>
cc:     Vincent Chen <vincent.chen@sifive.com>,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu
Subject: Re: [PATCH 4/4] riscv: remove the switch statement in
 do_trap_break()
In-Reply-To: <20191007161050.GA20596@infradead.org>
Message-ID: <alpine.DEB.2.21.9999.1910091524590.11044@viisi.sifive.com>
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com> <1569199517-5884-5-git-send-email-vincent.chen@sifive.com> <20190927224711.GI4700@infradead.org> <alpine.DEB.2.21.9999.1910070906570.10936@viisi.sifive.com>
 <20191007161050.GA20596@infradead.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019, Christoph Hellwig wrote:

> On Mon, Oct 07, 2019 at 09:08:23AM -0700, Paul Walmsley wrote:
> >  		force_sig_fault(SIGTRAP, TRAP_BRKPT,
> >  				(void __user *)(regs->sepc));
> 
> No nee for the extra braces, which also means it all fits onto a single
> line.  You could have just copied what I pasted..

It turns out that the rewrite breaks allnoconfig:

https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/VDCU2WOB6KQISREO4V5DTXEI2M7VOV55/

Am just going to pick up Vincent's original patch.  Then we can do 
any subsequent cleanup in a separate patch.


- Paul

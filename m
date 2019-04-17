Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E55CC282DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5D921871
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555517730;
	bh=rOQwJJPGGkMVzU6K62glKu4UuVWXcNyseEcIx5c1xG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DLF9eJGgC4E1JSwvNahhLhIhK8kFonV6njuROiKzTFtlUFnBRw7OcpZ8POT0GILF5
	 /bpDLYZypuMOtNMusdPG9HmMZZg4vhsfPBeK4xXkJ/aQ0psBbicML3KzjLOCLXjMsJ
	 b9DkbK9Z9cOM4TMIkxVImrUMmaCtbmCmwZjaN84E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbfDQQP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:15:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45772 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:15:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so32682052wra.12;
        Wed, 17 Apr 2019 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2E2gGWXwlEXHD0EdhjliuzLa0L4LUy3dnmNjJuBPY1M=;
        b=nyS/WViclzZJjR30HVMMB/ma7fcLYSTWP9QxF2Fshf4EJq6uRarq3jSaxiVNfV92fh
         zEZfmA69o8F7gNO5JT6uv0zE0OJeE7BWbIRv09fAQTN2l+N2dnFwJ9Lfuiiy6+74FoDp
         uGRo9f5/Goa9H9R9Ca2oLvyjv31O0I5e5WLdLO3tmvoyjg1wNvw+8b2zxVEfd9gJSTwJ
         +SSg2n/omewPli8xLPnvSElOhwgHU9I/P33Tw7RfhZ2LRLr+x5PTn04fXGfMHG1ZHR4/
         XB7f4UjQbIdtenugCUJSD8W8ywk7H6JVByBN8MjE8ZURVuqLb51s1gVwQaBsfh/AY/u/
         6ICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2E2gGWXwlEXHD0EdhjliuzLa0L4LUy3dnmNjJuBPY1M=;
        b=nBR+wtjJDdfshmdLRlUr6HJ3s3sJNaMlD/cPBjdwVglBPYCKFrAaDyohXcLTHW69r7
         eASUxXylTxAMhwwqGmu6MfufZ6eZu9tYd9qUtKU/evVu/zRlWKILIgPaC8ojkOj3/Nxh
         AxFSZxj9WF4tnwKeBMS1ADslhqQnkOHF3BEIXOZtkJwkdLat8F6D6Zvw8T6DVAoRAyDz
         sjis53MhqFOeh8euiUM14P6zJUJhsOILf8Xl4qsuF+ufNUzBdq0plMPjdLGAdSB5YiwC
         PTehD+rKnCZ1S/DJUlhJtUbiabVAXOltmdCkLXQFT9pUEjBfIRztmeE6HWoaaUjWbmSL
         A0sg==
X-Gm-Message-State: APjAAAXqpgtV+XHu5MDOih9bYLs8MRsw7gNiQSYn6qEBMMgwHqT2fGUr
        fnp1dzY8CNaMdF3T/yaLEqM=
X-Google-Smtp-Source: APXvYqy35ID2kalnRZopmGnEWCBLThqKczYiLY/rC35gAIxUEa+THgEb4y2voVmHavCnFbNEpnRFQQ==
X-Received: by 2002:adf:dbce:: with SMTP id e14mr59140093wrj.249.1555517726742;
        Wed, 17 Apr 2019 09:15:26 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y1sm154976060wrd.34.2019.04.17.09.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 09:15:25 -0700 (PDT)
Date:   Wed, 17 Apr 2019 18:15:22 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        keescook@google.com, konrad.wilk@oracle.com,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        Khalid Aziz <khalid@gonehiking.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Dave Hansen <dave@sr71.net>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
Message-ID: <20190417161042.GA43453@gmail.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
 <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Sorry, had to trim the Cc: list from hell. Tried to keep all the 
  mailing lists and all x86 developers. ]

* Khalid Aziz <khalid.aziz@oracle.com> wrote:

> From: Juerg Haefliger <juerg.haefliger@canonical.com>
> 
> This patch adds basic support infrastructure for XPFO which protects 
> against 'ret2dir' kernel attacks. The basic idea is to enforce 
> exclusive ownership of page frames by either the kernel or userspace, 
> unless explicitly requested by the kernel. Whenever a page destined for 
> userspace is allocated, it is unmapped from physmap (the kernel's page 
> table). When such a page is reclaimed from userspace, it is mapped back 
> to physmap. Individual architectures can enable full XPFO support using 
> this infrastructure by supplying architecture specific pieces.

I have a higher level, meta question:

Is there any updated analysis outlining why this XPFO overhead would be 
required on x86-64 kernels running on SMAP/SMEP CPUs which should be all 
recent Intel and AMD CPUs, and with kernel that mark all direct kernel 
mappings as non-executable - which should be all reasonably modern 
kernels later than v4.0 or so?

I.e. the original motivation of the XPFO patches was to prevent execution 
of direct kernel mappings. Is this motivation still present if those 
mappings are non-executable?

(Sorry if this has been asked and answered in previous discussions.)

Thanks,

	Ingo

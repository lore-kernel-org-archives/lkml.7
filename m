Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451FBC2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1277F24679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iENtrLMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfLTLIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 06:08:43 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:34758 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLTLIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:08:41 -0500
Received: by mail-il1-f193.google.com with SMTP id s15so7655801iln.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 03:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nqoS5tYqLZszZEkeln6BME5bfDmS2wgCY0AhSGjAR00=;
        b=iENtrLMN4QyPmh9JUuuZvwD52ZdaT+pz4AMAFeo1p6YilJzq/yewAvOuEJCjnCeXe+
         PGX9O2OmHO9VUVEE01iO/KApQ05qhoKzP79tj08wZyx9LnIIyEKfmmqAUy4/YhBPiCnS
         5ZjU/lX6L7w7ujWfWSTGmNuJ8xKla7xZ0ETZR68VrvP2T6EqEbFmPjEWLERFAzGoRljO
         IY9mldHGAp8Kw1zwaxXgjxH7RbfRrzXHST9FVGfzB5xsJhNa33PiPihKdaoL6fQ6uQct
         bWCvYOnrXRYHAcyqZ4QKrUnxWFfLvPMITTXhm8jZ1gsXqGkXpRPJMla4ZWtnZfQgkUqZ
         vufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=nqoS5tYqLZszZEkeln6BME5bfDmS2wgCY0AhSGjAR00=;
        b=TtrCCKEUd0vAd7VoWSqTECvjRw5InnUfCipX76IInfYFyEdbis67eIx75RROFHGqbN
         lWOdFL1EXiLfkwiY22n70QcS1UHXcmy4bQCsdeScUmUj/n17BfPh5pjdY5txb9Rg2zRG
         2hsLb2MCQh1nXxKkoR6BrS1yVAD47yQmzfkkOfEcG/akpCJMF+InU6XdYB0gRW36JoLc
         j7+/otVmNtdwGkq7mErJTuya815kB9Qh9Yiu4KJNEISrfuhgmb7o2JC0D8adyhOqL20I
         1M4jO/FnVhX7CkSYEykUrsNrwl8ryTNOJyZLq+cb6fO7Xvh3A8nkITRPkv317NWtuXkC
         Niag==
X-Gm-Message-State: APjAAAXuBkna8r5wi5J0KCRQXeFJididMOlqZ9LQuHq8oTfz9DAU00YY
        vg+s1oay5BY4mTNJiImQVuhNwg==
X-Google-Smtp-Source: APXvYqzmtUBDHLQYZ/T8nMK7rlY4JPblpQvbwP3kEvacI2QUvVGsNhI0SSeNSwVqg4tOvZQd8uoUOw==
X-Received: by 2002:a92:1d98:: with SMTP id g24mr11386978ile.307.1576840120863;
        Fri, 20 Dec 2019 03:08:40 -0800 (PST)
Received: from localhost (67-0-26-4.albq.qwest.net. [67.0.26.4])
        by smtp.gmail.com with ESMTPSA id n20sm3098227ioj.83.2019.12.20.03.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 03:08:40 -0800 (PST)
Date:   Fri, 20 Dec 2019 03:08:39 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Stefan O'Rear <sorear2@gmail.com>,
        Yash Shah <yash.shah@sifive.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] define vmemmap before pfn_to_page calls
In-Reply-To: <20191218082814.895851-1-david.abdurachmanov@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1912200307400.3767@viisi.sifive.com>
References: <20191218082814.895851-1-david.abdurachmanov@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019, David Abdurachmanov wrote:

> pfn_to_page & page_to_pfn depend on vmemmap being available before the calls
> if kernel is configured with CONFIG_SPARSEMEM_VMEMMAP=y. This was caused
> by NOMMU changes which moved vmemmap definition bellow functions definitions
> calling pfn_to_page & page_to_pfn.
> 
> Noticed while compiled 5.5-rc2 kernel for Fedora/RISCV.
> 
> v2:
> - Add a comment for vmemmap in source
> 
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@sifive.com>
> Fixes: 6bd33e1ece52 ("riscv: add nommu support")
> Reviewed-by: Anup Patel <anup@brainfault.org>

This looks like it was due to my error when resolving the merge conflicts, 
not Christoph's.  Queued for v5.5-rc, thanks David.


- Paul

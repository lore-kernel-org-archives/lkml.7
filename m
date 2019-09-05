Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF77C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4D3206A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YUS/Lirb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfIEOaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:30:08 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38044 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfIEOaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:30:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id b2so3037321qtq.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 07:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y5SqPKw+eQauSARI3e7prNN2KoPrq6IiDIlL7ozwmws=;
        b=YUS/LirbfUeEH6j8oqy1lBBdLDuxiPUCcALpk0Hc8m6PUiQ7G4O1VAbZpXB3p4Ggvs
         pu9j9dwe0Rw2cJlOJd7aXrc4NPjo7q2FdIG6QptITVOMqNuGsARNijn5QXbf5EXEGraD
         ITyjVjY/tkgVZO1BZWAHg/5I+DpMItKGorWYoWVLob4JCbhYqzvPm5irhvrf4BBmHnIS
         pUL1RaLk/10Q+p9r1fUle5S/ZkcjIoIZpJS6yNFAFApfxggrEV0RKNss/PQuhL/cbtov
         y7aWo/VzQ18/j2TnwBm70is0Z6ojeCUJKOtM6WLVxBQRKd2a4e1Wem65pvx3t083SQoU
         Z40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y5SqPKw+eQauSARI3e7prNN2KoPrq6IiDIlL7ozwmws=;
        b=cAO+96dRvc0qhB5oQOT8SrFWD21oPHXhCvYyyoL05/JtGcyJz7XZT8g82mh5D1UEWf
         aSrfEC0LHtbspS+TAtLhYDU+q8wVSG7Uoq5BJIK0fj9OZ94ZbX3t4ZEBh0juYcCQe+65
         An4Ba+esa6f+Q1ccWdsF8zpDJiSE9xxhUFABLtaPnje+FujHhmc6oxVcNuINJe4ipz7X
         f5ITPynaW5fuLdY3Kz+gooApfUepxbU+wcuds2w0PF4jArq1vHcLRu/NGpSAW+QZ2N74
         3DX3V0Sotu3poaOdGtDsANKnCLhURZx16GwGHcesZm2ijG9ZALzeyB0VogmK+gZvvwBf
         +LTw==
X-Gm-Message-State: APjAAAWiWqQdQjX4afJnhwYJa0RpipJAagxbC7G5c4UMCc/Be2VkQ6nS
        Bx0lXvoHzu3mmdhMOzhQ7iEMgQ==
X-Google-Smtp-Source: APXvYqxcdKN38EPysNNewvg4TKYlHffHO0KLI9alERc/45IMpFAyjIK/F7Cu91FwzUjFmJeERuER8g==
X-Received: by 2002:a0c:e706:: with SMTP id d6mr1872330qvn.58.1567693806689;
        Thu, 05 Sep 2019 07:30:06 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t185sm1042277qkb.15.2019.09.05.07.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 07:30:05 -0700 (PDT)
Message-ID: <1567693804.5576.93.camel@lca.pw>
Subject: Re: lockdep warning while booting POWER9 PowerNV
From:   Qian Cai <cai@lca.pw>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 05 Sep 2019 10:30:04 -0400
In-Reply-To: <87ef0vpfbc.fsf@mpe.ellerman.id.au>
References: <1567199630.5576.39.camel@lca.pw>
         <9b8b287a-4ae1-ca9b-cff1-6d93672b6893@acm.org>
         <87ef0vpfbc.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-05 at 13:55 +1000, Michael Ellerman wrote:
> Bart Van Assche <bvanassche@acm.org> writes:
> > On 8/30/19 2:13 PM, Qian Cai wrote:
> > > https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config
> > > 
> > > Once in a while, booting an IBM POWER9 PowerNV system (8335-GTH) would
> > > generate
> > > a warning in lockdep_register_key() at,
> > > 
> > > if (WARN_ON_ONCE(static_obj(key)))
> > > 
> > > because
> > > 
> > > key = 0xc0000000019ad118
> > > &_stext = 0xc000000000000000
> > > &_end = 0xc0000000049d0000
> > > 
> > > i.e., it will cause static_obj() returns 1.
> > 
> > (back from a trip)
> > 
> > Hi Qian,
> > 
> > Does this mean that on POWER9 it can happen that a dynamically allocated 
> > object has an address that falls between &_stext and &_end?
> 
> I thought that was true on all arches due to initmem, but seems not.
> 
> I guess we have the same problem as s390 and we need to define
> arch_is_kernel_initmem_freed().

Actually, it is in the .bss section. The commit 2d4f567103ff ("KVM: PPC:
Introduce kvm_tmp framework") adds kvm_tmp[] into the .bss section and then free
the rest of unused spaces back to the page allocator.

kernel_init
  kvm_guest_init
    kvm_free_tmp
      free_reserved_area
        free_unref_page
          free_unref_page_prepare

Later, alloc_workqueue() happens to allocate some pages from there, and triggers
the warning. Not sure what the best way to solve this.

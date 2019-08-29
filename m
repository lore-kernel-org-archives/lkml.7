Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B655C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD0C20856
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfH2Blm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 21:41:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfH2Blm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 21:41:42 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2BBD5AFDE
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:41:41 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id y66so1161199pfb.21
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 18:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8DWNu1dK4HKJfDzkOqyZXX+I5s8gHPW0nTQ4GZnnxHE=;
        b=qnAPDP9E7paVqBB5KQL1ij8CZ/r2GyrOYF96qWvqIzkyNwFs+Y8pofCQ0j1BfwMPpr
         CcKs3UdNWCZGWfK0CubYcci5HH/sjfOa2u8OMKK3GAU+CTxDwZRDcbnzFa/mdD4H28tP
         I3s9fnsEYznYiReyWRoa0Jja69iw3N2puXj7QHV3Tz24MerQ1LyCSOrq8QEGHkx5fAai
         E1fyQJRQDlHuc1XrUXpeBKUDfoXSlTLi4IGE6i2u5WR8e4xSJBZLXLvqRJbfRcx0vBZC
         Az1qOO47hU+s/PL6c9sOWe8DjyLJI6spnKY8urvRHChSTunx3aOj6Flu4TO4dtHMkyZc
         wElQ==
X-Gm-Message-State: APjAAAUBA+L0NErTeCaIGbNtzHpfIKd65c1BMZidZ2lC6MEzFW1YOVZE
        CThTDfd0bBNSdJ/xwQE6LvZkUndwf/AT5nFcMKTBzPzzkHIJVZuwdIEe3PkP+VAHBDtG8TmyTHu
        wv3XO8xNqR8jlCI8keXUfQFwW
X-Received: by 2002:a17:90b:8e:: with SMTP id bb14mr7047937pjb.35.1567042900660;
        Wed, 28 Aug 2019 18:41:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwY+F2/S/0LgTY32xYN6uNnbYmaTrNV4G2U/b+SM1xbAWugSw5NKCTUFcLK4AWzt5fwKp5HPQ==
X-Received: by 2002:a17:90b:8e:: with SMTP id bb14mr7047931pjb.35.1567042900489;
        Wed, 28 Aug 2019 18:41:40 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s7sm728550pfb.138.2019.08.28.18.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 18:41:39 -0700 (PDT)
Date:   Thu, 29 Aug 2019 09:41:29 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/4] KVM: selftests: Move vm type into _vm_create()
 internally
Message-ID: <20190829014129.GE8729@xz-x1>
References: <20190827131015.21691-1-peterx@redhat.com>
 <20190827131015.21691-2-peterx@redhat.com>
 <20190828112357.auyhr3de5reie6hs@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190828112357.auyhr3de5reie6hs@kamzik.brq.redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 01:23:57PM +0200, Andrew Jones wrote:

[...]

> 
> >  {
> >  	struct kvm_vm *vm;
> >  
> > @@ -139,8 +139,7 @@ struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages,
> >  	TEST_ASSERT(vm != NULL, "Insufficient Memory");
> >  
> >  	vm->mode = mode;
> > -	vm->type = type;
> > -	vm_open(vm, perm, type);
> > +	vm->type = 0;
> >  
> >  	/* Setup mode specific traits. */
> >  	switch (vm->mode) {
> > @@ -190,6 +189,13 @@ struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages,
> >  		TEST_ASSERT(false, "Unknown guest mode, mode: 0x%x", mode);
> >  	}
> >  
> > +#ifdef __aarch64__
> > +	if (vm->pa_bits != 40)
> > +		vm->type = KVM_VM_TYPE_ARM_IPA_SIZE(guest_pa_bits);
>                                                     ^^
>                                                     should be vm->pa_bits

Thanks for spotting it!  Fixed this and also the rest of indent
issues.

Regards,

-- 
Peter Xu

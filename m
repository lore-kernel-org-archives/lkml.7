Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB95C3A5A4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 02:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20D12077B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 02:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfH2CJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 22:09:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfH2CJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 22:09:47 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E1AE85536
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 02:09:47 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id j9so1046053pgk.20
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 19:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cWz9sGB+WBliUQqYKGmTy4CKie+Spvd6Fx2kg3YzjVg=;
        b=Xat7DY5WQy/U+GBEELWAda4zXDi/358UWpocV7nBVf7s/m8//6+xWdle6+6/RT3+Ja
         xlbYxyfgzv2O13w9SgHtya2s2+VX/d1cWE2r7zYqbXBKT7uVV2mxhAlV+XEuluvqdxKb
         D1SUFk4Mk8Fp9WtBmz6pV4XG6JRzcnJgAohTEClsStDV60A7ZNaZ4oRNX6O81+k99Bb6
         kuJ/HDoZeGfBEY5jdkI7ZlaGbyz/vgcDjqOff4W301I0KjWfR2AXD4lJmIqOX5CfGH9h
         Ftu3VlLs5aAbrXDNeF7wdVSSGmewOvzr4LA90Xbtm2mNJ5fhX1J9nO9/i5D7710A80zZ
         MwrQ==
X-Gm-Message-State: APjAAAU61IPpGC7o9XUhX2VKMHASfFzJH3MvjKdyfvokVs27pNAaOm5p
        9Lu9OF/T7bBzNH36pRAlMJxWFra0xEn6m3gRtIt3qtPGy9CdHJFbJwGYPpqyR5LFVa0U4+gZPa5
        fRY/fZTNsmyau6IBoUeQu6iMS
X-Received: by 2002:a17:90a:fa95:: with SMTP id cu21mr7538034pjb.43.1567044586734;
        Wed, 28 Aug 2019 19:09:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqydpBl4a4u3UFZMu8NHSxmpgKb5IpM9yElt8QSTfIHghvIUhueai7ynoRWwLrFVTt0WrknE2Q==
X-Received: by 2002:a17:90a:fa95:: with SMTP id cu21mr7538021pjb.43.1567044586575;
        Wed, 28 Aug 2019 19:09:46 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x128sm772805pfd.52.2019.08.28.19.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 19:09:45 -0700 (PDT)
Date:   Thu, 29 Aug 2019 10:09:35 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 4/4] KVM: selftests: Remove duplicate guest mode handling
Message-ID: <20190829020935.GG8729@xz-x1>
References: <20190827131015.21691-1-peterx@redhat.com>
 <20190827131015.21691-5-peterx@redhat.com>
 <20190828114613.a2rvpip45c3ywdnj@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190828114613.a2rvpip45c3ywdnj@kamzik.brq.redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 01:46:13PM +0200, Andrew Jones wrote:

[...]

> > +unsigned int vm_get_page_size(struct kvm_vm *vm)
> > +{
> > +	return vm->page_size;
> > +}
> > +
> > +unsigned int vm_get_page_shift(struct kvm_vm *vm)
> > +{
> > +	return vm->page_shift;
> > +}
> 
> We could get by with just one of the above two, but whatever

Right... and imho if we export kvm_vm struct we don't even any
helpers. :) But I didn't touch that.

> > +
> > +unsigned int vm_get_max_gfn(struct kvm_vm *vm)
> > +{
> > +	return vm->max_gfn;
> > +}
> > -- 
> > 2.21.0
> >
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>

Thanks!

-- 
Peter Xu

Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0ABC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01D8205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561521080;
	bh=bZ1G2S3PGPwXnzJ2rk9+AJfTR7RiYbBDCp2Ne0/fTPM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZY0z/72z/b8SkSBTaQdBd2XW0+FXnKQoEFtXE7ASvDmJDRp6GDMp+LNYYS1psfxn0
	 BgRuvGnTcEkTyEAxarw74wfTpALz/oZVaLe0617kOfE/fZFXlCiLUjviZkozMZtYT3
	 /8gYAOOGF0BMBt0PbjK9mJm5qxjcCX6JXArRYJ9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfFZDvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbfFZDvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:51:18 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 750A021743
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 03:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561521077;
        bh=bZ1G2S3PGPwXnzJ2rk9+AJfTR7RiYbBDCp2Ne0/fTPM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hDpnehLLZWYQsb4aX9YZYzguXD8TTUSAIhULp729n8DAd3sPSpCCjjH+HzCPLwdZd
         b7eIz7p7jzWRuAZuJf+gL4x8oEpDDZ1WHdrxlJzrAbNnzfkQ4tgX4ZJLAL3u/PvZx1
         JmoDEivgDpfzwuzPz30YkfqmKdCjBVNxvm3Drhkk=
Received: by mail-wr1-f44.google.com with SMTP id r16so888025wrl.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 20:51:17 -0700 (PDT)
X-Gm-Message-State: APjAAAVB004iiPCJkipyiWgdQKAwN9a13uvg3Q9u2jwf2ku8KXRpJzPT
        Xlicz8rIqloF3b65YKJgYKkjgBRxrk91wB5K5czxkw==
X-Google-Smtp-Source: APXvYqxhbwnXC+HHtbgLXKDHMg8L3l+e67NPNctbsjFY5QgqxzbbdaPZPdECVjYrpk2ZK2KQAYoaSiz68v0i6AaL3z0=
X-Received: by 2002:adf:f606:: with SMTP id t6mr1183395wrp.265.1561521076028;
 Tue, 25 Jun 2019 20:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190613064813.8102-1-namit@vmware.com> <20190613064813.8102-5-namit@vmware.com>
 <CALCETrXyJ8y7PSqf+RmGKjM4VSLXmNEGi6K=Jzw4jmckRQECTg@mail.gmail.com> <28C3D489-54E4-4670-B726-21B09FA469EE@vmware.com>
In-Reply-To: <28C3D489-54E4-4670-B726-21B09FA469EE@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 25 Jun 2019 20:51:05 -0700
X-Gmail-Original-Message-ID: <CALCETrUicyG0NJfj309zU6SX1Xdq6gcmC9+zGLqW4iFkodnWjw@mail.gmail.com>
Message-ID: <CALCETrUicyG0NJfj309zU6SX1Xdq6gcmC9+zGLqW4iFkodnWjw@mail.gmail.com>
Subject: Re: [PATCH 4/9] x86/mm/tlb: Flush remote and local TLBs concurrently
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        kvm list <kvm@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 8:48 PM Nadav Amit <namit@vmware.com> wrote:
>
> > On Jun 25, 2019, at 8:36 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Wed, Jun 12, 2019 at 11:49 PM Nadav Amit <namit@vmware.com> wrote:
> >> To improve TLB shootdown performance, flush the remote and local TLBs
> >> concurrently. Introduce flush_tlb_multi() that does so. The current
> >> flush_tlb_others() interface is kept, since paravirtual interfaces need
> >> to be adapted first before it can be removed. This is left for future
> >> work. In such PV environments, TLB flushes are not performed, at this
> >> time, concurrently.
> >
> > Would it be straightforward to have a default PV flush_tlb_multi()
> > that uses flush_tlb_others() under the hood?
>
> I prefer not to have a default PV implementation that should anyhow go away.
>
> I can create unoptimized untested versions for Xen and Hyper-V, if you want.
>

I think I prefer that approach.  We should be able to get the
maintainers to test it.  I don't love having legacy paths in there,
ahem, UV.

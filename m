Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1CFC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB535214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXWibDix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfJJVnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 17:43:03 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34568 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfJJVnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:43:03 -0400
Received: by mail-io1-f67.google.com with SMTP id q1so17190096ion.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 14:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgBbezehA3ikP9oZRce9D/NdIFW9A/2nwCHvWz1qbio=;
        b=PXWibDixpgKJCby0TQFLHsZui075Akm20g2TmZP0MeUZu3m3TF2pxyJ6S0YjeAMB9k
         BNLlTLTKCcnK4fLg9rTzwLxxAE8f37HmurDGiwgHD846Eire0Z+6V97ptIkKb/Pw4WZQ
         JMSVx2LWoEFLhcZvxaggKnTPoNhmm0x/mCblauI4fbockAsXT2GtwizjO/RPdB2iPzPS
         KoZHu81rUu/NoB97BqerCDfp1ZwOIMHhsBzYxM9zAkAV+QumBorRWlW1Ui1MYMHgBs/t
         nAw0lKVjeuQqcj4TsSy+XCp6RuzzXuEk81yruvFRraHNrYc2NHN3gVLwcB8XqkwJAEMe
         fjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgBbezehA3ikP9oZRce9D/NdIFW9A/2nwCHvWz1qbio=;
        b=p1BK5R1AqmG9W3pe1lsYvg2JrvVPn7ei7TrQ9DvNtky8AlzXiLVkPH0Hm4Mebv+cm+
         aU+RahSCQrY2haD7PLdbb4pEEVv4jKtb5+ZGixbXy2XYpFe4hQvcZpi4xdgm8J2acWYC
         XlaIqvv4JnTBcq/fBF7DbAOnxR9iaFIQYMi6B7sbxXOuZVLrXqCve7REXh/OcERgbHJd
         bpr5Hffq5aKEIqdyiAKYQ67gisPQ7mq+01GYECvglOLiO+rUm05ohkLCH1bSnIrzWXur
         p4aMlZsMLM2BEzJ1aMmZjyEF555Pur+ALlnnQPmOg9Z/VdKABWem+IjcaqHX8Mnd1lqp
         ZHYQ==
X-Gm-Message-State: APjAAAVVsCTn5su9ZFcIO0qZ5Qb4ybrcverDBC3IAp87kDufhA8MOzi4
        gRh1Zt47DslCdo0UWkXU8AQZNm99t/xEeE7BhqI6eg==
X-Google-Smtp-Source: APXvYqzyL4eIxkMFi6sg1vb8I0p+Byp7KJS0VWOUTKHzD3FfxdDEDF/ndhyoviKqw/bxI8kk0ZY7KIOYr8HJSACfp78=
X-Received: by 2002:a5d:9057:: with SMTP id v23mr1741177ioq.119.1570743782188;
 Thu, 10 Oct 2019 14:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190917085304.16987-1-weijiang.yang@intel.com>
In-Reply-To: <20190917085304.16987-1-weijiang.yang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 10 Oct 2019 14:42:51 -0700
Message-ID: <CALMp9eSTz+XbmLtWZLqWvSNjjb4Ado4s+SfABtRuVNQBXUHStQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Enable Sub-page Write Protection Support
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        yu.c.zhang@intel.com, alazar@bitdefender.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 1:52 AM Yang Weijiang <weijiang.yang@intel.com> wrote:
>
> EPT-Based Sub-Page write Protection(SPP)is a HW capability which allows
> Virtual Machine Monitor(VMM) to specify write-permission for guest
> physical memory at a sub-page(128 byte) granularity. When this
> capability is enabled, the CPU enforces write-access check for sub-pages
> within a 4KB page.
>
> The feature is targeted to provide fine-grained memory protection for
> usages such as device virtualization, memory check-point and VM
> introspection etc.
>
> SPP is active when the "sub-page write protection" (bit 23) is 1 in
> Secondary VM-Execution Controls. The feature is backed with a Sub-Page
> Permission Table(SPPT), SPPT is referenced via a 64-bit control field
> called Sub-Page Permission Table Pointer (SPPTP) which contains a
> 4K-aligned physical address.
>
> To enable SPP for certain physical page, the gfn should be first mapped
> to a 4KB entry, then set bit 61 of the corresponding EPT leaf entry.
> While HW walks EPT, if bit 61 is set, it traverses SPPT with the guset
> physical address to find out the sub-page permissions at the leaf entry.
> If the corresponding bit is set, write to sub-page is permitted,
> otherwise, SPP induced EPT violation is generated.

How do you handle sub-page permissions for instructions emulated by kvm?

Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F81C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4445B20872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393537AbfIJGgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:36:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732338AbfIJGgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:36:04 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E43D0821D8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 06:36:03 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id s139so12301474pfc.21
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 23:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oY3Ce/5Kbiwb4uUtpEcG5bKndL/d68YsWBrf+ZfdEUg=;
        b=DiWXjawbuUtJEmjU0RbkdBDMv4cOW5UWUYQTLt2PlchVo0jIk5FKgb0EJr5AgqDaxU
         3sh0PSj1p3EhguujPe6zWZ7jbHn0EmG4hborpmuNOkVIojM6A1Vc8GL//+tIJKGrACc4
         lNxFrfXRNmc6gcIEqSXHwaoRBlJxjgmz3cU98b+bSPeIau0jIPVFSKa36rHj42DslUBV
         ft+dXDXdnW/czqXVQhC+UBQB0zJF7z+l5aevtLI/ZsGxfKdeOYlINl8ggL7Okj4gII2y
         Pa1ZBUGZDSrchAyRoLQIU3ZCI1l0Vfdr6Wo88MZaQpvYtV22V4ZwcM6BvuGmLDc98Cp4
         qckA==
X-Gm-Message-State: APjAAAXcTMqsv+5pZplRdL15I70w0NbmxARhhRLH3jUDbTo0BZ1lUwL2
        I8zVygQkmHdPanOtzVe1CpGbWtwYP6/FtLeUSUgaWLpW1uiLIIHY+ZLKJF0qbGKwkZFlm/zrfvj
        o6YfW68VqunKQSq+VCsB1l1Hm
X-Received: by 2002:a62:cf82:: with SMTP id b124mr32811079pfg.159.1568097363356;
        Mon, 09 Sep 2019 23:36:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzBN6NUbe6QHosEJOHGq8wA7M68Xro9xrRVctByU6UK/vg6Yda0DomOLpqVHL7ahH1j5pqomg==
X-Received: by 2002:a62:cf82:: with SMTP id b124mr32811050pfg.159.1568097363109;
        Mon, 09 Sep 2019 23:36:03 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a29sm30436883pfr.152.2019.09.09.23.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 23:36:02 -0700 (PDT)
Date:   Tue, 10 Sep 2019 14:35:52 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>,
        Doug Reiland <doug.reiland@intel.com>
Subject: Re: [PATCH] KVM: x86: Manually calculate reserved bits when loading
 PDPTRS
Message-ID: <20190910063552.GB8696@xz-x1>
References: <20190903233645.21125-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190903233645.21125-1-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:36:45PM -0700, Sean Christopherson wrote:
> Manually generate the PDPTR reserved bit mask when explicitly loading
> PDPTRs.  The reserved bits that are being tracked by the MMU reflect the
> current paging mode, which is unlikely to be PAE paging in the vast
> majority of flows that use load_pdptrs(), e.g. CR0 and CR4 emulation,
> __set_sregs(), etc...  This can cause KVM to incorrectly signal a bad
> PDPTR, or more likely, miss a reserved bit check and subsequently fail
> a VM-Enter due to a bad VMCS.GUEST_PDPTR.
> 
> Add a one off helper to generate the reserved bits instead of sharing
> code across the MMU's calculations and the PDPTR emulation.  The PDPTR
> reserved bits are basically set in stone, and pushing a helper into
> the MMU's calculation adds unnecessary complexity without improving
> readability.
> 
> Oppurtunistically fix/update the comment for load_pdptrs().
> 
> Note, the buggy commit also introduced a deliberate functional change,
> "Also remove bit 5-6 from rsvd_bits_mask per latest SDM.", which was
> effectively (and correctly) reverted by commit cd9ae5fe47df ("KVM: x86:
> Fix page-tables reserved bits").  A bit of SDM archaeology shows that
> the SDM from late 2008 had a bug (likely a copy+paste error) where it
> listed bits 6:5 as AVL and A for PDPTEs used for 4k entries but reserved
> for 2mb entries.  I.e. the SDM contradicted itself, and bits 6:5 are and
> always have been reserved.
> 
> Fixes: 20c466b56168d ("KVM: Use rsvd_bits_mask in load_pdptrs()")
> Cc: stable@vger.kernel.org
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Reported-by: Doug Reiland <doug.reiland@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Maybe with a test case would be even better?  FWIW:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

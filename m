Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F361C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396EA2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDJG+FHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbfDDU25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:28:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37067 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729657AbfDDU24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:28:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so1934262pfr.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 13:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4qUk8W0GAzWA97FnJKu3eUQ+vGfAvxqnmlQdPm3iJDk=;
        b=jDJG+FHekDqus5RI2HRReA5lJyBIce30V90l3z6R0EapIUZyJVM/pE1M4DjiBuF/nK
         tRF7L3aHXW76V+03de5yuxJSU6/UY0tpKqdgh+nVTT8/MPtETM4H7Ehfk+K3xwGje/3C
         up20w6cBeDi8xG4N2EAdHOxsFnRqMxLJspG7hJSiPoLwDGevUnIGq1/OsWOn2iooJjyl
         EL9H4CsplNsDhLuPN4v7FGdmJJO100k3bnaS8P6E4qN59gb0A7jV1pEVAKf/Gpx/w1TE
         rjAVdHdOA//eUxwjlp+OuowIZmz+RcRQ0p+taq50XA/eiESMkSua3xIhHaUNPmePiop+
         bc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4qUk8W0GAzWA97FnJKu3eUQ+vGfAvxqnmlQdPm3iJDk=;
        b=ZuZsywZbwy7OnV2sDkhuoN9xzLbJBieAcbt1sPdWokUpC39DGYbsQCAb2GWVBeUgRE
         B8qDhjaNJ45rrD4fiFSKgi8f60u4BapyAL671nKkTjo/MuabQwjfRpFOwnbnLZZmTs9g
         CVwMFHK0ksG+yVgYQ5JudxuFygn7eK/1pV5TZajjSeunVO+XFg+67QDalkccaMly4FaD
         a+sTBNLKpJU+b+3O5Th+PvuISFhRYE8OFTEj5+OJ2ECVKzkAYGbQ7hx+pJm6/ath1ppz
         ybmJuu6Ims76EDH29DOiuzr7tEbOii4fW8ngU1j0+IaUTemSlny3q2Q1ZqdDhZNwYi7d
         om3A==
X-Gm-Message-State: APjAAAUxTn9L2S0ITtamkTxRjjDPvAZXw5n31LkUPHIkCxiODT2iamkP
        tQwZdSySjNjbm98nTxszmD2Z+1SkIiI=
X-Google-Smtp-Source: APXvYqykvrNarnYRrmQ39P2Tb9+d1I8m6DUa+RGJC8yzMyWYP+buLoJAWvAE40aaaXJAY9zYZnL+Ww==
X-Received: by 2002:a63:2c3:: with SMTP id 186mr7675400pgc.161.1554409735180;
        Thu, 04 Apr 2019 13:28:55 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id e21sm28301337pfd.177.2019.04.04.13.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 13:28:54 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] kvm: Use huge pages for DAX-backed files
From:   Barret Rhoden <brho@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, yu.c.zhang@intel.com
References: <20190404202345.133553-1-brho@google.com>
Message-ID: <ac4e061c-429d-2306-2f7b-b7f8e6fc362b@google.com>
Date:   Thu, 4 Apr 2019 16:28:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190404202345.133553-1-brho@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


-yi.z.zhang@intel.com (Bad email address / failure)

Sorry about that.

On 4/4/19 4:23 PM, Barret Rhoden wrote:
> This patch series depends on DAX pages not being PageReserved.  Once
> that is in place, these changes will let KVM use huge pages with
> DAX-backed files.
> 
>  From previous discussions[1], it sounds like DAX might not need to keep
> the PageReserved bit, but that it hadn't been sorted out yet.
> 
> Without the PageReserved change, KVM and DAX still work with these
> patches, simply without huge pages - which is the current situation.
> 
> If you want to test the huge-page functionality as if DAX pages weren't
> PageReserved for KVM, this hack does the trick:
> 
> ------------------
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index c44985375e7f..ee539eec1fb8 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -153,6 +153,10 @@ __weak int kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
>   
>   bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
>   {
> +       // XXX hack
> +       if (is_zone_device_page(pfn_to_page(pfn)))
> +               return false;
> +
>          if (pfn_valid(pfn))
>                  return PageReserved(pfn_to_page(pfn));
>   
> ------------------
> 
> Perhaps if we are going to leave DAX pages marked PageReserved, then I
> can make that hack into a proper commit and have KVM alone treat DAX
> pages as if they are not reserved.
> 
> v2 -> v3:
> v2: https://lore.kernel.org/lkml/20181114215155.259978-1-brho@google.com/
> - Updated Acks/Reviewed-by
> - Rebased onto linux-next
> 
> v1 -> v2:
> https://lore.kernel.org/lkml/20181109203921.178363-1-brho@google.com/
> - Updated Acks/Reviewed-by
> - Minor touchups
> - Added patch to remove redundant PageReserved() check
> - Rebased onto linux-next
> 
> RFC/discussion thread:
> https://lore.kernel.org/lkml/20181029210716.212159-1-brho@google.com/
> 
> [1] https://lore.kernel.org/lkml/ee8cc068-903c-d87e-f418-ade46786249e@redhat.com/
> 
> Barret Rhoden (3):
>    mm: make dev_pagemap_mapping_shift() externally visible
>    kvm: Use huge pages for DAX-backed files
>    kvm: remove redundant PageReserved() check
> 
>   arch/x86/kvm/mmu.c  | 33 +++++++++++++++++++++++++++++++--
>   include/linux/mm.h  |  3 +++
>   mm/memory-failure.c | 38 +++-----------------------------------
>   mm/util.c           | 34 ++++++++++++++++++++++++++++++++++
>   virt/kvm/kvm_main.c |  8 ++------
>   5 files changed, 73 insertions(+), 43 deletions(-)
> 


Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C269C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1185620856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfDAOpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:45:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38779 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfDAOpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:45:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id d13so11112798qth.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 07:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gMWFXOF84tirN8vJJaH4r/H0McFie5EFwhOH5jwK39Q=;
        b=IT62E++lYX4tpa7y7X3WBotrhGqvSAEZUxKtXuhT7y6Y3pTeOcTOHzDdE/HX2WjLHR
         fXMJfV177GuoppxZiVFc1uAqPdAcju4e0ynJ9LaJFyQXprKOrhSbJsPlOSHrfTfZxqy9
         dwLCnxtibR+GR+p7O+1Q1W+nhZUBJQMVjy8E2WSB6sj8KH0GIOo8U9KASoSt00bqRKyJ
         dbr0Y7tYcQ6QT2aCj84t9Gw6q8C0MlYpn9SBuXeFFJQBAIWbc+lzAwXJOiKXyI/qcIUJ
         M7F4tJsJVxjPmeMeuIRqLe/4aFnhj7CVa4ayX0+ShL4a31KvtjDVaU34BRm4Aexv1YrA
         vWpg==
X-Gm-Message-State: APjAAAUrQ7tV8uHVUKow6HV0HouxpUqLAAUqWwWZ7XP4RQiAxcIiiEOL
        CUlkHQsPtjc3sPd7PZrTp6EtAQ==
X-Google-Smtp-Source: APXvYqzJBJY8DrD6iTliprqMc4U5/LFnbB2DPVMUWe0YjnKWLftbU9KgcgwpqYMeNv25dt8ev3bOFA==
X-Received: by 2002:a0c:ae04:: with SMTP id y4mr46602243qvc.49.1554129930417;
        Mon, 01 Apr 2019 07:45:30 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id b46sm5053834qtk.77.2019.04.01.07.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 07:45:29 -0700 (PDT)
Date:   Mon, 1 Apr 2019 10:45:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
        aarcange@redhat.com, alexander.duyck@gmail.com
Subject: Re: On guest free page hinting and OOM
Message-ID: <20190401104328-mutt-send-email-mst@kernel.org>
References: <20190329084058-mutt-send-email-mst@kernel.org>
 <f6332928-d6a4-7a75-245d-2c534cf6e710@redhat.com>
 <20190329104311-mutt-send-email-mst@kernel.org>
 <7a3baa90-5963-e6e2-c862-9cd9cc1b5f60@redhat.com>
 <f0ee075d-3e99-efd5-8c82-98d53b9f204f@redhat.com>
 <20190329125034-mutt-send-email-mst@kernel.org>
 <fb23fd70-4f1b-26a8-5ecc-4c14014ef29d@redhat.com>
 <20190401073007-mutt-send-email-mst@kernel.org>
 <29e11829-c9ac-a21b-b2f1-ed833e4ca449@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29e11829-c9ac-a21b-b2f1-ed833e4ca449@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 04:09:32PM +0200, David Hildenbrand wrote:
> > 
> > When you say yield, I would guess that would involve config space access
> > to the balloon to flush out outstanding hints?
> 
> I rather meant yield your CPU to the hypervisor, so it can process
> hinting requests faster (like waiting for a spinlock). This is the
> simple case. More involved approaches might somehow indicate to the
> hypervisor to not process queued requests but simply return them to the
> guest so the guest can add the isolated pages to the buddy. If this is
> "config space access to the balloon to flush out outstanding hints" then
> yes, something like that might be a good idea if it doesn't harm
> performance.

The problem would be in testing this unfortunately. Same as any
OOM hack, it is difficult to test well.

> -- 
> 
> Thanks,
> 
> David / dhildenb

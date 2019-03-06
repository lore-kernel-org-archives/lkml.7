Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780C5C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415972147A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfCFSiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:38:21 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46035 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730032AbfCFSiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:38:20 -0500
Received: by mail-qk1-f194.google.com with SMTP id v139so7395852qkb.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 10:38:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T24eVcgpzAYAMO6VRnHBSEvjogV8HmqLjlBXwIfM6kE=;
        b=bx7PVIwc6ddsz6ZUIJ9pAiksnWvGfrhkF8nH1voyYZzLwifMWF2lVsT/N/i0ZMwTEX
         IQGufRlC9h83gleCW4r58/yUFvx1B+8qWRoaopYGXfqy1QR2tPkW43V/vomEkjY37B2N
         lM01HLTljsRqJUWn1UaUSb1MDMrEG54n6nvKNNmilKK1H5gcisKCqA3C/GLcOvL8UJEb
         nugBzi8mdXS4COAkfpRusMif6CKakrcNUBRWcbap82UwYC6FsqFEfAaejC4aJQJcvbjL
         BXEvANeukz+3SbGQJlCUtYSKN1fly8dk0vE0IGFNY2fiLd4PBbiSUE1PRbY0rFX9DijM
         tzkA==
X-Gm-Message-State: APjAAAV0F4l2hL/E4gmkvP9MbMfXSDlki7Jet3KIDEXThcJViUA/jQmc
        +GxyTqlbHV/C9fG/j4hEPxfPVA==
X-Google-Smtp-Source: APXvYqyp4/fWLcvJkLYY14pEzyen//W/96hdXYhLSGykOJker4NgGzIDFKXI03sbZ9R8gDmGBpDBRw==
X-Received: by 2002:a37:6314:: with SMTP id x20mr6786541qkb.276.1551897499201;
        Wed, 06 Mar 2019 10:38:19 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id r198sm43238qke.52.2019.03.06.10.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 10:38:18 -0800 (PST)
Date:   Wed, 6 Mar 2019 13:38:15 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, pbonzini@redhat.com, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com, yang.zhang.wz@gmail.com,
        riel@surriel.com, david@redhat.com, dodgen@google.com,
        konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com,
        alexander.duyck@gmail.com
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
Message-ID: <20190306133613-mutt-send-email-mst@kernel.org>
References: <20190306155048.12868-1-nitesh@redhat.com>
 <20190306110501-mutt-send-email-mst@kernel.org>
 <bd029eb2-501a-8d2d-5f75-5d2b229c7e75@redhat.com>
 <20190306130955-mutt-send-email-mst@kernel.org>
 <afc52d00-c769-01a0-949a-8bc96af47fab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc52d00-c769-01a0-949a-8bc96af47fab@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 01:30:14PM -0500, Nitesh Narayan Lal wrote:
> > Want to try testing Alex's patches for comparison?
> Somehow I am not in a favor of doing a hypercall on every page (with
> huge TLB order/MAX_ORDER -1) as I think it will be costly.
> I can try using Alex's host side logic instead of virtio.
> Let me know what you think?

I am just saying maybe your setup is misconfigured
that's why you see no speedup. If you try Alex's
patches and *don't* see speedup like he does, then
he might be able to help you figure out why.
OTOH if you do then *you* can try figuring out why
don't your patches help.

-- 
MST

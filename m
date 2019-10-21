Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F013ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF15C2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="A08jDv+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfJUOpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:45:02 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38800 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfJUOpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:45:02 -0400
Received: by mail-ot1-f66.google.com with SMTP id e11so11198469otl.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 07:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nXKBAnyH4k8+RtijsexqxpoxgeB4fhcJobwvx31LMho=;
        b=A08jDv+Vol6PvOoXT/M++kzuwcxp91LiBFYVYM8EPNPJr69L5QUHqGuyp6zGv7tyF9
         6FX/3oF06Fh+suEw+xQCGVLXW/2yTptC75eQ4/Bbh3WX6Ds/b0M7cf50hvpynQ5ibr4v
         gyYdRFItY3w55CEltwtFaefj+WsgXARJ5YWtFuxW73BsZK0zpcCSH1MoB0rLRv8RqmVt
         qiaRQW1K0uEwRHT9/yan1nEhEFofsZXJYLXFQRs8G0Luo67GpvQH6OEE/XLvxxr7bbTv
         RWxGf3MhxbRyjvhxwa7eDi1zMvw+87+x9G1yJ+8txjhDZ6FYAZefo+3fNI8vS/AdDEne
         vqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXKBAnyH4k8+RtijsexqxpoxgeB4fhcJobwvx31LMho=;
        b=aee2tWZ/K9v61Z2aouEM8WxqdcuBFespb6A99RiXuRFus7JK10TFVerPLNkSlEHe7t
         7J5DYzoDz+lFEF4/9kl9G/vuRoE1lrpAGH+WD7PtFXWrcI+40SNxnF/04L6NqI37nlpW
         MQXbAAmq/40BhLnSNj/NPoR/8MsW/FMqTErZmweVTCkuMn49dkI9ITDNOy8PKtFLl0y1
         eivyTEbW+8MWgpSopmcvwnFxSa1/I0oQVrOZrpCWYdsK5uHw70VwSCFpPXzHcV4Qvyig
         Y98zvYXo2ocliHpDWuqMVwkuKtRlNzWDFTZ3tucMKn4i2dmmZL0CrQXEy29yahfyudDq
         3zUQ==
X-Gm-Message-State: APjAAAWZ5Aq5RkkcHj8XHVgqVe8+k3pXf2bZliai0zrebG5Lk/juIAbL
        5346GHDWMyYx8TdWKIZegChdO4Wkrk1l7tbEHn78kA==
X-Google-Smtp-Source: APXvYqxBK0s4meOHW5S/bgvSxL00+aVLbFSn/xa462jwXlzSuPi3v0iK8imKwTC8RSn2iFmHXyu4Ls1dS51GrTPHPKE=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr19206153otn.363.1571669101455;
 Mon, 21 Oct 2019 07:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <157150237973.3940076.12626102230619807187.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x495zkii9o5.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x495zkii9o5.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 21 Oct 2019 07:44:51 -0700
Message-ID: <CAPcyv4j66KoivrNRpOrqwrVtsOP5fSWKPqcHx_dDf1czy=f3qQ@mail.gmail.com>
Subject: Re: [PATCH] fs/dax: Fix pmd vs pte conflict detection
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Smits <jeff.smits@intel.com>,
        Doug Nelson <doug.nelson@intel.com>,
        stable <stable@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 5:07 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > Check for NULL entries before checking the entry order, otherwise NULL
> > is misinterpreted as a present pte conflict. The 'order' check needs to
> > happen before the locked check as an unlocked entry at the wrong order
> > must fallback to lookup the correct order.
>
> Please include the user-visible effects of the problem in the changelog.
>

Yup, I noticed that right after sending.

Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD44BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E5A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfCRJFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:05:20 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36602 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfCRJFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:05:20 -0400
Received: by mail-it1-f193.google.com with SMTP id h9so20037054itl.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 02:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BeZakifWw0X5ZYNb9U7X3d9hDCEeWS8qibn9TE102P0=;
        b=FQzF1FV+zIKd2Ti47ok4AzVvOQc4h0jiPFWBQ2JiLYNwFVWr3l2IKiVjEFItRE3Q4k
         KEDKu+Z1z4l/1CsZ4CltMTD7vqqDxXaEJ97UIs7JL75gY8D8hpZe6yrMZ3KsddSBpMqj
         Nk1xZecFPugQHFBcR0d3n5uCGqQRJo5tz6Gg2pmOewpoeVAo2AXOVlO1IdiaNuGS1oWT
         KnIqenAIGWUo/DkeX84XkghCYUKgLbMLOJtVpBviDyx7leR5Pjoag6uKSee7SiquvPcB
         +WMfeQb5fahZAUqrlohKFgy+V3aAkV/TqGNOTaBsOm67XJW/A15SRYxQUlgpSgqoJuQa
         zusg==
X-Gm-Message-State: APjAAAVFGkNIvK48f7H4V5sF8UbAEbGrwVTvwm6PLOmD/WVHm36fDCk4
        Y6S0qLMfV7KfQy/HyEwgGjIDKzlhPjkr0f9gdpMcFA==
X-Google-Smtp-Source: APXvYqw0vdOlNDP1vStnD2agkkfcnHMP0BbVrjbt2hju4UZho0DkIBVjBE1ZubF3OPNDuYz58MHhyBT9Ah3X7SOygqg=
X-Received: by 2002:a02:745:: with SMTP id f66mr10831212jaf.137.1552899919099;
 Mon, 18 Mar 2019 02:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190312142019.30936-1-lhenriques@suse.com> <20190312142019.30936-3-lhenriques@suse.com>
 <CAAM7YAmMBv1Z4Etp5yf9K=RqpTNF0kJ3tsiAysfs_wv9mdNG8w@mail.gmail.com>
In-Reply-To: <CAAM7YAmMBv1Z4Etp5yf9K=RqpTNF0kJ3tsiAysfs_wv9mdNG8w@mail.gmail.com>
From:   Gregory Farnum <gfarnum@redhat.com>
Date:   Mon, 18 Mar 2019 14:35:08 +0530
Message-ID: <CAJ4mKGZ3a9xq4HkR3JQ0yRyBCh1acm0YEz14OBUK+bQFzbVEDg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ceph: quota: fix quota subdir mounts
To:     "Yan, Zheng" <zyan@redhat.com>
Cc:     Luis Henriques <lhenriques@suse.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hendrik Peyerl <hpeyerl@plusline.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 2:32 PM Yan, Zheng <ukernel@gmail.com> wrote:
> After reading the code carefully. I feel a little uncomfortable with
> the "lookup_ino" in get_quota_realm.  how about populating directories
> above the 'mount subdir' during mounting (similar to cifs_get_root ).

Isn't that going to be a problem for any clients which have restricted
filesystem access permissions? They may not be able to see all the
directories above their mount point.
-Greg

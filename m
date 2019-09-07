Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49838C0030B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 19:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A60E21848
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 19:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567886158;
	bh=+oKsQ9GfC8l7kVr6a7/37aCNJzDVzhyrmLAiB1VKdGY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fvXya2sF0bJO/jVwou2TLJERzs9XL3igh7HYEUjJpZSFVDAc8b63WXxewj/C9dLI2
	 zgtlOo8fqgXrVm6GS/Q73M714qZryXJyRzYkprWZFMyF1i1gJtqUY+dZgH8cZDiYMG
	 UoJ3vRjbPJevw5b9OkhKT7YOp5ZkLaq0pbipEkqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405119AbfIGTz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 15:55:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40736 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfIGTz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 15:55:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id u29so7593890lfk.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 12:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=663xhzIHxf1pK8txAzNcnxHkg/IWtvcnbHcDk/Hfg2g=;
        b=M0wgqewNEoEY1SReAm1dZItv8C9F48pCqYdE249MYwIQuA6a9rDQ3vPZ1LWGw1upQB
         kJ/9CCrSG0gNE2Gwm1qOTEKQCzc3dQB/0i1U5m6mp+uZO3efppPPZoXX7FK9dlLnOSJP
         Hqpn9Ih4glGrGlUoRDU8T6+ayMV8VHlQJfvm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=663xhzIHxf1pK8txAzNcnxHkg/IWtvcnbHcDk/Hfg2g=;
        b=ncpMm0Xw2ZkzTxWsE6QGVhMeUnzIkmmPN+rBFq5IAGOANv9tbHicXDAy0YZ+gppJpX
         uaGfw1QNV86CA6EGMcIkpBZmmvWmsZ3rRwNEAEaVGmVapZ62exwPAUIY/Ed+GupQRIqh
         VqjagIYDAW2344g38lWQ/AzPtxEXYvBEf69s2Aee7EDSkYcJCl6HNFBJQBxQjDB3uk12
         rwG5ZvbrjZsWopAwcAMPkYGP9PCQ4qyjl8lCxH2SdjzMbVLPIvEGrOjzb+10lUCyIcPj
         8oXghRjSdvqeQ99oFdKe2H4ts82iWwWDg+R/e7xPcyFNHeVTX3Ih3y3o/wWxbwCmOvUj
         uX7A==
X-Gm-Message-State: APjAAAVUYfiz6Rn1cwWIvBGoWtI/Ri6NJgScGi8ReQHCbEaf+3eelP3K
        6bv1BJGs+MTArhBBuIS4Qwj8qU5YSbE=
X-Google-Smtp-Source: APXvYqw3Z2yPZppHXD9w2Yi8xG3NLX7KubU/IFl5Cal5TJVpIhlhxVDQ17Q6hWJvVPzdc6+I1JRulg==
X-Received: by 2002:a19:4912:: with SMTP id w18mr10650580lfa.93.1567886153924;
        Sat, 07 Sep 2019 12:55:53 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id l5sm1597799ljc.12.2019.09.07.12.55.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2019 12:55:52 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id a4so9052315ljk.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 12:55:52 -0700 (PDT)
X-Received: by 2002:a2e:814d:: with SMTP id t13mr10346678ljg.72.1567886152153;
 Sat, 07 Sep 2019 12:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1909041252230.94813@chino.kir.corp.google.com>
 <CAHk-=wjmF_MGe5sBDmQB1WGpr+QFWkqboHpL37JYB5WgnG8nMA@mail.gmail.com>
 <alpine.DEB.2.21.1909051345030.217933@chino.kir.corp.google.com> <alpine.DEB.2.21.1909071249180.81471@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1909071249180.81471@chino.kir.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Sep 2019 12:55:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifuQ68e6Q4F2txGS48WgcoX2REE4te5_j36ypV-T2ZKw@mail.gmail.com>
Message-ID: <CAHk-=wifuQ68e6Q4F2txGS48WgcoX2REE4te5_j36ypV-T2ZKw@mail.gmail.com>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote hugepages
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 12:51 PM David Rientjes <rientjes@google.com> wrote:
>
> Andrea acknowledges the swap storm that he reported would be fixed with
> the last two patches in this series

The problem is that even you aren't arguing that those patches should
go into 5.3.

So those fixes aren't going in, so "the swap storms would be fixed"
argument isn't actually an argument at all as far as 5.3 is concerned.

End result: we'd have the qemu-kvm instance performance problem in 5.3
that apparently causes distros to apply those patches that you want to
revert anyway.

So reverting would just make distros not use 5.3 in that form.

So I don't think we can revert those again without applying the two
patches in the series. So it would be a 5.4 merge window operation.

               Linus

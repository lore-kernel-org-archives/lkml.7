Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D5EECE589
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FF821A4C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="P+CATDmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732436AbfJALfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:35:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40843 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfJALfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:35:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id v38so11545115edm.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 04:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E97hATFqUaGgFuCNpdc4AOwFPOf5+SqGe40+poznacI=;
        b=P+CATDmh/jTPq0XwaKF/n39BSZeOuBW3MQRyxZHIuMawzm5eeqJlzJx5S1j7GSWLk0
         NoZoKF6YvxFPcNPncaZyHz14QW/Upj8jeWxIrD/s/DMC6j1fE45rj0wuIzPh7tI4hM3a
         L64HqPqorKlSORb5EsEy5NO0P7suoxa2BuiPbjUSwGQEvvfDqfOFvpnDC7QArSvORm8k
         SRtHEqeFXRnwCJLHk6hbsw8Nv8eDJQx8uHPvQROdrknp7WBsBug/Xlz41OXrxzBeZMNi
         u+uNGi0T6SLucoeifrnMlmbvX85ulTOL7X0rxNpHycpkwrzYlnrmEF0BabPkJlDgHLkr
         NZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E97hATFqUaGgFuCNpdc4AOwFPOf5+SqGe40+poznacI=;
        b=rRF+THOx7aKl0456u8WvvvNnc8ROizitFSmaauXckxNVAVekIHeBK6Hw/CnM1gKHwr
         hAINLLYIN1CgFZMcbfc3CCbK8A+7y162wYkQtQ944lJVcgwqdeUjemPRe717Ba89Bu12
         c+IKJGyaxBngc41kWXnXOYkHBcrVocLmTLNIZFBzURamSg95L+5bX588n2MLMeqiENQ7
         SFJr6yaqSBn2N5ruzriAyld7gGvw9nmgpPJexiSO2UhgpNLS1pvDc1cF1BnmvbGF2ba7
         HAH+GtBN00xr6MXoq9Xs4aktsLtZdMz1DYI/1HQ+umtAtD/IUzJJug32DgJyHejsHGY8
         y86w==
X-Gm-Message-State: APjAAAU3wV9LF8AYCcNzKQoe/guaJ2YG67JSDlRtScDhXgN924fyL1vX
        yKePPRZBIqPlvH8xk62fNNWgCQ==
X-Google-Smtp-Source: APXvYqw8wc+2HNPj2szS78WqBHuJJNXhqrNG97HJku+gxizOVoujL7OOXkpAqRPmfRsaWysgId8Osw==
X-Received: by 2002:a50:ce06:: with SMTP id y6mr24178667edi.282.1569929706062;
        Tue, 01 Oct 2019 04:35:06 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g6sm3087125edk.40.2019.10.01.04.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 04:35:05 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BC366102FB8; Tue,  1 Oct 2019 14:35:05 +0300 (+03)
Date:   Tue, 1 Oct 2019 14:35:05 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH v2 2/3] mm, page_owner: decouple freeing stack trace from
 debug_pagealloc
Message-ID: <20191001113505.kidbhjl7u2hawxvb@box>
References: <20190930122916.14969-1-vbabka@suse.cz>
 <20190930122916.14969-3-vbabka@suse.cz>
 <1569847787.5576.244.camel@lca.pw>
 <eccee04f-a56e-6f6f-01c6-e94d94bba4c5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eccee04f-a56e-6f6f-01c6-e94d94bba4c5@suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 11:39:34PM +0200, Vlastimil Babka wrote:
> On 9/30/19 2:49 PM, Qian Cai wrote:
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -3237,6 +3237,14 @@
> >>  			we can turn it on.
> >>  			on: enable the feature
> >>  
> >> +	page_owner_free=
> >> +			[KNL] When enabled together with page_owner, store also
> >> +			the stack of who frees a page, for error page dump
> >> +			purposes. This is also implicitly enabled by
> >> +			debug_pagealloc=on or KASAN, so only page_owner=on is
> >> +			sufficient in those cases.
> >> +			on: enable the feature
> >> +
> > 
> > If users are willing to set page_owner=on, what prevent them from enabling KASAN
> > as well? That way, we don't need this additional parameter.
> 
> Well, my use case is shipping production kernels with CONFIG_PAGE_OWNER
> and CONFIG_DEBUG_PAGEALLOC enabled, and instructing users to boot-time
> enable only for troubleshooting a crash or memory leak, without a need
> to install a debug kernel. Things like static keys and page_ext
> allocations makes this possible without CPU and memory overhead when not
> boot-time enabled. I don't know too much about KASAN internals, but I
> assume it's not possible to use it that way on production kernels yet?

I don't know about production, but QEMU (without KVM acceleration) is
painfully slow if KASAN is enabled.

-- 
 Kirill A. Shutemov

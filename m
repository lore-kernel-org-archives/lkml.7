Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7C0C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7FA20863
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="SSNNjgPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389931AbfIJJbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:31:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42902 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387801AbfIJJbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:31:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id y91so16384339ede.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 02:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nPUEYX1NKslohD2E+roi3GND2/I3OUXfvQ3XAcK+/GA=;
        b=SSNNjgPQ1LSHIFhAfZd4y0wYr0+CC4ozBTywesC/p7SttOr6N2R7mXpSTeUG7e5Asp
         r8Y/5rQ+0c4hRlG2zqaksGhlUOxOHvFvcWaPcfWbBQRLfk9F4xEpKsfnIlW6rWvwKohN
         RNGw0IM/rKcv+cvba+nXEbQz0fbZXP6AHWb68cHXdh8ePHUYqx+2OqRBCekHgvlyW+Sw
         P8Vkg+ZokeeLku2jJcT4X/bYAzCp+7R5R7yHqtsOA3sn6/NIShlu4GVTrZyZ9adTF5QC
         J0N4aHa7o44cenXBoTu5Me3EkOwY3YbZwKPp5kN8YgRpX8rQ34t4N+SuVkQb/4NR5Mgv
         w3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nPUEYX1NKslohD2E+roi3GND2/I3OUXfvQ3XAcK+/GA=;
        b=rTLUfxEOp/1X1sW3iMo8ypTSR74ZAx4tgMbnEHzuQLl6Vm17uiiXCezksFnO/ka2EH
         3YMDDDvheG3zBF0d6YTTxuRRF69Fj+Hq+YGt1x2Y1P739doZEVCrxYD0zBjAE1Mw1zA2
         evDuM4gLsFN9AKTUok7PWh9Ogw6jqVwWIC/kTk1uanM/71uWqaSQ59ecA6Ef9DwVxYFh
         LZiQlIpEsHB93301iXifapUmJ0rXu7nqaeBUKJkJ6xp89XbTA5gGODlSBMqPe84Lc9md
         E+RpmcKR5nYAS9N9WwQrbu8qWB2RvAjKw+tVOv19gjEggfGzYhVocoXXdI4SefpefVTE
         HmCw==
X-Gm-Message-State: APjAAAXlNLTvZxLmO4YeRTtR0QZYrWj5YdT/Hb+Yk1FR/hnMxcZoho+Q
        LgPeM7zFCO88jStJVWPkkMMhVw==
X-Google-Smtp-Source: APXvYqxCHutpkbRJfLAOgIJs9EabO82Ve9zSCkPCIkSC3X5ZdrOL0QaU2or0dKk75rTzC1h9BCUrgw==
X-Received: by 2002:a17:906:4f04:: with SMTP id t4mr23891798eju.190.1568107863856;
        Tue, 10 Sep 2019 02:31:03 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u27sm3463898edb.48.2019.09.10.02.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 02:31:03 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 9F3511009F6; Tue, 10 Sep 2019 12:31:03 +0300 (+03)
Date:   Tue, 10 Sep 2019 12:31:03 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v2 1/2] mm/page_ext: support to record the last stack of
 page
Message-ID: <20190910093103.4cmqk4semlhgpmle@box.shutemov.name>
References: <20190909085339.25350-1-walter-zh.wu@mediatek.com>
 <36b5a8e0-2783-4c0e-4fc7-78ea652ba475@redhat.com>
 <1568077669.24886.3.camel@mtksdccf07>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568077669.24886.3.camel@mtksdccf07>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 09:07:49AM +0800, Walter Wu wrote:
> On Mon, 2019-09-09 at 12:57 +0200, David Hildenbrand wrote:
> > On 09.09.19 10:53, Walter Wu wrote:
> > > KASAN will record last stack of page in order to help programmer
> > > to see memory corruption caused by page.
> > > 
> > > What is difference between page_owner and our patch?
> > > page_owner records alloc stack of page, but our patch is to record
> > > last stack(it may be alloc or free stack of page).
> > > 
> > > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > ---
> > >  mm/page_ext.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > > index 5f5769c7db3b..7ca33dcd9ffa 100644
> > > --- a/mm/page_ext.c
> > > +++ b/mm/page_ext.c
> > > @@ -65,6 +65,9 @@ static struct page_ext_operations *page_ext_ops[] = {
> > >  #if defined(CONFIG_IDLE_PAGE_TRACKING) && !defined(CONFIG_64BIT)
> > >  	&page_idle_ops,
> > >  #endif
> > > +#ifdef CONFIG_KASAN
> > > +	&page_stack_ops,
> > > +#endif
> > >  };
> > >  
> > >  static unsigned long total_usage;
> > > 
> > 
> > Are you sure this patch compiles?
> > 
> This is patchsets, it need another patch2.
> We have verified it by running KASAN UT on Qemu.

Any patchset must be bisectable: do not break anything in the middle of
patchset.

-- 
 Kirill A. Shutemov

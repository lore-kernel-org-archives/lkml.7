Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC34BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB044206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfDINb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:31:28 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40310 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfDINb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:31:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id w20so10204758qka.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 06:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iQ/be5gcP57ja8QS2fif8abmySnQekyGUoKgB6lvQBw=;
        b=OxhXml1n/xSOEaM5SsIVTMC9B8zJZchAcHJSY+kfj8GvkFvLtQNvr6UsVzdxlgGjHW
         +dFjYVmMV7oHzd9/vuZ5AA3vnn60t9ySy0wU1H/wIv2ZjUivSM4Kp8qRotkdHZsvl1CN
         FnW6A6Fves0BnQb3KeNEePHVIVslaRdzUAF0Xp6A2NBDnjtUlEx/ZDnFiTdhhpiyWYOW
         DI15e45GJNnxYoFErqAdREbKA9phpb66Ar/oWxUv+n3UvWhJL5vRk9Jz0wiCIEDwdL4l
         5USYpUxj57EaAZ2zysbqx4OK9egUzpvJHK5pXqluVoTfgOg7a8k0Y+KCii48uLQSCdis
         7BBQ==
X-Gm-Message-State: APjAAAUh1bw5YQUBhY6ZH0agda+1g1a8NtthnH3WIEB9/+M2mwDzMav8
        yoTjq3footKLfjyJboCvClpGvw==
X-Google-Smtp-Source: APXvYqxbrl9TI0FxmrWsS4ec//7ojsf+1C5OLlAEmLcfDwWlkw58TfVAGN4rnpu0WLtzYV73t8C/HA==
X-Received: by 2002:a05:620a:132b:: with SMTP id p11mr27788585qkj.279.1554816687062;
        Tue, 09 Apr 2019 06:31:27 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id m31sm23156297qtm.46.2019.04.09.06.31.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 06:31:26 -0700 (PDT)
Date:   Tue, 9 Apr 2019 09:31:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: Thoughts on simple scanner approach for free page hinting
Message-ID: <20190409092625-mutt-send-email-mst@kernel.org>
References: <CAKgT0Ue4LufT4q4dLwjqhGRpDbVnucNWhmhwWxbwtytgjxx+Kw@mail.gmail.com>
 <d2413648-8943-4414-708a-9442ab4b9e65@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2413648-8943-4414-708a-9442ab4b9e65@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 11:20:36AM +0200, David Hildenbrand wrote:
> BTW I like the idea of allocating pages that have already been hinted as
> last "choice", allocating pages that have not been hinted yet first.

OK I guess but note this is just a small window during which
not all pages have been hinted.

So if we actually think this has value then we need
to design something that will desist and not drop pages
in steady state too.

-- 
MST

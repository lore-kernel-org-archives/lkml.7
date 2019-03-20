Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F367EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD865218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="n/tRt296"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfCTU52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:57:28 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37284 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfCTU52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:57:28 -0400
Received: by mail-yw1-f66.google.com with SMTP id w66so3166545ywd.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7TKyPat2diHfhv30jcYBziI63YFmk+7ZB7yCGURrsOk=;
        b=n/tRt29629ySiX3AtuVlLNum1FJJFphZldMMdvbBJx3fBa56guOATGv7CDMkOuBIjc
         lzEk19RcZMpmyKktO8DEh7EwfhTBzl7o9eU0Dnrr5jS4Aaxpqsgj8GpD9CobgAurX7Lm
         jTxmvqZHeXYvEMnn0BCfStSfCjOKIrILFOF43AXJGjAl3Tx/DKnYj2mDeAG4or7XFeZx
         ToNeHbOIFyEwmFGYilxIy66E3+V0mVcRKqxsVdDKARJBx8Lv5Pno2YySaSBM8WEB6JSY
         Zey6IfsC58wGD+Wb1AoP1n+c6OLPw6xLrTGc2fFbfv5kfQaLcwxo95kPNMrGXjaf287S
         FLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7TKyPat2diHfhv30jcYBziI63YFmk+7ZB7yCGURrsOk=;
        b=su8gW9b231N1bLTLy+uJL88Ibr2M4CbcA3KW93pLfMIIbQUhr4/ZOGgZnBWK9xa6NL
         igTZaHrPOBnWNwJGc6YRHAlV5M2RdH7gph62q6M0esoZ3PhgjeSX+htH6mzSfYJtZyPB
         BVZCi2YQI+ZKnPJxpHBIaP3Mb4RwktsdMmyXY5+r/UyNbHLstQMsomxycU7uS36YYmua
         i05XDQ7f+6YYz3rhizJK+u3SC0fD2ACQv06mpW6DYd+szMolK5xsyDfD3g7rVRdT+t5j
         jdoEFwLgR+8A6SNGo7AkNye6pm4W7D29YvuEzc+iz814mnONi+aNQkeajmhinOeJn7SQ
         wVpA==
X-Gm-Message-State: APjAAAUd/6OhRPE4M03toHdSJ8Xrx611C6zj+BW6q74XOUWlP5XN3iaa
        O47mlrY+ekvmXdUh/FvPxnVK1A==
X-Google-Smtp-Source: APXvYqwOKUtGkLTUXQ0H0uuntHFrKcjih1M7U3TDMxpi3QF4joDAtykhux/4NWNJEPzjdQNr2cYchQ==
X-Received: by 2002:a81:5d8b:: with SMTP id r133mr110177ywb.361.1553115447491;
        Wed, 20 Mar 2019 13:57:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:b52c])
        by smtp.gmail.com with ESMTPSA id x12sm1578123ywj.76.2019.03.20.13.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 13:57:26 -0700 (PDT)
Date:   Wed, 20 Mar 2019 16:57:25 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v6 3/7] psi: rename psi fields in preparation for psi
 trigger addition
Message-ID: <20190320205725.GB19382@cmpxchg.org>
References: <20190319235619.260832-1-surenb@google.com>
 <20190319235619.260832-4-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319235619.260832-4-surenb@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 04:56:15PM -0700, Suren Baghdasaryan wrote:
> Renaming psi_group structure member fields used for calculating psi totals
> and averages for clear distinction between them and trigger-related fields
> that will be added next.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EFEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15F8218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="UlM3Ag0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfCTUzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:55:20 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45516 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfCTUzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:55:20 -0400
Received: by mail-yw1-f65.google.com with SMTP id j128so3125955ywg.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QQYLVXkrs82mdvyVr+o8qJgCSfJ2t/bxI7yFaYhe2ug=;
        b=UlM3Ag0sHjKm6b60Xzruo36+UDlJMrcULXCsz153tfTpIzb5RNHWobPLHgqI/mhWmy
         nAzG2b60WzKXMmT44qvypKs/MRK3dAvTvsH7FaGR2TvLZdw4/xJW8HsjT5RsKvT2l114
         IxT/BWtMIDwxGR3Rmfw37IsijmQCBbzByTYNMnfL5Pqrmqbt0ycHo6hbZZnw/ciMk73x
         cPcXJLfScHgpDqcmjbfZuTV1rp0MyTLNKhI28W8pS3bGyOp6RhItnuEcuUJOy2Kdykwv
         PxWIWOxISeF3vhf5selrKImaCqn1ve35lBZip8IjabpLC+gzrspIs30WY8hjdR6M7M8X
         2FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QQYLVXkrs82mdvyVr+o8qJgCSfJ2t/bxI7yFaYhe2ug=;
        b=VdAYV2DYjuic3J9pBFCpLfQGY3BWXWDjkD5ZpIDWs3d6Q53+9b5DETAAx1oPWWmFel
         2rYAQVnUiBG2jJhO3bwP84BgkJNJU1Fr/+bFZRydtfo0q0aCz3kbmHySvvC0e97oVPc4
         tDBLydE7CP37ORkvIgvnNUBLTLnbYUfQbk03YxxlPfZxPXO1WwioAaNJZkAgTGXGC4om
         mtJte5rb7uPp0AuavZX+uXv9lSzpkCHojx3yyx2TFvr5+LLudm1Au4lqiENs1YVLuvyc
         RJzjKA6iWt+5M17dnaibOOJ7vKfGCVaQiNIR3j0/XeZ9zdpeM0My2a/6/fh/ukNG260+
         OwMQ==
X-Gm-Message-State: APjAAAVneSpRNSJhVStqVR+oYvoZtHmwZuEO5/shvYPhbQ2dxeCEIrda
        4KJL7yfVFqaPsGwn/yshiPlO6Q==
X-Google-Smtp-Source: APXvYqyIbRSYuOZ+T6cPUs3nMP69qxZ/A1CkgW2QQVmoCqQ+qIU4OgICrzlh/aj/ZsVwMkaKM+QPbw==
X-Received: by 2002:a81:2c85:: with SMTP id s127mr107964yws.255.1553115319248;
        Wed, 20 Mar 2019 13:55:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:b52c])
        by smtp.gmail.com with ESMTPSA id j15sm1001794ywa.7.2019.03.20.13.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 13:55:18 -0700 (PDT)
Date:   Wed, 20 Mar 2019 16:55:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v6 2/7] psi: make psi_enable static
Message-ID: <20190320205517.GA19382@cmpxchg.org>
References: <20190319235619.260832-1-surenb@google.com>
 <20190319235619.260832-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319235619.260832-3-surenb@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 04:56:14PM -0700, Suren Baghdasaryan wrote:
> psi_enable is not used outside of psi.c, make it static.
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

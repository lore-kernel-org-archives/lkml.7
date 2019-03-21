Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A2BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608932083D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553175824;
	bh=tPXTA3tExjHYvCl0U8yOGW77eTnvySzweHtIvbC5220=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ojCZv6aLqcw96WR1ZINlJcQ0iHvZXNmgO0TwZErfFL+aauGXtXRX2lBy+9aXCmI8i
	 xtgDs+lmHqAWpp5snwQSizbJ4Mjr4sc1w4PiLKId/eGdNiQSaE21w0FWHjK0KeVIte
	 SKwRnlJ5hXXgjWxIdHcjYYJVy6Q6VNE/CHnl/yoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfCUNnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:43:43 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46058 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfCUNnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:43:41 -0400
Received: by mail-yw1-f66.google.com with SMTP id j128so4747138ywg.12;
        Thu, 21 Mar 2019 06:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tPXTA3tExjHYvCl0U8yOGW77eTnvySzweHtIvbC5220=;
        b=OyEWuiy1xHqsTxV0pslZuOu1930UBKZG875Hd6Qu1K/WllqMBmBnBdnkC9L2pZgUVh
         irqScVS951ENbHK6FbV1pJGs247D5ir8mxQukgXhVAT8p21pex3WlVihF/WM1qHSc7jp
         Jm3YPkh6CWKVWDq4aUM++i1LeU54Qdc036Hz6EVBq7DSshF3Tnr3lfKm3PpCiSSDeu3N
         efVCnPP4a0Mg57jUfLsIfcmAAlb93Zbef2N3YpM9HCt3wwX5pqPzjzDtULoip4txLA1l
         FRxZVmNeoa858zmeZOp6essQVrFZEF6j2sMUaI8IX/cj9gncyRQn3cSAPwc7nO7w+DvT
         QzBg==
X-Gm-Message-State: APjAAAX9XrlrbPfelrM24WGsZ7uEWlFmSHx6NQ9O7LQOvEM+k26qVf/V
        b+PbtmM0EyJlNQuwV9E/HTyz06I+1Jk=
X-Google-Smtp-Source: APXvYqw5PwOhd1NNd08+tnqkHFD93x8/dvdvJETQt4RzUQYDXMzJx9lmCJfqJW5NDLyJjwUYL9lIQA==
X-Received: by 2002:a81:2748:: with SMTP id n69mr3162674ywn.70.1553175820774;
        Thu, 21 Mar 2019 06:43:40 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id v77sm3451008ywv.79.2019.03.21.06.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 06:43:39 -0700 (PDT)
Received: by 42.do-not-panic.com (sSMTP sendmail emulation); Thu, 21 Mar 2019 13:43:35 +0000
Date:   Thu, 21 Mar 2019 13:43:35 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>, linux-mm@kvack.org,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] userfaultfd/sysctl: add
 vm.unprivileged_userfaultfd
Message-ID: <20190321134335.GB1146@42.do-not-panic.com>
References: <20190319030722.12441-1-peterx@redhat.com>
 <20190319030722.12441-2-peterx@redhat.com>
 <20190319110236.b6169d6b469a587a852c7e09@linux-foundation.org>
 <20190319182822.GK2727@work-vm>
 <20190320190112.GD23793@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320190112.GD23793@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 03:01:12PM -0400, Andrea Arcangeli wrote:
> but
> that would be better be achieved through SECCOMP and not globally.'.

That begs the question why not use seccomp for this? What if everyone
decided to add a knob for all syscalls to do the same? For the commit
log, why is it OK then to justify a knob for this syscall?

 Luis

Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7285FC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 04:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3852173B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 04:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="I+BSH0Gv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfHQEn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 00:43:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40258 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHQEn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 00:43:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so3908183pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 21:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qx7dTBSG5mnk9PlWmVRYTFFzE3XW/jirUbpR2SM2oiA=;
        b=I+BSH0Gvlmmo/v+XAvC4f1KctY9tlqWzkGt0C/mQ2gw5HOchK0I1p8OoJJlJnk0pQl
         JJ+dHLbFJAa2ESNGTwQuQzfyfmrkLybo+ACnkTe45dIo89s8tgvDBgH3qQXOFxzHiLNm
         PEbTOPapMI6eaczSnfX5GUDCNSho7F/8i3jsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qx7dTBSG5mnk9PlWmVRYTFFzE3XW/jirUbpR2SM2oiA=;
        b=tj68iCF7dD1iVuEHEaNjY7N1lI3Ea6a5HHgr9bh66CEzIhTQxAdmue5CP2USObcevh
         ZBNyRQokvfAqrKfDMOXHWxKlcW2KSYufRex2+/VHVjSe7qLr7p2NQ6ZfZ+BtWLTvVfKq
         P4rzb+jCuOC3S/uS2o1+CSPfHOmMXvkyZo+Ntw+/+ChuGspbxJ/zitENgZMYQ7BXXsoS
         S8IVtn5k3OYjFOz7tkKxAF77LHvK9A6yvzlCWbk8exn4zkjnkAwYZus/7PwWlMJ5s2YF
         4zHs/i9M7niCv9jKLGNNK9TXzDDzR+XBuPZNdNZF1RVfPqkdG2sDQ0EHn+k1UQpA9wb7
         mU0Q==
X-Gm-Message-State: APjAAAXk8wDyFUd9JVhu9twEbvqAbVtVlf7v/f3TnVzDU4mTBtxGzlVj
        nnLdYRaBHj2+nMtAZfHU88wumEM5FRo=
X-Google-Smtp-Source: APXvYqyBu3kIqgX8zTEo5NzvbBjhOsyHwgwMssvSZCuLP0+UnBJsxmwTNR4U2NeBP//sTg8GqJYqhw==
X-Received: by 2002:aa7:984a:: with SMTP id n10mr14319362pfq.3.1566017006016;
        Fri, 16 Aug 2019 21:43:26 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id q4sm12828431pff.183.2019.08.16.21.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 21:43:25 -0700 (PDT)
Date:   Sat, 17 Aug 2019 00:43:08 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH -rcu/dev] Please squash: fixup! rcu/tree: Add basic
 support for kfree_rcu() batching
Message-ID: <20190817044308.GA139754@google.com>
References: <20190817042211.137149-1-joel@joelfernandes.org>
 <alpine.DEB.2.21.9999.1908162131490.18249@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1908162131490.18249@viisi.sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 09:38:54PM -0700, Paul Walmsley wrote:
> On Sat, 17 Aug 2019, Joel Fernandes (Google) wrote:
> 
> > xchg() on a bool is causing issues on riscv and arm32.
> 
> Indeed, it seems best not to use xchg() on any type that's not 32 bits 
> long or that's not the CPU's native word size.  Probably we should update 
> the documentation.

I would endorse any such documentation effort ;-)

> > Please squash this into the -rcu dev branch to resolve the issue.
> > 
> > Please squash this fix.
> > 
> > Fixes: -rcu dev commit 3cbd3aa7d9c7bdf ("rcu/tree: Add basic support for kfree_rcu() batching")
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.9999.1908161931110.32497@viisi.sifive.com/T/#me9956f66cb611b95d26ae92700e1d901f46e8c59
> Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>

Thanks Paul! And nice to meet you again after many years ;-) Glad to see you
working on riscv.

thanks,

 - Joel


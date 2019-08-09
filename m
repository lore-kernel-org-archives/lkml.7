Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6624C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770FB214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MLDFO4GF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfHIU31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:29:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39412 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbfHIU3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:29:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so45442325pls.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 13:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A9NhgTl7zfb3l1+NKbkDU/P+hrZFZUgJYh8JpIsec0E=;
        b=MLDFO4GFjW+A+4D9jAGcXTdfEyXRibjGCZMZZ5cEKAKSUpleSuAJgryFida0cokfZq
         oApVkJ/APJFAV//OVXvzZNrwYnSrC75TeDz0WS6iedhnobDKVsLxx9AjkKAH6+y+HyhV
         iubniIEPLSFYfria85M3qoMT6UyFfMsUqYawE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A9NhgTl7zfb3l1+NKbkDU/P+hrZFZUgJYh8JpIsec0E=;
        b=RnonJfs2NZs4m4gg7Q7ckKhKDSr13VcKIwFz7UBpfn46e+lUNVlw5xIaFEp/2JkBUS
         1n5b1zSK5QmVkDZrBfws0DlUBnxn84N55NcneaWNrhsXMEnDQn9BYUbfym4KG3+j/6dU
         2V+hNIqInEME5ZzdIiRFLWHwSQQqfjMMqwoThPZaB5Db4Xh1YdptoStspiW2XqbuER7L
         tqQNTz3AZMyI9BSbyVZrL87pbHEx88Wka1B9UG5ftLfRl8fdfG0A63Yn5XRdIyGAyAQj
         OOk8xTGy2iIbuDtEtqEcHW1dHBym4h24rubqPLhGGjv3P2whqNIeRNQc8TDJtI09tmx4
         dF7A==
X-Gm-Message-State: APjAAAXFL2m1PlaV8C4YgrEIUZ7ihMyFz8+tZqtb7NnhW7JElpUu7q1a
        +hVEa2DADCJlb6NHAgQILI72Zw==
X-Google-Smtp-Source: APXvYqxAzSoqBoiHk7b+bAdo2F3seV7zxBnNzc1weazPV3iVfTuGK1yaJE3TB+II7IRyJkDlx9xARQ==
X-Received: by 2002:a17:902:ac88:: with SMTP id h8mr15447969plr.77.1565382562846;
        Fri, 09 Aug 2019 13:29:22 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v185sm110394406pfb.14.2019.08.09.13.29.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 13:29:21 -0700 (PDT)
Date:   Fri, 9 Aug 2019 16:29:20 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, kernel-team@android.com,
        kernel-team@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190809202920.GE255533@google.com>
References: <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190808095232.GA30401@X58A-UD3R>
 <20190808125607.GB261256@google.com>
 <20190808233014.GA184373@google.com>
 <20190809151619.GD28441@linux.ibm.com>
 <20190809153924.GB211412@google.com>
 <20190809163346.GF28441@linux.ibm.com>
 <20190809202226.GC255533@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809202226.GC255533@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 04:22:26PM -0400, Joel Fernandes wrote:
> > > > o	With any of the above, invoke rcu_momentary_dyntick_idle() along
> > > > 	with cond_resched() in your kfree_rcu() loop.  This simulates
> > > > 	a trip to userspace for nohz_full CPUs, so if this helps for
> > > > 	non-nohz_full CPUs, adjustments to the kernel might be called for.
> 
> I did not try this yet. But I am thinking why would this help in nohz_idle
> case? In nohz_idle we already have the tick active when CPU is idle. I guess
> it is because there may be a long time that elapses before
> rcu_data.rcu_need_heavy_qs == true ?

Sorry, here I meant 'tick active when CPU is not idle'.

thanks,

 - Joel
 

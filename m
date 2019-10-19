Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9FBCA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 15:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D770B21925
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 15:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSujy8Xy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfJSPvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 11:51:49 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45312 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfJSPvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 11:51:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id q64so9091356ljb.12
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 08:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T/AGAu62ovkqmmOaipnU4qwxs2oksLKTDo7XFRANQ34=;
        b=iSujy8XyB/9+LufsCiBp9n5mGxdaqfiezYUI0un1OjDum+O2GENbFfibBnvxTGOnHy
         Ik1w2XzMm5jeNF5fp5FjC9rRsqtq5BQi7FA5u9tbEOu/SYIzRlZ8JWtBPoy4nM3pap7V
         6DwJrb2xPySVxBaPx71Ywu7McX5gEnLlWjZLVe/YlvJEQa7zZL+Bwc30drr6Vra8jHsK
         GZ2dP0FWv11nLhl427O2i9ZdtR4H/Zj25KmYaRlYgIp4WWlsQV7dOb3VVZmmkAmNiQiL
         P/aXxUSPVNyY7Z/x1RBUpZ1A1WgZ5aUMikghQV85KyNzB2SjIBqyGEAOJ1JyTY5wl5q+
         bU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T/AGAu62ovkqmmOaipnU4qwxs2oksLKTDo7XFRANQ34=;
        b=pOdwG54hCHJJYfW6UDtUi3w8Xho5UbpQPa44T1Y/ec5021wJRPvPdp5VGasVVcaSID
         uFp3cX99WexvYQp+fpV4NzGHifbnv9yxNYVbTBnPLVI75YjPKgAI+RU6XqMuox4H8hJC
         rCM/7IQ84jU+UIC3xwE5iXIZ8pAykUHKvTVNBAIVPsY4kbxcJsQ+T9RbdjRHtVRdGopn
         YR7WuxYNWKDQHn/hbcRNGtz43CSJubE90/VWU4NgECPl9rRu24EXaP/VOZx+esF6HBaY
         W/w3LlibiwsV5WlTrsC+rGMhfP//tQEQ2JOCoRNSjX5tLj21LCbjxr9aHSyJGEP5AJW8
         jt1Q==
X-Gm-Message-State: APjAAAWpqxXB8MOSyGSMyd/PbjSU2aOh5vSQK/D/x+ZlD5MsBKImefEE
        4IyYEITAVE+o7MZB3Ky55dk=
X-Google-Smtp-Source: APXvYqzrzVT4jLUO81aUaygCshaJH6cPq2ieZ6ehY7potGY6gHloPziZZZxHJsVFWT416QG6SSNbzg==
X-Received: by 2002:a2e:9b02:: with SMTP id u2mr9865388lji.50.1571500305667;
        Sat, 19 Oct 2019 08:51:45 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id h3sm5903773ljf.12.2019.10.19.08.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 08:51:44 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sat, 19 Oct 2019 17:51:35 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 2/3] mm/vmalloc: respect passed gfp_mask when do
 preloading
Message-ID: <20191019155135.GA13781@pc636>
References: <20191016095438.12391-1-urezki@gmail.com>
 <20191016095438.12391-2-urezki@gmail.com>
 <20191016110604.GT317@dhcp22.suse.cz>
 <20191018094049.GB8744@pc636>
 <20191018185856.1a77fc3a14a58ec18ca76a59@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018185856.1a77fc3a14a58ec18ca76a59@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 
> > > This is explaining what but it doesn't say why. I would go with
> > > "
> > > Allocation functions should comply with the given gfp_mask as much as
> > > possible. The preallocation code in alloc_vmap_area doesn't follow that
> > > pattern and it is using a hardcoded GFP_KERNEL. Although this doesn't
> > > really make much difference because vmalloc is not GFP_NOWAIT compliant
> > > in general (e.g. page table allocations are GFP_KERNEL) there is no
> > > reason to spread that bad habit and it is good to fix the antipattern.
> > > "
> > I can go with that, agree. I am not sure if i need to update the patch
> > and send v4. Or maybe Andrew can directly update it in his tree.
> > 
> > Andrew, should i send or can update?
> 
> I updated the changelog with Michal's words prior to committing.  You
> were cc'ed :)
> 
Ah, i saw the email stating that the patch has been added to the "mm"
tree, but i did not check the commit message. Now i see everything is
sorted out :)

Thank you!

--
Vlad Rezki

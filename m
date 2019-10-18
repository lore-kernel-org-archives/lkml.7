Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAD2CA9EA3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CBD21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBv/GTlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407778AbfJRJlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:41:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41397 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389109AbfJRJlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:41:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id f5so5524003ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 02:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FaqhYpk8/vEXz6AyAyq6XdJfdwEpVbnl8qtLLXSCjzU=;
        b=KBv/GTlWHcfp48EqhdfNng4cY0v8E8BlIOjghU9vrW1AIMRJJslFn/IUm3tuZudMMm
         ntgbzQo+rBkaTyRuiUjQTN18gJF8PtMG8AOQwuLopRfrZX4ERIHIYRvey+kPwlJpJAry
         xuO4t1yim1gmKAgLZmGuPwwRvMMjq8U2SJ15AJQzYvV4vJ9vE77xngJlKWMwDGeR7vsE
         uQtEWfhvHAVDsh6eGnjTSdlZktlQYub0FodHqeluJ4Yr51VxYi/lZPb9iotNENOhrnCA
         uJBYxOx7vg7loiTptivSzIPO9iFLzzjS93DPEY6zuztGba4wXvdJ6QAk/cCbjkMNj0rq
         GkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FaqhYpk8/vEXz6AyAyq6XdJfdwEpVbnl8qtLLXSCjzU=;
        b=n4YIe9Hnk1Ioy2CNggm7msABwdyZYGLMU6AN0Yonw1IFd4NcAPhS4iLFVAMXiWwTQN
         0tykCqgxXM1nXfxQdqXDPopDhgL9xYuBdIVvvEze/dwOdgKFDgCsOMolrT7PLHS1zvMf
         aEdBbfrmhhCPA/XlG+Qiu22vqoeb1mTJ43y7eUHC3wIIDYRH1r4BvQZj+Ux1vxIU5ILt
         zLdR7USg9ejIw5hSfgbYPTJDlvUJ3cF/4xzgzyr+M+Dza8FwjuTa5sa1dvJXQI/FxpkH
         U50ubKm/6FpV67pqNu3NVwJs30d7TtzSH5RyAc0FLpC5oDKp4hE1iPhlGa71e/nsVJiv
         dbBQ==
X-Gm-Message-State: APjAAAWLlmmcXuEZUUy7HNwJxpppl5CKvl872EhzmIqJIEA7eNsbhSrl
        kRkCwjplxmDQgNNXQ2IP9Vo=
X-Google-Smtp-Source: APXvYqycdQ7AhAX+shpXYAMhzOz05krOqyr45JSNDo9nzzzaNpIEsoiAOmL24cPaVOexJIaU9gErHw==
X-Received: by 2002:a2e:2943:: with SMTP id u64mr5616305lje.241.1571391678535;
        Fri, 18 Oct 2019 02:41:18 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id a27sm3395039lfj.48.2019.10.18.02.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 02:41:17 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 18 Oct 2019 11:41:15 +0200
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 3/3] mm/vmalloc: add more comments to the
 adjust_va_to_fit_type()
Message-ID: <20191018094115.GC8744@pc636>
References: <20191016095438.12391-1-urezki@gmail.com>
 <20191016095438.12391-3-urezki@gmail.com>
 <20191016110722.GU317@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016110722.GU317@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 01:07:22PM +0200, Michal Hocko wrote:
> On Wed 16-10-19 11:54:38, Uladzislau Rezki (Sony) wrote:
> > When fit type is NE_FIT_TYPE there is a need in one extra object.
> > Usually the "ne_fit_preload_node" per-CPU variable has it and
> > there is no need in GFP_NOWAIT allocation, but there are exceptions.
> > 
> > This commit just adds more explanations, as a result giving
> > answers on questions like when it can occur, how often, under
> > which conditions and what happens if GFP_NOWAIT gets failed.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
Thanks!

--
Vlad Rezki

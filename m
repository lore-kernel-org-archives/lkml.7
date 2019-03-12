Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324F2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F185E214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDUdImna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfCLJel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:34:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38315 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfCLJel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:34:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id n125so1400538pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 02:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BPYxN4cvUVjTLq6adpD+hkVjKR+C4kmufX0TRKSyCsI=;
        b=eDUdImnaxomiTKtFloiIoMcubwQt7tjptJNw0Aq1wTm5i01v5CIoxZtwHFcWVFWvAy
         baviP5ho+35p6q0M4EfryeJAg3PqVhVK/tvyyNjtcjkQKnfN4dAlUK1sCSIgpnyHo0OW
         6ZjbQEN+/TUTmmvLsalmGI+0da9SXS8Nox8ETN6LoZnyQ2PMdXTZHnkRh7U13RluISPs
         Bv2JRVuNmwT7yL2To8x+yhFJDKCuvK0hQLOGO0sOcb8OJdXaoWRPiOMtVtJuk3u6KR5B
         sE0HqEbbfPwg2yj3tAHWK89tGMvmWAGF5rrL7Kc2+qPsB8n9Jj3k4lJRRQW49sf2yEuV
         NtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BPYxN4cvUVjTLq6adpD+hkVjKR+C4kmufX0TRKSyCsI=;
        b=acc8WRo3RlJxcigNo34c3DRtckJ6mAZHyzG1axhGWgUgtwhwAXFJE46w5+W+8NOr3T
         Wsso2s1h3tCCjx691ckiTRtCXQUe0Ix3uJOHgKdkswMHCReQ5NXKXRNakeqZNtEU5opc
         xZj9iPo51jhZkQ12H3BWgpmjr98EoycP2eW3TuoD486E1Q5CaH3r0bR/pvLYQ3/wRYrT
         rfZ6yNIVvaQFUA4QgnEb9fW0FH6mrcLMk1EhvC6ciCqyVOEK6SsgqUs7zhSYfU7bxgvr
         SngiBRdMdi2d2zsoYY8JAj7WhyeqjAQna8CCd2dyvel9mnZ63t/qM8LuvDA59ddhVpJb
         6OfQ==
X-Gm-Message-State: APjAAAWHjjm3pnviP0yGOkAiGC9J/ZVqlZhCqa+SjEc4ln/SgIbsbco5
        Dr+HCelDarwbi2qWjHJIvyE=
X-Google-Smtp-Source: APXvYqyRsMsm7fVDZzFUYvDR3v4f5eLXsqJIm/BRs0gqAvNu7Q6baA1WQVpV2s9XnS06pApOCsDy7A==
X-Received: by 2002:a62:4214:: with SMTP id p20mr12143583pfa.204.1552383280034;
        Tue, 12 Mar 2019 02:34:40 -0700 (PDT)
Received: from localhost ([175.223.49.170])
        by smtp.gmail.com with ESMTPSA id d6sm12263572pfg.47.2019.03.12.02.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 02:34:38 -0700 (PDT)
Date:   Tue, 12 Mar 2019 18:34:35 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: kmsg_dump: Mark registered flag as private
Message-ID: <20190312093435.GA15673@jagdpanzerIV>
References: <20190310200302.GA11096@darwi-home-pc>
 <20190311124905.GA416@tigerII.localdomain>
 <20190312091810.gm6q7ao6u2lpsnqh@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312091810.gm6q7ao6u2lpsnqh@pathway.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/12/19 10:18), Petr Mladek wrote:
> > >   * @max_reason:	filter for highest reason number that should be dumped
> > > - * @registered:	Flag that specifies if this is already registered
> > > + * @registered:	Flag that specifies if this is already registered (private)
> > >   */
> > >  struct kmsg_dumper {
> > >  	struct list_head list;
> > 
[..]
> This is another field in the same structure. There are 4 other fields
> that are described as private by extra comment. Thefore this patch
> might make it more consistent.

Well, no objections from my side. At the same time nothing in kmsg_dump.h
suggests that "(private)" stands for "protected by logbuf_lock". Even more,
that struct has another "private" members, which are protected by
logbuf_lock - cur_idx, next_idx, cur_srq, next_seq; except when they are
not (see kmsg_dump_get_line_nolock() and other _nolock() functions). So
"private" has conflicting meanings.

struct kmsg_dumper {
	struct list_head list;
	void (*dump)(struct kmsg_dumper *dumper, enum kmsg_dump_reason reason);
	enum kmsg_dump_reason max_reason;
	bool active;
	bool registered;

	/* private state of the kmsg iterator */
	u32 cur_idx;
	u32 next_idx;
	u64 cur_seq;
	u64 next_seq;
};

> 
> Well, I am not sure if it is worth it. Andrew?
> 

Agreed.

	-ss

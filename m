Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6327C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858DE2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574671263;
	bh=MenO7hS/yRhu9zl/G/SpFxZWpzIUCQ3XlKEqf2FCD8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YF2AIggKAK2+Jnl4bpCUfLIjgX7ihcw4p5pvDQ1ZcXVG+2AAin6C8fOb15NVoi9hJ
	 9uBX4mAtIdas33C/2BXLXvnSjIIlgSGmsUbesuhGCOhgJfyKTultTt5HdwN7jST0V/
	 yMqybARQMuoGkGM6KRQZrGR8RAfUPOf9rewhtWzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfKYIlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 03:41:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50181 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfKYIlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 03:41:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id l17so14438191wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 00:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jBkEVM1ZML9yppqM2XGG1VzJZp8iZsSYQ50Ax01TjF4=;
        b=NQA3kDUJ8SYs3rtunn7ievWeAbd23BESi365VFbQymjruqn7xpSxK6x7pekLWLrphm
         ym0MkRNv4BmJ92DKYQzKRZe6pv1pJ/RZFeMmKE8bENms1CFxWrVvsVKfG6v1oJ67uQD+
         gx+qzRb+Z/AUuxSHmxaGuIQab7T6gZpPCIrY1w47wLdZas1TeTNkbBd4BX+gXiw1NZ+4
         ytEJtUGFIfUbIq/gmg/E0tOVRfUMbX735hmTtbJPj5LPTI2BM1i/XGxHLZ75DZxOAEOe
         obqsedzIjHoR7JphDO128ETp7G4wKEhOfSotd7KjTp5kadN1xc8dMgbgFlBDGOy81uQl
         W8vw==
X-Gm-Message-State: APjAAAUIQCjUc8kdk4S2CC2WztEwWjATxmLaPMyhmStHV5AZCaZQOU0q
        Z5Wh7TGFzyEcylcQZbWolQc=
X-Google-Smtp-Source: APXvYqzYLiBWDU9gior4n3WX5fyulWr1KDwvTOmKNx/1LFUP4ZLZcQE6+Xf7GcxPfhAdk9oQKXqP0g==
X-Received: by 2002:a7b:c8c2:: with SMTP id f2mr26246965wml.99.1574671260222;
        Mon, 25 Nov 2019 00:41:00 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id o189sm7943305wmo.23.2019.11.25.00.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 00:40:59 -0800 (PST)
Date:   Mon, 25 Nov 2019 09:40:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pengfei Li <fly@kernel.page>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC v1 00/19] Modify zonelist to nodelist v1
Message-ID: <20191125084058.GD31714@dhcp22.suse.cz>
References: <20191121151811.49742-1-fly@kernel.page>
 <20191121180401.GL23213@dhcp22.suse.cz>
 <20191122230543.2f106c80.fly@kernel.page>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122230543.2f106c80.fly@kernel.page>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-11-19 23:05:43, Pengfei Li wrote:
> On Thu, 21 Nov 2019 19:04:01 +0100
> Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Thu 21-11-19 23:17:52, Pengfei Li wrote:
> > [...]
> > > Since I don't currently have multiple node NUMA systems, I would be
> > > grateful if anyone would like to test this series of patches.
> > 
> > I didn't really get to think about the actual patchset. From a very
> > quick glance I am wondering whether we need to optimize as there are
> > usually only small amount of numa nodes. But I am quite busy so I
> > cannot really do any claims.
> 
> Thanks for your comments.
> 
> I think it's time to modify the zonelist to nodelist because the
> zonelist is always in node order and the page reclamation is based on
> node.
> 
> I will do more performance testing to show that multi-node systems will
> benefit from this series of patches.

Sensible performance numbers on multiple workloads (ideally some real
world ones rather than artificial microbenchmarks) is essential for a
performance optimization that is this large.
-- 
Michal Hocko
SUSE Labs

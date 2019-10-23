Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9430BCA9EBC
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF172084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WiW6N27n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404857AbfJWS5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:57:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42897 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404756AbfJWS5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:57:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14so12654596pgi.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 11:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0A/h7iLy4iHQtSsekrwsy2+ZOdTrZGwWLZDqgK94iTI=;
        b=WiW6N27nIGzcNodI0rwBgBHNHkWhgXetcPMk3sdC5v3k+2c7+jvFI5wUsKX4vYKVPH
         b57QDME3T4453VBQh06dbHYs6/6qkpCpi0D7ju8F43it9oOGgqfNMtOdrAL5brWnRLSS
         rwgowlv51ncyLoxqhU3EOUYYJkA5tDHaqYs2XN40yA8QKDGDGLYTyLNtHeto5ImmKaE8
         QWU8n15oNlqodMsKE8FfF0uxDy7Zowk8Pxn8i6HJ5dOgEtI6yyFxxjLuFOeV25s/Chw3
         re2XRlgnj4fuCwCWA4goBXL0qgQhWTezgUeEhuALaZtaGGUmvvAn/HRef6Irqh0Ony+u
         dT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0A/h7iLy4iHQtSsekrwsy2+ZOdTrZGwWLZDqgK94iTI=;
        b=D58MJ1e/JtjzYy5hgkWoZEF2nwr55KXAaAcuSwnGI6bKGaUgbl2mbcwmgAxc7v+fkT
         qbxAbwM0B77wT4DzF67AOlDWziqjEAlQfr9iY6VeviKoX3duzMhQz/4Qq5qcqJb1K7hH
         NGkH0WHxMcoudxIuD68CdKvfBH1P6jm1AiEEOmFA/6JQYKQ0oEWNR5TNt7unELnWE/Kl
         0OufQrqA08qVnIMYlL02Hj88QuesdRx0P/tod6zHArF1gPjiRDxUeu1vj9hJZrLfUfqV
         b4XngSQalL5H47PHORLBSEcwBk+RqxHgDtpF0b3BcbWQp3LSSwNJODT2b5yU0WdR3Dqf
         7krQ==
X-Gm-Message-State: APjAAAWZy3POPZ6fUHnvQi8+4onnwPBOzPVik3cmNU9K0jxtM9FtmOXY
        jCjENQmkwP1HIo9nWeiycHlVgw==
X-Google-Smtp-Source: APXvYqx13mXWJwGmMU4WM10j2g/LqTaCcPjmA9goHOXK5t7jCgjGf6iFQ4JS3U1on9Dm5nlm2nm2MA==
X-Received: by 2002:a63:fe15:: with SMTP id p21mr11544514pgh.26.1571857068258;
        Wed, 23 Oct 2019 11:57:48 -0700 (PDT)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id w11sm30045956pfd.116.2019.10.23.11.57.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 11:57:47 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:57:17 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     Matthew Wilcox <willy@infradead.org>, hughd@google.com,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        gavin.dg@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [v2 PATCH] mm: thp: handle page cache THP correctly in
 PageTransCompoundMap
In-Reply-To: <792ea136-4fa0-c87b-9399-5ca47c501c9c@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.1910231144490.1088@eggly.anvils>
References: <1571850304-82802-1-git-send-email-yang.shi@linux.alibaba.com> <20191023172420.GB2963@bombadil.infradead.org> <792ea136-4fa0-c87b-9399-5ca47c501c9c@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019, Yang Shi wrote:
> On 10/23/19 10:24 AM, Matthew Wilcox wrote:
> > On Thu, Oct 24, 2019 at 01:05:04AM +0800, Yang Shi wrote:
> > > +	return map_count >= 0 &&
> > > +	       map_count == atomic_read(&head[1].compound_mapcount);
> > >   }
> > I didn't like Hugh's duplicate definition either.  May I suggest:
> 
> Thanks, Willy. It is fine to me. Will take it in v3.

Agreed, that will be better.

Hugh

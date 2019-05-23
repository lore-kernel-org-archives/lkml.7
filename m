Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7F6C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA4020851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY/HQXW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbfEWLt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 07:49:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34686 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbfEWLt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:49:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id v18so4185893lfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YevW+X+2+POPi7PMf63t0Xk4zVo6kPahAFQzxSKuB6A=;
        b=BY/HQXW/klTF568pBiSEXjI8idFQLdUtOcmhIaTb6gq+YhCaklihF99CBnhri+5r0v
         cLFUwZ/n/tNUMFXdr+/mkWC0Xe1IPnH4w80SbAKPjH3u3bv2G/gUG8DGHv7gzA+d0Sli
         2iUmfXZexxYgS8DmUKKCQ69WOKBr5mGMKB6RmDc93Bn8/kWgvHnb7jEY8ZcOx3nbWLFM
         RL5dkF2ZuIKaPN7BUqq9IuGssUQikoO6qgf2ocbX+VgTJa4I/otp1g3k57PrB+bT9NP9
         TQBWG+vDovPa7mV0qXPq6Aac21hymbSGq1bLBt6OKVeWSbXwQYvZ2LEBLsLkoZoQZncL
         zz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YevW+X+2+POPi7PMf63t0Xk4zVo6kPahAFQzxSKuB6A=;
        b=qAyFtUIaGdrYSTHyDtStR/e0tvC/91KaLrgIOha7zhJhNXNyu7oATjiWH3Fu6kzg6U
         bItWq0i4jeRLlr0757T5zdQCMNxf88Fs909UaHFMGTiCN6pkLmTfjgPZyhngaOP2C4ML
         snrVqq2QxF6Df3KXG35jFyYlCoy6mEGUFA5H/8Pc1u6aL/eNExZjT5jVXMKE4xsqQxNb
         uHpRC+IagRijNBXdF+MsHdZYsJLHZe7FLT/kEposygx6K0NCyUIkiukBJqZlueM8zsZ9
         lUiZEXIeYCkvbjHy3iJ+UAJlEcZUHJ7Mq8z4S8nWzS58CR7+I5buNDmwxcxKyphl/kJ0
         HZfw==
X-Gm-Message-State: APjAAAX3pHJYUedeyJ/vfKeIWlihzcfc6OJZMw6BLxCZDkpz3RcRxHjU
        ydgOyKFWwWbTW7tGb8VwNn4=
X-Google-Smtp-Source: APXvYqy4q/Gsv+Imt0hcA2GhAtXoLBa35Ypwc9Y67jsM17tDnshGvZ1t6u/2M9JridJ/nRnly/zAlQ==
X-Received: by 2002:a19:4811:: with SMTP id v17mr40677474lfa.10.1558612193842;
        Thu, 23 May 2019 04:49:53 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id y3sm5920528lfh.12.2019.05.23.04.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 04:49:53 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 23 May 2019 13:49:50 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] mm/vmap: get rid of one single unlink_va() when merge
Message-ID: <20190523114950.cugrtqcz5hleczyd@pc636>
References: <20190522150939.24605-1-urezki@gmail.com>
 <20190522150939.24605-3-urezki@gmail.com>
 <20190522111911.963fbb4950e051a35e92887c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522111911.963fbb4950e051a35e92887c@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 11:19:11AM -0700, Andrew Morton wrote:
> On Wed, 22 May 2019 17:09:38 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> 
> > It does not make sense to try to "unlink" the node that is
> > definitely not linked with a list nor tree. On the first
> > merge step VA just points to the previously disconnected
> > busy area.
> > 
> > On the second step, check if the node has been merged and do
> > "unlink" if so, because now it points to an object that must
> > be linked.
> 
> Again, what is the motivation for this change?  Seems to be a bit of a
> code/logic cleanup, no significant runtime effect?
> 
It is just about some cleanups. Nothing related to design change
and it behaviors as before.

--
Vlad Rezki

Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32B2C48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAD52084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="AKwtxhlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfFUMzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:55:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44474 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfFUMzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:55:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so6718295qtk.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 05:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AmV2+dUM73e06WwcPyFpqf/fAKS1T6gQn0zr0KXsJgU=;
        b=AKwtxhlES3SluAiJmC4fHfZzQIZr6NUzu5K2S/r8+Waw+ZGRthsBAeI1/X4Gu6crZ4
         JmrOO4AwR4dG9YlWuzlGGy2YsbTZ5bGzbzL75yCIwMHnO6BfWAP99qnS3GgfU0ZYrKU3
         vWMr3E5+Fq6n8AWz3bMC+W8M9NsOrWUpHx+zfGdjPcjEiqnWLlGoDTvJ+7lKdMnzMAI1
         hXGhqSCU/T+DZpcUps3hUkMzUP+Q2QHL6p+rCtNwhLT5ZRCUhoGTfy6Zy4AiRCsxK3mq
         YU/egKBKFASfeIdn/ARK6dxlL5tC3murZmI2bBh8Iq7M/VtjSv6QfohJHzLTWXLmphlk
         4fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AmV2+dUM73e06WwcPyFpqf/fAKS1T6gQn0zr0KXsJgU=;
        b=M4/xb1aQF/kEjc80zj2SJ9JZuC93Wl1+Cb6WpwkNCXn81+E+cc5Uid4RbTgloPgapF
         AkR5Cx3SbX0wJnTTfWMn1yfknvCeFWY5lbelBwCZXnUhJL4CQCn8XzQaWCStohr3z0Lq
         XZd4iHwCTCaMDpUB1HjHss3bTu1s5F8poos6HZuVCDFxv+IEsQD0cSSeWv84O53ZRGm+
         eGV0DIaAdjVPOdE2RDya9hyQuOYVdJCZuDrh7UR2k3h+lhhE85iqZ1G2yIpsNkupo7ju
         slqDTAJ/2ytsPpeskeK4ull5nDbAiJBkVNjwRdyyk9kg1ewYfMLB3kDsvKlraTGKAnFl
         NniA==
X-Gm-Message-State: APjAAAX9JokK2tiQsA0VXynPPAqU3okpjxnUbFIzFwBK3aZnqUoOCMAN
        +f5QYsyxD6fK2VFJzlHaxXzAbg==
X-Google-Smtp-Source: APXvYqwxtg5a6XoYMpMcxIBPOmmfaEaKkS2AWcyFeFyXLLxCpnNs049plHm+A4MWArI+IrDLJ+TCJg==
X-Received: by 2002:ac8:282b:: with SMTP id 40mr86139772qtq.49.1561121747830;
        Fri, 21 Jun 2019 05:55:47 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s130sm1209636qke.104.2019.06.21.05.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 05:55:47 -0700 (PDT)
Message-ID: <1561121745.5154.37.camel@lca.pw>
Subject: Re: [PATCH -next] slub: play init_on_free=1 well with SLAB_RED_ZONE
From:   Qian Cai <cai@lca.pw>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, glider@google.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 21 Jun 2019 08:55:45 -0400
In-Reply-To: <201906201818.6C90BC875@keescook>
References: <1561058881-9814-1-git-send-email-cai@lca.pw>
         <201906201812.8B49A36@keescook> <201906201818.6C90BC875@keescook>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-20 at 18:19 -0700, Kees Cook wrote:
> On Thu, Jun 20, 2019 at 06:14:33PM -0700, Kees Cook wrote:
> > On Thu, Jun 20, 2019 at 03:28:01PM -0400, Qian Cai wrote:
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index a384228ff6d3..787971d4fa36 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -1437,7 +1437,7 @@ static inline bool slab_free_freelist_hook(struct
> > > kmem_cache *s,
> > >  		do {
> > >  			object = next;
> > >  			next = get_freepointer(s, object);
> > > -			memset(object, 0, s->size);
> > > +			memset(object, 0, s->object_size);
> > 
> > I think this should be more dynamic -- we _do_ want to wipe all
> > of object_size in the case where it's just alignment and padding
> > adjustments. If redzones are enabled, let's remove that portion only.
> 
> (Sorry, I meant: all of object's "size", not object_size.)
> 

I suppose Alexander is going to revise the series anyway, so he can probably
take care of the issue here in the new version as well. Something like this,

memset(object, 0, s->object_size);
memset(object, 0, s->size - s->inuse);

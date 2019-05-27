Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39AFC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEB121721
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/ydN1Qy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfE0Jhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 05:37:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45572 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfE0Jhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:37:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id r76so3319494lja.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 02:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kctcpWSb6oxF6cOmVvTIWupimplFMZMcqonrB1e6g1Y=;
        b=W/ydN1Qyl8v5mSPMC+AZod6ZCCjUVZFtwLA66FeIV2evNnAKXqdQ36FAjN7b+FpvMm
         xwnA7XEwzmkfXTPqL2YMTvqqOnsVMUkBPJl+LFZB6K6ytAyPBgTpOkbQelKbD95IYxzN
         SlnT3a8EsOlYJd3I/5XwbPr+6DRpTKyK3pGlaqb04VUvn10cYC0fe6o+NlRcwkHuCHLj
         8PUtSXw/mPLYr+++6p8kGdqhnhdji+IV8SqB3QQxAP/MQGE5k2WqHDXApzTSKRg9QXar
         7wvda5YYkNl46ZJ70QVbgTysmgQ+ziuCRz8OeItS9/kGMC4YuBpzYNFZdfEOrfjSCNn2
         nG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kctcpWSb6oxF6cOmVvTIWupimplFMZMcqonrB1e6g1Y=;
        b=aFeivQBy1L9c/QJmGC0s9WR9pAtHFfOsclxiuJzgKZI3oxr2Ngt+j4RY1RfSbo5JLu
         m3W37hlY58UuWbyKTMdKtum2+JD7M5/ckVv2lD1dECnErRhxX+qVFFSvI1VjiPJ4YPQO
         Oz3SWkFxShuo8oNeRH1yZVmo5rC11mACA0lAmw71rXiJpjf6c0GtRt4r/9QGTTedxNGM
         dRSoJkKKbdlNw6wdscKj5wtXcf6EaFUh1/3n3W59Sqat4j4hlYIkO3Qk34oT+pw2TdiD
         Sge155nXWKg6BipY0KyfQfEnjV9oaRN6c6XzZryCMAAXQC8alHTzg5x1ETlpP1z207oS
         kUgA==
X-Gm-Message-State: APjAAAUPu92WBHObAVh0EkQ8u4c2wDoxZhURDxcVrsR2KuBAQKPYHNGJ
        5G6CObVGfvsIXA9lAkMzAdc=
X-Google-Smtp-Source: APXvYqy6Wo+D10qjtgxCpBFfuPhQESOXYViGWczEP50sAynUvr8AHNbiFilHgTBskTScDN8+ZfCIrw==
X-Received: by 2002:a2e:6545:: with SMTP id z66mr37392510ljb.146.1558949854180;
        Mon, 27 May 2019 02:37:34 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id t22sm2180872lje.58.2019.05.27.02.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 02:37:33 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 27 May 2019 11:37:26 +0200
To:     Hillf Danton <hdanton@sina.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 3/4] mm/vmap: get rid of one single unlink_va() when
 merge
Message-ID: <20190527093726.fmbsgyek6ofrniup@pc636>
References: <20190527030712.15472-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527030712.15472-1-hdanton@sina.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 11:07:12AM +0800, Hillf Danton wrote:
> 
> On Mon, 27 May 2019 05:22:28 +0800 Uladzislau Rezki (Sony) wrote:
> > It does not make sense to try to "unlink" the node that is
> > definitely not linked with a list nor tree. On the first
> > merge step VA just points to the previously disconnected
> > busy area.
> > 
> > On the second step, check if the node has been merged and do
> > "unlink" if so, because now it points to an object that must
> > be linked.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> 
> Acked-by: Hillf Danton <hdanton@sina.com>
> 
Thanks!

> >  mm/vmalloc.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index b553047aa05b..6f91136f2cc8 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -718,9 +718,6 @@ merge_or_add_vmap_area(struct vmap_area *va,
> >  			/* Check and update the tree if needed. */
> >  			augment_tree_propagate_from(sibling);
> > 
> > -			/* Remove this VA, it has been merged. */
> > -			unlink_va(va, root);
> > -
> >  			/* Free vmap_area object. */
> >  			kmem_cache_free(vmap_area_cachep, va);
> > 
> > @@ -745,12 +742,12 @@ merge_or_add_vmap_area(struct vmap_area *va,
> >  			/* Check and update the tree if needed. */
> >  			augment_tree_propagate_from(sibling);
> >
> > -			/* Remove this VA, it has been merged. */
> > -			unlink_va(va, root);
> > +			/* Remove this VA, if it has been merged. */
> > +			if (merged)
> > +				unlink_va(va, root);
> >
> The change makes the code much easier to read, thanks.
> What is more, checking merged makes the polished comment unnecessary, imo.
> And it can be applied, I think, to the above hunk.
> 
That is odd. Will remove it.

--
Vlad Rezki

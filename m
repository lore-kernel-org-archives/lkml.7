Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830F1C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C5E207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZGWYGBKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503536AbfIWXUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 19:20:22 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46447 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404574AbfIWXUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 19:20:22 -0400
Received: by mail-pl1-f194.google.com with SMTP id q24so7203562plr.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 16:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CFATbYWeHQUWFhlXAsb5eUd2KlAcJsW24M+BNCgo4pA=;
        b=ZGWYGBKAmtffK0FtCjaNcaLo0NA0Vlf1+k36qISFiqOzW7qD7Ktu8p1dyxCDSnJ8wl
         likxB7pqfJ6F9y2MyiJGygBM/5glHRqiEnhpQjGoKUlohphI9+2+N4Gp4KxFmrkISrut
         j6BuTsfxl47+muQaAnnYpj7W3QbsXsjIoK6as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CFATbYWeHQUWFhlXAsb5eUd2KlAcJsW24M+BNCgo4pA=;
        b=p1UoGzh1bsJMbxUiUGNDNXw/vXqifUkF3f7tpsWy4wRp+gZALDCsg2j90acbn7SLBG
         pdALHN6287asVHz9RY1lmjRoZmcpgX+3z/DF6f06OGd02ZosYb9buMeXpOINaZhj9Fq2
         mu5eN/o+EjvPaOCMopAosgkrH0ZKTAmN4J9V9RrHNNCnA3KbOIugVEfVz0kiX+yaXwEV
         1HWHrhrnmW0kfh+w0N+DS6z/IXWOGkjuwsWRrQBlDcsQIByqLDkS2P/lIfoUm0Ytnw8e
         TK8JLatq0qFT+XF8ZLdeQe0m4hu2rTTqK4ajPJS6W7u/3OcpzUr/aB7XATUYup22kt8h
         GUNQ==
X-Gm-Message-State: APjAAAVpIf1w4XAvH7YjvtYfFVXVFi90vwSfqT1hl6OOtfRY7jbcVnd0
        kpIuGpixXiDS25U60Cq2ScICjg==
X-Google-Smtp-Source: APXvYqxQ2fEtz7Xf+sUIEAmsivoBRkAga2yJdYTPaY+W0awe8f1IS/TdeGDNsTYe1cV+oCDn7hztow==
X-Received: by 2002:a17:902:36c:: with SMTP id 99mr2227293pld.69.1569280821306;
        Mon, 23 Sep 2019 16:20:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u17sm11944927pgf.8.2019.09.23.16.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 16:20:20 -0700 (PDT)
Date:   Mon, 23 Sep 2019 16:20:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Yi Wang <wang.yi59@zte.com.cn>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, cai@lca.pw, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, osalvador@suse.de, mhocko@suse.com,
        rppt@linux.ibm.com, richardw.yang@linux.intel.com,
        xue.zhihong@zte.com.cn, up2wing@gmail.com, wang.liang82@zte.com.cn
Subject: Re: [PATCH] mm: fix -Wmissing-prototypes warnings
Message-ID: <201909231620.7C39AE91@keescook>
References: <1566978161-7293-1-git-send-email-wang.yi59@zte.com.cn>
 <89532e1d-bc41-ce70-ae3c-d6073e5c3cd4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89532e1d-bc41-ce70-ae3c-d6073e5c3cd4@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 09:52:40AM +0200, David Hildenbrand wrote:
> On 28.08.19 09:42, Yi Wang wrote:
> > We get two warnings when build kernel W=1:
> > mm/shuffle.c:36:12: warning: no previous prototype for ‘shuffle_show’
> > [-Wmissing-prototypes]
> > mm/sparse.c:220:6: warning: no previous prototype for
> > ‘subsection_mask_set’ [-Wmissing-prototypes]
> > 
> > Make the function static to fix this.
> > 
> > Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> > ---
> >  mm/shuffle.c | 2 +-
> >  mm/sparse.c  | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/shuffle.c b/mm/shuffle.c
> > index 3ce1248..b3fe97f 100644
> > --- a/mm/shuffle.c
> > +++ b/mm/shuffle.c
> > @@ -33,7 +33,7 @@ __meminit void page_alloc_shuffle(enum mm_shuffle_ctl ctl)
> >  }
> >  
> >  static bool shuffle_param;
> > -extern int shuffle_show(char *buffer, const struct kernel_param *kp)
> > +static int shuffle_show(char *buffer, const struct kernel_param *kp)
> >  {
> >  	return sprintf(buffer, "%c\n", test_bit(SHUFFLE_ENABLE, &shuffle_state)
> >  			? 'Y' : 'N');
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 72f010d..49006dd 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -217,7 +217,7 @@ static inline unsigned long first_present_section_nr(void)
> >  	return next_present_section_nr(-1);
> >  }
> >  
> > -void subsection_mask_set(unsigned long *map, unsigned long pfn,
> > +static void subsection_mask_set(unsigned long *map, unsigned long pfn,
> >  		unsigned long nr_pages)
> >  {
> >  	int idx = subsection_map_index(pfn);
> > 
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Andrew, can you take this?

-- 
Kees Cook

Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E3EC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD5320868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3/14IV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390976AbfGOO2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:28:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46878 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403776AbfGOO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:28:06 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so16453853ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5jX8RO2G+Dqveq3/9ZIxcRNHFe4mw3shiUGtuynCPU0=;
        b=d3/14IV3hSNMRDcLy989ICz3liv+mqjjSlW0El1mnKf1DOz5JPMkYTV5X2XfM5proK
         7k1eaAzv9eAe8s9ElN5YSGhnIIHix6PHO4WbLxrSC1Bg4CShvJ3rN8GrZwK9Jrwdixy7
         ziRX3kHL4P0X4Pmx2CRPhDuGSUllqNrR1M2ZTm4YgAoiYdRnRa1OC4xD0LMuspJXA3Ve
         /COxemWlBI3Tl3LClQBSKECiteCiSHEDi4eENFT4WOBuaJ+vsdwS8pMcHCDEH1zrFFZc
         mHIW/MTCDKpoRtJlx8Tw5ldTVnsDbi9sOGSzb2tLaXUDKnurnKlvpB6+BVs3v3a3XZpg
         0lkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5jX8RO2G+Dqveq3/9ZIxcRNHFe4mw3shiUGtuynCPU0=;
        b=RiF7g4Spq8DEAQ4LFr36i23ZKrxJXBKVYqEFXCLKUlvL7NiLZH1Gn7sUXUfzXEmHLs
         Y+IJIOn+zFVrtunrKHyLwcKPEnVF2/VgNtd2lObgR2QD5w9fTHpKsbiXvktWdRMWVday
         1jKW4mD3hTnePEijx7N9X9gGTu7XY1VLlHdxw1fbsYsmKJPqrZwVRp5alZzv+l8ZN8ch
         sMCEhAb4ca3MWDHx14D5DMF+TO79UHIasYJ0dmLsGKEM4QnZx1yjTCLY0Ol+zQAHOi5z
         Px+iC+bBQbAayfz1D8ztZ3SgrTXW7nw7QVYEheUdtpk/Tdoz54LRBel/AERp/Qa4M4C6
         0mhw==
X-Gm-Message-State: APjAAAVKL7DIFLQZPMtZnSJROidCjsrgmlJY4uJ9i9qu2H+sLG99pdys
        eFHXzn6fiV91wUB2tJXVXQA=
X-Google-Smtp-Source: APXvYqwkk4wG7LqF3s03ECykm/guY9mj3pBSapqVetXgxHIrnb4xm9bU3dssIzaUILeRZSgr6ITLCg==
X-Received: by 2002:a2e:968f:: with SMTP id q15mr9362552lji.30.1563200884282;
        Mon, 15 Jul 2019 07:28:04 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id h4sm3209138ljj.31.2019.07.15.07.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jul 2019 07:28:03 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 15 Jul 2019 16:27:54 +0200
To:     Pengfei Li <lpf.vector@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, rpenyaev@suse.de,
        peterz@infradead.org, guro@fb.com, rick.p.edgecombe@intel.com,
        rppt@linux.ibm.com, aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mm/vmalloc.c: Modify struct vmap_area to reduce
 its size
Message-ID: <20190715142754.pw55g4b2l6lzoznn@pc636>
References: <20190712120213.2825-1-lpf.vector@gmail.com>
 <20190712120213.2825-3-lpf.vector@gmail.com>
 <20190712134955.GV32320@bombadil.infradead.org>
 <CAD7_sbEoGRUOJdcHnfUTzP7GfUhCdhfo8uBpUFZ9HGwS36VkSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD7_sbEoGRUOJdcHnfUTzP7GfUhCdhfo8uBpUFZ9HGwS36VkSg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 11:09:00PM +0800, Pengfei Li wrote:
> On Fri, Jul 12, 2019 at 9:49 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Jul 12, 2019 at 08:02:13PM +0800, Pengfei Li wrote:
> >
> > I don't think you need struct union struct union.  Because llist_node
> > is just a pointer, you can get the same savings with just:
> >
> >         union {
> >                 struct llist_node purge_list;
> >                 struct vm_struct *vm;
> >                 unsigned long subtree_max_size;
> >         };
> >
> 
> Thanks for your comments.
> 
> As you said, I did this in v3.
> https://patchwork.kernel.org/patch/11031507/
> 
> The reason why I use struct union struct in v4 is that I want to
> express "in the tree" and "in the purge list" are two completely
> isolated cases.
> 
I think that is odd. Your v3 was fine to me. All that mess with
struct union struct makes it weird, so having just comments there
is enough, imho.

<snip>
-               __free_vmap_area(va);
+               merge_or_add_vmap_area(va,
+                       &free_vmap_area_root, &free_vmap_area_list);
+
<snip>
Should not be done in this patch. I can re-spin "mm/vmalloc: do not keep unpurged areas in the busy tree"
and add it there. So, as a result we will not modify unlink_va() function.

Thus, this patch will reduce the size only, and will not touch other parts.

--
Vlad Rezki

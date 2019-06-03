Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103E8C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA26272C8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZtRRCEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfFCRfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:35:39 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46673 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfFCRfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:35:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id m15so8741397ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 10:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1SfpobffKOrWKpwW04bKR3mmJHzrYDeRfbFX89KU/oE=;
        b=jZtRRCEdmQBOJG+Z5Up8Wy+HVMsB57ugBkXzh+rkJObgJLdoRJgQKS7nDZimjMzczG
         S3F4JvOrlWCxkK/z/bDgxnJY6URVrCDeXW239F+/VHZZ81wNElY2v7G1OpQcS5I9wS3V
         cSf1fcSFeDdhba9fTG2mUs0IncszXpghIDfP4G3Mcxydu7l8apcf6f9nyBvpqQ2e3LB9
         +nKxYMfSCIlUDiplICylhbJ8YNz7gYuxTo8xJN4Ru3P+sgTjMWFYTXOe0MptITF/M9Oy
         beo5KkDFxhWrrHlzSQqKMdwlDCzajLk6/ckQFloacvBIgL6ze5EYrW3BD+mnusYRi1W3
         5GZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1SfpobffKOrWKpwW04bKR3mmJHzrYDeRfbFX89KU/oE=;
        b=fl1Ijtn81BouYVgSWFnJD3qTjaXNja+SJZj2ujAosbtPO27veX26/qlk3hMzSHm4VV
         kgdmL7HXQvN0EnMxQkRvOa4JLXZf1FCaC/b1ltliS0XarMT5Y1mnaLl/a3srVmqCE3EN
         YRx4somzmYcRgpGCYTxTgpAgpJapxQVgeTHXmXgGq3p7fvnpWkXFJNwsct88A1zQQgFY
         ln2C5rXROlAnO2tKI9STWIm+xteyuGbcO/GNOly07m3Ay0UMTiwhYY6HbEXe5JCYWRa5
         2dNyC8O1S1TJxBJPNI5bBs1EjHSG9W/NpiV130jsxq+fZQuElwu472PZl92biRYmF90n
         h+7w==
X-Gm-Message-State: APjAAAUAf9uwYmDmsG4EqSOOuf8/58kkBRr3gzg3ZeDldUmRN8fvDy/D
        ddVbg4HctphYOeh56fF/I5w=
X-Google-Smtp-Source: APXvYqxDhmj7CdetUC52G+P/KDdFxFmprc9ZbFMlBQef2Z4kbsNDFuCKau2KhIv26tP0/iKhJ8ROwA==
X-Received: by 2002:a2e:9a4f:: with SMTP id k15mr14550155ljj.159.1559583336440;
        Mon, 03 Jun 2019 10:35:36 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id q11sm3261148lfh.47.2019.06.03.10.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 10:35:35 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 3 Jun 2019 19:35:28 +0200
To:     Roman Gushchin <guro@fb.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 4/4] mm/vmap: move BUG_ON() check to the unlink_va()
Message-ID: <20190603173528.7ukfgznmiypzfyze@pc636>
References: <20190527093842.10701-1-urezki@gmail.com>
 <20190527093842.10701-5-urezki@gmail.com>
 <20190528225001.GI27847@tower.DHCP.thefacebook.com>
 <20190529135817.tr7usoi2xwx5zl2s@pc636>
 <20190529162638.GB3228@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529162638.GB3228@tower.DHCP.thefacebook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Roman!

On Wed, May 29, 2019 at 04:26:43PM +0000, Roman Gushchin wrote:
> On Wed, May 29, 2019 at 03:58:17PM +0200, Uladzislau Rezki wrote:
> > Hello, Roman!
> > 
> > > > Move the BUG_ON()/RB_EMPTY_NODE() check under unlink_va()
> > > > function, it means if an empty node gets freed it is a BUG
> > > > thus is considered as faulty behaviour.
> > > 
> > > It's not exactly clear from the description, why it's better.
> > > 
> > It is rather about if "unlink" happens on unhandled node it is
> > faulty behavior. Something that clearly written in stone. We used
> > to call "unlink" on detached node during merge, but after:
> > 
> > [PATCH v3 3/4] mm/vmap: get rid of one single unlink_va() when merge
> > 
> > it is not supposed to be ever happened across the logic.
> > 
> > >
> > > Also, do we really need a BUG_ON() in either place?
> > > 
> > Historically we used to have the BUG_ON there. We can get rid of it
> > for sure. But in this case, it would be harder to find a head or tail
> > of it when the crash occurs, soon or later.
> > 
> > > Isn't something like this better?
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index c42872ed82ac..2df0e86d6aff 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -1118,7 +1118,8 @@ EXPORT_SYMBOL_GPL(unregister_vmap_purge_notifier);
> > >  
> > >  static void __free_vmap_area(struct vmap_area *va)
> > >  {
> > > -       BUG_ON(RB_EMPTY_NODE(&va->rb_node));
> > > +       if (WARN_ON_ONCE(RB_EMPTY_NODE(&va->rb_node)))
> > > +               return;
> > >
> > I was thinking about WARN_ON_ONCE. The concern was about if the
> > message gets lost due to kernel ring buffer. Therefore i used that.
> > I am not sure if we have something like WARN_ONE_RATELIMIT that
> > would be the best i think. At least it would indicate if a warning
> > happens periodically or not.
> > 
> > Any thoughts?
> 
> Hello, Uladzislau!
> 
> I don't have a strong opinion here. If you're worried about losing the message,
> WARN_ON() should be fine here. I don't think that this event will happen often,
> if at all.
>


If it happens then we are in trouble :) I prefer to keep it here as of now,
later on will see. Anyway, let's keep it and i will update it with:

<snip>
    if (WARN_ON(RB_EMPTY_NODE(&va->rb_node)))
        return;
<snip>

Thank you for the comments!

--
Vlad Rezki

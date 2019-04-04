Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B636C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A87206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaH0QyHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfDDPxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:53:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42802 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDDPxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:53:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id v22so2539136lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=69s05neAi83p1BcVREyc1LoY0XUeiOlTcpfAjyTNwYY=;
        b=jaH0QyHeb+dHGmubQzhMukaX7N16Vxg6TLoBCbEwjeuBdxAScZXs48BE+NaYkURPAW
         WbsWb00NyxZvd1ZGyxWE6xPlKD+LHFB7+53cGtdRt5Tl1nJ9mYlWDSen+YgJwSbZJGjs
         lJQDEysz4/HvKafsLo+U2/B5insAknqJviVUz0ATypYdpWsKydZ7Z9/TD4rrSJglCfcW
         eq4HMzoz2g7sHy+UJuzVlCpeUHeEMaadA/3IXCb4IgP/maO074fOWSQwQEMHamm3g9UD
         Eylsw3nXTSTRi5/oXqmxARq/tNA8U/G2+XgClXlJ7gI2BvAcM1G6QoAE/ES3Wcjth/I7
         1lkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=69s05neAi83p1BcVREyc1LoY0XUeiOlTcpfAjyTNwYY=;
        b=Di23VpHFEujnouKMbIoybDJQ9Z2E2IY5WUTpWEy3Ojz2z5tmMyl6kdprCQGC7fB3vz
         +P7nNTScnDL65K5P5T5bIPJ4hml3sf3V+Myz9NSl9ICOwE4mIsn2UvKnbkV4lcbG41YY
         +4yV4CeQe8hdPbUwZJlyJOFrSV2ckdXE+x9oo/o2/STCU66a75uNJtvZe8oFlFrOaC3P
         /x6DeQJfTiOpx3MUu3s+buKHW5Wyvdv+mu6g2kRE4uhEXYTlivnyC3TdOxZ1DBNaOqIT
         8n1CXtIWawpqAjjsfyZQP65pU8krnsyOLGzq/l1Dv8FEJoIXUjtsPILucJvsahYTOg4c
         gRfw==
X-Gm-Message-State: APjAAAVbloUApY8+S/8UaPelaJXjjAgZTKGksw+cqwQ4gsCQ2UrNDAWA
        +Y0E0BkvE26OchgClwnj9V8=
X-Google-Smtp-Source: APXvYqzj0uwo/mfji4kDTEIceD/EGvOp0fUilEJhJczaWSYf+ko+2/oKhY6O+VuCheQOVW9pumjXAg==
X-Received: by 2002:a2e:292:: with SMTP id y18mr3779169lje.52.1554393197268;
        Thu, 04 Apr 2019 08:53:17 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id x2sm3702757lfg.59.2019.04.04.08.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 08:53:16 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 4 Apr 2019 17:53:09 +0200
To:     Roman Gushchin <guro@fb.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RESEND PATCH 2/3] mm/vmap: add DEBUG_AUGMENT_PROPAGATE_CHECK
 macro
Message-ID: <20190404155309.udxvjorbq7shug4v@pc636>
References: <20190402162531.10888-1-urezki@gmail.com>
 <20190402162531.10888-3-urezki@gmail.com>
 <20190403211540.GJ6778@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403211540.GJ6778@tower.DHCP.thefacebook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +#if DEBUG_AUGMENT_PROPAGATE_CHECK
> > +static void
> > +augment_tree_propagate_do_check(struct rb_node *n)
> > +{
> > +	struct vmap_area *va;
> > +	struct rb_node *node;
> > +	unsigned long size;
> > +	bool found = false;
> > +
> > +	if (n == NULL)
> > +		return;
> > +
> > +	va = rb_entry(n, struct vmap_area, rb_node);
> > +	size = va->subtree_max_size;
> > +	node = n;
> > +
> > +	while (node) {
> > +		va = rb_entry(node, struct vmap_area, rb_node);
> > +
> > +		if (get_subtree_max_size(node->rb_left) == size) {
> > +			node = node->rb_left;
> > +		} else {
> > +			if (__va_size(va) == size) {
> > +				found = true;
> > +				break;
> > +			}
> > +
> > +			node = node->rb_right;
> > +		}
> > +	}
> > +
> > +	if (!found) {
> > +		va = rb_entry(n, struct vmap_area, rb_node);
> > +		pr_emerg("tree is corrupted: %lu, %lu\n",
> > +			__va_size(va), va->subtree_max_size);
> > +	}
> > +
> > +	augment_tree_propagate_do_check(n->rb_left);
> > +	augment_tree_propagate_do_check(n->rb_right);
> > +}
> > +
> > +static void augment_tree_propagate_from_check(void)
> 
> Why do you need this intermediate function?
> 
> Other than that looks good to me, please free to use
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
Will remove, we do not need that extra wrapper.

--
Vlad Rezki

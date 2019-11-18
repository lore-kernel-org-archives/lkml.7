Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D55C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0A6222DC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vvfbp0Or"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKRVs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:48:56 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44510 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfKRVs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:48:56 -0500
Received: by mail-qk1-f195.google.com with SMTP id m16so15897311qki.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 13:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q4B0Yr9MAH2OOg9e+2b4uJAfwJytTTL68mfbk8OBhyw=;
        b=Vvfbp0OrCgdTvICqPVO8WcPkW9ijaNwWbxmlSk+D0EB0YpBzPn4ZZb+f5PIT7mxvsx
         x9NNZkBMQtjQXI6jy+fWLutZ/8OjtFanDkSZZgvM5DZNk004u3iHO92IMg8qJy5EJhdu
         97ZCm6xODzY87FDX4AI/jgMj5Ta8+IdwEZgN8AaaaobIylkwXDmMtlnJsEYRJpAOWThT
         1deIAVVSuFAtkzY8uiwN4p2VwJ6I+CiO9Y0iDPpSj/uf+T6D2wZrTB2arJ/IK7pWWS/r
         xqtMPydC8hkGr+noMhvdheSIzaeUM/7OarjFia7hj/SEwi4gw+OzTjhk2uFQn86vO9nt
         yePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q4B0Yr9MAH2OOg9e+2b4uJAfwJytTTL68mfbk8OBhyw=;
        b=SREifwLMghKV5lzrTxOr3K4qEka4+HDDvNzTFgW3EER7pGrrfNyguv39qNdz+7/XmN
         YlOb9tNYmReQIl6Oo4ZQhkvGaN44iUp1m7orkjb5TIzjs4dOEI+tMlO+Sv+9bf5bDm8p
         vvzK9Gz3dyo9yEaR7KCWzizLyNGdUwxM41QkaLQw1rkk+uWbeseQoW7Xvs1p9paBQ+0b
         6s0MOhp8WyyjbkjccRotOb0a9pdBONtLdw8kFOVydNYmnUkiUh8Z3ojTAm84UkgoQSjk
         xK7cG22ARitKuYDreAJpirZRwD2fzJmkXeWeokYUmVcVv3HLmBsemym6CXVLNeTUrT5b
         iqPQ==
X-Gm-Message-State: APjAAAXOYlux643daxwBZBi5aBNrzClTmGsuvjswo+JHKW/JZdoOSi7g
        7PO0Mdc2va+HMChoBZIMB9k=
X-Google-Smtp-Source: APXvYqy0Vd5NbsNbEaE0q9ix5UTYeXFagdw7Wa2Z6XCsVWsE/zbr7nwWUytVsLAuKyoqgfQpCQF/HQ==
X-Received: by 2002:a37:9d12:: with SMTP id g18mr24162968qke.157.1574113734704;
        Mon, 18 Nov 2019 13:48:54 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id i41sm11427666qti.42.2019.11.18.13.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 13:48:53 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 71C4840D3E; Mon, 18 Nov 2019 18:48:51 -0300 (-03)
Date:   Mon, 18 Nov 2019 18:48:51 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCHv2 0/2] perf tools: Share struct map after clone
Message-ID: <20191118214851.GA17315@kernel.org>
References: <20191016082226.10325-1-jolsa@kernel.org>
 <20191023075517.GA22919@krava>
 <20191029205855.GA20826@krava>
 <20191118121400.GA14046@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118121400.GA14046@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 18, 2019 at 01:14:00PM +0100, Jiri Olsa escreveu:
> On Tue, Oct 29, 2019 at 09:58:55PM +0100, Jiri Olsa wrote:
> > > > 
> > > > Also available in here:
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > > >   perf/map_shared

> > > I rebased to latest perf/core and pushed the branch out

> > rebased and pushed out
 
> heya,
> I lost track of this.. what's the status, are you going with your
> version, or is this one still in? I don't see any of them in latest
> code..

So, I'm still working on and off on this, current status is at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/map_share

Its just one patch more than perf/core, the one that does the sharing.

The thing is, as I'm going over all the fields in 'struct map', it seems
that we'll end up with just one cacheline per instance, as there are
things there that are not strictly related to a map, but to a map_group
(unmap_ip/map_ip), or to a dso (maj, min, ino, ino_generation), and some
need less than what is allocated to them.

Current status is:

[root@quaco ~]# pahole -C map ~acme/bin/perf
struct map {
	union {
		struct rb_node rb_node __attribute__((__aligned__(8))); /*     0    24 */
		struct list_head node;                   /*     0    16 */
	} __attribute__((__aligned__(8)));                                               /*     0    24 */
	u64                        start;                /*    24     8 */
	u64                        end;                  /*    32     8 */
	_Bool                      erange_warned:1;      /*    40: 0  1 */
	_Bool                      priv:1;               /*    40: 1  1 */

	/* XXX 6 bits hole, try to pack */
	/* XXX 3 bytes hole, try to pack */

	u32                        prot;                 /*    44     4 */
	u64                        pgoff;                /*    48     8 */
	u64                        reloc;                /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	u64                        (*map_ip)(struct map *, u64); /*    64     8 */
	u64                        (*unmap_ip)(struct map *, u64); /*    72     8 */
	struct dso *               dso;                  /*    80     8 */
	refcount_t                 refcnt;               /*    88     4 */
	u32                        flags;                /*    92     4 */

	/* size: 96, cachelines: 2, members: 13 */
	/* sum members: 92, holes: 1, sum holes: 3 */
	/* sum bitfield members: 2 bits, bit holes: 1, sum bit holes: 6 bits */
	/* forced alignments: 1 */
	/* last cacheline: 32 bytes */
} __attribute__((__aligned__(8)));
[root@quaco ~]#

This is with the tentative move of maj/min/ino/ino_generation to 'struct
dso', but that needs more work to match the sort order that touches it
"dcacheline", i.e. a map that comes with the same backing DSO but
different values for those fields is not the same DSO, right?

Right now with moving the maj/min/etc to dso, in the map_share patch we
get the structure used to keep shared entries in the rb_tree at 40
bytes, under one cacheline, while the full 'struct map' is 32 bytes more
than one cacheline, so still good for sharing:

[acme@quaco perf]$ pahole -C map_node ~/bin/perf
struct map_node {
	union {
		struct rb_node rb_node __attribute__((__aligned__(8))); /*     0    24 */
		struct list_head node;                   /*     0    16 */
	} __attribute__((__aligned__(8)));               /*     0    24 */
	refcount_t                 refcnt;               /*    24     4 */
	_Bool                      is_node:1;            /*    28: 0  1 */

	/* XXX 7 bits hole, try to pack */
	/* XXX 3 bytes hole, try to pack */

	struct map *               map;                  /*    32     8 */

	/* size: 40, cachelines: 1, members: 4 */
	/* sum members: 36, holes: 1, sum holes: 3 */
	/* sum bitfield members: 1 bits, bit holes: 1, sum bit holes: 7 bits */
	/* forced alignments: 1 */
	/* last cacheline: 40 bytes */
} __attribute__((__aligned__(8)));
[acme@quaco perf]$ pahole -C map ~/bin/perf
struct map {
	union {
		struct rb_node rb_node __attribute__((__aligned__(8))); /*     0    24 */
		struct list_head node;                   /*     0    16 */
	} __attribute__((__aligned__(8)));               /*     0    24 */
	refcount_t                 refcnt;               /*    24     4 */
	_Bool                      is_node:1;            /*    28: 0  1 */
	_Bool                      erange_warned:1;      /*    28: 1  1 */
	_Bool                      priv:1;               /*    28: 2  1 */

	/* XXX 5 bits hole, try to pack */
	/* XXX 3 bytes hole, try to pack */

	u64                        start;                /*    32     8 */
	u64                        end;                  /*    40     8 */
	u64                        pgoff;                /*    48     8 */
	u64                        reloc;                /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	u64                        (*map_ip)(struct map *, u64); /*    64     8 */
	u64                        (*unmap_ip)(struct map *, u64); /*    72     8 */
	struct dso *               dso;                  /*    80     8 */
	u32                        flags;                /*    88     4 */
	u32                        prot;                 /*    92     4 */

	/* size: 96, cachelines: 2, members: 14 */
	/* sum members: 92, holes: 1, sum holes: 3 */
	/* sum bitfield members: 3 bits, bit holes: 1, sum bit holes: 5 bits */
	/* forced alignments: 1 */
	/* last cacheline: 32 bytes */
} __attribute__((__aligned__(8)));
[acme@quaco perf]$

So give me some more time, please :-)

The sharing map is this one, without the maj/map/ move to 'struct dso':

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/map_share&id=451df1d4ad3c636f6be57b8e69b4f94c1bbf4a65

- Arnaldo

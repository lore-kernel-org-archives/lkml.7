Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E8BC19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A876E214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfHGGaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 02:30:13 -0400
Received: from verein.lst.de ([213.95.11.211]:34839 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbfHGGaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 02:30:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 662B368B05; Wed,  7 Aug 2019 08:30:03 +0200 (CEST)
Date:   Wed, 7 Aug 2019 08:30:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hugh Dickins <hughd@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHv2 2/3] i915: convert to new mount API
Message-ID: <20190807063002.GG6627@lst.de>
References: <20190805160307.5418-1-sergey.senozhatsky@gmail.com> <20190805160307.5418-3-sergey.senozhatsky@gmail.com> <20190805181255.GH1131@ZenIV.linux.org.uk> <20190805182834.GI1131@ZenIV.linux.org.uk> <alpine.LSU.2.11.1908060007190.1941@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1908060007190.1941@eggly.anvils>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 12:50:10AM -0700, Hugh Dickins wrote:
> Though personally I'm averse to managing "f"objects through
> "m"interfaces, which can get ridiculous (notably, MADV_HUGEPAGE works
> on the virtual address of a mapping, but the huge-or-not alignment of
> that mapping must have been decided previously).  In Google we do use
> fcntls F_HUGEPAGE and F_NOHUGEPAGE to override on a per-file basis -
> one day I'll get to upstreaming those.

Such an interface seems very useful, although the two fcntls seem a bit
odd.

But I think the point here is that the i915 has its own somewhat odd
instance of tmpfs.  If we could pass the equivalent of the huge=*
options to shmem_file_setup all that garbage (including the
shmem_file_setup_with_mnt function) could go away.

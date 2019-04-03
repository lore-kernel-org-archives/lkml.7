Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFA6C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A094214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gj3d2dIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfDCNHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:07:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36882 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCNHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:07:53 -0400
Received: by mail-qt1-f193.google.com with SMTP id z16so19410799qtn.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 06:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6TbXx470gB2/L327MHubCCa9FGqzdEttkYRsItRZ/js=;
        b=gj3d2dIgyS1juous1+rrj5kPXgzLNcDgCTr0MjFUCmXxbywzvPEbuXfBhNfDjC1N61
         CMGh6M7pxGvStFupFAXAL40cY305TZmNYiylRnPoXmCIzQGxiPbCnqdVKmF24zamew3f
         wUNbwizEnVexKfzbEK/xTornjseE5OAqSvInI36+WiWJB1fsyhjYID9AR9MV9LOsoKGH
         mIgaeq/jub+ukXx0pZt8vkjbglYCRAVr8KrhLWylg0RElkC5hZ6AkIu1V18C4/vWsdtO
         A0FjzOj2TDtxxN4Yz0HfwFkvJVZOvGGedSsWJ5PR0iuS44JwO4BYQQrIY6V2DiSCXipQ
         JIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6TbXx470gB2/L327MHubCCa9FGqzdEttkYRsItRZ/js=;
        b=KdhzH/SKug4q7rOhK1TUXepYeRUWUp7HQyapRIJ60jQ+1p8t7IKlP1noc6fjJmUu05
         NmtXeWoaATlUXBqqsnEqlDOA/gygJSZbMXjZUmTkJOeygiiV+0LdYPImEWuGgUHdS178
         IGySlPPE/7D0EQGCSI/8yWym7wwDcBCA8+DGOW9Izo1NlJr7CU8POii47InhKcCX1drF
         VPxUgiWLZaBch1FM1rmz2t0Zn2CXOSsgqERm2/3gAmZ9n/oZLMTBY+AEQ3QNAqJSosz5
         pWS/jd+Hnrcn5wvBaFeGGqOHi0tTKOmmz63+lH7zt4s3NbK6CBnMSIA4lQYF3aaxmBmx
         he4w==
X-Gm-Message-State: APjAAAWUEsBqo9Turz18Gi3VQualV2P4RMRdfwgCh26QviaXE20Me7Aw
        oBxvd+09Jm2RaUt9bIydZ3XRQQ==
X-Google-Smtp-Source: APXvYqzEEHgsgkai8JhpGANOP06QXmX0CP1vzaNNrNU61AclZARASaHB8UoGll4tCJ6GJGEk51f24A==
X-Received: by 2002:ac8:66d0:: with SMTP id m16mr53517935qtp.215.1554296872208;
        Wed, 03 Apr 2019 06:07:52 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h2sm7013076qkl.3.2019.04.03.06.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 06:07:51 -0700 (PDT)
Message-ID: <1554296870.26196.32.camel@lca.pw>
Subject: Re: [PATCH] slab: store tagged freelist for off-slab slabmgmt
From:   Qian Cai <cai@lca.pw>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 03 Apr 2019 09:07:50 -0400
In-Reply-To: <CAAeHK+y25S6GYMrGUEQJJ5AU1LZ7T-jWrwoDsLXdxuk_E+q5BQ@mail.gmail.com>
References: <20190403022858.97584-1-cai@lca.pw>
         <CAAeHK+y25S6GYMrGUEQJJ5AU1LZ7T-jWrwoDsLXdxuk_E+q5BQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-03 at 13:23 +0200, Andrey Konovalov wrote:
> On Wed, Apr 3, 2019 at 4:29 AM Qian Cai <cai@lca.pw> wrote:
> > 
> > The commit 51dedad06b5f ("kasan, slab: make freelist stored without
> > tags") calls kasan_reset_tag() for off-slab slab management object
> > leading to freelist being stored non-tagged. However, cache_grow_begin()
> > -> alloc_slabmgmt() -> kmem_cache_alloc_node() which assigns a tag for
> > the address and stores in the shadow address. As the result, it causes
> > endless errors below during boot due to drain_freelist() ->
> > slab_destroy() -> kasan_slab_free() which compares already untagged
> > freelist against the stored tag in the shadow address. Since off-slab
> > slab management object freelist is such a special case, so just store it
> > tagged. Non-off-slab management object freelist is still stored untagged
> > which has not been assigned a tag and should not cause any other
> > troubles with this inconsistency.
> 
> Hi Qian,
> 
> Could you share the config (or other steps) you used to reproduce this?

https://git.sr.ht/~cai/linux-debug/blob/master/config

Additional command-line option to boot:

page_poison=on crashkernel=768M earlycon page_owner=on numa_balancing=enable
systemd.unified_cgroup_hierarchy=1 debug_guardpage_minorder=1


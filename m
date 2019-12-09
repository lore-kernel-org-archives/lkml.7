Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE633C2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8EDE206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfLIUdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:33:14 -0500
Received: from gentwo.org ([3.19.106.255]:47336 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbfLIUdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:33:14 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id B1FD53EEC7; Mon,  9 Dec 2019 20:33:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id B06213ED44;
        Mon,  9 Dec 2019 20:33:13 +0000 (UTC)
Date:   Mon, 9 Dec 2019 20:33:13 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Daniel Wagner <dwagner@suse.de>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep warns: cpu_hotplug_lock.rw_sem --> slab_mutex -->
 kn->count#39
In-Reply-To: <20191209182418.7vxer6vmre67ewvt@beryllium.lan>
Message-ID: <alpine.DEB.2.21.1912092029080.6020@www.lameter.com>
References: <20191209182418.7vxer6vmre67ewvt@beryllium.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2019, Daniel Wagner wrote:

> [    5.038862]
> [    5.038862] -> #2 (kn->count#39){++++}:
> [    5.039329]        __kernfs_remove+0x240/0x2e0
> [    5.039717]        kernfs_remove_by_name_ns+0x3c/0x80
> [    5.040159]        sysfs_slab_add+0x184/0x250

sysfs_slab_add should not be called under any lock. But it happens during
an initcall (sysfs_slab_init) when the kmalloc slab array is being set up.

And the problems results from a hotplug event? During system bringup when
the slab caches have not been setup yet?

Is this really something that can happen?


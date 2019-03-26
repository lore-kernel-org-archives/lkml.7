Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02ECC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F95F20857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553590339;
	bh=DFXSXCeVxPtLSPmRNHG4Sn0d5Gw/4vSPTZ3zcUw68dg=;
	h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:
	 From;
	b=ZcwwM8YVuN2KcEvamQWpDzn0WDqlRAhf4FdH2UX0v+OtMEasBgwQxViU15BR3ile/
	 Uk2Acd8D46qYMd/uNcRVM6YGmmxZaeuqSSoRVeXvgU/PHr37qHNOH49zfl2LpDRxz8
	 glJYgp1CeGfb2WVACkPh5L/vwjhaMdo5v3bjwSwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbfCZIwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:52:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbfCZIwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:52:17 -0400
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7D8820856;
        Tue, 26 Mar 2019 08:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553590336;
        bh=DFXSXCeVxPtLSPmRNHG4Sn0d5Gw/4vSPTZ3zcUw68dg=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ECHkNasnFxMDI2q80ivdLMf3DhZXb3rq1iwIsuKFSKTv/tnXthHb8P5D3Xi79ZkPo
         ZHREl8EHQUwW49H+G+z5p7LWZHev1ob8s38IV5czFMjUzhN0TAd9ybCezN06oaflhq
         80ku6GeID0Os5n/Y9NmxYzD1NrlMd1EDm7DNsmHY=
Reply-To: kbingham@kernel.org
Subject: Re: [PATCH 3/4] scripts/gdb: Add rb tree iterating utilities
To:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>
References: <20190325184522.260535-1-swboyd@chromium.org>
 <20190325184522.260535-4-swboyd@chromium.org>
From:   Kieran Bingham <kbingham@kernel.org>
Openpgp: preference=signencrypt
Message-ID: <227f1a1f-d8dd-72f4-4eb9-43bba714d52a@kernel.org>
Date:   Tue, 26 Mar 2019 08:52:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325184522.260535-4-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 25/03/2019 18:45, Stephen Boyd wrote:
> Implement gdb functions for rb_first(), rb_last(), rb_next(), and
> rb_prev(). These can be useful to iterate through the kernel's red-black
> trees.

I definitely approve of getting data-structure helpers into scripts/gdb,
as it will greatly assist debug options but my last attempt to do this
was with the radix-tree which I had to give up on as the internals were
changing rapidly and caused continuous breakage to the helpers.

Do you foresee any similar issue here? Or is the corresponding RB code
in the kernel fairly 'stable'?


Please could we make sure whomever maintains the RBTree code is aware of
the python implementation?

That said, MAINTAINERS doesn't actually seem to list any ownership over
the rb-tree code, and get_maintainers.pl [0] seems to be pointing at
Andrew as the probable route in for that code so perhaps that's already
in place :D



[0]
> ./scripts/get_maintainer.pl -f ./include/linux/rbtree*
> Andrew Morton <akpm@linux-foundation.org> (commit_signer:3/2=100%,commit_signer:2/1=100%)
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> (commit_signer:1/2=50%,authored:1/2=50%,added_lines:1/3=33%,commit_signer:1/1=100%,authored:1/1=100%,added_lines:1/1=100%)
> Wei Yang <richard.weiyang@gmail.com> (commit_signer:1/2=50%,authored:1/2=50%,added_lines:2/3=67%,removed_lines:2/2=100%)
> linux-kernel@vger.kernel.org (open list)

--
Regards

Kieran


> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Nikolay Borisov <n.borisov.lkml@gmail.com>
> Cc: Kieran Bingham <kbingham@kernel.org>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Jackie Liu <liuyun01@kylinos.cn> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  scripts/gdb/linux/rbtree.py | 169 ++++++++++++++++++++++++++++++++++++
>  scripts/gdb/vmlinux-gdb.py  |   1 +
>  2 files changed, 170 insertions(+)
>  create mode 100644 scripts/gdb/linux/rbtree.py
> 
> diff --git a/scripts/gdb/linux/rbtree.py b/scripts/gdb/linux/rbtree.py
> new file mode 100644
> index 000000000000..fd7b0b961ca1
> --- /dev/null
> +++ b/scripts/gdb/linux/rbtree.py
> @@ -0,0 +1,169 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright 2019 Google LLC.
> +
> +import gdb
> +
> +from linux import utils
> +
> +rb_root_type = utils.CachedType("struct rb_root")
> +rb_node_type = utils.CachedType("struct rb_node")
> +
> +
> +def rb_first(root):
> +    if root.type == rb_root_type.get_type():
> +        node = node.address.cast(rb_root_type.get_type().pointer())
> +    elif root.type != rb_root_type.get_type().pointer():
> +        raise gdb.GdbError("Must be struct rb_root not {}"
> +                .format(root.type))
> +
> +    node = root['rb_node']
> +    if node is 0:
> +        return None
> +
> +    while node['rb_left']:
> +        node = node['rb_left']
> +
> +    return node
> +
> +def rb_last(root):
> +    if root.type == rb_root_type.get_type():
> +        node = node.address.cast(rb_root_type.get_type().pointer())
> +    elif root.type != rb_root_type.get_type().pointer():
> +        raise gdb.GdbError("Must be struct rb_root not {}"
> +                .format(root.type))
> +
> +    node = root['rb_node']
> +    if node is 0:
> +        return None
> +
> +    while node['rb_right']:
> +        node = node['rb_right']
> +
> +    return node
> +
> +def rb_parent(node):
> +    parent = gdb.Value(node['__rb_parent_color'] & ~3)
> +    return parent.cast(rb_node_type.get_type().pointer())
> +
> +def rb_empty_node(node):
> +    return node['__rb_parent_color'] == node.address
> +
> +def rb_next(node):
> +    if node.type == rb_node_type.get_type():
> +        node = node.address.cast(rb_node_type.get_type().pointer())
> +    elif node.type != rb_node_type.get_type().pointer():
> +        raise gdb.GdbError("Must be struct rb_node not {}"
> +                .format(node.type))
> +
> +    if rb_empty_node(node):
> +        return None
> +
> +    if node['rb_right']:
> +        node = node['rb_right']
> +        while node['rb_left']:
> +            node = node['rb_left']
> +        return node
> +
> +    parent = rb_parent(node)
> +    while parent and node == parent['rb_right']:
> +            node = parent
> +            parent = rb_parent(node)
> +
> +    return parent
> +
> +def rb_prev(node):
> +    if node.type == rb_node_type.get_type():
> +        node = node.address.cast(rb_node_type.get_type().pointer())
> +    elif node.type != rb_node_type.get_type().pointer():
> +        raise gdb.GdbError("Must be struct rb_node not {}"
> +                .format(node.type))
> +
> +    if rb_empty_node(node):
> +        return None
> +
> +    if node['rb_left']:
> +        node = node['rb_left']
> +        while node['rb_right']:
> +            node = node['rb_right']
> +        return node.dereference()
> +
> +    parent = rb_parent(node)
> +    while parent and node == parent['rb_left'].dereference():
> +            node = parent
> +            parent = rb_parent(node)
> +
> +    return parent
> +
> +
> +class LxRbFirst(gdb.Function):
> +    """Lookup and return a node from an RBTree
> +
> +$lx_rb_first(root): Return the node at the given index.
> +If index is omitted, the root node is dereferenced and returned."""
> +
> +    def __init__(self):
> +        super(LxRbFirst, self).__init__("lx_rb_first")
> +
> +    def invoke(self, root):
> +        result = rb_first(root)
> +        if result is None:
> +            raise gdb.GdbError("No entry in tree")
> +
> +        return result
> +
> +LxRbFirst()
> +
> +class LxRbLast(gdb.Function):
> +    """Lookup and return a node from an RBTree.
> +
> +$lx_rb_last(root): Return the node at the given index.
> +If index is omitted, the root node is dereferenced and returned."""
> +
> +    def __init__(self):
> +        super(LxRbLast, self).__init__("lx_rb_last")
> +
> +    def invoke(self, root):
> +        result = rb_last(root)
> +        if result is None:
> +            raise gdb.GdbError("No entry in tree")
> +
> +        return result
> +
> +LxRbLast()
> +
> +class LxRbNext(gdb.Function):
> +    """Lookup and return a node from an RBTree.
> +
> +$lx_rb_next(node): Return the node at the given index.
> +If index is omitted, the root node is dereferenced and returned."""
> +
> +    def __init__(self):
> +        super(LxRbNext, self).__init__("lx_rb_next")
> +
> +    def invoke(self, node):
> +        result = rb_next(node)
> +        if result is None:
> +            raise gdb.GdbError("No entry in tree")
> +
> +        return result
> +
> +LxRbNext()
> +
> +class LxRbPrev(gdb.Function):
> +    """Lookup and return a node from an RBTree.
> +
> +$lx_rb_prev(node): Return the node at the given index.
> +If index is omitted, the root node is dereferenced and returned."""
> +
> +    def __init__(self):
> +        super(LxRbPrev, self).__init__("lx_rb_prev")
> +
> +    def invoke(self, node):
> +        result = rb_prev(node)
> +        if result is None:
> +            raise gdb.GdbError("No entry in tree")
> +
> +        return result
> +
> +LxRbPrev()
> diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
> index be0efb5dda5b..89e4aa4f8966 100644
> --- a/scripts/gdb/vmlinux-gdb.py
> +++ b/scripts/gdb/vmlinux-gdb.py
> @@ -30,5 +30,6 @@ else:
>      import linux.config
>      import linux.cpus
>      import linux.lists
> +    import linux.rbtree
>      import linux.proc
>      import linux.constants
> 


-- 
--
Kieran

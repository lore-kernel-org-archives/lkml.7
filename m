Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9112BC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597BE2190F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbfJAJ5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:57:21 -0400
Received: from know-smtprelay-omc-7.server.virginmedia.net ([80.0.253.71]:40332
        "EHLO know-smtprelay-omc-7.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfJAJ5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:57:21 -0400
Received: from mail0.xen.dingwall.me.uk ([82.47.84.47])
        by cmsmtp with ESMTPA
        id FEuCiVv5DwGUPFEuDi7v6n; Tue, 01 Oct 2019 10:57:17 +0100
X-Originating-IP: [82.47.84.47]
X-Authenticated-User: james.dingwall@blueyonder.co.uk
X-Spam: 0
X-Authority: v=2.3 cv=Kc78TzQD c=1 sm=1 tr=0 a=0bfgdX8EJi0Cr9X0x0jFDA==:117
 a=0bfgdX8EJi0Cr9X0x0jFDA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
 a=XobE76Q3jBoA:10 a=33Y00tmxvujBNogj190A:9 a=CjuIK1q_8ugA:10
Received: from localhost (localhost [IPv6:::1])
        by mail0.xen.dingwall.me.uk (Postfix) with ESMTP id B313410FA4A;
        Tue,  1 Oct 2019 09:57:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at dingwall.me.uk
Received: from mail0.xen.dingwall.me.uk ([127.0.0.1])
        by localhost (mail0.xen.dingwall.me.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y8OCGeF8EDC4; Tue,  1 Oct 2019 09:57:16 +0000 (UTC)
Received: from behemoth.dingwall.me.uk (behemoth.dingwall.me.uk [IPv6:2001:470:695c:302::c0a8:105])
        by dingwall.me.uk (Postfix) with ESMTP id 69A8510FA47;
        Tue,  1 Oct 2019 09:57:16 +0000 (UTC)
Received: by behemoth.dingwall.me.uk (Postfix, from userid 1000)
        id 47C91FC7B2; Tue,  1 Oct 2019 09:57:16 +0000 (UTC)
Date:   Tue, 1 Oct 2019 09:57:16 +0000
From:   James Dingwall <james@dingwall.me.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: xenbus hang after userspace ctrl-c of xenstore-rm
Message-ID: <20191001095716.GA16951@dingwall.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CMAE-Envelope: MS4wfFZYhzw2qGl/LmsrYbqguqBGMDPbBf6vQCAfCRTlKlA338BgfHW9UD0ZT6QT2Nw2iYq7XfgLM8MjSa+PrIuIlXm8ryyHvkmtaK+nqQVPgaEUhof75MMi
 u2H4n+9BVn+/knmYmpGKY8crcoZ//+DUt7hd7L1Fo7xq4GDhHn5saWFoyfxEX+67gvOw7Wm0oFafwvW3i0RVkzxI2Oza6fXSVoM1/7D94fMg5ACvTUUzm9U7
 eFzMJcRWaNMg1RpK9i+7jhhtFS/5RzkXqG3KmWSuHBYcgnxVtZDMY3NYPpf0UIWm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been investigating a problem where xenstore becomes unresponsive 
during domain shutdowns.  My test script seems to trigger the problem 
but without definitively being the same.  It is possible to replicate 
the issue in dom0 or a domU.  If the test script is run in dom0 it seems 
that it is possible to affect xenstore access in domUs but I have not 
observed any negative impact in dom0 or other guests when running in a 
domU.

The environment is a default Ubuntu 5.0.0-29-generic kernel, xen 
4.11.3-pre (built from current head of staging-4.11), xenstore is 
running in a stubdom.  I did try a kernel with 
d10e0cc113c9e1b64b5c6e3db37b5c839794f3df "xenbus: Avoid deadlock during 
suspend due to open transactions" but that didn't help, this stack trace 
is with that patch applied.

[ 2551.474706] INFO: task xenbus:37 blocked for more than 120 seconds.
[ 2551.492215]       Tainted: P           OE     5.0.0-29-generic #5
[ 2551.510263] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 2551.528585] xenbus          D    0    37      2 0x80000080
[ 2551.528590] Call Trace:
[ 2551.528603]  __schedule+0x2c0/0x870
[ 2551.528606]  ? _cond_resched+0x19/0x40
[ 2551.528632]  schedule+0x2c/0x70
[ 2551.528637]  xs_talkv+0x1ec/0x2b0
[ 2551.528642]  ? wait_woken+0x80/0x80
[ 2551.528645]  xs_single+0x53/0x80
[ 2551.528648]  xenbus_transaction_end+0x3b/0x70
[ 2551.528651]  xenbus_file_free+0x5a/0x160
[ 2551.528654]  xenbus_dev_queue_reply+0xc4/0x220
[ 2551.528657]  xenbus_thread+0x7de/0x880
[ 2551.528660]  ? wait_woken+0x80/0x80
[ 2551.528665]  kthread+0x121/0x140
[ 2551.528667]  ? xb_read+0x1d0/0x1d0
[ 2551.528670]  ? kthread_park+0x90/0x90
[ 2551.528673]  ret_from_fork+0x35/0x40

From a vanilla Ubuntu 5.0.0-29-generic kernel (seems to be the same):

[ 3639.401276] INFO: task xenbus:37 blocked for more than 120 seconds.
[ 3639.417908]       Tainted: P           OE     5.0.0-29-generic #31~18.04.1-Ubuntu
[ 3639.435642] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3639.453824] xenbus          D    0    37      2 0x80000080
[ 3639.453828] Call Trace:
[ 3639.453837]  __schedule+0x2bd/0x850
[ 3639.453842]  ? __wake_up+0x13/0x20
[ 3639.453844]  ? _cond_resched+0x19/0x40
[ 3639.453845]  schedule+0x2c/0x70
[ 3639.453848]  xs_talkv+0x1e8/0x2a0
[ 3639.453850]  ? wait_woken+0x80/0x80
[ 3639.453852]  xs_single+0x53/0x80
[ 3639.453853]  xenbus_transaction_end+0x3b/0x70
[ 3639.453855]  xenbus_file_free+0x5a/0x160
[ 3639.453857]  xenbus_dev_queue_reply+0xc4/0x220
[ 3639.453859]  xenbus_thread+0x7de/0x880
[ 3639.453861]  ? wait_woken+0x80/0x80
[ 3639.453864]  kthread+0x121/0x140
[ 3639.453865]  ? xb_read+0x1d0/0x1d0
[ 3639.453867]  ? kthread_park+0x90/0x90
[ 3639.453870]  ret_from_fork+0x35/0x40

To reproduce this I run the script once and allow it to complete.  In a 
second run if I ctrl-c while it is doing the xenstore-rm it exits but 
then further xenstore commands are unresponsive.  I haven't tried to 
reduce the numbers but I assume that with only a small number of keys 
that interrupting the xenstore-rm would have the same result.  It was 
just a hunch that during domain shutdown the toolstack is doing a clean 
up and removing keys for the shutdown domain which is why I wrote this 
test.

I'm happy to provide further information about the configuration or run 
other tests.

Thanks,
James

----- Test script -----

#!/bin/bash

set -eu

# just in case xenstore stubdom tells us anything
xl set-parameters guest_loglvl=debug

tree="${1:-/tree}"
xcount="256"
branches="256"
leaves="256"
xstring="$(awk 'BEGIN { while (c++<'"${xcount}"') printf "x" }')"

echo "writing approximately $((xcount * branches * leaves)) of data to xenstore under ${tree}"

xenstore-rm "${tree}"
xenstore-write "${tree}" ""

for branch in $(seq 1 "${branches}") ; do
    echo "filling branch ${branch} of ${branches}"
    xenstore-write "${tree}/branch${branch}" ""
    for leaf in $(seq 1 "${leaves}") ; do
        xenstore-write "${tree}/branch${branch}/leaf${leaf}" "${xstring}"
    done
done


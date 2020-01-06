Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AACC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CA920848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgAFHYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:24:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:48996 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgAFHYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:24:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jan 2020 23:24:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,401,1571727600"; 
   d="scan'208";a="222761835"
Received: from liujing-mobl1.ccr.corp.intel.com (HELO [10.238.130.219]) ([10.238.130.219])
  by orsmga003.jf.intel.com with ESMTP; 05 Jan 2020 23:24:20 -0800
Subject: Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        "Liu, Jiang" <gerry@linux.alibaba.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, jing2.liu@intel.com,
        chao.p.peng@intel.com
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <229e689d-10f1-2bfb-c393-14dfa9c78971@redhat.com>
 <0460F92A-3DF6-4F7A-903B-6434555577CC@linux.alibaba.com>
 <f8b46502-a5a5-c5c6-88df-101dbfd02fda@redhat.com>
 <56703BDA-B7AE-4656-8061-85FD1A130597@linux.alibaba.com>
 <20200105054142-mutt-send-email-mst@kernel.org>
From:   "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <ec003137-c08f-cda6-6a94-d37d5460189c@linux.intel.com>
Date:   Mon, 6 Jan 2020 15:24:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200105054142-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/5/2020 6:42 PM, Michael S. Tsirkin wrote:
> On Thu, Dec 26, 2019 at 09:16:19PM +0800, Liu, Jiang wrote:
>>> 2) The mask and unmask control is missed
>>>
>>>
>>>>   but the extension doesn’t support 3) because
>>>> we noticed that the Linux virtio subsystem doesn’t really make use of interrupt masking/unmasking.
> Linux uses masking/unmasking in order to migrate interrupts between
> CPUs.

Hi Michael,

Thanks for reviewing the patches!

When trying to study the mask/unmask use case during migrating irq, it 
seems being used e.g.

1) migrate irq(s) away from offline cpu

2) irq affinity is changing, while an interrupt comes so it sets 
SETAFFINITY_PENDING and

the lapic (e.g. x86) does the mask and unmask to finish the pending 
during ack.

Is this right? So we should have mask/unmask for each vector.

Thanks,

Jing


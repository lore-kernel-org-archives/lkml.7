Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16088C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E602C22533
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfKTNiT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:38:19 -0500
Received: from mga03.intel.com ([134.134.136.65]:43545 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729792AbfKTNiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:38:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 05:38:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="200717654"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by orsmga008.jf.intel.com with ESMTP; 20 Nov 2019 05:38:13 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     zhiche.yy@alibaba-inc.com, xlpang@linux.alibaba.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] intel_th: avoid double free in error flow
In-Reply-To: <7e2a501f-955a-5bd1-f70d-ad69e7223981@linux.alibaba.com>
References: <20191119173447.2454-1-wenyang@linux.alibaba.com> <87y2wad7e5.fsf@ashishki-desk.ger.corp.intel.com> <7e2a501f-955a-5bd1-f70d-ad69e7223981@linux.alibaba.com>
Date:   Wed, 20 Nov 2019 15:38:12 +0200
Message-ID: <87v9red5x7.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wen Yang <wenyang@linux.alibaba.com> writes:

> Another example after a few lines lower:
>
>          err = device_add(&thdev->dev);
>
>          if (err) {
>                   put_device(&thdev->dev);
>                   goto fail_free_res;
>
>           }
>
> device_add() has increased the reference count,
>
> so when it returns an error, an additional call to put_device()
>
> is needed here to reduce the reference count.
>
> So the code in this place is correct.

No, device_add() drops its own extra reference in case of error (as it
should), so in "if (err) ..." branch we still only have just one
reference before it goes free.

Regards,
--
Alex

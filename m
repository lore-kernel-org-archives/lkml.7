Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22831C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F93222C4
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfLIN5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:57:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:60392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726687AbfLIN5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 08:57:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC6FAAC3C;
        Mon,  9 Dec 2019 13:57:49 +0000 (UTC)
Subject: Re: [PATCH 4/4] xen-blkback: support dynamic unbind/bind
To:     Paul Durrant <pdurrant@amazon.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-5-pdurrant@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <bbf958af-d435-3a56-1e91-e068125a9ce7@suse.com>
Date:   Mon, 9 Dec 2019 14:57:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191205140123.3817-5-pdurrant@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.19 15:01, Paul Durrant wrote:
> By simply re-attaching to shared rings during connect_ring() rather than
> assuming they are freshly allocated (i.e assuming the counters are zero)
> it is possible for vbd instances to be unbound and re-bound from and to
> (respectively) a running guest.
> 
> This has been tested by running:
> 
> while true; do dd if=/dev/urandom of=test.img bs=1M count=1024; done
> 
> in a PV guest whilst running:
> 
> while true;
>    do echo vbd-$DOMID-$VBD >unbind;
>    echo unbound;
>    sleep 5;
>    echo vbd-$DOMID-$VBD >bind;
>    echo bound;
>    sleep 3;
>    done
> 
> in dom0 from /sys/bus/xen-backend/drivers/vbd to continuously unbind and
> re-bind its system disk image.

Could you do the same test with mixed reads/writes and verification of
the read/written data, please? A write-only test is not _that_
convincing regarding correctness. It only proves the guest is not
crashing.

I'm fine with the general approach, though.


Juergen

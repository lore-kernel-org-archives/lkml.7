Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1011C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897022068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfLINzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:55:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:59704 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbfLINzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 08:55:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B3B57AC3F;
        Mon,  9 Dec 2019 13:55:20 +0000 (UTC)
Subject: Re: [PATCH 3/4] xen/interface: don't discard pending work in
 FRONT/BACK_RING_ATTACH
To:     Paul Durrant <pdurrant@amazon.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-4-pdurrant@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <8a42e7a2-e1aa-69ff-32a4-f43cc5df10d9@suse.com>
Date:   Mon, 9 Dec 2019 14:55:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191205140123.3817-4-pdurrant@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.19 15:01, Paul Durrant wrote:
> Currently these macros will skip over any requests/responses that are
> added to the shared ring whilst it is detached. This, in general, is not
> a desirable semantic since most frontend implementations will eventually
> block waiting for a response which would either never appear or never be
> processed.
> 
> NOTE: These macros are currently unused. BACK_RING_ATTACH(), however, will
>        be used in a subsequent patch.
> 
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> ---
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> ---
>   include/xen/interface/io/ring.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/xen/interface/io/ring.h b/include/xen/interface/io/ring.h
> index 3f40501fc60b..405adfed87e6 100644
> --- a/include/xen/interface/io/ring.h
> +++ b/include/xen/interface/io/ring.h
> @@ -143,14 +143,14 @@ struct __name##_back_ring {						\
>   #define FRONT_RING_ATTACH(_r, _s, __size) do {				\
>       (_r)->sring = (_s);							\
>       (_r)->req_prod_pvt = (_s)->req_prod;				\
> -    (_r)->rsp_cons = (_s)->rsp_prod;					\
> +    (_r)->rsp_cons = (_s)->req_prod;					\
>       (_r)->nr_ents = __RING_SIZE(_s, __size);				\
>   } while (0)
>   
>   #define BACK_RING_ATTACH(_r, _s, __size) do {				\
>       (_r)->sring = (_s);							\
>       (_r)->rsp_prod_pvt = (_s)->rsp_prod;				\
> -    (_r)->req_cons = (_s)->req_prod;					\
> +    (_r)->req_cons = (_s)->rsp_prod;					\
>       (_r)->nr_ents = __RING_SIZE(_s, __size);				\
>   } while (0)

Lets look at all possible scenarios where BACK_RING_ATTACH()
might happen:

Initially (after [FRONT|BACK]_RING_INIT(), leaving _pvt away):
req_prod=0, rsp_cons=0, rsp_prod=0, req_cons=0
Using BACK_RING_ATTACH() is fine (no change)

Request queued:
req_prod=1, rsp_cons=0, rsp_prod=0, req_cons=0
Using BACK_RING_ATTACH() is fine (no change)

and taken by backend:
req_prod=1, rsp_cons=0, rsp_prod=0, req_cons=1
Using BACK_RING_ATTACH() is resetting req_cons to 0, will result
in redoing request (for blk this is fine, other devices like SCSI
tapes will have issues with that). One possible solution would be
to ensure all taken requests are either stopped or the response
is queued already.

Response queued:
req_prod=1, rsp_cons=0, rsp_prod=1, req_cons=1
Using BACK_RING_ATTACH() is fine (no change)

Response taken:
req_prod=1, rsp_cons=1, rsp_prod=1, req_cons=1
Using BACK_RING_ATTACH() is fine (no change)

In general I believe the [FRONT|BACK]_RING_ATTACH() macros are not
fine to be used in the current state, as the *_pvt fields normally not
accessible by the other end are initialized using the (possibly
untrusted) values from the shared ring. There needs at least to be a
test for the values to be sane, and your change should not result in the
same value to be read twice, as it could have changed in between.

As this is an error which can happen in other OS's, too, I'd recommend
to add the adapted macros (plus a comment regarding the possible
problem noted above for special devices like tapes) to the Xen variant
of ring.h.


Juergen

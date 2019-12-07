Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E46C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 08:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07512173E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 08:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuzGvB7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfLGID7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 03:03:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20804 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725976AbfLGID7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 03:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575705838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vliPqnCEhaC7aRJFwTK4kmONvLe/uovKYwo4EW/vES0=;
        b=XuzGvB7eQTn5BVsGU3f1RxGyM/BSv/4dNCPQaTjNUaQ7Fpx+yC6k+nxAVkcKEFpIJeORCg
        suRv+MNlViaueFe44A5FrdmuZ2HlEqnH7h199ezzUjHZbMpnA7hihJBlYHwcIXpf9Z9DuE
        5sn6StaYZlhGldLeNhID4JNx29lXRS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-e3lQR1x2NYGHNHG0AZGL-g-1; Sat, 07 Dec 2019 03:03:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BAB61005502;
        Sat,  7 Dec 2019 08:03:52 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5DAB5D9CA;
        Sat,  7 Dec 2019 08:03:40 +0000 (UTC)
Date:   Sat, 7 Dec 2019 16:03:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     tglx@linutronix.de, chenxiang66@hisilicon.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        maz@kernel.org, hare@suse.com, hch@lst.de, axboe@kernel.dk,
        bvanassche@acm.org, peterz@infradead.org, mingo@redhat.com
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
Message-ID: <20191207080335.GA6077@ming.t460p>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1575642904-58295-2-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: e3lQR1x2NYGHNHG0AZGL-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 10:35:04PM +0800, John Garry wrote:
> Currently the cpu allowed mask for the threaded part of a threaded irq
> handler will be set to the effective affinity of the hard irq.
>=20
> Typically the effective affinity of the hard irq will be for a single cpu=
. As such,
> the threaded handler would always run on the same cpu as the hard irq.
>=20
> We have seen scenarios in high data-rate throughput testing that the cpu
> handling the interrupt can be totally saturated handling both the hard
> interrupt and threaded handler parts, limiting throughput.

Frankly speaking, I never observed that single CPU is saturated by one stor=
age
completion queue's interrupt load. Because CPU is still much quicker than
current storage device.=20

If there are more drives, one CPU won't handle more than one queue(drive)'s
interrupt if (nr_drive * nr_hw_queues) < nr_cpu_cores.

So could you describe your case in a bit detail? Then we can confirm
if this change is really needed.

>=20
> For when the interrupt is managed, allow the threaded part to run on all
> cpus in the irq affinity mask.

I remembered that performance drop is observed by this approach in some
test.


Thanks,=20
Ming


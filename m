Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32C9C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DD42073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXAIb/mi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgAGJOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:14:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54126 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726327AbgAGJOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578388456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mzHsx/Rrd3lLiiC7W87+hNI2uYZ3BAUjcjxT/JMbIlA=;
        b=WXAIb/miAmqSA6uTx6MrW/MVw0xcsF+v+PNqcWK6RC0N2qqrLacNo+W6yInIs68+F3hAbn
        Zmqu1irESCqpbjZiyc1M/RmBpql7wcF2wtI58sHpApPe2HBbqzPliqCgkqWEWMcpiI9HKA
        h0d5lPAVbBPzj2NCKDxya/Wnj0X48A8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126--LRj-Qx8NKOoRGZjA9y0Xw-1; Tue, 07 Jan 2020 04:14:12 -0500
X-MC-Unique: -LRj-Qx8NKOoRGZjA9y0Xw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3644F801E6C;
        Tue,  7 Jan 2020 09:14:11 +0000 (UTC)
Received: from gondolin (ovpn-117-222.ams2.redhat.com [10.36.117.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63B501C4;
        Tue,  7 Jan 2020 09:14:07 +0000 (UTC)
Date:   Tue, 7 Jan 2020 10:14:04 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        kernel-janitors@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] vfio: vfio_pci_nvlink2: use mmgrab
Message-ID: <20200107101404.340a3442.cohuck@redhat.com>
In-Reply-To: <1577634178-22530-3-git-send-email-Julia.Lawall@inria.fr>
References: <1577634178-22530-1-git-send-email-Julia.Lawall@inria.fr>
        <1577634178-22530-3-git-send-email-Julia.Lawall@inria.fr>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Dec 2019 16:42:56 +0100
Julia Lawall <Julia.Lawall@inria.fr> wrote:

> Mmgrab was introduced in commit f1f1007644ff ("mm: add new mmgrab()
> helper") and most of the kernel was updated to use it. Update a
> remaining file.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> <smpl>
> @@ expression e; @@
> - atomic_inc(&e->mm_count);
> + mmgrab(e);
> </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/vfio/pci/vfio_pci_nvlink2.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


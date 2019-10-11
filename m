Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590AEC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB5D206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfJKOTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:19:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbfJKOTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:19:20 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6B1AC80F83
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 14:19:20 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id d6so9595305qtn.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 07:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tOHWk3jmfyzzhm92cDghOddICmz8kRnulovjwgtaBGg=;
        b=qr9385BrYAVqydR8vfLgJqV3ZadKaxH924rJL0MWfZymVPy+lUNtkF1hFNzWX3lo+I
         mclPtPGuZsyb2BreB0s3JrXkZXKyi07BVZCYEOU4hpQsdR0ZLJQqnq/rtxfWWMPExn/o
         dcgMiSaM+/hybZUSCkn6VYf5IZC94jLZbYFynZvWgNgprCwH2Q+0TGX8zPR8NCOk2B0F
         YbVmfQhKIQXhBpS1tJLNNfkLegBpKEWxTp1m4T5F+L27Sx1tI0UAhM60H6yGLT0p/gK8
         U5yUTAbQz4LzFMtqv4aAOoLmHHrHINsgv3LLbtQGFtbk/0KTFSRkhGNptbFYXMCz0HnP
         intw==
X-Gm-Message-State: APjAAAX1e0HuWXSegodtX2KuCD3j83MD7/ZNiw7XLVG8HiXf7nAAJsXX
        T7mI/3ZFHFREy3GnzYIeRNyTtIKTSPddj3whKBB9/GxzcAXE9Ffz7gWL15jlRdnyo5+XFVIEq18
        r0KeJCRhw83ZzeEA24pdpTmTk
X-Received: by 2002:a37:5d3:: with SMTP id 202mr15754096qkf.155.1570803559736;
        Fri, 11 Oct 2019 07:19:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy+WP4PnUirSsaoubHKJFArFKDsMl3YSsGut8UXfiBxoMA6BIkgeYPrju7GgkVsxDH1VHgtqQ==
X-Received: by 2002:a37:5d3:: with SMTP id 202mr15754075qkf.155.1570803559502;
        Fri, 11 Oct 2019 07:19:19 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id s16sm3621356qkg.40.2019.10.11.07.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:19:18 -0700 (PDT)
Date:   Fri, 11 Oct 2019 10:19:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        Jorgen Hansen <jhansen@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] vsock: don't allow half-closed socket in the
 host transports
Message-ID: <20191011101408-mutt-send-email-mst@kernel.org>
References: <20191011130758.22134-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011130758.22134-1-sgarzare@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 03:07:56PM +0200, Stefano Garzarella wrote:
> We are implementing a test suite for the VSOCK sockets and we discovered
> that vmci_transport never allowed half-closed socket on the host side.
> 
> As Jorgen explained [1] this is due to the implementation of VMCI.
> 
> Since we want to have the same behaviour across all transports, this
> series adds a section in the "Implementation notes" to exaplain this
> behaviour, and changes the vhost_transport to behave the same way.
> 
> [1] https://patchwork.ozlabs.org/cover/847998/#1831400

Half closed sockets are very useful, and lots of
applications use tricks to swap a vsock for a tcp socket,
which might as a result break.

If VMCI really cares it can implement an ioctl to
allow applications to detect that half closed sockets aren't supported.

It does not look like VMCI wants to bother (users do not read
kernel implementation notes) so it does not really care.
So why do we want to cripple other transports intentionally?



> Stefano Garzarella (2):
>   vsock: add half-closed socket details in the implementation notes
>   vhost/vsock: don't allow half-closed socket in the host
> 
>  drivers/vhost/vsock.c    | 17 ++++++++++++++++-
>  net/vmw_vsock/af_vsock.c |  4 ++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> -- 
> 2.21.0

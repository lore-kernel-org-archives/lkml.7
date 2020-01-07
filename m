Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8817C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76096208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcQd5Oxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgAGQAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:00:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24622 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728052AbgAGQAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 11:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578412841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2tgaAOxuK+BpANAaDpR2VlivTHiWdjlqBTqnI3DjVok=;
        b=YcQd5OxhDD93m32hoAsJJoehZAPLC2/9IdXjfP+OoZPBljEkOKcm5xF4kfcfVjxsjt//EM
        rBBv7C5GMQc3Nl0PBo8UXgcHQRE3jnCi4FrvxkvWwUQIPHdHq+DjvofrT8bpzIxAitjdvz
        ejxJr7gtSHt/Kc5Ivuv1i2rtXrE+MdU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-QlwyI2DuNjCUj8HwU1u-1Q-1; Tue, 07 Jan 2020 11:00:38 -0500
X-MC-Unique: QlwyI2DuNjCUj8HwU1u-1Q-1
Received: by mail-qt1-f198.google.com with SMTP id m18so73503qtq.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 08:00:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2tgaAOxuK+BpANAaDpR2VlivTHiWdjlqBTqnI3DjVok=;
        b=CBJ87Y2u5VtlA7EkPojP+DbLDtOd1wPVhuPyYgrQyXbiz6dZ8gSBwWx6eVBTNzsdwp
         lK38rbAmuLvUgxhYFqpUv1EwCHUlJSsz/f4cxQMNqlfclZOTPUegaL2HlyLJS4jMSJ9n
         lTt6yrPiVNyuhkgXrEPmUM/gCBgfxi6go2AYHSjzdoF3RIRCahgr4d3UztsV42LxtDyf
         1nvBEIAF3QuLQ7qeJjOAqcfE0S1aRtwPaxALoDMm7edzoCBULpW6Sx3P7OT3zQ6AErPg
         iVWJRF/eFd3AneYuHyCQUpsUpUfcIjA7d63CcC18B4tAOV0sQcnXeDXzMAZA/Oadu5+n
         cagw==
X-Gm-Message-State: APjAAAWVZKGss1zK0t2q9lKDrVMCHUp+PO12tc4Gkm+Bd5LfoCcXA11u
        E7VFsmuhoX5JNa5Cl6D5GwqrzMSfKizT20mqLLH4QR7paSWq4I8xNnOfkMOsnGz3do2Jlv0hBbL
        4lPavxu5P+4FEil7sJoaod/mE
X-Received: by 2002:ad4:5614:: with SMTP id ca20mr77314qvb.43.1578412838104;
        Tue, 07 Jan 2020 08:00:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxco4tN6LuFo9JPmqxefJvTz1h/hHztoZLdPyxjrU9NmEQbj/K8aPW34C5/taBpDrO7OrLbbw==
X-Received: by 2002:ad4:5614:: with SMTP id ca20mr77269qvb.43.1578412837710;
        Tue, 07 Jan 2020 08:00:37 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id t1sm20365985qkt.129.2020.01.07.08.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 08:00:37 -0800 (PST)
Date:   Tue, 7 Jan 2020 11:00:35 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v3 2/8] KVM: selftests: Add demand paging content to the
 demand paging test
Message-ID: <20200107160035.GG219677@xz-x1>
References: <20191216213901.106941-1-bgardon@google.com>
 <20191216213901.106941-3-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191216213901.106941-3-bgardon@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 01:38:55PM -0800, Ben Gardon wrote:

[...]

> +static void *uffd_handler_thread_fn(void *arg)
> +{
> +	struct uffd_handler_args *uffd_args = (struct uffd_handler_args *)arg;
> +	int uffd = uffd_args->uffd;
> +	int64_t pages = 0;
> +
> +	while (!quit_uffd_thread) {
> +		struct uffd_msg msg;
> +		struct pollfd pollfd[1];
> +		int r;
> +		uint64_t addr;
> +
> +		pollfd[0].fd = uffd;
> +		pollfd[0].events = POLLIN;
> +
> +		/*
> +		 * TODO this introduces a 0.5sec delay at the end of the test.
> +		 * Reduce the timeout or eliminate it following the example in
> +		 * tools/testing/selftests/vm/userfaultfd.c
> +		 */
> +		r = poll(pollfd, 1, 500);

Would you mind implement it instead of adding a todo?  IIUC it's as
simple as a few more lines than the comment itself.  Thanks,

-- 
Peter Xu


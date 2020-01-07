Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C584AC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCAD2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kp+EwQSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgAGQEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:04:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25480 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728344AbgAGQEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 11:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578413050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6/pI4t6B9z0wRX+NvUB89xIHygZ7s0TFKH3LWLJINv4=;
        b=Kp+EwQSb8lIYF0CdCvhVMg8eVvxZ4qVbmazz+orINvev3HSdFbcH2rfzdz/tPCgEeG61YC
        0+P8OAlA9uw1/GUpnykM5q4Gyvx+1q+KOKRzl0O7HAeAJx0LBJPqv0ps8IqDddnaFQduyP
        2lFrfQlny/ewDNDTbrHWeE93ef0/HzM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-x3SosPuIOXyGvpi-kHT3aA-1; Tue, 07 Jan 2020 11:04:07 -0500
X-MC-Unique: x3SosPuIOXyGvpi-kHT3aA-1
Received: by mail-qk1-f197.google.com with SMTP id d1so78581qkk.15
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 08:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6/pI4t6B9z0wRX+NvUB89xIHygZ7s0TFKH3LWLJINv4=;
        b=H1oWEFfWpWaPa6M98w0cmukZ95YPjPvfeoSMp7RPB3yTAQf7WyksCdwnbOCHmzpJLd
         dOSrQiivNeIXlbuSxjwL3/pYE3qvaw/6rPPqqUINGFU3CGJaOgNbXi4ri+xor9ahzVxy
         ojw16QwMTM60ZZU7V9v5KdG2Ny6hNsOfYNBb1k+CXKe5mFNVH8lrj+78AnUJJ49tcqJ4
         BZo7M+XNbz9KPQOaKpx+REMHHCgRuUj1Hdfr6JaBlHGxo8PN6GiyyopKH6jlMywAQvzk
         VZBxNqutMf3tE9FwBkD94hSYYp+D4nZ0Swg+DTtcH5LXRvZ3c38RVgczh6/cd0qivwtg
         yJhA==
X-Gm-Message-State: APjAAAXqEKcS/ocfECwDGYgUytlbLWHJHdkC/WwEfhsZ1e5MqUJzBYuP
        kmXLfv7LcsEQePjBcCgDtZGKLtKImgyDOSobXqOLFqihg9leRx8NREcg+uuv9lydP8G7WeiowmK
        IFp/5ykj448lq/kEOVCu2VyU1
X-Received: by 2002:aed:2d67:: with SMTP id h94mr78673825qtd.74.1578413046804;
        Tue, 07 Jan 2020 08:04:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqw66uIFnVme9AqF60F5anI9TjXT0ppMeOA6QoIMEfNwjdJGOKZ3GP3xMn0fUgfQqx9ibtRZXQ==
X-Received: by 2002:aed:2d67:: with SMTP id h94mr78673801qtd.74.1578413046612;
        Tue, 07 Jan 2020 08:04:06 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id k50sm47999qtc.90.2020.01.07.08.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 08:04:05 -0800 (PST)
Date:   Tue, 7 Jan 2020 11:04:04 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v3 3/8] KVM: selftests: Add configurable demand paging
 delay
Message-ID: <20200107160404.GH219677@xz-x1>
References: <20191216213901.106941-1-bgardon@google.com>
 <20191216213901.106941-4-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191216213901.106941-4-bgardon@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 01:38:56PM -0800, Ben Gardon wrote:
> When running the demand paging test with the -u option, the User Fault
> FD handler essentially adds an arbitrary delay to page fault resolution.
> To enable better simulation of a real demand paging scenario, add a
> configurable delay to the UFFD handler.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


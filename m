Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959BDC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6975924656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QV6E/rmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgAGOdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:33:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46005 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727559AbgAGOdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578407620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LIlISc+oFNSUFYsXBbt0s1bPhdRwU0QuyhBE/WUY0LY=;
        b=QV6E/rmv7bRlaG12RqFhExv4otSpYPlN/IzQcVsvpJsvtozAyBCI41uSHvi9aHt/xFl9yl
        RYr9Ph3nYZFMimWNjF+BfGsXMfFtnH+Id4SQJhcfIqIVsVBlyllAP9oKbutkGALYWQkAS1
        wiUtRDfTI4IoJnST870S6SU7Z2RCpFI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-6Vq-6UJKNv-K3h_GhMjWMg-1; Tue, 07 Jan 2020 09:33:37 -0500
X-MC-Unique: 6Vq-6UJKNv-K3h_GhMjWMg-1
Received: by mail-qv1-f70.google.com with SMTP id k2so3894qvu.22
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 06:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LIlISc+oFNSUFYsXBbt0s1bPhdRwU0QuyhBE/WUY0LY=;
        b=kqehBnHbHmdWLlgrlHkeNHcPX80p0YMVxegmsV33VIPUcZP7QkEwawbjH9KwfhOIyE
         jxvbHBDKsH+RuIuyp2q4dydbVD5ZwRnIfl59ZIL4xaGhxu/IYAfq5b0l5g3ffjWJ5qs1
         jQnICaaiQcsyow+amhL7EvRB1voT/CxH9vigDoqBug0QMixRgyNcVhH7dHD6AEmlOH2g
         SvsobiU9+E0gnvV98mRsTdZknRbZVISdrnROIW+ESNS8PCPk4Gp2wSt4EhFU4kGEVT5z
         YMsoNb+bBksJ/lzUoSGdZ3XiGm3qsJlmgfFSk2+yNgKStpu6HUYQJoEFDQGlXhNAsCKa
         EX7A==
X-Gm-Message-State: APjAAAUwnvYZiLnM6EHDiysFmatCJorgvU2CC6WJkRyk8vJvPSZcxsoq
        DDlUNtAgssoRr8T0PF501suChva3abzRf7roge6lf44H3O78XmELuimdBV6k3DHA2EMXmZlDPNl
        Uc0G+WW8Or3idDtCm5ci6xEDB
X-Received: by 2002:a05:620a:1663:: with SMTP id d3mr89412683qko.204.1578407617059;
        Tue, 07 Jan 2020 06:33:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwIGMDr1WALhNYI3XjsUL6aYAw4TNtgyas8iR6yCDYV5GmJoDkDtGiffkZzxsW1v0I7msmFFA==
X-Received: by 2002:a05:620a:1663:: with SMTP id d3mr89412659qko.204.1578407616724;
        Tue, 07 Jan 2020 06:33:36 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id a19sm22455306qka.75.2020.01.07.06.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 06:33:35 -0800 (PST)
Date:   Tue, 7 Jan 2020 09:33:34 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v3 1/8] KVM: selftests: Create a demand paging test
Message-ID: <20200107143334.GF219677@xz-x1>
References: <20191216213901.106941-1-bgardon@google.com>
 <20191216213901.106941-2-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191216213901.106941-2-bgardon@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 01:38:54PM -0800, Ben Gardon wrote:
> While userfaultfd, KVM's demand paging implementation, is not specific
> to KVM, having a benchmark for its performance will be useful for
> guiding performance improvements to KVM. As a first step towards creating
> a userfaultfd demand paging test, create a simple memory access test,
> based on dirty_log_test.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>

It's fine to start with x86-only for this test, but imho it would be
better to mention that in cover letter, or reply to reviewer comments
on that you removed aarch64 from previous post.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


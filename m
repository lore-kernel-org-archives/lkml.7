Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DE5C7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC12C2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JX9vGziM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388796AbfG2VrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:47:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44634 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfG2VrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:47:15 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so123297975iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j10iEndEcfl7GFmx0FBUfHkT/DIF6Lz0Je3WuUXspf4=;
        b=JX9vGziMLV0bTzWdDEXuN2wORxj61dz7dEOXT8Y9SKYKtqwU+xD6ErVpMeRWiEzuI9
         98yyj3qE8qXIZZMfgOvU/ScnBtJ2CDT7V5DT0pjTOgpoyLSl95jt69WDW0iNODp2cmw9
         oF09HKKjSA6zgwa6539xg9dw/7oNc3Q6Debx/rjZCXOUFxjL/1CUBhy5gRGjz0EDELiY
         9DcD3CI1ee7sVs5VlAd44Xw0XZ16251YPtko3DyygrdJoTjMekRrdWrFZ1Nb2c4cLzEf
         KpxJZbxyRTy9MEYf/AHlJ0Sd8kVCJIC6j3PJvb19FoT65p1ROCUKwFKE9pqk9jvoKbBq
         E1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j10iEndEcfl7GFmx0FBUfHkT/DIF6Lz0Je3WuUXspf4=;
        b=gqhKO0WR/87Xy+kOAtDQrJUiiRyLqL1QkOi7oa9J7RfTcrd9LM10Py9tkfbclESKe0
         G1zcdMNSPqiyFrvdxIDh4Mp2Io46RsuvxE15CpEu4xssST9kdHFN1G873Qb6SJ+hHBXq
         NQ8llgvq6vp5yuU32EPxBjQ3UR9OUXKxJMG7RqT8SZKKXOaseC7+MuPtxu52g5ak2fUo
         CGHW7G7otdFXaEKb936GXRXcMHGbCXkMBD8XPtZFDZhwJs3Sqxok0VG8sEHMP7tN4+Vn
         VYNns8pyclIbxOMp+i47NQ07XrKkdi9EbxS+vWjYdDsdMVHTjYn8V7BqSBxArc6CC74I
         mD4A==
X-Gm-Message-State: APjAAAXU1hXxCg/lQUmP8YOuv4Okj517mTQeO7mn4Bu1H9FJgGkU1JDN
        fNz9giBaJGBdNQuff6B2QFeMtt4yHrOB0Khcc8BzYw==
X-Google-Smtp-Source: APXvYqzm3EZUnnvVpNns0C5pcvCXqaLAcYBywGrdM9ZfVRZDiZMOV9R7ercGbfHFqw5oA66zZL1UqInfPCyK99Izl1k=
X-Received: by 2002:a5e:8c11:: with SMTP id n17mr35080222ioj.64.1564436834661;
 Mon, 29 Jul 2019 14:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com> <20190718194415.108476-24-matthewgarrett@google.com>
In-Reply-To: <20190718194415.108476-24-matthewgarrett@google.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 29 Jul 2019 14:47:03 -0700
Message-ID: <CACdnJuvFBQCpR4hk1YBQ2HSxJcweB0_XBqYZxn=LpG6NFU7S6w@mail.gmail.com>
Subject: Re: [PATCH V36 23/29] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 12:45 PM Matthew Garrett
<matthewgarrett@google.com> wrote:
> bpf_read() and bpf_read_str() could potentially be abused to (eg) allow
> private keys in kernel memory to be leaked. Disable them if the kernel
> has been locked down in confidentiality mode.
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> cc: netdev@vger.kernel.org
> cc: Chun-Yi Lee <jlee@suse.com>
> cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>

Any further feedback on this?

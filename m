Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94931C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B55218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="IF7AL/YR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfCTVXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:23:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34674 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfCTVXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:23:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id k2so4411160qtm.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Aj6nIkn/AI1AWOF6wEFthrXZBX84FY8wDZnSJigal8g=;
        b=IF7AL/YRhbpaZdHqMetud8t7yiazxqXvtQnXKunLy4VNyxr7P4CnBV1c9PoknNhA3L
         tZ/DGlqxfElhkjbZcsJvNhaRyCX5FP1R8EHA5zj+Wko3imaXTtBhvq4BbOo7wl2r+Y6y
         5VJOMQm87TlhLNM6qC7TW59kAYjnIKPhmMUgQ42hkxkMzklQVRNBMVkwjGlBXYhG/dYd
         4oLnYJ7RVGVc3VPFG3gUw2wQ99e+BWZo/4K8vXj55/eO92kRWFnRON1Sgo78vtmjEvIS
         nf7TsZVGZsTQx5LAWeR9e91SmEbHUIlFX8YlSyTvXK+eIoIM68Rnh7A8EQ3XfDNXCWNb
         1YiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Aj6nIkn/AI1AWOF6wEFthrXZBX84FY8wDZnSJigal8g=;
        b=i/99JFBzfIuVTxUlOFFbadCF5jegYIBSdOQ7nZrgpw16nm4riKOFDLsWobjvHtNdG7
         L2qWQY0lbCaLBWTcDq7UV8A6/rH/B8gXQfcsGaBwtuungpQUdUBNfegeWN/ik5b/4O6O
         3xXCqowQ5omAIu/MtFFY1gXMnJhRbqBwrToxbq0Pcj5XWMDLYC2Vd1qzg5b6yDpDj9I5
         QVhtlltmseGOZrnS1NecWMov0qPJXkr63DQV/dJsJD1F1ZNES0rmlLYRzzZwaWgi41Ac
         hoGiYXtyJ1UpZ4j7XaOZcYd8G5kBAJY1FdlA1AocW70Tna6zfdP7SHkj8zPs0mWcR9Z3
         JOEw==
X-Gm-Message-State: APjAAAXvoDvRPenfYeQuPcQqphiiaILvwNIX4qaUVIkLVeAJWgMJHIyn
        MUMHGq0ErLgKxYcNdnghg9ssFA==
X-Google-Smtp-Source: APXvYqwidp8PK88SKWHfQz18wyMml4ciS0Q2gHGtN8xR2rx5uBD6FtZh7fyEinqsVOpP6EvS1/zhzw==
X-Received: by 2002:a0c:81fa:: with SMTP id 55mr151252qve.91.1553117031341;
        Wed, 20 Mar 2019 14:23:51 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id v8sm1881599qtv.81.2019.03.20.14.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 14:23:50 -0700 (PDT)
Date:   Wed, 20 Mar 2019 14:23:46 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alban Crequy <alban.crequy@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alban@kinvolk.io, iago@kinvolk.io
Subject: Re: [PATCH bpf-next v1 4/7] tools: bpftool: implement map exec
 command
Message-ID: <20190320142346.3b552895@cakuba.netronome.com>
In-Reply-To: <20190320173332.18105-4-alban@kinvolk.io>
References: <20190320173332.18105-1-alban@kinvolk.io>
        <20190320173332.18105-4-alban@kinvolk.io>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 18:33:29 +0100, Alban Crequy wrote:
> From: Alban Crequy <alban@kinvolk.io>
> 
> The map exec commands allows to open an existing map and pass the file
> descriptor to a child process. This enables applications to use an
> existing BPF map even when they don't support bpffs.
> 
> Example of usage:
>     # bpftool map exec pinned /sys/fs/bpf/foo fd 99 cmd -- readlink /proc/self/fd/99
>     anon_inode:bpf-map

Would you mind telling us a little more about the use for this feature?
It seems fairly limited.  If it's about probing objects (finding out if
they are a map or a program) perhaps we can add a command just for that?

(I guess bpftool -f isn't really the cleanest way of getting at that
info.)

> Documentation and bash completion updated as well.
> 
> Signed-off-by: Alban Crequy <alban@kinvolk.io>

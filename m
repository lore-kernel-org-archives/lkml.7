Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C6CC73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 18:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BDA20644
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 18:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="KQB4R6Vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfGNSVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 14:21:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40992 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbfGNSVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 14:21:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so11545642wrm.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wnb9nn2B9H0aCiCMAJR3V3d0+SuWg3WhM/Ux4knA5zw=;
        b=KQB4R6VkA+OYz6z436+6Znh4f8IZ8va+IDDsHL2xD5NcxGRNH+8qZirOwYWrCO7owa
         U+QKooAfq70s+HlGI+WIak+z4KvavNpggzrJHJ5k5nmviBHrxGnp8zxkRAYA4ssS3f8M
         0cf3NkGQ/+kHulP9WtK7Ke7sZiok68dxs/NvhTla2CmS0l0j/O7E99jPLrpxMATzzPNw
         ndJspgegz/ointrHIOlxBwtYc0P8Vw23kSqxJA6tD9YtWrJhoCP/AvhZ7AqaiuUBsxk9
         zq2ODcc6gy35dz0ToFjtIOcxGceqtyOjKTxDSbq9sOBurRuB+LcPzjRfNdogdOXQH/x/
         61WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wnb9nn2B9H0aCiCMAJR3V3d0+SuWg3WhM/Ux4knA5zw=;
        b=S6qVwxSzQcZs/AeGCG0U1tQOfmK8F9JNlq1KfnUDXUwOBs8VeisnURUowzbGtiarCk
         MIcl2jAzn/DLGkxRnGoJlDmsT/Icnfm8lUwtcvlQ+OcahivbG/qPqb/mESxF7uKHkmiF
         KF00tcPc4w+6/60F9zRP4TxliuXuXiMn84zHrsKaa6wWIBwN3mrjwV5eFno+LgPvAtQW
         9KZ8gcoDHnUvTd0l1vQnuceMCH/+t7XPabkaMAJlsPyMdONLNVko75C4uMNIKEfwU7ue
         YflPz6M5ZAhjB1F2+bB2iJOdVbkDe2Ps6koLD6xrGLGonrSQMKwjC/O98dQRUi0QZr+4
         XStg==
X-Gm-Message-State: APjAAAU+XRjhd1b5YGD97oHhg9WCgKD/AkgjAYmD/4SzqZBD+7nqkSX0
        9T0/VJCq4sDrV0Egs4NkPyk=
X-Google-Smtp-Source: APXvYqzG95BCHtda3TJntDM8lscGBt3JFLQ1tchM1ivJYXcKmMovAKxj/1Kb2NOefoNwq4uPM1yIaA==
X-Received: by 2002:a5d:5692:: with SMTP id f18mr24060934wrv.104.1563128488793;
        Sun, 14 Jul 2019 11:21:28 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id f1sm10586332wml.28.2019.07.14.11.21.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 11:21:28 -0700 (PDT)
Date:   Sun, 14 Jul 2019 20:21:26 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Anatoly Pugachev <matorola@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clone: fix CLONE_PIDFD support
Message-ID: <20190714182125.z2qepmevnkwnuoby@brauner.io>
References: <20190714120206.GC6773@altlinux.org>
 <20190714121724.mwg2t3di6goha7yq@brauner.io>
 <20190714141007.GA9131@altlinux.org>
 <20190714142304.3uihy4vepmxgdqha@brauner.io>
 <20190714161449.GA10389@altlinux.org>
 <20190714162047.GB10389@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190714162047.GB10389@altlinux.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 07:20:47PM +0300, Dmitry V. Levin wrote:
> The introduction of clone3 syscall accidentally broke CLONE_PIDFD
> support in traditional clone syscall on compat x86 and those
> architectures that use do_fork to implement clone syscall.
> 
> This bug was found by strace test suite.
> 
> Link: https://strace.io/logs/strace/2019-07-12
> Fixes: 7f192e3cd316 ("fork: add clone3")
> Bisected-and-tested-by: Anatoly Pugachev <matorola@gmail.com>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

This looks good; moving this into my tree.

Thanks!
Christian

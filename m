Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DD9C32753
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8882073D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMAo8/vM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406068AbfHBNfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:35:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44889 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406017AbfHBNfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:35:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so33641892plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 06:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FUKwvsUakiLdWHeLmkm41eeKrCNSJsxR9s2deeLtAuU=;
        b=FMAo8/vMKAG3Z081LK7599yv8zpQ5D1bMJw/Chyc6hnWkWEUo3NtEviyx4qmTuoLAu
         s/81LhUqS6pnSzJ5KEV/XM744D5k8ZgDTQNogZU5IMvzmejd4Y2sMifoYG/ikmpctugZ
         EUnXnEtqKJgtRF1tcCwX916sa8aGaIcKWLMRm6BZGPuNbE4Z3F2ErVvlwPnmxtweyF2K
         SS779zE83lL5bpAS8mOJ/opldu5ZFMsAFgxmimKF4D1NeOyGLnt6z9by0WJB/TUTEr/Y
         /q7HO6go55GE33Vt0iklPJzIUXu4OQD66lPdunc9FCEeTv6ceu+Immxa0kkzPac8IKw5
         jd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FUKwvsUakiLdWHeLmkm41eeKrCNSJsxR9s2deeLtAuU=;
        b=c4EmrScZrzL0xsyqpTIlvUPrbTun4RVP/4nxt1DqeCh+vav8rM/gIFRX98L7J+4R93
         IB/LJZvUgLBQ68fVOdXai2/+LelE8+V9DmcoybkO0k4Qg7YhWqilYkUJAjb0/7vEaRvm
         D3pa948MZzIYNb5vHxLiTJEhpumOoQEsc/ZUKUhk7U8SwhIVJoNTbM2bcwv2CHM0Y4ug
         Z+vrpoom7tIEezFvQ7C3wk/Bl46jmQoAA/2e31wXXSzldJPUa54ChMyZmcl0FT3fKrls
         /iNutnKvN6JLdMTNaBCtWZ9atgJy2PLyzHAVBormyOOmMRtMHv0S3LOcTHCWm/jkvRj0
         j2cA==
X-Gm-Message-State: APjAAAUvc7KTwuZxqRTJfxC7Bn/n8h14YKaBuFZRAmPYIEp/1QMMSJLh
        UtbcJv53tHReLYffJ03ctFk=
X-Google-Smtp-Source: APXvYqwCXqnpwkproCYUNPLmAwfyhMI2JJoAiWiv9cKeSy9WaCOxpDHDV717uA6xD2DJ2hwr19LRfA==
X-Received: by 2002:a17:902:aa88:: with SMTP id d8mr124580948plr.274.1564752906788;
        Fri, 02 Aug 2019 06:35:06 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id g66sm73903121pfb.44.2019.08.02.06.35.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 06:35:06 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 2 Aug 2019 22:35:03 +0900
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 2/2] i915: do not leak module ref counter
Message-ID: <20190802133503.GA18318@tigerII.localdomain>
References: <20190802123956.2450-1-sergey.senozhatsky@gmail.com>
 <20190802123956.2450-2-sergey.senozhatsky@gmail.com>
 <156475071634.6598.8668583907388398632@skylake-alporthouse-com>
 <156475141863.6598.6809215010139776043@skylake-alporthouse-com>
 <20190802131523.GB466@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190802131523.GB466@tigerII.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/02/19 22:15), Sergey Senozhatsky wrote:
[..]
> > > Looking around, it looks like we always need to drop type after
> > > mounting. Should the
> > >         put_filesystem(type);
> > > be here instead?
> > > 
> > > Anyway, nice catch.
> > 
> > Sigh. put_filesystem() is part of fs internals. I'd be tempted to add
> 
> Good catch!
> 
> So we can switch to vfs_kern_mount(), I guess, but pass different options,
> depending on has_transparent_hugepage().

Hmm. This doesn't look exactly right. It appears that vfs_kern_mount()
has a slightly different purpose. It's for drivers which register their
own fstype and fs_context/sb callbacks. A typical usage would be

	static struct file_system_type nfsd_fs_type = {
		.owner→ →       = THIS_MODULE,
		.name→  →       = "nfsd",
		.init_fs_context = nfsd_init_fs_context,
		.kill_sb→       = nfsd_umount,
	};
	MODULE_ALIAS_FS("nfsd");

	vfs_kern_mount(&nfsd_fs_type, SB_KERNMOUNT, "nfsd", NULL);

i915 is a different beast, it just wants to mount fs and reconfigure
it, it doesn't want to be an fs. So it seems that current kern_mount()
is actually right.

Maybe we need to export put_filesystem() instead.

	-ss

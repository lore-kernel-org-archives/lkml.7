Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920E2C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C02021670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukGEBlNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfD3JiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:38:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46228 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfD3JiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:38:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so12084958ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 02:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zYjnml+G09Y2iH7YOBy1RnUmEBfOtgqF9A/Rh/pjRIY=;
        b=ukGEBlNWpw3ngsxHEBXIQvlOeQhk4/p8R6GklmoB2a/Xv4c2NAwqOW+cNq7yBLyL2B
         dBM9smuHxp7kZy66IxNEH6kzgwI4RJd82xvidtZDKhUdNbLaEsENurzJ+oj57ObbDtPs
         2gPE4aJopsgxoW0EJ3MNExq6DgBsaZ+Kv6Jfluqf0CtBIn88GNQzHCmQolL80H1brM2K
         yijxEgwd99V9DqOpzUHXvBwaNvpoxs9k9tTcEX9MRgfaanxEYssrdayZTUb/xuilfH7/
         y9GV0XIkScDJQx2nQUJrqtsIXjr2x18uJzzzUjE/TilqtUizxTCPjBmxTC6/AOgrlhFc
         HKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zYjnml+G09Y2iH7YOBy1RnUmEBfOtgqF9A/Rh/pjRIY=;
        b=oA8rZ3PBj06sSA8s3hBgKX35s1u//j9t2mdi8WBxvBZbKcVG8WqjYHi3vqkFOXvJ4H
         cYPHTeMyFEdMmzXUSd0OuEr66OdZ7kxgC8EBRCKZOKByWSRupbJzVYW9Zp+rpXnvj42D
         Sm0qsl10YicI1ReeTa3Rv804AJ9noQQnPa5+w69BNcZbLL9xq2pFCJvfFMZgPcCn/FGM
         dcImPFk2/gSjBaT5ShtXl0tcxaZTF3SX3sSWpc1J6aMCGM4Rl/DhXH/AMwjVRAtIVUmy
         K8TXNa74b4gLyyZr4o3OdtQP3NTp/WCy3CRqBShepihlxZSjS6wusnRZFI1Toaio6pbN
         aBWw==
X-Gm-Message-State: APjAAAUhxMieGq2E5TVCc35Ki6Y2f/QIO4GBxZ4oILhosX4ZtDPvyNwx
        VyjrVcuQ2/KQIrOMbPqrAwY=
X-Google-Smtp-Source: APXvYqxOGwnTEPiPGzR1pnewgUsAD0rmNHah8NK5uqndt/a8Ai7cN9+BqLVfK2dgtlDwZGL1HRdMqw==
X-Received: by 2002:a2e:8648:: with SMTP id i8mr36897627ljj.166.1556617090058;
        Tue, 30 Apr 2019 02:38:10 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id l16sm7876890lfk.44.2019.04.30.02.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 02:38:09 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 840A24603CA; Tue, 30 Apr 2019 12:38:08 +0300 (MSK)
Date:   Tue, 30 Apr 2019 12:38:08 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        akpm@linux-foundation.org, arunks@codeaurora.org, brgl@bgdev.pl,
        geert+renesas@glider.be, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, mhocko@kernel.org, rppt@linux.ibm.com,
        vbabka@suse.cz
Subject: Re: [PATCH 1/3] mm: get_cmdline use arg_lock instead of mmap_sem
Message-ID: <20190430093808.GD2673@uranus.lan>
References: <20190418182321.GJ3040@uranus.lan>
 <20190430081844.22597-1-mkoutny@suse.com>
 <20190430081844.22597-2-mkoutny@suse.com>
 <4c79fb09-c310-4426-68f7-8b268100359a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c79fb09-c310-4426-68f7-8b268100359a@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:09:57PM +0300, Kirill Tkhai wrote:
> 
> This looks OK for me.
> 
> But speaking about existing code it's a secret for me, why we ignore arg_lock
> in binfmt code, e.g. in load_elf_binary().

Well, strictly speaking we probably should but you know setup of
the @arg_start by kernel's elf loader doesn't cause any side
effects as far as I can tell (its been working this lockless
way for years, mmap_sem is taken later in the loader code).
Though for consistency sake we probably should set it up
under the spinlock.

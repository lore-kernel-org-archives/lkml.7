Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7112C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DAC206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555442254;
	bh=Gyal0DJBynaOAunz+LSzA+7EJ5fZVwePBNLNCkzk9is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aDCX/BPJ8CHeLbUHjcCVOj8OChVgLJLQ/7kSPlX8smjC0qyNQVPOXh/76e3z4oD2i
	 EqqRYr4CeWGTF6Gg0YHWUdtqVQ4Qgqfn1JgH5W2RJDbOBzYeF7ymnQmIlBfuTFyWns
	 Bgo5hjLdLzhz9cVmBmGoxTdwdnuDXOYizFDKH0N8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbfDPTRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:17:32 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36718 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPTRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:17:32 -0400
Received: by mail-yb1-f196.google.com with SMTP id e76so8193854ybc.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 12:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v8LNHinSAWsRwFIAeDbz9HBGrKYVLRo7R09JylxmB0o=;
        b=OV+0PMnNogS0CKUY/MoNhjHD9MsmHFDoB/ap24DIZmHRGdGikia0A3ajEezOy+GAsJ
         PnVWtyrz/ZwF5PznqiFLwU1wpgBaQgLspGZWY+o4wn707WlY25KxFMGGy7gcoLHPkzxQ
         PCfIT9mHMcJW28Z2DOdvh1So2pqxvuFTctVYAvkDx7ujnhcAkNjFVKxNXHCTmv0lFBzO
         LBs0YE0spWnHprcM5FoLgyrgB5OwYCaJQfUxNWz/ZaT7jfG+LIW+KBarXmjln1aZdCgu
         3p4opfmIuiB6X7bwCKWlYZ+TGJ1MAL8TxzBJKHnBuWk1ywc67HWigOYSd5BGP5uFVabu
         rTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=v8LNHinSAWsRwFIAeDbz9HBGrKYVLRo7R09JylxmB0o=;
        b=qfoMSV2NDuMdN4/89yUOWSP7o0L2F+j16IzykmduVh87Kz1Q54FMdM2EQsVuZw2QAe
         1USrRXKogW+J/uTHZDJXMOL99+fd+2SYfmwOdjs968RgCkMybTOjYONb+AF0BtsIl3RY
         /WSCQRu3CTEIEY3r208wPPEdeT//AIV1B06X2alJLJoTJljtqBjtmKzJ4FBXzuGCIZ+8
         ZrROaMi0uPDDWpjUu7UQO1MMjoPCgeJu/r5r2dFjQ0GNQlLlpauuN1Vgl0GBnNNRq+0v
         TSJUhOn+hCGbaFhvqdyumtIShAwpPhbLcxp1mJCpnQjOekzphj52nVSoGHtMzeQ7N9Kl
         ZZ9A==
X-Gm-Message-State: APjAAAVWfPqkl2vPBHqfXIAW0PHoUFZMfWkxHL7AjNPMM7PotYJiW1J2
        GcPnOSqrS+gZDTFzTtpOduE=
X-Google-Smtp-Source: APXvYqy0TSHeqXVJzhHz+a1KIAwVc+TNFvPEi2T5Yyc1KyY5zXqm32szj5JvPoV6whTEhXY2N2hpQw==
X-Received: by 2002:a25:9703:: with SMTP id d3mr55763549ybo.113.1555442250507;
        Tue, 16 Apr 2019 12:17:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::c7e0])
        by smtp.gmail.com with ESMTPSA id y70sm22283236ywy.86.2019.04.16.12.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 12:17:29 -0700 (PDT)
Date:   Tue, 16 Apr 2019 12:17:27 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Konstantin Khorenko <khorenko@virtuozzo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] kernfs: keep kernfs node alive for
 __kernfs_remove()
Message-ID: <20190416191727.GD374014@devbig004.ftw2.facebook.com>
References: <20190416155335.14627-1-khorenko@virtuozzo.com>
 <20190416155335.14627-2-khorenko@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416155335.14627-2-khorenko@virtuozzo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 06:53:35PM +0300, Konstantin Khorenko wrote:
> __kernfs_remove() which is called under kernfs_mutex,
> assumes nobody kills kernfs node whie it's working on it
> and "get"s current kernfs node for that.
> 
> But we hit a warning in kernfs_get(): kn->counter == 0 already:
>   ------------[ cut here ]------------
>   WARNING: CPU: 2 PID: 63923 at fs/kernfs/dir.c:377 kernfs_get+0x2f/0x40
>   ...
>   Call Trace:
>    [<ffffffffa7f92e67>] dump_stack+0x19/0x1b
>    [<ffffffffa78987b8>] __warn+0xd8/0x100
>    [<ffffffffa78988fd>] warn_slowpath_null+0x1d/0x20
>    [<ffffffffa7aecaff>] kernfs_get+0x2f/0x40
>    [<ffffffffa7aed233>] __kernfs_remove+0x113/0x260
>    [<ffffffffa7aee201>] kernfs_remove+0x21/0x30
>    [<ffffffffa7af1010>] sysfs_remove_dir+0x50/0x80
>    [<ffffffffa7b9fb38>] kobject_del+0x18/0x50
>    [<ffffffffa7a38a4d>] sysfs_slab_remove+0x3d/0x50
>    [<ffffffffa79f1e6b>] do_kmem_cache_release+0x3b/0x70
>    [<ffffffffa79f2aa1>] memcg_destroy_kmem_caches+0xb1/0xf0
>    [<ffffffffa7a4ed5c>] mem_cgroup_css_free+0x4c/0x280
>    [<ffffffffa79377fc>] cgroup_free_fn+0x4c/0x120
>    [<ffffffffa78bc222>] process_one_work+0x182/0x440
>    [<ffffffffa78bd3d6>] worker_thread+0x126/0x3c0
>    [<ffffffffa78c4441>] kthread+0xd1/0xe0
> 
> This could be for example because of kernfs_notify_workfn() which
> does kernfs_put(kn) out of kernfs_mutex held section,
> so move kernfs_put(kn) under the mutex.

This patch doesn't really make sense to me.  Can you give a more
concrete scenario where this would help?

Thanks.

-- 
tejun

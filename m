Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC17ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAB721479
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfJGOpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:45:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfJGOpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:45:51 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8373E80F98
        for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2019 14:45:51 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id r15so15496492qtn.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 07:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pAkWBhiPIf23Q3yen918L7S8GMw4Rv0tKaPiOqMHwe8=;
        b=MmK7hru+dyNiQ/Z7mospgr02LIV0KOUYUTeHMghU5jw4lNM/2P9hUGYsDG0liqOcXb
         A+WZYZpPiIA9OuYS4jhP3vGWxfm6/ucazK2hjfbUuOY0WUpnNIOTUI9wuWcbmVacRzyG
         hMm88eDypNSWlK3xSvRasCH21/6VSL02LKFdcJWT3zmvRZ6Y8M237ZU7870jS8nAKnsm
         53jFFFFZ61qxZ+7aVxOWn3xQlZBYsYRQoCdmSsa7hQ1uDICZOE3X4GK3hRY4ybWgb/w/
         rUkuDGguHP541k3XUak4u77YbwSy4ACMqr0FepctYyCKaMuVOdmBLAfgG1duY1e9SdKk
         6oTw==
X-Gm-Message-State: APjAAAVYVubfqh7z8U3/yAMPzh9s7Ktkv69YUL2HqrRI2WEXFXo9alwp
        Oy5Tt1EWOpDuKD4rFtqOuNUPRiX3L6lLzvXhBG/4d9UN41OhjXYO/+xjdIsxerePKm7qzY5Qb9h
        /vMlNnJaN4J1xGzTe3CQ00OEQ
X-Received: by 2002:ac8:474c:: with SMTP id k12mr30797303qtp.319.1570459550257;
        Mon, 07 Oct 2019 07:45:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwnnI4w3osQ3PWAUY3wt0nD+Y39v32sP+fzXakxYjiq4ENdUdq2GU0Xq3j/fCwCVGC6ogmB/g==
X-Received: by 2002:ac8:474c:: with SMTP id k12mr30797267qtp.319.1570459549869;
        Mon, 07 Oct 2019 07:45:49 -0700 (PDT)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id u27sm11001486qta.90.2019.10.07.07.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 07:45:49 -0700 (PDT)
Subject: Re: mount on tmpfs failing to parse context option
From:   Laura Abbott <labbott@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
References: <d5b67332-57b7-c19a-0462-f84d07ef1a16@redhat.com>
Message-ID: <d7f83334-d731-b892-ee49-1065d64a4887@redhat.com>
Date:   Mon, 7 Oct 2019 10:45:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <d5b67332-57b7-c19a-0462-f84d07ef1a16@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/19 12:07 PM, Laura Abbott wrote:
> Hi,
> 
> Fedora got a bug report https://bugzilla.redhat.com/show_bug.cgi?id=1757104
> of a failure to parse options with the context mount option. From the reporter:
> 
> 
> $ unshare -rm mount -t tmpfs tmpfs /tmp -o 'context="system_u:object_r:container_file_t:s0:c475,c690"'
> mount: /tmp: wrong fs type, bad option, bad superblock on tmpfs, missing codepage or helper program, or other error.
> 
> 
> Sep 30 16:50:42 kernel: tmpfs: Unknown parameter 'c690"'
> 
> I haven't asked the reporter to bisect yet but I'm suspecting one of the
> conversion to the new mount API:
> 
> $ git log --oneline v5.3..origin/master mm/shmem.c
> edf445ad7c8d Merge branch 'hugepage-fallbacks' (hugepatch patches from David Rientjes)
> 19deb7695e07 Revert "Revert "Revert "mm, thp: consolidate THP gfp handling into alloc_hugepage_direct_gfpmask""
> 28eb3c808719 shmem: fix obsolete comment in shmem_getpage_gfp()
> 4101196b19d7 mm: page cache: store only head pages in i_pages
> d8c6546b1aea mm: introduce compound_nr()
> f32356261d44 vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API
> 626c3920aeb4 shmem_parse_one(): switch to use of fs_parse()
> e04dc423ae2c shmem_parse_options(): take handling a single option into a helper
> f6490b7fbb82 shmem_parse_options(): don't bother with mpol in separate variable
> 0b5071dd323d shmem_parse_options(): use a separate structure to keep the results
> 7e30d2a5eb0b make shmem_fill_super() static
> 
> 
> I didn't find another report or a fix yet. Is it worth asking the reporter to bisect?
> 
> Thanks,
> Laura

Ping again, I never heard anything back and I didn't see anything come in with
-rc2

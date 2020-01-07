Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F32C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDDC2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkRRQBL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgAGSwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:52:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22457 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728358AbgAGSwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578423125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VErRlwO5Ymf/mDUAeuLrx6IdZ2Ci3A9/OC+EwB3cogU=;
        b=AkRRQBL2eBAUXBgD1CTbPdB+Fa5bes9j61CaLYGieka5PboFBDdvZVFx6o72buHt/rvIOf
        vUaPoclw/fjcUBXBt6uVfVJ238htgsln1g4Uue1lo1MzQN+2O0bgLdvMScUTNMjz+5kTVi
        g8HTD6TmtYObpKGE7plJFxxG62TaXUU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-k8l0-UB4PR-d58INI8c__A-1; Tue, 07 Jan 2020 13:52:02 -0500
X-MC-Unique: k8l0-UB4PR-d58INI8c__A-1
Received: by mail-qt1-f200.google.com with SMTP id l1so376022qtp.21
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 10:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=VErRlwO5Ymf/mDUAeuLrx6IdZ2Ci3A9/OC+EwB3cogU=;
        b=KCCURyMS9PWrGYVPznausp/sZFQysZoXUBxk/BFcQkUwx1AS8Mnq/JdtCgIWHHymka
         3RQtwcXnvQqwZo4KQNMCxm2G60qrdfUbRQg1xsyYQwsE8Kw34uXxyYLQxYoACvfat1E2
         bWYDhdwEi4BABy7SrIIFyWgLlaFW/n1pbQy74+zagFXaK1meJVd4G659t/XveQVwEHPP
         X7UgphaCPLGlzZyMChiNNs3VsNQeP2hX2sLCY4J+/MAKISC7zG2OhK1/bTDTVYCvFUPI
         4resxph9tZMSBXD+UlhB/tpRv4rClt66CVLITE9PuammkomwuJBSsjLxyqeuVGHzMHsG
         9Bdw==
X-Gm-Message-State: APjAAAXXt0Yi+frwBYEeJHsjpx2z560G6RfZ1n6TF4VO9iZWU8xLUNUs
        dAWPDn3AO3yMdSeQZUgc1+5tcUsS0JqdDtBt4GJ1BwBKfE0/QPM4Z5FuExk2EUrDPro5mmISyQj
        5bqZiXSbY6GDZoVIlRFVPQYJC
X-Received: by 2002:a05:620a:1467:: with SMTP id j7mr743492qkl.76.1578423122088;
        Tue, 07 Jan 2020 10:52:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqyR0JS6estJWyDeOP24MAGmqxrnl0mMWFA6iohfjOV36L4F3MNNN2VxLjUQQMYR1bbDv8jQQg==
X-Received: by 2002:a05:620a:1467:: with SMTP id j7mr743467qkl.76.1578423121800;
        Tue, 07 Jan 2020 10:52:01 -0800 (PST)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id q25sm226420qkq.88.2020.01.07.10.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 10:52:01 -0800 (PST)
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
From:   Laura Abbott <labbott@redhat.com>
Subject: Bad usercopy from tpm after d23d12484307 ("tpm: fix invalid locking
 in NONBLOCKING mode")
Message-ID: <b85fa669-d3aa-f6c9-9631-988ae47e392c@redhat.com>
Date:   Tue, 7 Jan 2020 13:51:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Fedora got two bug reports https://bugzilla.redhat.com/show_bug.cgi?id=1788653
https://bugzilla.redhat.com/show_bug.cgi?id=1788257 of a usercopy bug from
tpm:

[   67.037526] usercopy: Kernel memory exposure attempt detected from wrapped address (offset 0, size 18446634686907596985)!
[   67.037541] ------------[ cut here ]------------
[   67.037543] kernel BUG at mm/usercopy.c:99!
[   67.037550] invalid opcode: 0000 [#1] SMP PTI
[   67.037553] CPU: 1 PID: 3277 Comm: tpm2-abrmd Not tainted 5.4.7-200.fc31.x86_64 #1
[   67.037555] Hardware name: Dell Inc. Latitude 5580/0FH6CJ, BIOS 1.16.0 07/03/2019
[   67.037562] RIP: 0010:usercopy_abort+0x77/0x79
[   67.037565] Code: 4c 0f 45 de 51 4c 89 d1 48 c7 c2 e3 ce 35 b0 57 48 c7 c6 30 80 34 b0 48 c7 c7 a8 cf 35 b0 48 0f 45 f2 4c 89 da e8 50 6c e4 ff <0f> 0b 4c 89 e1 49 89 d8 44 89 ea 31 f6 48 29 c1 48 c7 c7 25 cf 35
[   67.037567] RSP: 0018:ffffae5b42eabe48 EFLAGS: 00010246
[   67.037570] RAX: 000000000000006d RBX: ffffffffffffffff RCX: 0000000000000000
[   67.037572] RDX: 0000000000000000 RSI: ffff9c83b6257908 RDI: ffff9c83b6257908
[   67.037574] RBP: ffff9c836686c0b9 R08: ffff9c83b6257908 R09: 000000000000007c
[   67.037576] R10: ffffae5b42eabcf8 R11: 0000000000000000 R12: ffff9c836686c0ba
[   67.037578] R13: 0000000000000001 R14: ffff9c836686c010 R15: ffff9c836686c0ba
[   67.037580] FS:  00007fb2dbfff700(0000) GS:ffff9c83b6240000(0000) knlGS:0000000000000000
[   67.037582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   67.037584] CR2: 00007fc1137f3e00 CR3: 00000002205c4002 CR4: 00000000003606e0
[   67.037586] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   67.037588] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   67.037589] Call Trace:
[   67.037595]  __check_object_size.cold+0x46/0x80
[   67.037600]  tpm_common_read+0x74/0x140
[   67.037605]  vfs_read+0x9d/0x150
[   67.037610]  ksys_read+0x5f/0xe0
[   67.037615]  do_syscall_64+0x5b/0x1a0
[   67.037620]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

I think this is related to d23d12484307 ("tpm: fix invalid locking in NONBLOCKING mode")
Specifically, if tpm_try_get_ops fails I don't think we should be putting the error
code in priv->response_length since tpm_common_read doesn't seem to account for
negative errno values.

I don't have a reproducer since this was just what was reported to Fedora's bug
reporter but both reports happened after that commit landed in stable.

Thanks,
Laura


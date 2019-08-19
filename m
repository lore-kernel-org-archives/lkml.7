Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B5BC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D6822CE8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="SjxVcsjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfHSVW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 17:22:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38736 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfHSVW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:22:28 -0400
Received: by mail-qt1-f196.google.com with SMTP id x4so3598551qts.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Eyvjuyl6e+48GXyoQtQ0Bav0v4bio9vejLA0zjYntlQ=;
        b=SjxVcsjpNDsxMB43E9GO9HuatiRTR2hWaKxQD8EtovL2PQH83fXQqTKsTqm3XPtjjw
         7Vk4uHZ8mj23l2CPavnsa2zgP50UGD+hS6WWf2mtZT4f6RbRSv39+Snnf+UIBCY6K7Q4
         7Y0qWNMlPOsng5vAsDaREC00Xx59sfrw9zRmIGpS+I3ZriW8ndH5mDMoatt0NoVf9k13
         S4DFZqBfy4XdI1Yf0YXF1r7uwXkDkqJYNlk/ifUnyCiSMGWqX+BinsCdifBnzLFAG17/
         LDl8AybhmMx8kvFkxmGyWxICYwc0oU7PeRMsbXEwRDfE919SpeCAeJj7F91AXpRpF7d9
         YskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Eyvjuyl6e+48GXyoQtQ0Bav0v4bio9vejLA0zjYntlQ=;
        b=X9JWVd/N+EfRL9CshNkaM6Bgk5+kodxoAIEHp4mC2TQ2GPRQR6byC0GSqQk1uUUoyp
         hL6ny+FzRdCCshY/KVAVwMDoBtYHEO3ODbjoia+cuOr208JXb4U0Em/izzwtl1a6J0u/
         JRo6t+xfiE+ADh6ALccKgPniPsXna+0PBZMyMQr5OEVvLkVSgfGTj32V02Qn5aq5h9fm
         N6M0dD6I6JiOTuEmAqNhrNqJAPmeD5bpa5ASzxReGddEN82sZyJc4/7MRA9ya/fEDtUo
         szsEDcm7+zOZhKvHHx3Jo98qN6RG+BPsgTOfQrK5g3jGwSmiMI/t7O47u0t2MDN2UEvV
         ioOg==
X-Gm-Message-State: APjAAAWXuTReu8zyw9yb3giltRY/vWVdBWY65fqmSPWRocRs4Z0KD+ZF
        hEU7nnJIy8kaKzw0iFNj5gl++Q==
X-Google-Smtp-Source: APXvYqwZjrxoURDZUnFvrPAuAYmIucmRL5XJOtPCZmkOlm9gcOGuN4XKpxMjR/HF61FZDPkjdzTfFA==
X-Received: by 2002:ac8:3258:: with SMTP id y24mr22710720qta.183.1566249747361;
        Mon, 19 Aug 2019 14:22:27 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id h13sm7579776qkk.12.2019.08.19.14.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 14:22:27 -0700 (PDT)
Date:   Mon, 19 Aug 2019 14:22:20 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     syzbot <syzbot+2134b6b74dec9f8c760f@syzkaller.appspotmail.com>
Cc:     aviadye@mellanox.com, borisp@mellanox.com, davejwatson@fb.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in tls_write_space
Message-ID: <20190819142220.264040d8@cakuba.netronome.com>
In-Reply-To: <0000000000003dab1605704fb71d@google.com>
References: <0000000000003dab1605704fb71d@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jul 2018 00:36:02 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    1a84d7fdb5fc Merge branch 'mlxsw-Add-resource-scale-tests'
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17dec75c400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a63be0c83e84d370
> dashboard link: https://syzkaller.appspot.com/bug?extid=2134b6b74dec9f8c760f
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2134b6b74dec9f8c760f@syzkaller.appspotmail.com

#syz dup: general protection fault in tls_write_space

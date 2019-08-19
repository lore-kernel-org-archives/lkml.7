Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A12C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDED2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="pA5NkowD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfHSWhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 18:37:51 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38401 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbfHSWhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:37:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id u190so2889356qkh.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 15:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=rsagY98pY3y6P0r4oJuEyk/CtDLJ+v8VBbs+1ATcMes=;
        b=pA5NkowDQ5sq9RA3z0tdahrFNXl+dfJGk9N66l2fvNKchiHZvUSkHGZ7h/Yh2732yN
         yzS75fIomcfJFlJ43MOV759PKSj22Z+ftqvzbDqfIXvyBp8AUcgl87jUX6Q3yQ7jUMrU
         cv0DcTJGDS3ypjuPMs6xn+PIjz/RigfsLsnlDZICreCmYzS/AjZtsQD9nduFkNhHRsit
         M7S11k4Hz58CBMxaYZ1gVgKM/XOVnZJbnqREW16/PC2hLbgSkVeRp8Rp53O7BQ64Lxch
         jpqlFJ+LypHmVKgmV+EtwOipnlmyYVrkQi5F0THYGR+2CoFONkjYDloHOkx+dE6FC2x1
         Ur3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=rsagY98pY3y6P0r4oJuEyk/CtDLJ+v8VBbs+1ATcMes=;
        b=P2Rq6dOVvowCzon07jLbA3Mv4VmT3U1U7e6nZ4F98ihSOngUC8MHFnZuDjNsdeqQSE
         X6Bo9SnlDKVwVHeqXUcBJagjwd4oR89pLglsXEykV+B1PStgqHTPPa4hLKZ2kR5az0ja
         S35YqL27qJto6ylfxfAuSe5M4b8+2JbPiIaXK8I+fHglqnjSeo18bhmDdMvNRgE/VgQN
         qp1J7QzoZSLnv+QDmxnXHMMT1sGRJFlagdyo2HUhIpz9ALY1/0pDdlfkCa1qCF1rRQOi
         /FqhCCvdWcLGNFjAUcpesJ8+9/9vXbYCS3BONiZfIkBPjq6mmAExEEYJXgrbd8b3Rv/D
         UUVg==
X-Gm-Message-State: APjAAAWlg8RwxrTi70xlKFedozfUudxKjPxny7PtozJ7CsKPh8mmvAZ4
        nW0Hcl+ik1z3YJukUPlJ82RHMQ==
X-Google-Smtp-Source: APXvYqxZi9h9aRIS+EXau57hZDU/wx9fF+xgZ0qy+6NMAZ+eniAdhhoqfD3KytvlBByc7Q72rfNzIw==
X-Received: by 2002:a37:a358:: with SMTP id m85mr23592048qke.190.1566254269969;
        Mon, 19 Aug 2019 15:37:49 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id t2sm7373384qtq.73.2019.08.19.15.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 15:37:49 -0700 (PDT)
Date:   Mon, 19 Aug 2019 15:37:43 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     syzbot <syzbot+70ab6a1f8151888c4ea0@syzkaller.appspotmail.com>
Cc:     aviadye@mellanox.com, borisp@mellanox.com, daniel@iogearbox.net,
        davejwatson@fb.com, davem@davemloft.net, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: ODEBUG bug in tls_sw_free_resources_tx
Message-ID: <20190819153743.33eea0b2@cakuba.netronome.com>
In-Reply-To: <00000000000062c5c3057a095d25@google.com>
References: <00000000000062c5c3057a095d25@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Nov 2018 17:52:03 -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    7c6c54b505b8 Merge branch 'i2c/for-next' of git://git.kern..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1276246d400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=136ed5b316dbf1d8
> dashboard link: https://syzkaller.appspot.com/bug?extid=70ab6a1f8151888c4ea0
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+70ab6a1f8151888c4ea0@syzkaller.appspotmail.com

This was most likely fixed by John:

#syz fix: net/tls: remove close callback sock unlock/lock around TX work flush

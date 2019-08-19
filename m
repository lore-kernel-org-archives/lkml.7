Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBCCC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAB52070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="IN8oX6sV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfHSWmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 18:42:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39792 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbfHSWmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:42:39 -0400
Received: by mail-qk1-f195.google.com with SMTP id 125so2899611qkl.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 15:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=lcp+YLDBpIdavMYZNzsYtx/6frDIFLB/mtEMPIGQcP0=;
        b=IN8oX6sVAg2IBinffenCEWbsApvRd9a9R15KqQOKf1MrNurbdhkSlXMFZnisrsjEni
         Wi/NOPLUz/eU7VfDU7OBi3X7qi64sShMxSsqufmO5z47e4SM2jYnaEY7HLoFmhH1wYER
         TpJ0jxmK4f1Dq6cAUsLRkgqngVGBq//EzIE5fVfn1tBd5uVm5kQIOjIlm4CDlxivG1kb
         8JhPpVp6CX/ZUsL+Og+Xhj80Ksy2IRUqk204J/tvelajK+lZs1dLpSSHDfKizJHOgJHa
         ky4RIs646NLnzR0a0xQFb2AYe3C5ML9rYwNo6qN//7eqsAEDl2jht6Hjo1B9+S3EIbfM
         h8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=lcp+YLDBpIdavMYZNzsYtx/6frDIFLB/mtEMPIGQcP0=;
        b=Ujoz0mVkSRj/hwUlmQFr5qcLbdn2tc2za0abHBNcnQ6BHiT0S6G74B3nPtW/yEpnbl
         /XcH3qt4tVVOOZ5jGoKRZaPYYWVuY6RA8RXyfS4kA29LPRaVF+T7RXcnsJcCk2joHwcO
         L70lRpED53PSAwnPF47jSNMZnbiL7ViKDIrL2JqXv+5lNUk7UeJlbLl9VGHILrtxHcRE
         WoBhjVI7OWOofCq6or5D1WEpYQ++8Fo17G+DX8CRhRh1TwyEGRVmGpJTHnhpgSBnGBf4
         X4JBGqm4WuvX7OKPWcYPAzjx4MSxfiXik90Bji9kMP3ekHfN/Ev56h3oPlLux1ApQOTg
         I8Aw==
X-Gm-Message-State: APjAAAVKrX1QS7u2AIisoOgbCDaUlhwEllB7EefUqsS8Ra2seadSPBdm
        CIvG0vBcKtONmW9ndLbPc5TF2Q==
X-Google-Smtp-Source: APXvYqwkycOlwWICAK5DY/s2gye+jBIFKcaX4m6pf/9isjOpkChpjqm9237VN/njknmFQUW8C4DhMQ==
X-Received: by 2002:a37:dc1:: with SMTP id 184mr23232000qkn.10.1566254558998;
        Mon, 19 Aug 2019 15:42:38 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id g3sm7541182qke.105.2019.08.19.15.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 15:42:38 -0700 (PDT)
Date:   Mon, 19 Aug 2019 15:42:32 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     syzbot <syzbot+66fbe4719f6ef22754ee@syzkaller.appspotmail.com>
Cc:     aviadye@mellanox.com, borisp@mellanox.com, daniel@iogearbox.net,
        davejwatson@fb.com, davem@davemloft.net, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in tls_push_sg
Message-ID: <20190819154232.4f1ed902@cakuba.netronome.com>
In-Reply-To: <0000000000000d1491058919b662@google.com>
References: <0000000000000d1491058919b662@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019 11:40:05 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    35c99ffa Merge tag 'for_linus' of git://git.kernel.org/pub..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10ff3322a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=82f0809e8f0a8c87
> dashboard link: https://syzkaller.appspot.com/bug?extid=66fbe4719f6ef22754ee
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+66fbe4719f6ef22754ee@syzkaller.appspotmail.com

Most likely:

#syz fix: net/tls: fix page double free on TX cleanup

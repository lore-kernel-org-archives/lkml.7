Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7191EC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DFB22CEC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="PYrjGexu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfHSWeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 18:34:46 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37290 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbfHSWel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:34:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id y26so3795263qto.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 15:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=/8syMKrISRpi1LM7hCsQr+3ogO/UJ/CBR8QK6jTRgOA=;
        b=PYrjGexujQ7qjZ9HEQOtuMaFIDsAuSlIWNtS94bqJSfDt+JzMRd2oOrLYM3Dg4D7yH
         6vSi0r+0NlolywFYZucE+X39yXuIvx719CBDU7QcxWcMBB1zKJJfc/QzccUR4P61AKw4
         egl/9oz7J7Z6JbwxBmN4WMxPyQUx3/RD2XI5sdzFUuxCwxhC2/n2SWyB2G3fDCdK8joO
         o6/e1kBlsjD/vZWMXd49zDsfzTAI/xajN7WNZjfiPxE21RI1LRS7P1Dt59SmOeYQML2F
         z5DnzIRMgOLFqVZ7jawa6wN19Xex96uC5hhqhMYJ7uVeadvv02KT8ERQ4YewXfs70mqP
         dRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=/8syMKrISRpi1LM7hCsQr+3ogO/UJ/CBR8QK6jTRgOA=;
        b=JWK/NmCuh6CZUxTZNGN38q49KvfWQ5WEo1e0hJWZKevB/Q6jlXBRQveuWPh8RnHcAz
         aXJbR1RbO9tQt1iSoQsdu7LWvxv6g6bO2EsCZRWmK+v9TdKKJS1LMkJtVsKOpy07Y0AF
         dW7Jgq1rrXBDBN7V157E4HwZ/jTZUFSItQOTalnyv2jYCB6A7heTKKdLRzZOsnC5L7sT
         qIGTKcb35Tt4ccNqVKP6H0NY4H3FCki0Hv0wjH5NWDKU0WvHNdDRej7tS6z3lDNugAKt
         cZ4B+oVyXtgVRfw0hW2UI3idoI2hUmN+UGUqDS9dpS60f8CcooknF1Fxy+/tlYif8i58
         ubCQ==
X-Gm-Message-State: APjAAAWL2aTdJjul4hEompAmo68Ae7MdShYeKtONeKRlCwVg4NA4cqMS
        xUiVUG+7Jl+VrQREYo2ROTP8Bbj0XeY=
X-Google-Smtp-Source: APXvYqxt8DIc/EEwhFZZ6YFwgGynE/NFwfuo1VlLbW1HmXwJB5q8m9Ztm89w5K6iYJ61JWS9UZia5Q==
X-Received: by 2002:a0c:8cc3:: with SMTP id q3mr12065348qvb.127.1566254080873;
        Mon, 19 Aug 2019 15:34:40 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id p3sm8945645qta.12.2019.08.19.15.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 15:34:40 -0700 (PDT)
Date:   Mon, 19 Aug 2019 15:34:32 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     syzbot <syzbot+4207c7f3a443366d8aa2@syzkaller.appspotmail.com>
Cc:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, john.fastabend@gmail.com,
        kafai@fb.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Subject: Re: BUG: unable to handle kernel paging request in tls_prots
Message-ID: <20190819153432.06c23d19@cakuba.netronome.com>
In-Reply-To: <000000000000d7bcbb058c3758a1@google.com>
References: <000000000000d7bcbb058c3758a1@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019 03:17:05 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    904d88d7 qmi_wwan: Fix out-of-bounds read
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=14a8b865a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=137ec2016ea3870d
> dashboard link: https://syzkaller.appspot.com/bug?extid=4207c7f3a443366d8aa2
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15576c71a00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4207c7f3a443366d8aa2@syzkaller.appspotmail.com

That's one of the bugs John fixed:

#syz fix: bpf: sockmap/tls, close can race with map free

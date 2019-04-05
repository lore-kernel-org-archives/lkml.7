Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C640C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B8C20989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDEWDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:03:04 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:48948 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726124AbfDEWDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 18:03:03 -0400
Received: from mr1.cc.vt.edu (mr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x35LRkEN006317
        for <linux-kernel@vger.kernel.org>; Fri, 5 Apr 2019 17:27:46 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x35LRe2T010393
        for <linux-kernel@vger.kernel.org>; Fri, 5 Apr 2019 17:27:45 -0400
Received: by mail-qk1-f198.google.com with SMTP id f196so6154328qke.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 14:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=Y79cdCdF/M5lgfA1xcm93DhUSoi2n3NbM7Cae4JkvcY=;
        b=YiyL9E+xrrMSUunzwq4zZ9lU3NEZIgxJyxjDXSF/frKKTONBJwFWrgV4GckOsdoP4R
         KLxgnIipYh2BjGtHGiImXVzR2KRXLL/J7XQfCv15TxeDGpz5CwURdLji8pEudJBLC+no
         CA+Dh0PFXSFzuu0UEGakwjbhP4BLYhAtGfkxda6liaG1Ky6AMRYIqk8LTd3CXz/c5Ueo
         x7xCWKW7xeaZZvZvzWhNvRoyZgCoHAZEXBYt/0EYLCcUiuEbrx2vLcj3lnTrTDlpK/iV
         GGbRfuDH4LERXZuqzB0sTKIKu4hoj1R7POCWmY69vj2hThpPMHrz9OvCYS1gcmhx6IpG
         guAg==
X-Gm-Message-State: APjAAAXoavwUpV4PFj1D2XNYPPLOD8UnMKppnwPlv9g430GGUXrraRYY
        XKz2MF/mFE7h+yew4zQbJBFAIx/vHVDUopNjyr5+CboEpQLkkpTB4v5/tEpOZ80D9ZqJcJGB8eO
        d7h/XgqY60yRZ0NhCOYRUf8RmfweZ+L0wfS8=
X-Received: by 2002:a0c:d092:: with SMTP id z18mr11840008qvg.14.1554499660608;
        Fri, 05 Apr 2019 14:27:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxNuR6TLAZ7r/bEEXsC7ygCFH1VT8BXKCBf0qPFgAa9qRwr3vE1qxeJ67tezCv9L036/cZsYg==
X-Received: by 2002:a0c:d092:: with SMTP id z18mr11839994qvg.14.1554499660359;
        Fri, 05 Apr 2019 14:27:40 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::9ca])
        by smtp.gmail.com with ESMTPSA id p62sm6308944qkd.27.2019.04.05.14.27.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 14:27:38 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Pankaj Suryawanshi <suryawanshipankaj@yahoo.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kernelnewbies@kernelnewbies.org" <kernelnewbies@kernelnewbies.org>
Subject: Re: How to calculate page address to PFN in user space.
In-reply-to: <1536252828.16026118.1554461687939@mail.yahoo.com>
References: <1536252828.16026118.1554461687939.ref@mail.yahoo.com>
 <1536252828.16026118.1554461687939@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Fri, 05 Apr 2019 17:27:37 -0400
Message-ID: <6977.1554499657@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Apr 2019 10:54:47 -0000, Pankaj Suryawanshi said:

> I have PFN of all processes in user space, how to calculate page address to PFN.

*All* user processes?  That's going to be a lot of PFN's.  What problem are you trying
to solve here?

(Hint - under what cases does the kernel care about the PFN of *any* user page?)

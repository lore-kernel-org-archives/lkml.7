Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025F3CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACC2205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfJ3PlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:41:06 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:35318 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726461AbfJ3PlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:41:06 -0400
Received: from mr4.cc.vt.edu (mr4.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9UFf5QL006874
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:41:05 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9UFf03u006364
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:41:05 -0400
Received: by mail-qt1-f199.google.com with SMTP id k53so2835763qtk.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 08:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=eIoWGi3U/SGYr7w5rrsbliBxDrgak+FNrEviy/8rGIk=;
        b=Qem+ASaUqScax1MPITXVxJ1SgXRm9hCJVEihvwSGN9gKwYr17G27oMRABiqBBY1vh4
         DY25yp8cHpZxbhESVkE8fSZOqXFDgmwM807N4FaG7Er4nDP95bRWTHyifwhIU7FlEZkh
         DnQAOa0vgO1mjmFJXQ8Oaz1WM0pTa4Jubd74EIInriusXhvSJe3gHMnSxX7NECt1u0GF
         ZRQ/uMB/eCuKK4QKMNs4uB0lIkwx7bypuxjXKHihdxgd7+uegml4kVaAWVA3eoQ09WTp
         ZXuLmRiyHRXGtkrf6EvlyyGXnMggo6zU6ffbwZi9pAAqqSqkPlsMaw9lO511Py/27Eme
         Tedw==
X-Gm-Message-State: APjAAAURMU3QU2U4b1rdxJdjOFIAJ/s9d7WSer7oilVEbfsPTNRCdCmY
        NCLudnQyOwcSUKG1ep8MrD2xO7UT2wxs+Ic3yHc4bE/A60abmIdIakszZh7m2/1UajupAsI+NT4
        kwLQk/5BDyehY/v/syD9K3un3OTrXA0V61Pk=
X-Received: by 2002:ac8:7546:: with SMTP id b6mr716402qtr.104.1572450059574;
        Wed, 30 Oct 2019 08:40:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwxyrOL2KJZakZX+lSdi47kBXVJMoQi6jylMX1/YtjfV276ujKko4yFtHRvF28Z5bPPRKRdfA==
X-Received: by 2002:ac8:7546:: with SMTP id b6mr716361qtr.104.1572450059254;
        Wed, 30 Oct 2019 08:40:59 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id c17sm273439qkm.37.2019.10.30.08.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 08:40:58 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Davidlohr Bueso <dave@stgolabs.net>
cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers/staging/exfat: Replace binary semaphores for mutexes
In-reply-to: <20191030144916.10802-1-dave@stgolabs.net>
References: <20191029080521.GA494993@kroah.com>
 <20191030144916.10802-1-dave@stgolabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 30 Oct 2019 11:40:57 -0400
Message-ID: <74400.1572450057@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019 07:49:16 -0700, Davidlohr Bueso said:
> At a slight footprint cost (24 vs 32 bytes), mutexes are more optimal
> than semaphores; it's also a nicer interface for mutual exclusion,
> which is why they are encouraged over binary semaphores, when possible.
>
> For both v_sem and z_sem, their semantics imply traditional lock
> ownership; that is, the lock owner is the same for both lock/unlock
> operations. Therefore it is safe to convert.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Looks sane.

Acked-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>



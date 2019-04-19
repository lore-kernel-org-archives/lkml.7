Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E08C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69910217FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJcZSD9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfDSVlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:41:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42524 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfDSVlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:41:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so3152423pgh.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sgVFhxDqfVPVv96StH2CfU6FG0N/pAfm/sn71zUxjIY=;
        b=JJcZSD9HCJpk2lu5iLVZIC+3fTiDv8Bjc3UmntHTEF3tLjbapQAqffVtSxjTXk1gHq
         6bf8pML4ImHVYuV6pjOmJ1MTLQUMVn26F0Q0J51cEl/fmxMoj4qNNJT+Yk97NPSIgFuq
         UuQgMYWBbLncGrglRNTlBS1fBXdjvSGCiC00pVWbeszmOIIv2ol38pQqwUTOh5n7GuVh
         +cluXSuV6f86CDWtyVtS7ScX5x5ot4fCQunxDa5HA6uoCRYssq+OSuaZSQgBKMKD2ahR
         mu3sfgf5XYfNVI7Vr/wpoOaN7EBYFpvxhe0ZSAXPamsCQpcbkFmp8/0qpnfyZ32IDHj0
         fHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sgVFhxDqfVPVv96StH2CfU6FG0N/pAfm/sn71zUxjIY=;
        b=bU7JhkmjDVlcwbVLC3228TIsaUaOmfz0FiChd3jkKPPyo0Qk51KQvHFZ1rEv6hnpYn
         V21f75TXwMOzUwlkWYE4PP8H/Vb276AR4Z99oxYUUCvdq32WTE1C35DLagAuRmkOXu8f
         gT4eJkIZ3UVvR2aJ+voGiRUNL0zGIMbuJUkTCmvWlJC8cISrien/HchiJa4jxQYX4WJ0
         SOqKzuxYdQV7DLf8HA0eME3x2oYyuGqaK6s5YuZfyE6tSfJrRN3x+qktyNzEW1sUlZsc
         TORoty5lX3loPjnYB+Ph91B6jz385fz66PY1g4UTOHL3WT+UzjMCVXldiD4MuNF9/lgF
         Wiiw==
X-Gm-Message-State: APjAAAUdpX8oR7DRoaiKq9plynacS/2ahQ8YDNaU/vUJ5OtF91DrvHFs
        AovZDWRIMec/GwoC7qNqP9c2FG3e6CE=
X-Google-Smtp-Source: APXvYqz/sp8H3x86xArhlg636ZCPLDazcHqtwg/NBWqTeB/3SaxESSAc1piK3NoUeRZU5NWKhR6+qg==
X-Received: by 2002:a65:5c42:: with SMTP id v2mr5914874pgr.360.1555710082873;
        Fri, 19 Apr 2019 14:41:22 -0700 (PDT)
Received: from [10.33.115.113] ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id u26sm8024245pfn.5.2019.04.19.14.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 14:41:21 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 1/4] mm/balloon_compaction: list interfaces
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <679D6F11-07D7-4227-9D02-41F9F8901E61@vmware.com>
Date:   Fri, 19 Apr 2019 14:41:19 -0700
Cc:     Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Julien Freche <jfreche@vmware.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Nadav Amit <namit@vmware.com>
Content-Transfer-Encoding: 7bit
Message-Id: <5A5146D6-9BE3-4240-BEBB-FDA5BC536E96@gmail.com>
References: <20190328010718.2248-1-namit@vmware.com>
 <20190328010718.2248-2-namit@vmware.com>
 <679D6F11-07D7-4227-9D02-41F9F8901E61@vmware.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 8, 2019, at 10:35 AM, Nadav Amit <namit@vmware.com> wrote:
> 
>> On Mar 27, 2019, at 6:07 PM, Nadav Amit <namit@vmware.com> wrote:
>> 
>> Introduce interfaces for ballooning enqueueing and dequeueing of a list
>> of pages. These interfaces reduce the overhead of storing and restoring
>> IRQs by batching the operations. In addition they do not panic if the
>> list of pages is empty.
>> 
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> 
> Michael, may I ping for your ack?

Ping again?

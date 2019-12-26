Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D104C2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 09:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6203820828
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 09:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfLZJHy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 04:07:54 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49634 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfLZJHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 04:07:53 -0500
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1ikP7X-0003yW-OC
        for linux-kernel@vger.kernel.org; Thu, 26 Dec 2019 09:07:51 +0000
Received: by mail-wr1-f72.google.com with SMTP id z14so12214422wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 01:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oFTyBe48cc1VjVZVOZfgQ9vfLk7JKDJXzBm/i7Z9r/E=;
        b=FieQPErDcqq5TWKi9800LMgMhhFTwpqKD+OPjDmYqiDsavqY+Wtac4AQSOu+1/y+b5
         oQFLvxibGh3iynPPOtM06cLlSNEUgRyVrUsclHUAMsBe+zi/Ka7Qgp3pwtVav7K0AXxR
         TXquMUvkLvelNBA435mDVr+pWvGKP25LTeHaHoG+eV/+DPu6xQOXHuJ8mD//XwvWOQqi
         e68wa2UCye/Ye6FaNlChmdHjsxpruNbxOAoMll7xBSGZK9hRf6O1RTBgqmOOiB4flTnq
         62RroU57tHXLQMI59c4gXc8n0ciTiN8YdFyOtMVwwCJX6JISMtuP4XFdieVZ3Lmnxjbr
         m3Hg==
X-Gm-Message-State: APjAAAU4LtgM5Gaf4rVugzVtrATt0TeQMwmgFj2D55D7sfZTXFTCOCZu
        pINNNjnKbMH2t4J3r6blvpCZ+07QoCNW07voCEbZ2V1t8o/Ko4GBhW8F2Uzm2MKfRFCIeFX39lw
        EzhskAKhHwORQujSlD+oAbNRdhEXVaDQ8i5gxd09ydaOfDn37F8eUvUlVeg==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr45243404wrp.378.1577351271499;
        Thu, 26 Dec 2019 01:07:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqw1A2F3oktQrSoq8rmLU+7uy69CPrTZ3xYgzR76K+4Csr/oogvawT604ZUoQGdJ1Y0l2qq0YU5ZYR2zN7KsPWk=
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr45243380wrp.378.1577351271224;
 Thu, 26 Dec 2019 01:07:51 -0800 (PST)
MIME-Version: 1.0
References: <CAFv23Qn9h=pwaHkiMB2ci-OaR54gY6fdc1Q_7ZMz5mH7wHr9+w@mail.gmail.com>
 <Pine.LNX.4.44L0.1912241021580.28718-100000@netrider.rowland.org>
 <CAFv23Qmc82p3o=1vDvmX5jkfbcOzoQFX7grxrKGwf1KD_vebig@mail.gmail.com> <6089B7674E6F464F847AB76B599E0EAA78A86A7A@PGSMSX102.gar.corp.intel.com>
In-Reply-To: <6089B7674E6F464F847AB76B599E0EAA78A86A7A@PGSMSX102.gar.corp.intel.com>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Thu, 26 Dec 2019 17:07:40 +0800
Message-ID: <CAFv23Qm6+_KseMzjkdJG0W3My0yPVahiZ7gCrYybdz+czRMNCQ@mail.gmail.com>
Subject: Re: [PATCH] usb: hub: move resume delay at the head of all USB access functions
To:     "Pan, Harry" <harry.pan@intel.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        David Heinzelmann <heinzelmann.david@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathieu Malaterre <malat@debian.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I just corrected the file permission.

Pan, Harry <harry.pan@intel.com> 於 2019年12月26日 週四 下午12:14寫道：
>
> Hi AceLan,
>
> Would you mind to read this thread and evaluate whether it is helpful or not by kernel downgrade?
> https://bugzilla.kernel.org/show_bug.cgi?id=202541
>
> BTW, would you mind to the shared pcap file permission as well?
>
> -Harry
> ________________________________________
> 從: AceLan Kao [acelan.kao@canonical.com]
> 寄件日期: 2019年12月25日 上午 11:15
> 至: Alan Stern
> 副本: Greg Kroah-Hartman; Kai-Heng Feng; Thinh Nguyen; Pan, Harry; David Heinzelmann; Andrey Konovalov; Nicolas Saenz Julienne; Mathieu Malaterre; linux-usb@vger.kernel.org; Linux-Kernel@Vger. Kernel. Org
> 主旨: Re: [PATCH] usb: hub: move resume delay at the head of all USB access functions
>
> Here[1] are the dmesg and the usbmon log from wireshark, and
> /sys/kernel/debug/usb/usbmon/0u.
>
> I verified this issue on Dell XPS 13 + Dell Salomon WD19 docking
> station(plug-in 3 USB disk on it)
> After s2idle 7 times, 2 usb disks lost. But from wireshark log, the
> packets look normal, no error.
>
> So, I re-do the test again and log the usbmon/0u output, but it's greek to me.
> Hope you can help to find some clues in the logs.
> Thanks.
>
> 1. https://people.canonical.com/~acelan/bugs/usb_issue/

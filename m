Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D10FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D4120896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mbuki-mvuki-org.20150623.gappssmtp.com header.i=@mbuki-mvuki-org.20150623.gappssmtp.com header.b="QjYaow5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfDATna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:43:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53424 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDATna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:43:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so668584wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 12:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbuki-mvuki-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hCvKWyfA2yfae0INe1jawbLmQY3Z1G8FYHe5lbIqFQ=;
        b=QjYaow5D1vRVD+0Uc7vDlQ4c/vbmVy4fcdnrJgTPDDNJl+ttNtjS9kVh1GX858P/2+
         rhMLIeQ6lg576Tf04cNlkmOsrCGfvrpZ8iyj4HLmI40n0W39S543AHYOBrC9+nrOCcrk
         V1NAxkPNZ2ARI59WCIv/elSg+zhbrxQrvDUmDpd1TiRWklO1BmGerQ4+CX4dLx2tFCML
         1Oe4Em3E5A0jG6L0PlglVnAXnPR2J+HDSNpUwRt7WSFLjB5zHTyuR757RBFMB2C8mcEw
         U2UxhObdxyj8KhPzYofk0Y+AFguYmCnPmw2jjdT7CIVPuN/Zj4CLba2854AXd1PHBbU+
         9R/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hCvKWyfA2yfae0INe1jawbLmQY3Z1G8FYHe5lbIqFQ=;
        b=QBIA4qRWiQWE91poxuArcoTrtz1S/60b9ykxjqOLvQeBf+5Mo3XBVD9jwn/KEHNsMZ
         66+JX/D+A43JfDmht6MIK9f6+U3YE3oXQ8wii1fdK9onTzyImXIC8NvKFk13x/4nvHOb
         1s0bhZAyHDtHStr6lHvwntgtxJtNg7Tn110cH6L7bO0iZHT80r4qqKOH1nsKy3pRkfeY
         2PGH+XGqaVMR6gCXRssl/r8X3/3U2uqzMShlWbPHBMnQjkFPuxCaOuM3DQJo246kOZn4
         5u9sZQKZjr4v501sg3YzPEFOWjdcAM9J7tKlvTdY/7F4PK9f2w+kV2jWGYzBWHmLq7Li
         3ymQ==
X-Gm-Message-State: APjAAAU+utECaT/TcpgP/YrYp0gzNJgVygcX5CKSh4LyjpVqRDjtyN0A
        LIpOodpWNIWOr1TKRuhvr2o7Yhxtj5gTS4U/jqaGhw==
X-Google-Smtp-Source: APXvYqymAATX+jbSeXR0YJjn+8YvLK9qSS33jD4aMy9VnT75iZsoQICMqTDr02tp1bnRC9WPFE8P+OPnx8LJ20FDAdY=
X-Received: by 2002:a1c:ca07:: with SMTP id a7mr855708wmg.104.1554147808367;
 Mon, 01 Apr 2019 12:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <CANSNSoWiKd98Dt1N2sSjP9Af8zk1NPV-=3P4VLtFs_cSQG4RUg@mail.gmail.com>
 <20190313232112.GC210027@google.com> <CANSNSoXPFDu9RQAUA6dUCUrSCAj68q-Nj2W7ECz3fKpFtSNU+Q@mail.gmail.com>
 <20190321232310.GL251185@google.com> <CANSNSoXhiYP4Ad3hO1v03aMOX1VtUao2yCLgj_J0z9fCNwWo5w@mail.gmail.com>
In-Reply-To: <CANSNSoXhiYP4Ad3hO1v03aMOX1VtUao2yCLgj_J0z9fCNwWo5w@mail.gmail.com>
From:   Jesse Hathaway <jesse@mbuki-mvuki.org>
Date:   Mon, 1 Apr 2019 14:43:17 -0500
Message-ID: <CANSNSoWdXZLSmq67dDeFKoSnHwEpu2TcpqvhZavjqBX7okgVFw@mail.gmail.com>
Subject: Re: Regression causes a hang on boot with a Comtrol PCI card
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 3:02 PM Jesse Hathaway <jesse@mbuki-mvuki.org> wrote:
> > Can you boot v5.0 vanilla with "initcall_debug"?  Maybe we can narrow
> > it down to a specific quirk.
>
> yup, added the "initcall_debug" output to the ticket:
> https://bugzilla.kernel.org/show_bug.cgi?id=202927, here is the tail end
>
> [   14.896337] NET: Registered protocol family 1
> [   14.901314] initcall af_unix_init+0x0/0x4e returned 0 after 4866 usecs
> [   14.908694] calling  ipv6_offload_init+0x0/0x7f @ 1
> [   14.914238] initcall ipv6_offload_init+0x0/0x7f returned 0 after 1 usecs
> [   14.921821] calling  vlan_offload_init+0x0/0x20 @ 1
> [   14.927365] initcall vlan_offload_init+0x0/0x20 returned 0 after 0 usecs
> [   14.934948] calling  pci_apply_final_quirks+0x0/0x126 @ 1
> [   14.941106] pci 0000:00:1a.0: calling  quirk_usb_early_handoff+0x0/0x6a0 @ 1

Bjorn, did you get a chance to look at the initcall_debug output for anything
obvious to you on what might be the cause of the problem?

Thanks, Jesse Hathaway

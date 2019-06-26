Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AF1C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAF02086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeRsMz+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFZJoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:44:06 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:42499 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZJoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:44:06 -0400
Received: by mail-oi1-f170.google.com with SMTP id s184so1418799oie.9;
        Wed, 26 Jun 2019 02:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FWE8M8rx2al2WmpLiaszR8ERWhndI8CHZ91PqS/pz0A=;
        b=OeRsMz+9cjbakYaf2D3qd+/K+lxO/QrMUGGr/2vAjSRDEDzaKM7JFQS2zDbvrTnlpE
         jfOPS9PfsjsNEaTNoq+pBDi4uZwyDFTgKtfzhDeB9NxR+fvxFh3Nzo/Tdkxhn/DVtZ8f
         Yz8D6sYbF91qQXdb3y0z7OKpBrRZU2+R5Pq0xQ7g208v2Prdfqc0DkAbZNo0aPlKIzg7
         baPSR14ZZjXFooQujIEfkX+LmeWxqhs8ITp9CRiumvsIIZZSINOPTm+WBCn7qFHOpyHs
         ZN0SNk4nCKt1tQtoFKD7QIFafBXj4mSESsqiksb9BHCk/G1If3zLI0NF8SCuqvYY13pc
         jSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FWE8M8rx2al2WmpLiaszR8ERWhndI8CHZ91PqS/pz0A=;
        b=JBT4qW9g1PDPWAl0nRi7i8WxeVEUu3odh9/h5+ozGBAOQRt9QlnLtB/USRvxt/rnmR
         jjTWQ8OJFPyubGzlGfZcwpr17Elz2L5r9jvGCfrtSNgaVyXBTbm6BcT4piVU5+LDwPJe
         9SL8nf1Yv/qxUHoqPKIW8JAdgTVEOF+1wl+c5+qqXUmq31TYXmHHCx6btuMK4NoAQiaL
         ObvDzijH37/vfoxVmK9AE6Kdph0jeLx38QvCP4VQg+i5lFIxsuOMQ7om83DqPP/WcBhT
         517cVRTNXCIPyV9w58rY/Qdlgb+agKzluiAlvrTfqITQWqTda+HqUKKNgUMQjFUXwgEa
         okOg==
X-Gm-Message-State: APjAAAU2Y4nJqGMjUZ2YqW7TkX2nlpoJ+SlEseL6ge92StnWluu9cGtc
        orO06B96P4rC9PZd2UP9EFyUI/E4s7Nn9CWuuB8=
X-Google-Smtp-Source: APXvYqz+xJQrf+JUKTlVpdGKJZZ1zqONbH4N9BougchUbsGfniXJhXCv4x23r5NorJCiZXPfOOMJBow3JfSicukXlrc=
X-Received: by 2002:aca:b9d4:: with SMTP id j203mr1199591oif.5.1561542245446;
 Wed, 26 Jun 2019 02:44:05 -0700 (PDT)
MIME-Version: 1.0
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Wed, 26 Jun 2019 17:43:55 +0800
Message-ID: <CANRm+Cyge6viybs63pt7W-cRdntx+wfyOq5EWE2qmEQ71SzMHg@mail.gmail.com>
Subject: cputime takes cstate into consideration
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        KarimAllah <karahmed@amazon.de>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After exposing mwait/monitor into kvm guest, the guest can make
physical cpu enter deeper cstate through mwait instruction, however,
the top command on host still observe 100% cpu utilization since qemu
process is running even though guest who has the power management
capability executes mwait. Actually we can observe the physical cpu
has already enter deeper cstate by powertop on host. Could we take
cstate into consideration when accounting cputime etc?

Regards,
Wanpeng Li

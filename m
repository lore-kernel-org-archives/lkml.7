Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C36C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 20:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1809520873
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 20:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTbau4Al"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfELUpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 16:45:01 -0400
Received: from mail-yw1-f48.google.com ([209.85.161.48]:34765 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfELUpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 16:45:00 -0400
Received: by mail-yw1-f48.google.com with SMTP id n76so9372397ywd.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 13:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=rXTZLv/Z8jb2kzjcdk+NYdqir90CjcF1FIy5Z+1TlgE=;
        b=eTbau4AlAAGdyg4cbB7cGIwK3X4MnhrpMB2A6lCDZQvtwbNz+Za2WH7BZmI2P2udd3
         A4+EvTpH9CPFeFVC3Sx7KFvX0VOQmV5fuw3cjC0TxGbdDhzNbfjqAS+2expnQkfyx71u
         P4dwyJB/KmobC+6w7Wft7JUgGHUc+VFfzBelCCC9+RMH8plas8cWN9Q7Xl4S1mU5YQfg
         KwLGnbR5Gjp/i7MLlVa/lqulgbTpdD9WarE2x0um4tEewVYuwv0EDV12LZmRsIhjwwuc
         kVfpU7dnxlV2cgk129+57KVjLdD6Hn7AQ2/B/kSrk6HS2/g7FJ7JUQw0y9cca4vP+0KQ
         993w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=rXTZLv/Z8jb2kzjcdk+NYdqir90CjcF1FIy5Z+1TlgE=;
        b=lplQfCFAaO8yiMrUzNDq6yU0gmqwMC2IU6CJmu7k7/ObqUoMKKQaIj0vRYAMQ5J7au
         IWDt90nGxn9OcM98C749Tkf1Fa7EOddFtBZvoUZ6X2J/lMRX07VsuoAcr7/yGDPu2qCf
         Bv/OzCLqxV20yy4UKKJXPVGY9gaeMtivQ1UfYSQ/RQc4Xd3d7Aufx+r4deoe0yS4p8Dc
         Tqo7s3aFVTT+hk397N6mFhGMqn4px6BSm8CpGnPIpKxHo3kNjIIbLvp+SvuwnM76ekyj
         8xCVRYuOoh6k45IDvwR1UISWo/mj0l7SBda+L43qoUvB1OqHV7euRbAwY+KEeKny3wGD
         81Zg==
X-Gm-Message-State: APjAAAVAcafycJ3EzxeTYVrn0dMVSxbSKN2rNGFC6YfCF9dMQ8lE6sV2
        BUo1texV9utF3iExtKhJwAXYYzalz3BjLebjHHQ=
X-Received: by 2002:a81:7c2:: with SMTP id 185mt13059385ywh.113.1557693900014;
 Sun, 12 May 2019 13:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190502074519.61272b42@canb.auug.org.au> <a645ff18-4c55-6b4c-0913-5b397ab83e03@gmx.de>
In-Reply-To: <a645ff18-4c55-6b4c-0913-5b397ab83e03@gmx.de>
From:   Carlo Pisani <carlojpisani@gmail.com>
Date:   Sun, 12 May 2019 22:44:31 +0200
Message-ID: <CA+QBN9A4PhPZ36otsk0TRaO9KKnKL=hfnskfFJGQJEbtb3=i=Q@mail.gmail.com>
Subject: C3600, sata controller
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

guys,
I asked a friend to lend us his card, which is the card2 listed below
and not things are becoming really weird

card1, Silicon Image, Inc. Adaptec AAR-1210SA
card2, Silicon Image, Inc. SiI 3124 PCI-X Serial ATA

the card1 is a PCI32 bit card, and uses the "sata_sil" driver
the card2 is a PCI64 bit card, and uses the "sata_sil24" driver

card1 is installed in a PCI32 slot, and it's moving 32Gbyte in a loop
without any issue

I have just tested card2 in each of the PCI-X slot (including the 3.3V
one) and ... it has always triggered the HPMC unit, crashing the
machine

the hardware is different, and drivers are also different, but  ....
maybe the problem is related to 32 vs 64bit?

I am going to repeat the test with card2 installed in a PCI32 slot.
This should force it to 32bit: will it work correctly?
(hope this makes sense)

---

we have also checked if the kernel is correctly handling the ram
we have a C3600 with 8Gbyte of ram

mount -t tmpfs -o size=7G tmpfs /mnt/ramdrive/
dd if=/dev/zero of=/mnt/ramdrive/test.bin
badblocks -swv /mnt/ramdrive/test.bin

checking for bad blocks in read-write mode
From block 0 to 7340031
Testing with pattern 0xaa: done
Reading and comparing: done
Testing with pattern 0x55: done
Reading and comparing: done
Testing with pattern 0xff: done
Reading and comparing: done
Testing with pattern 0x00: done
Reading and comparing: done
Pass completed, 0 bad blocks found.

no problems found
